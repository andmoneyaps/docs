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

View the full script in [Enable-SCIM-Provisioning.ps1](#enable-scim-provisioningps1)

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

## Related Documentation

- [Single-Tenant Installation](single-tenant-installation)
- [Multi-Tenant Installation](multi-tenant-installation)
- [SCIM Configuration](scim-provisioning-setup)
- [Microsoft 365 Integration](../configuration/microsoft-365-integration)