---
layout: default
title: Enable-SCIM-Provisioning.ps1
nav_order: 5
parent: BookMe
collection: bookme
---
# Enable-SCIM-Provisioning.ps1
```PowerShell
param (
  [string] $ApplicationName, # The name of the application to create. Choose a name that are easily distinguishable from other applications (Default: BookMe - SCIM integration)
  [string] $TenantId, # The tenant ID to use - this should be the bank's tenant ID (required)
  [string] $Environment, # The environment to use (dev, test, prod, Default: Test)
  [string] $ScimToken # The SCIM token from &money. This is a secret token that is used to authenticate the SCIM requests and is specific to the TenantId (required)
)

$ErrorActionPreference = "Stop"

if (Get-Module -ListAvailable -Name Microsoft.Graph.Applications && Get-Module -ListAvailable -Name Microsoft.Graph.Authentication) {
  Write-Host "Modules for Microsoft.Graph.Applications and Microsoft.Graph.Authentication are imported"
} 
else {
  Install-Module Microsoft.Graph.Applications -Force
  Install-Module Microsoft.Graph.Authentication -Force
  Import-Module Microsoft.Graph.Applications
  Import-Module Microsoft.Graph.Authentication
}

function New-AppRegistration {
  param (
    [string] $ApplicationName,
    [string] $Environment,
    [string] $TenantId
  )

  $CalendarsReadWriteScope = Find-MgGraphPermission -SearchString Calendars.ReadWrite -PermissionType Application -ExactMatch -ErrorAction Stop

  Write-Host "Creating AppRegistraiton with the following permissions:"
  Write-Host $CalendarsReadWriteScope

  $CreateAppParams = @{
    DisplayName            = "$($ApplicationName) - $($Environment)"
    RequiredResourceAccess = @{
      ResourceAppId  = "00000003-0000-0000-c000-000000000000"
      ResourceAccess = @(
        @{
          Id   = $CalendarsReadWriteScope.Id
          Type = "Role"
        }
      )

    }
  }

  $appRegistration = New-MgApplication @CreateAppParams -ErrorAction Stop

  $clientSecret = Add-MgApplicationPassword -ApplicationId $appRegistration.Id `
    -PasswordCredential @{ DisplayName = "Automated" } -ErrorAction Stop

  Write-Host
  Write-Host -ForegroundColor Gray "Created App registration '$($CreateAppParams.DisplayName)' >>"
  Write-Host -ForegroundColor Cyan -NoNewline "Application ID: "
  Write-Host -ForegroundColor Yellow $appRegistration.Id

  Write-Host -ForegroundColor Cyan -NoNewline "Client ID: "
  Write-Host -ForegroundColor Yellow $appRegistration.Id

  if ($null -ne $clientSecret) {
    Write-Host -ForegroundColor Cyan -NoNewline "Client secret: "
    Write-Host -ForegroundColor Yellow $clientSecret.SecretText " (Expires: $($clientSecret.EndDateTime))"
  }

  Write-Host -ForegroundColor Green "SUCCESS >> App registration '$($CreateAppParams.DisplayName)' created <<"
  Write-Host
}

