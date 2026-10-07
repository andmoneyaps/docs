param (
    [Parameter(Mandatory = $true, HelpMessage = "Entra tenant id in which to create the grant (the consuming/bank tenant).")]
    [guid]$tenantId,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) of the client application whose service principal receives the grant.")]
    [guid]$clientAppId,

    [Parameter(HelpMessage = "AppId of the resource API. Default: Dataverse (Dynamics CRM).")]
    [guid]$resourceAppId = '00000007-0000-0000-c000-000000000000',

    [Parameter(HelpMessage = "Delegated permission (scope) value to grant. Default: user_impersonation.")]
    [string]$scope = 'user_impersonation'
)

# Grants a delegated permission directly on the client app's SERVICE PRINCIPAL in
# the given tenant (an oauth2PermissionGrant), without touching the app
# registration's manifest. Use when a permission applies only to some consuming
# tenants - e.g. Dataverse user_impersonation for Dynamics banks - and must not
# appear in every tenant's consent prompt. The /adminconsent endpoint cannot do
# this (it only grants manifest-advertised permissions), hence this Graph write.
#
# Idempotent upsert: a client/resource pair holds at most one AllPrincipals grant,
# whose Scope is a space-separated list; re-running appends the scope or no-ops.
# Graph's grant list reads lag writes by seconds, so allow a moment between runs
# against the same pair - an immediate re-run can miss the new row and attempt a
# duplicate create, which Graph rejects with a key conflict.
#
# To undo, use the command printed under "Undo:" at the end of the run. It differs
# per path: a grant this script created is deleted outright, whereas a scope
# appended to a pre-existing grant is removed by writing the original Scope list
# back. Deleting a pre-existing grant would revoke every other delegated
# permission the client app holds tenant-wide.
#
# Run by an admin of the target tenant. Application Administrator is sufficient;
# so are Cloud Application
# Administrator, Directory Writers, Privileged Role Administrator and User
# Administrator. Global Administrator is not required.
#
# Signing in consents the Microsoft first-party app "Microsoft Graph Command Line
# Tools" to the scopes below, which leaves a tenant-wide grant for that app behind
# after this script exits. Revoke it under Enterprise applications > Microsoft
# Graph Command Line Tools > Permissions if tenant policy disallows standing
# admin-tooling consent.

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns

## To run the cmdlets in this script, you need the Microsoft Graph module installed.
# Command to run in Powershell shell: Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns
# Check if installed: Get-InstalledModule -Name Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Applications
Import-Module Microsoft.Graph.Identity.SignIns

# ContextScope Process keeps the token cache in memory, so no bank-tenant Graph
# context outlives the run on the operator's machine. The resulting context is
# then asserted against $tenantId: a cancelled or expired sign-in can otherwise
# leave an earlier tenant's context live, and the grant written below is
# tenant-wide. Get-MgContext rather than Get-MgOrganization, so the assert needs
# no user-read scope on the bank's consent prompt.
Connect-MgGraph -TenantId $tenantId -Scopes "Application.Read.All", "DelegatedPermissionGrant.ReadWrite.All" -ContextScope Process -NoWelcome -ErrorAction Stop

$context = Get-MgContext
if ($null -eq $context -or [guid]$context.TenantId -ne $tenantId) {
    Write-Host -ForegroundColor Red "Signed in to tenant '$($context.TenantId)', expected '$tenantId'."
    Write-Host -ForegroundColor Red "Sign in as an admin of the target tenant and re-run."
    exit 1
}

#################################################################################################################
# Resolve the two service principals in the target tenant
#################################################################################################################
$clientSp = Get-MgServicePrincipal -Filter "appId eq '$clientAppId'" -ErrorAction Stop
if ($null -eq $clientSp) {
    Write-Host -ForegroundColor Red "No service principal for appId $clientAppId in tenant $tenantId."
    Write-Host -ForegroundColor Red "The application must be installed (admin-consented) in this tenant first."
    exit 1
}

$resourceSp = Get-MgServicePrincipal -Filter "appId eq '$resourceAppId'" -ErrorAction Stop
if ($null -eq $resourceSp) {
    Write-Host -ForegroundColor Red "No service principal for resource appId $resourceAppId in tenant $tenantId."
    Write-Host -ForegroundColor Red "For Dataverse this means the tenant has no Dynamics/Power Platform footprint."
    exit 1
}

