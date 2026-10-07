param (
    [Parameter(Mandatory = $true, HelpMessage = "Entra tenant id in which to create the SCIM applications (the consuming/bank tenant).")]
    [guid]$tenantId,

    [Parameter(Mandatory = $true, HelpMessage = "Engage environment the applications provision into: test or prod.")]
    [ValidateSet('test', 'prod')]
    [string]$environment,

    [Parameter(HelpMessage = "SCIM token from &money for this tenant and environment. Omit to be prompted without echo.")]
    [securestring]$scimToken,

    [Parameter(HelpMessage = "Display name prefix for the two enterprise applications.")]
    [string]$applicationName = "AndMoney SCIM"
)

# Creates the two Entra SCIM provisioning applications that push employees and meeting
# rooms to Engage - one for Advisors, one for Rooms - points each at its Engage endpoint
# with the SCIM token, sets the attribute mappings, and starts provisioning.
#
# Only users and groups assigned to an application are provisioned (SyncAll is off), so
# nothing reaches Engage until someone is assigned.
#
# Idempotent: applications are found by display name and reused, so a re-run updates the
# token and mappings rather than creating duplicates. Display names carry the environment,
# so test and prod live side by side in one tenant.
#
# To undo, delete the two applications listed under "Undo:" at the end of the run.
# Deleting the application also removes its service principal and provisioning job.
# Users already provisioned to Engage are not removed by deleting the application.
#
# Run by an admin of the target tenant. Application Administrator or Cloud Application
# Administrator is sufficient; Global Administrator is not required.
#
# Signing in consents the Microsoft first-party app "Microsoft Graph Command Line Tools" to
# the scopes below, which leaves a tenant-wide grant for that app behind after this script
# exits. Revoke it under Enterprise applications > Microsoft Graph Command Line Tools >
# Permissions if tenant policy disallows standing admin-tooling consent.

#Requires -Modules Microsoft.Graph.Authentication

## To run the cmdlets in this script, you need the Microsoft Graph module installed.
# Install-Module Microsoft.Graph.Authentication

Import-Module Microsoft.Graph.Authentication

$ErrorActionPreference = 'Stop'

# Microsoft's template for a non-gallery application that provisions over SCIM.
$scimApplicationTemplateId = '8adf8e6e-67b2-4cf2-a259-e3dc5476c621'

$endpoints = @{
    test = @{ Advisors = 'https://api.test-env.booking.andmoney.dk/advisors/scim'; Rooms = 'https://api.test-env.booking.andmoney.dk/rooms/scim' }
    prod = @{ Advisors = 'https://api.booking.andmoney.dk/advisors/scim'; Rooms = 'https://api.booking.andmoney.dk/rooms/scim' }
}
$environmentLabel = @{ test = 'Test'; prod = 'Production' }[$environment]

# Target SCIM attribute <- Entra source attribute. "active" is handled separately: it keeps
# the template's soft-delete expression, so a deleted user is deactivated in Engage.
$userMappings = [ordered]@{
    'userName'                            = 'userPrincipalName'
    'displayName'                         = 'displayName'
    'name.givenName'                      = 'givenName'
    'name.familyName'                     = 'surname'
    'addresses[type eq "work"].formatted' = 'physicalDeliveryOfficeName'
    'externalId'                          = 'objectId'
}
$roomMappings = [ordered]@{
    'userName'                            = 'userPrincipalName'
    'displayName'                         = 'displayName'
    'addresses[type eq "work"].formatted' = 'physicalDeliveryOfficeName'
    'externalId'                          = 'objectId'
}

if ($null -eq $scimToken) {
    $scimToken = Read-Host -AsSecureString "SCIM token for $environmentLabel"
}
$scimTokenPlain = [System.Net.NetworkCredential]::new('', $scimToken).Password
if ([string]::IsNullOrWhiteSpace($scimTokenPlain)) {
    Write-Host -ForegroundColor Red "No SCIM token given. Ask &money for the token for this tenant and environment."
    exit 1
}

# ContextScope Process keeps the token cache in memory, so no bank-tenant Graph context
# outlives the run. The resulting context is then asserted against $tenantId: a cancelled
# or expired sign-in can otherwise leave an earlier tenant's context live.
Connect-MgGraph -TenantId $tenantId -Scopes "Application.ReadWrite.All", "Synchronization.ReadWrite.All" -ContextScope Process -NoWelcome

