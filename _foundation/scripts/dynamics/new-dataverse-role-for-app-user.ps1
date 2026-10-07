param (
    [Parameter(Mandatory = $true, HelpMessage = "Dataverse environment URL, e.g. https://org12345.crm4.dynamics.com")]
    [string]$environmentUrl,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) the Dataverse application user is bound to.")]
    [guid]$applicationId,

    [Parameter(HelpMessage = "Engage product the role is for: Present or Schedule. Default: Present.")]
    [ValidateSet('Present', 'Schedule')]
    [string]$product = 'Present',

    [Parameter(HelpMessage = "Name of the security role to create or update. Defaults to a name per product.")]
    [string]$roleName,

    [Parameter(HelpMessage = "Business unit for the role. Defaults to the environment's root business unit.")]
    [guid]$businessUnitId,

    [Parameter(HelpMessage = "Bearer token for the environment. Omit to acquire one interactively via Azure CLI.")]
    [string]$accessToken
)

# Creates (or re-trims) the Dataverse security role the Engage application user needs, and
# assigns it. Every privilege is at Global depth.
#
# Present - four privileges, and none on any business table:
#
#   prvReadEntity, prvReadAttribute, prvReadRelationship  - reading the schema
#   prvReadOrganization                                   - the SDK client's connect handshake
#
# Schedule - the same four, plus the record access the application identity itself uses:
#
#   prvReadUser                                           - matching advisors to their Dynamics users
#   prvReadActivity                                       - finding a booking's appointment
#   prvReadContact                                        - resolving customer attendees
#   prvWriteActivity, prvAppendActivity,
#   prvAppendToContact, prvAppendToUser                   - adding attendees to the appointment
#
# Everything else - creating, changing and cancelling bookings - runs as the signed-in
# advisor under their own role, so the application identity needs nothing more.
#
# Each product gets its own role name, so on an application user both products share, the
# two roles sit side by side and re-running one never trims the other.
#
# Why a script rather than the role editor: a role created in the modern editor arrives
# carrying ~80 privileges (and "Copy role" clones an equally large one), including workflow
# creation and SharePoint document writes. Trimming that by hand is ~80 toggles with no way
# to confirm the result. Creating the role through the Web API avoids the editor's template
# entirely, and the read-back below states what the role actually carries.
#
# Idempotent: an existing role of the same name in the same business unit is re-trimmed
# rather than duplicated, and an already-assigned role is left alone.
#
# Run as a System Administrator of the environment. The application user cannot modify its
# own role.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$schemaPrivileges = @('prvReadEntity', 'prvReadAttribute', 'prvReadRelationship', 'prvReadOrganization')
$productPrivileges = @{
    Present  = $schemaPrivileges
    Schedule = $schemaPrivileges + @(
        'prvReadUser', 'prvReadActivity', 'prvReadContact',
        'prvWriteActivity', 'prvAppendActivity', 'prvAppendToContact', 'prvAppendToUser'
    )
}
$defaultRoleNames = @{
    Present  = 'Engage Present - schema read'
    Schedule = 'Engage Schedule'
}
if ([string]::IsNullOrWhiteSpace($roleName)) {
    $roleName = $defaultRoleNames[$product]
}

$envUrl  = $environmentUrl.TrimEnd('/')
$apiRoot = "$envUrl/api/data/v9.2"

#################################################################################################################
# Token
#################################################################################################################
if ([string]::IsNullOrWhiteSpace($accessToken)) {
    # The Azure CLI's first-party client can obtain a delegated Dataverse token for the
    # signed-in admin, which avoids adding an app registration just to run this once.
    Write-Host -ForegroundColor Cyan "Acquiring a token for $envUrl via Azure CLI..."
    $accessToken = (az account get-access-token --resource $envUrl --query accessToken -o tsv)
    if ([string]::IsNullOrWhiteSpace($accessToken)) {
        Write-Host -ForegroundColor Red "Could not acquire a token. Run 'az login --tenant <tenant>' first,"
        Write-Host -ForegroundColor Red "or pass one with -accessToken."
        exit 1
    }
}

$headers = @{
    Authorization      = "Bearer $accessToken"
    'OData-MaxVersion' = '4.0'
    'OData-Version'    = '4.0'
    Accept             = 'application/json'
}

function Invoke-Dv {
    param([string]$Method, [string]$Path, $Body)
    $uri = if ($Path -match '^https?://') { $Path } else { "$apiRoot/$Path" }
    $args = @{ Method = $Method; Uri = $uri; Headers = $headers }
    if ($null -ne $Body) {
        $args.Body = ($Body | ConvertTo-Json -Depth 6)
        $args.ContentType = 'application/json'
    }
    return Invoke-RestMethod @args
}

#################################################################################################################
# Business unit
#################################################################################################################
if (-not $PSBoundParameters.ContainsKey('businessUnitId')) {
    $root = Invoke-Dv GET 'businessunits?$select=businessunitid,name&$filter=_parentbusinessunitid_value eq null'
    if ($root.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Expected exactly one root business unit, found $($root.value.Count)."
        Write-Host -ForegroundColor Red "Pass -businessUnitId explicitly."
        exit 1
    }
    $businessUnitId = $root.value[0].businessunitid
    Write-Host -ForegroundColor Cyan -NoNewline "Business unit: "
    Write-Host -ForegroundColor Yellow "$($root.value[0].name) ($businessUnitId)"
}

