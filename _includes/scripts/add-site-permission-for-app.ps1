param (
    [Parameter(Mandatory = $true, HelpMessage = "Entra tenant id in which to record the permission (the consuming/bank tenant).")]
    [guid]$tenantId,

    [Parameter(Mandatory = $true, HelpMessage = "SharePoint host name, e.g. 'bank.sharepoint.com' - bare host, no scheme or path.")]
    [string]$siteHostname,

    [Parameter(Mandatory = $true, HelpMessage = "Server-relative site path, e.g. '/sites/decks'.")]
    [string]$sitePath,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) of the application receiving access to the site.")]
    [guid]$clientAppId,

    [Parameter(HelpMessage = "Label recorded next to the app on the permission. Defaults to the application's display name, falling back to its app id.")]
    [string]$clientAppDisplayName,

    [Parameter(HelpMessage = "Role to grant on the site. Default: write.")]
    [ValidateSet('read', 'write')]
    [string]$role = 'write'
)

# Grants an application access to ONE SharePoint site (a site permission), which is
# what the delegated/application Sites.Selected scope needs before it reaches any
# site at all. Sites.Selected on its own grants nothing; this is the second half.
#
# Idempotent: an application already holding the requested role on the site is left
# alone. An application holding a DIFFERENT role is reported rather than silently
# changed - dropping someone from write to read (or the reverse) is not a decision
# this script should make on its own.
#
# To undo, use the command printed under "Undo:" at the end of the run. Deleting the
# site permission is the correct way to revoke this access: removing or reinstalling
# the enterprise application does NOT, because a site permission identifies the
# application by client id rather than by service-principal object id, so a recreated
# principal inherits it.
#
# Run by an admin of the target tenant. Recording a site permission requires
# Sites.FullControl.All, which in practice means SharePoint Administrator or Global
# Administrator.
#
# Signing in consents the Microsoft first-party app "Microsoft Graph Command Line
# Tools" to the scope below, which leaves a tenant-wide grant for that app behind
# after this script exits. Revoke it under Enterprise applications > Microsoft Graph
# Command Line Tools > Permissions if tenant policy disallows standing admin-tooling
# consent.

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Sites

## To run the cmdlets in this script, you need the Microsoft Graph module installed.
# Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Sites

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Sites

# ContextScope Process keeps the token cache in memory, so no bank-tenant Graph
# context outlives the run. The resulting context is then asserted against $tenantId:
# a cancelled or expired sign-in can otherwise leave an earlier tenant's context live,
# and this script writes a permission into whichever tenant it is connected to.
Connect-MgGraph -TenantId $tenantId -Scopes "Sites.FullControl.All" -ContextScope Process -NoWelcome -ErrorAction Stop

$context = Get-MgContext
if ($null -eq $context -or [guid]$context.TenantId -ne $tenantId) {
    Write-Host -ForegroundColor Red "Signed in to tenant '$($context.TenantId)', expected '$tenantId'."
    Write-Host -ForegroundColor Red "Sign in as an admin of the target tenant and re-run."
    Disconnect-MgGraph | Out-Null
    exit 1
}

#################################################################################################################
# Resolve the site
#################################################################################################################
# Graph addresses a site as "{hostname}:{server-relative-path}". A ':' inside the path
# would split that address early and silently resolve a different site, so the path is
# rejected rather than normalised.
$trimmedPath = $sitePath.TrimEnd('/')
if (-not $trimmedPath.StartsWith('/') -or $trimmedPath.IndexOfAny(@(':', '#', '%', '?', ';')) -ge 0) {
    Write-Host -ForegroundColor Red "sitePath must be server-relative, start with '/', and contain none of : # % ? ;"
    Disconnect-MgGraph | Out-Null
    exit 1
}

$siteAddress = "$($siteHostname):$trimmedPath"
# The underlying error is reported rather than swallowed: a site that does not exist
# and a lookup refused for want of consent are different problems, and reporting both
# as "no such site" sends the reader after the wrong one.
try {
    $site = Get-MgSite -SiteId $siteAddress -ErrorAction Stop
} catch {
    Write-Host -ForegroundColor Red "Could not read a SharePoint site at '$siteAddress' in tenant $tenantId."
    Write-Host -ForegroundColor Red $_.Exception.Message
    Write-Host -ForegroundColor Red "Check the host name and server-relative path, that the site exists, and that Sites.FullControl.All was consented."
    Disconnect-MgGraph | Out-Null
    exit 1
}