$context = Get-MgContext
if ($null -eq $context -or [guid]$context.TenantId -ne $tenantId) {
    Write-Host -ForegroundColor Red "Signed in to tenant '$($context.TenantId)', expected '$tenantId'."
    Write-Host -ForegroundColor Red "Sign in as an admin of the target tenant and re-run."
    Disconnect-MgGraph | Out-Null
    exit 1
}

function Invoke-Graph {
    param([string]$Method, [string]$Path, $Body)
    $uri = "https://graph.microsoft.com/v1.0/$Path"
    if ($null -ne $Body) {
        $json = if ($Body -is [string]) { $Body } else { $Body | ConvertTo-Json -Depth 100 -Compress }
        return Invoke-MgGraphRequest -Method $Method -Uri $uri -Body $json -ContentType 'application/json' -OutputType PSObject
    }
    return Invoke-MgGraphRequest -Method $Method -Uri $uri -OutputType PSObject
}

# Entra creates the service principal and its provisioning job asynchronously; calls made
# too early fail with 404 or 400. Retry those for a bounded time rather than sleeping blind.
function Invoke-WithRetry {
    param([scriptblock]$Action, [string]$What, [int]$TimeoutSeconds = 180)
    $deadline = (Get-Date).AddSeconds($TimeoutSeconds)
    while ($true) {
        try {
            return & $Action
        } catch {
            if ((Get-Date) -gt $deadline) {
                Write-Host -ForegroundColor Red "Timed out waiting for Entra while trying to $What."
                throw
            }
            Write-Host -ForegroundColor Gray "  Waiting for Entra to finish creating the application ($What)..."
            Start-Sleep -Seconds 10
        }
    }
}

function Set-AttributeMappings {
    param([string]$servicePrincipalId, [string]$jobId, [System.Collections.Specialized.OrderedDictionary]$mappings)

    # The schema PUT replaces the whole schema, so read it, change only the user mappings
    # of the Entra-to-SCIM rule, and write everything else back as read.
    $schema = Invoke-Graph GET "servicePrincipals/$servicePrincipalId/synchronization/jobs/$jobId/schema"
    $userMapping = $null
    foreach ($rule in $schema.synchronizationRules) {
        foreach ($objectMapping in $rule.objectMappings) {
            if ($objectMapping.sourceObjectName -eq 'User') { $userMapping = $objectMapping }
        }
    }
    if ($null -eq $userMapping) {
        throw "The provisioning schema has no user mapping to configure."
    }

    $active = $userMapping.attributeMappings | Where-Object { $_.targetAttributeName -eq 'active' } | Select-Object -First 1
    if ($null -eq $active) {
        throw "The provisioning schema has no 'active' mapping to keep."
    }

    $new = @($active)
    foreach ($target in $mappings.Keys) {
        $sourceName = $mappings[$target]
        $new += [pscustomobject]@{
            source                  = [pscustomobject]@{ expression = "[$sourceName]"; name = $sourceName; parameters = @(); type = 'Attribute' }
            targetAttributeName     = $target
            flowType                = 'Always'
            flowBehavior            = 'FlowWhenChanged'
            # userName is the matching attribute, as in the template.
            matchingPriority        = if ($target -eq 'userName') { 1 } else { 0 }
            defaultValue            = $null
            exportMissingReferences = $false
        }
    }
    $userMapping.attributeMappings = $new

    Invoke-Graph PUT "servicePrincipals/$servicePrincipalId/synchronization/jobs/$jobId/schema" $schema | Out-Null
}

