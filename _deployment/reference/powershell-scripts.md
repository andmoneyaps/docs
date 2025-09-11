---
layout: default
title: PowerShell Automation
nav_order: 2
parent: Technical Reference
grand_parent: Platform Deployment
---

# PowerShell Scripts Reference

This section provides documentation for PowerShell scripts used in manual or automated BookMe deployment scenarios.

## When to Use PowerShell Scripts

Use these scripts when:
- Azure Marketplace UI is unavailable
- You need to automate deployment
- Customer has limited permissions
- Troubleshooting deployment issues

## Available Scripts

### Enable-SCIM-Provisioning.ps1

**Purpose**: Creates app registrations and configures SCIM provisioning in customer tenant

**Use Case**: When Azure Marketplace partial deployment fails or is unavailable

**Required Permissions**:
- `Application.ReadWrite.All`
- `Synchronization.ReadWrite.All`

**Parameters**:
- `TenantId` - Customer's Microsoft Entra ID tenant ID
- `ScimToken` - SCIM token from &money
- `Environment` - "Test" or "Production"

**Example Usage**:
```powershell
.\Enable-SCIM-Provisioning.ps1 `
  -TenantId "12345678-1234-1234-1234-123456789012" `
  -ScimToken "your-scim-token-here" `
  -Environment "Production"
```

**Output**: Client ID and Client Secret for Graph Proxy configuration

View the full script below in [Enable-SCIM-Provisioning.ps1](#enable-scim-provisioningps1-full-script)

### Add-Teams-Access-Policy.ps1

**Purpose**: Creates Teams access policy for BookMe app registration

**Use Case**: Enabling Teams online meeting creation capabilities

**Required Permissions**:
- Teams Administrator OR
- Teams Communications Administrator

**Parameters**:
- `ApplicationId` - App registration Client ID
- `PolicyName` - Name for the Teams policy

**Example Usage**:
```powershell
.\Add-Teams-Access-Policy.ps1 `
  -ApplicationId "87654321-4321-4321-4321-210987654321" `
  -PolicyName "BookMe-Teams-Policy"
```

View the full script in [Teams Access Policy Setup](../configuration/teams-access-policy)

## Script Execution Guide

### Prerequisites

1. **Install Required Modules**:
```powershell
Install-Module -Name Microsoft.Graph -Scope CurrentUser
Install-Module -Name MicrosoftTeams -Scope CurrentUser
```

2. **Set Execution Policy**:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Authentication

Scripts will prompt for authentication. Sign in with an account that has:
- Required permissions for the operation
- Access to the target tenant

### Running Scripts

1. **Download Script**: Save the script file locally
2. **Open PowerShell**: Run as Administrator recommended
3. **Navigate to Script Location**:
```powershell
cd C:\Scripts\BookMe
```
4. **Execute Script**: With appropriate parameters

### Troubleshooting Script Execution

#### Permission Errors

**Issue**: "Insufficient privileges to complete the operation"

**Solution**:
```powershell
# Verify current permissions
Connect-MgGraph -Scopes "Application.ReadWrite.All","User.Read"
Get-MgContext
```

#### Module Not Found

**Issue**: "The term 'Connect-MgGraph' is not recognized"

**Solution**:
```powershell
# Reinstall module
Remove-Module Microsoft.Graph -Force
Install-Module Microsoft.Graph -Force
Import-Module Microsoft.Graph
```

#### Authentication Issues

**Issue**: "Authentication failed"

**Solution**:
```powershell
# Clear token cache
Disconnect-MgGraph
Connect-MgGraph -TenantId "your-tenant-id"
```

## Automation Scenarios

### CI/CD Pipeline Integration

**Azure DevOps Pipeline Example**:
```yaml
- task: AzurePowerShell@5
  inputs:
    azureSubscription: 'ServiceConnection'
    ScriptType: 'FilePath'
    ScriptPath: '$(System.DefaultWorkingDirectory)/Enable-SCIM-Provisioning.ps1'
    ScriptArguments: '-TenantId $(TenantId) -ScimToken $(ScimToken)'
```

### Batch Customer Onboarding

**Multiple Customers Script**:
```powershell
$customers = @(
    @{TenantId="tenant1"; Token="token1"},
    @{TenantId="tenant2"; Token="token2"}
)

foreach ($customer in $customers) {
    .\Enable-SCIM-Provisioning.ps1 `
        -TenantId $customer.TenantId `
        -ScimToken $customer.Token `
        -Environment "Production"
}
```

## Security Best Practices

### Handling Secrets

**Never hardcode secrets in scripts**. Instead:

1. **Use Azure Key Vault**:
```powershell
$secret = Get-AzKeyVaultSecret -VaultName "MyVault" -Name "ScimToken"
$scimToken = $secret.SecretValue | ConvertFrom-SecureString -AsPlainText
```

2. **Use Environment Variables**:
```powershell
$scimToken = $env:SCIM_TOKEN
```

3. **Use Secure String Input**:
```powershell
$scimToken = Read-Host "Enter SCIM Token" -AsSecureString
```

### Logging and Auditing

Enable transcript for audit trail:
```powershell
Start-Transcript -Path "C:\Logs\BookMe-Deployment-$(Get-Date -Format yyyyMMdd).log"
# Run your scripts
Stop-Transcript
```

## Support

For script-related issues:
- Check script output for error messages
- Review prerequisites and permissions
- Contact your &money technical support
- Submit issues through the support portal

## Full Script Code

### Enable-SCIM-Provisioning.ps1 Full Script

<details markdown="1">
<summary>Click to expand the full Enable-SCIM-Provisioning.ps1 script</summary>

```powershell
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

</details>

## Token Management and Architecture

### Token Validation in Multi-Tenant Applications

When operating in a multi-tenant environment, the platform validates tokens as follows:

- **Issuer (iss) Claim**: Tokens include the customer's Entra Tenant ID as the issuer
- **Tenant Mapping**: The platform maintains a mapping between Entra Tenant IDs and internal BankIds in the organization database
- **Multiple BankId Support**: A single tenant can have multiple BankId mappings, allowing users to switch context in the Management UI

### Client Credentials Flow

For system-to-system integrations:

- **OAuth Flow**: Client credentials grant type is used for service accounts
- **Bank-Specific Integrations**: Each bank receives unique client ID and secret
- **Automatic Role Assignment**: System integrations automatically receive the System app role
- **Secret Rotation**: Client secrets expire after 2 years and must be renewed before expiration

### App Registration Architecture

The platform uses different app registrations for specific purposes:

| App Registration | Purpose | Authentication |
|:-----------------|:--------|:---------------|
| **BookingPlatform Management UI** | Browser-based login flows | Interactive |
| **BookingPlatform Management API** | API permission scopes and role definitions | Token-based |
| **BookMe API System Integration** | System-level integrations within BookMe tenant | Client credentials |
| **Bank-Specific System Integration** | Per-customer system access | Client credentials |

## Related Documentation

- [Single-Tenant Installation](single-tenant-installation)
- [Multi-Tenant Installation](multi-tenant-installation)
- [SCIM Configuration](scim-provisioning-setup)
- [Microsoft 365 Integration](../configuration/microsoft-365-integration)