# SharePoint rejects the create call below with a bare 400 'invalidRequest' when the
# application identity carries no displayName, so a label is always sent. Reading the
# service principal keeps the site's permission list legible, but needs directory read
# access this script does not ask for, so the app id stands in when that read fails.
if ([string]::IsNullOrWhiteSpace($clientAppDisplayName)) {
    try {
        $spQuery = "https://graph.microsoft.com/v1.0/servicePrincipals?`$filter=appId eq '$clientAppId'&`$select=displayName"
        $clientAppDisplayName = (Invoke-MgGraphRequest -Method GET -Uri $spQuery -ErrorAction Stop).value[0].displayName
    } catch {
        $clientAppDisplayName = $null
    }
    if ([string]::IsNullOrWhiteSpace($clientAppDisplayName)) {
        $clientAppDisplayName = $clientAppId.ToString()
    }
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Tenant:   "
Write-Host -ForegroundColor Yellow "$tenantId"
Write-Host -ForegroundColor Cyan -NoNewline "Site:     "
Write-Host -ForegroundColor Yellow "$($site.DisplayName) ($($site.WebUrl))"
Write-Host -ForegroundColor Cyan -NoNewline "App:      "
Write-Host -ForegroundColor Yellow "$clientAppDisplayName ($clientAppId)"
Write-Host -ForegroundColor Cyan -NoNewline "Role:     "
Write-Host -ForegroundColor Yellow "$role"
Write-Host

#################################################################################################################
# Upsert the site permission
#################################################################################################################
# A site carries at most one permission entry per application, so an existing entry is
# matched on the application's client id rather than created alongside.
$existing = Get-MgSitePermission -SiteId $site.Id -All -ErrorAction Stop |
    Where-Object { $_.GrantedToIdentitiesV2.Application.Id -contains $clientAppId.ToString() }

if ($null -ne $existing) {
    $currentRoles = @($existing.Roles)
    if ($currentRoles -contains $role) {
        Write-Host -ForegroundColor Green "Already granted '$role' - nothing to do."
        $permissionId = $existing.Id
        $undo = "Remove-MgSitePermission -SiteId '$($site.Id)' -PermissionId $permissionId"
    } else {
        Write-Host -ForegroundColor Yellow "The application already holds a different role on this site: $($currentRoles -join ', ')."
        Write-Host -ForegroundColor Yellow "Permission id: $($existing.Id)"
        Write-Host -ForegroundColor Yellow "Change it deliberately with Update-MgSitePermission, or remove it and re-run."
        Disconnect-MgGraph | Out-Null
        exit 1
    }
} else {
    $body = @{
        roles = @($role)
        grantedToIdentities = @(
            @{ application = @{ id = $clientAppId.ToString(); displayName = $clientAppDisplayName } }
        )
    }
    $new = New-MgSitePermission -SiteId $site.Id -BodyParameter $body -ErrorAction Stop
    if ($null -eq $new -or [string]::IsNullOrWhiteSpace($new.Id)) {
        Write-Host -ForegroundColor Red "The create call returned no permission id, so no permission was written."
        Write-Host -ForegroundColor Red "Check the state with Get-MgSitePermission before re-running."
        Disconnect-MgGraph | Out-Null
        exit 1
    }
    $permissionId = $new.Id
    Write-Host -ForegroundColor Green "SUCCESS >>> Site permission created."
    $undo = "Remove-MgSitePermission -SiteId '$($site.Id)' -PermissionId $permissionId"
}

#################################################################################################################
# Read back what the site now carries, so the run ends on observed state
#################################################################################################################
Write-Host
Write-Host -ForegroundColor Cyan "Permissions now on this site:"
Get-MgSitePermission -SiteId $site.Id -All -ErrorAction Stop | ForEach-Object {
    $apps = @($_.GrantedToIdentitiesV2.Application | Where-Object { $_ } | ForEach-Object { "$($_.DisplayName) ($($_.Id))" })
    Write-Host -ForegroundColor Yellow "  $($_.Id)  roles=$($_.Roles -join ',')  $($apps -join '; ')"
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Site id:  "
Write-Host -ForegroundColor Yellow "$($site.Id)"
Write-Host -ForegroundColor Cyan -NoNewline "Perm id:  "
Write-Host -ForegroundColor Yellow "$permissionId"
Write-Host -ForegroundColor Cyan -NoNewline "Undo:     "
Write-Host -ForegroundColor Yellow $undo

Disconnect-MgGraph | Out-Null