function Enable-ScimApplication {
    param([string]$kind, [System.Collections.Specialized.OrderedDictionary]$mappings)

    $displayName = "$applicationName - $kind ($environmentLabel)"
    $scimUrl = $endpoints[$environment][$kind]
    Write-Host
    Write-Host -ForegroundColor Cyan "$displayName -> $scimUrl"

    #############################################################################################################
    # Find or create the application
    #############################################################################################################
    $escaped = $displayName.Replace("'", "''")
    $existing = @((Invoke-Graph GET "servicePrincipals?`$filter=displayName eq '$escaped'&`$select=id,appId,displayName").value)
    if ($existing.Count -gt 1) {
        throw "More than one application named '$displayName' in this tenant. Delete the extras, then re-run."
    }

    if ($existing.Count -eq 1) {
        $servicePrincipalId = $existing[0].id
        $appId = $existing[0].appId
        Write-Host -ForegroundColor Yellow "  Application already exists - reusing it."
    } else {
        $created = Invoke-Graph POST "applicationTemplates/$scimApplicationTemplateId/instantiate" @{ displayName = $displayName }
        $servicePrincipalId = $created.servicePrincipal.id
        $appId = $created.application.appId
        Write-Host -ForegroundColor Green "  SUCCESS >>> Application created."
    }
    $application = Invoke-WithRetry -What "read the application" -Action {
        Invoke-Graph GET "applications(appId='$appId')?`$select=id"
    }

    #############################################################################################################
    # Find or create the provisioning job
    #############################################################################################################
    $job = Invoke-WithRetry -What "create the provisioning job" -Action {
        $jobs = @((Invoke-Graph GET "servicePrincipals/$servicePrincipalId/synchronization/jobs").value)
        if ($jobs.Count -gt 0) { $jobs[0] }
        else { Invoke-Graph POST "servicePrincipals/$servicePrincipalId/synchronization/jobs" @{ templateId = 'scim' } }
    }

    #############################################################################################################
    # Endpoint and token
    #############################################################################################################
    Invoke-WithRetry -What "set the endpoint and token" -Action {
        Invoke-Graph PUT "servicePrincipals/$servicePrincipalId/synchronization/secrets" @{
            value = @(
                @{ key = 'BaseAddress'; value = $scimUrl }
                @{ key = 'SecretToken'; value = $scimTokenPlain }
                @{ key = 'SyncNotificationSettings'; value = '{"Enabled":false,"DeleteThresholdEnabled":false}' }
                @{ key = 'SyncAll'; value = 'false' }
            )
        } | Out-Null
    } | Out-Null
    Write-Host -ForegroundColor Green "  SUCCESS >>> Endpoint and token set."

    #############################################################################################################
    # Attribute mappings
    #############################################################################################################
    Invoke-WithRetry -What "set the attribute mappings" -Action {
        Set-AttributeMappings -servicePrincipalId $servicePrincipalId -jobId $job.id -mappings $mappings
    } | Out-Null
    Write-Host -ForegroundColor Green "  SUCCESS >>> Attribute mappings set."

    #############################################################################################################
    # Start provisioning
    #############################################################################################################
    # The schedule state says whether provisioning has been started; the last-run status
    # stays "NotRun" until a cycle completes, and starting a running job again can stop it.
    $schedule = (Invoke-Graph GET "servicePrincipals/$servicePrincipalId/synchronization/jobs/$($job.id)").schedule.state
    if ($schedule -eq 'Active') {
        Write-Host -ForegroundColor Green "  Provisioning already running."
    } else {
        Invoke-Graph POST "servicePrincipals/$servicePrincipalId/synchronization/jobs/$($job.id)/start" | Out-Null
        Write-Host -ForegroundColor Green "  SUCCESS >>> Provisioning started."
    }

    #############################################################################################################
    # Read back, so the run ends on observed state
    #############################################################################################################
    $schema = Invoke-Graph GET "servicePrincipals/$servicePrincipalId/synchronization/jobs/$($job.id)/schema"
    foreach ($rule in $schema.synchronizationRules) {
        foreach ($objectMapping in $rule.objectMappings | Where-Object { $_.sourceObjectName -eq 'User' }) {
            Write-Host -ForegroundColor Cyan "  Mappings now:"
            foreach ($m in $objectMapping.attributeMappings) {
                Write-Host -ForegroundColor Yellow ("    {0,-38} <- {1}" -f $m.targetAttributeName, $m.source.expression)
            }
        }
    }

    return [pscustomobject]@{ Name = $displayName; ApplicationObjectId = $application.id }
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Tenant:      "
Write-Host -ForegroundColor Yellow "$tenantId"
Write-Host -ForegroundColor Cyan -NoNewline "Environment: "
Write-Host -ForegroundColor Yellow "$environmentLabel"

$results = @(
    Enable-ScimApplication -kind 'Advisors' -mappings $userMappings
    Enable-ScimApplication -kind 'Rooms' -mappings $roomMappings
)

Write-Host
Write-Host -ForegroundColor Cyan "Next: assign your advisors to the Advisors application and your meeting rooms to the"
Write-Host -ForegroundColor Cyan "Rooms application (Enterprise applications > the application > Users and groups)."
Write-Host
Write-Host -ForegroundColor Cyan "Undo:"
foreach ($r in $results) {
    Write-Host -ForegroundColor Yellow "  Invoke-MgGraphRequest -Method DELETE -Uri https://graph.microsoft.com/v1.0/applications/$($r.ApplicationObjectId)   # $($r.Name)"
}

$scimTokenPlain = $null
Disconnect-MgGraph | Out-Null