# Entra accepts grants for scope values the resource never published; guard against
# typos. Disabled scopes are excluded - a grant naming one is silently ignored at
# token time. Matching is case-sensitive because Entra's scope matching is too.
$publishedScopes = @($resourceSp.Oauth2PermissionScopes | Where-Object { $_.IsEnabled } | ForEach-Object { $_.Value })
if ($publishedScopes -cnotcontains $scope) {
    Write-Host -ForegroundColor Red "Resource '$($resourceSp.DisplayName)' does not publish an enabled delegated permission named '$scope'."
    Write-Host -ForegroundColor Red "Published scopes: $($publishedScopes -join ', ')"
    Write-Host -ForegroundColor Red "If the scope was published on the app registration only recently, this tenant's copy of the"
    Write-Host -ForegroundColor Red "service principal may be stale: run Update-MgServicePrincipalByAppId -AppId $resourceAppId here first."
    exit 1
}

#################################################################################################################
# Show what is about to be consented, while it is still avoidable
#################################################################################################################
Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Tenant:   "
Write-Host -ForegroundColor Yellow "$tenantId"
Write-Host -ForegroundColor Cyan -NoNewline "Client:   "
Write-Host -ForegroundColor Yellow "$($clientSp.DisplayName) ($clientAppId, SP $($clientSp.Id))"
Write-Host -ForegroundColor Cyan -NoNewline "Resource: "
Write-Host -ForegroundColor Yellow "$($resourceSp.DisplayName) ($resourceAppId)"
Write-Host

#################################################################################################################
# Upsert the AllPrincipals grant
#################################################################################################################
$grant = Get-MgOauth2PermissionGrant -Filter "clientId eq '$($clientSp.Id)' and consentType eq 'AllPrincipals'" -All -ErrorAction Stop |
    Where-Object { $_.ResourceId -eq $resourceSp.Id }

if ($null -ne $grant) {
    $grantId = $grant.Id
    $scopes = @($grant.Scope -split '\s+' | Where-Object { $_ })
    # Case-sensitive: a row differing only by casing is a different scope to Entra,
    # so treating it as a match would report success on a grant that never applies.
    if ($scopes -ccontains $scope) {
        Write-Host -ForegroundColor Green "Already granted - nothing to do."
        $finalScopes = $scopes
        $undo = $null
    } else {
        $finalScopes = $scopes + $scope
        Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId -Scope ($finalScopes -join ' ') -ErrorAction Stop
        Write-Host -ForegroundColor Green "SUCCESS >>> Appended '$scope' to the existing grant."
        # The grant pre-dates this run and carries scopes this run did not add, so
        # undo restores the captured list instead of deleting the grant.
        $undo = "Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId -Scope '$($scopes -join ' ')'"
    }
} else {
    $newGrant = New-MgOauth2PermissionGrant -ClientId $clientSp.Id -ConsentType 'AllPrincipals' -ResourceId $resourceSp.Id -Scope $scope -ErrorAction Stop
    if ($null -eq $newGrant -or [string]::IsNullOrWhiteSpace($newGrant.Id)) {
        Write-Host -ForegroundColor Red "The create call returned no grant id, so no grant was written."
        Write-Host -ForegroundColor Red "Check the state with Get-MgOauth2PermissionGrant before re-running."
        exit 1
    }
    $grantId = $newGrant.Id
    $finalScopes = @($scope)
    Write-Host -ForegroundColor Green "SUCCESS >>> Grant created."
    $undo = "Remove-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId"
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Scopes:   "
Write-Host -ForegroundColor Yellow ($finalScopes -join ' ')
Write-Host -ForegroundColor Cyan -NoNewline "Consent:  "
Write-Host -ForegroundColor Yellow "AllPrincipals (tenant-wide)"
Write-Host -ForegroundColor Cyan -NoNewline "Grant id: "
Write-Host -ForegroundColor Yellow "$grantId"
if ($null -ne $undo) {
    Write-Host -ForegroundColor Cyan -NoNewline "Undo:     "
    Write-Host -ForegroundColor Yellow $undo
}

Disconnect-MgGraph | Out-Null