function Add-ScimServicePrincipal {
  param (
    [string] $ApplicationName,
    [string] $Environment,
    [string] $TenantId,
    [string] $ScimUrl,
    [string] $ScimToken
  )

  # A uniqiue identifier for the application template
  $applicationTemplateId = "8adf8e6e-67b2-4cf2-a259-e3dc5476c621"

  $params = @{
    displayName = "$($ApplicationName) - $(Get-Date)"
  }

  $servicePrincipal = Invoke-MgInstantiateApplicationTemplate -ApplicationTemplateId $applicationTemplateId -BodyParameter $params

  Write-Host -ForegroundColor Cyan "Service principal for SCIM Provisioning Jobs created $($servicePrincipal.ServicePrincipal.Id)"
  Write-Host
    
  $timeout = 120 # Timeout in seconds
  $interval = 5 # Interval to check in seconds
  $startTime = Get-Date
  $extraDelay = 60 # Extra delay in seconds

  Write-Host -ForegroundColor Gray "Waiting for the service principal and its permissions to fully propagate..."
    
  while ($true) {
    $spExists = Get-MgServicePrincipal -Filter "id eq '$($servicePrincipal.ServicePrincipal.Id)'" -ErrorAction SilentlyContinue
    if ($spExists) {
      Write-Host -ForegroundColor Cyan "Service principal is now available."
      break
    }
    
    if ((Get-Date) -gt $startTime.AddSeconds($timeout)) {
      Write-Error "Timed out waiting for the service principal to propagate."
      Exit
    }
    
    Start-Sleep -Seconds $interval
  }

  $jobParams = @{
    templateId = "scim"
  }

  Write-Host -ForegroundColor Gray "Waiting an additional $extraDelay seconds for full propagation before creating SynchronizationJob"
  Write-Host
  Start-Sleep -Seconds $extraDelay
    
  $syncJob = New-MgServicePrincipalSynchronizationJob -ServicePrincipalId $servicePrincipal.ServicePrincipal.Id -BodyParameter $jobParams
    
  $params = @{
    value = @(
      @{
        key   = "BaseAddress"
        value = $ScimUrl
      }
      @{
        key   = "SecretToken"
        value = $ScimToken
      }
      @{
        key   = "SyncNotificationSettings"
        value = '{"Enabled":false,"DeleteThresholdEnabled":false}'
      }
      @{
        key   = "SyncAll"
        value = "false"
      }
    )
  }

  Set-MgServicePrincipalSynchronizationSecret -ServicePrincipalId $servicePrincipal.ServicePrincipal.Id -BodyParameter $params

  Write-Host -ForegroundColor Gray "SynchronizationJob created: $($syncJob.Id)"
  Write-Host -ForegroundColor Gray "Waiting $extraDelay seconds for full propagation of SynchronizationJob"
  Start-Sleep -Seconds $extraDelay

  Write-Host -ForegroundColor Gray "Starting SynchronizationJob..."
  Start-MgServicePrincipalSynchronizationJob -ServicePrincipalId $servicePrincipal.ServicePrincipal.Id -SynchronizationJobId $syncJob.Id
}

function Enable-SCIM-Provisioning {
  param (
    [string] $ApplicationName = "BookMe - SCIM integration",
    [string] $Environment = "Test",
    [string] $TenantId,
    [string] $ScimToken
  )

  $envName = $Environment.ToLowerInvariant()
  $scimAdvisorUrl = "https://api.dev-env.booking.andmoney.dk/advisors/scim"
  $scimRoomUrl = "https://api.dev-env.booking.andmoney.dk/rooms/scim"

  if ($envName -eq 'dev') {
    $scimAdvisorUrl = "https://api.dev-env.booking.andmoney.dk/advisors/scim"
    $scimRoomUrl = "https://api.dev-env.booking.andmoney.dk/rooms/scim"
  }
  elseif ($envName -eq 'test') {
    $scimAdvisorUrl = "https://api.test-env.booking.andmoney.dk/advisors/scim"
    $scimRoomUrl = "https://api.test-env.booking.andmoney.dk/rooms/scim"
  }
  elseif ($envName -eq 'prod') {
    $scimAdvisorUrl = "https://api.booking.andmoney.dk/advisors/scim"
    $scimRoomUrl = "https://api.booking.andmoney.dk/rooms/scim"
  }
  else {
    Write-Host -ForegroundColor Red "Invalid environment name: $envName"
    exit 1
  }

  Connect-MgGraph -Scopes "Application.ReadWrite.All,Synchronization.ReadWrite.All" -TenantId $TenantId -NoWelcome

  New-AppRegistration -ApplicationName $ApplicationName -Environment $Environment -TenantId $TenantId

  Add-ScimServicePrincipal -Environment $Environment -TenantId $TenantId -ApplicationName "$($ApplicationName) - Advisors" -ScimUrl $scimAdvisorUrl -ScimToken $ScimToken
  Add-ScimServicePrincipal -Environment $Environment -TenantId $TenantId -ApplicationName "$($ApplicationName) - Rooms" -ScimUrl $scimRoomUrl -ScimToken $ScimToken
}

Enable-SCIM-Provisioning -ApplicationName $ApplicationName -Environment $Environment -TenantId $TenantId -ScimToken $ScimToken
```