#################################################################################################################
# Role - find or create
#################################################################################################################
$escaped  = $roleName.Replace("'", "''")
$existing = Invoke-Dv GET "roles?`$select=roleid,name&`$filter=name eq '$escaped' and _businessunitid_value eq $businessUnitId"

if ($existing.value.Count -gt 1) {
    Write-Host -ForegroundColor Red "More than one role named '$roleName' in this business unit. Resolve by hand."
    exit 1
}

if ($existing.value.Count -eq 1) {
    $roleId = $existing.value[0].roleid
    Write-Host -ForegroundColor Yellow "Role '$roleName' already exists ($roleId) - its privileges will be replaced."
} else {
    $created = Invoke-Dv POST 'roles' @{
        name                        = $roleName
        'businessunitid@odata.bind' = "/businessunits($businessUnitId)"
    }
    # A create returns no body by default; read the role back by name rather than assume.
    $lookup = Invoke-Dv GET "roles?`$select=roleid,name&`$filter=name eq '$escaped' and _businessunitid_value eq $businessUnitId"
    if ($lookup.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Role was not created, or is ambiguous. Check the environment before re-running."
        exit 1
    }
    $roleId = $lookup.value[0].roleid
    Write-Host -ForegroundColor Green "SUCCESS >>> Role '$roleName' created ($roleId)."
}

#################################################################################################################
# Capture what the role carries now, before replacing it
#################################################################################################################
$before = Invoke-Dv GET "RetrieveRolePrivilegesRole(RoleId=$roleId)"
$beforeCount = @($before.RolePrivileges).Count
Write-Host -ForegroundColor Cyan -NoNewline "Privileges before: "
Write-Host -ForegroundColor Yellow "$beforeCount"
$backupPath = Join-Path (Get-Location) "role-$roleId-privileges-before.json"
$before | ConvertTo-Json -Depth 6 | Set-Content -Path $backupPath
Write-Host -ForegroundColor Cyan -NoNewline "Captured to:       "
Write-Host -ForegroundColor Yellow "$backupPath"

#################################################################################################################
# Replace with exactly the privileges the product needs
#################################################################################################################
$wanted = $productPrivileges[$product]
$privileges = @()
foreach ($name in $wanted) {
    $p = Invoke-Dv GET "privileges?`$select=privilegeid,name&`$filter=name eq '$name'"
    if ($p.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Privilege '$name' did not resolve to exactly one row."
        exit 1
    }
    $privileges += @{ PrivilegeId = $p.value[0].privilegeid; Depth = 'Global' }
}

Invoke-Dv POST "roles($roleId)/Microsoft.Dynamics.CRM.ReplacePrivilegesRole" @{ Privileges = $privileges } | Out-Null
Write-Host -ForegroundColor Green "SUCCESS >>> Privileges replaced."

#################################################################################################################
# Read the role back, so the run ends on observed state
#################################################################################################################
$after = Invoke-Dv GET "RetrieveRolePrivilegesRole(RoleId=$roleId)"
$afterIds = @($after.RolePrivileges | ForEach-Object { $_.PrivilegeId })
Write-Host
Write-Host -ForegroundColor Cyan "Privileges now on the role ($($afterIds.Count)):"
foreach ($id in $afterIds) {
    $n = Invoke-Dv GET "privileges($id)?`$select=name"
    Write-Host -ForegroundColor Yellow "  $($n.name)"
}
Write-Host
Write-Host -ForegroundColor Cyan "Expected: the $($wanted.Count) for $product. Four SharePoint privileges may also appear if the"
Write-Host -ForegroundColor Cyan "environment uses server-based SharePoint document management - those are imposed"
Write-Host -ForegroundColor Cyan "by the platform, not requested here."

#################################################################################################################
# Assign to the application user
#################################################################################################################
$appUser = Invoke-Dv GET "systemusers?`$select=systemuserid,fullname,isdisabled&`$filter=applicationid eq $applicationId"
if ($appUser.value.Count -ne 1) {
    Write-Host
    Write-Host -ForegroundColor Red "No application user bound to $applicationId in this environment."
    Write-Host -ForegroundColor Red "Create it first (Power Platform admin centre > Users + permissions > Application users),"
    Write-Host -ForegroundColor Red "then re-run - the role above is already in place."
    exit 1
}
$userId = $appUser.value[0].systemuserid
Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Application user:  "
Write-Host -ForegroundColor Yellow "$($appUser.value[0].fullname) ($userId), disabled=$($appUser.value[0].isdisabled)"

$assigned = Invoke-Dv GET "systemusers($userId)/systemuserroles_association?`$select=roleid"
if (@($assigned.value | Where-Object { $_.roleid -eq $roleId }).Count -gt 0) {
    Write-Host -ForegroundColor Green "Role already assigned - nothing to do."
} else {
    Invoke-Dv POST "systemusers($userId)/systemuserroles_association/`$ref" @{ '@odata.id' = "$apiRoot/roles($roleId)" } | Out-Null
    Write-Host -ForegroundColor Green "SUCCESS >>> Role assigned to the application user."
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Role id:   "
Write-Host -ForegroundColor Yellow "$roleId"
Write-Host -ForegroundColor Cyan -NoNewline "Undo:      "
Write-Host -ForegroundColor Yellow "delete the role if this run created it - its assignments go with it."
Write-Host -ForegroundColor Yellow "           Otherwise restore from $backupPath via ReplacePrivilegesRole,"
Write-Host -ForegroundColor Yellow "           and drop the assignment separately if this run added it."
