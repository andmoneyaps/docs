---
layout: default
title: Teams Access Policy Setup
nav_order: 7
parent: Configuration
grand_parent: Platform Deployment
collection: deployment
---

# Teams Access Policy Setup
{: .no_toc }

Configure Microsoft Teams application access policies to enable the platform to create and manage Teams meetings on behalf of users.
{: .fs-6 .fw-300 }

## Table of contents
{: .no_toc .text-delta }

1. TOC
{:toc}

---

## Overview

This PowerShell script creates and applies Microsoft Teams application access policies, allowing the BookMe platform to:
- Create Teams meetings programmatically
- Access meeting transcripts
- Integrate with user calendars

{: .warning }
> **Required Role:** Teams Communications Administrator or higher
>
> The identity running this script must have appropriate Teams administrative privileges.

## When to Use This Script

{: .warning }
> **IMPORTANT: Azure Marketplace Automation**
>
> **DO NOT run this script manually if:**
> - You deployed via Azure Marketplace with single-tenant mode
> - Your deployment succeeded without errors
> - You provided a managed identity with Teams admin roles
>
> **The marketplace deployment automatically runs this script for you.**
>
> **ONLY run this script manually for:**
> - Multi-tenant deployments (partial deployment mode)
> - Failed marketplace deployments requiring manual recovery
> - Custom deployments outside of Azure Marketplace
> - Updating or fixing existing policies

## Script Parameters

| Parameter | Type | Required | Description |
|:----------|:-----|:---------|:------------|
| `AppRegistrationId` | string | ✅ | The ID of the application registration created via Enable-SCIM-Provisioning.ps1 |
| `SecurityGroupId` | string | ✅ | The ID of the group to which the policy should be applied |
| `Environment` | string | ✅ | The environment name (e.g., Production, Staging, Development) |
| `TenantId` | string | ✅ | The tenant ID where the application registration exists |
| `ConnectionType` | string | ❌ | Authentication method: "User" (default) or "ManagedIdentity" |

## Usage Examples

### Interactive User Authentication

```powershell
.\Add-Teams-Access-Policy.ps1 `
    -AppRegistrationId "12345678-1234-1234-1234-123456789012" `
    -SecurityGroupId "87654321-4321-4321-4321-210987654321" `
    -Environment "Production" `
    -TenantId "abcdef12-3456-7890-abcd-ef1234567890"
```

### Managed Identity Authentication

```powershell
.\Add-Teams-Access-Policy.ps1 `
    -AppRegistrationId "12345678-1234-1234-1234-123456789012" `
    -SecurityGroupId "87654321-4321-4321-4321-210987654321" `
    -Environment "Production" `
    -TenantId "abcdef12-3456-7890-abcd-ef1234567890" `
    -ConnectionType "ManagedIdentity"
```

## Full Script

<details markdown="1">
<summary>Click to expand the full PowerShell script</summary>

```powershell
# Running this script requires that the identity (user or managed identity) 
# has the "Teams Communications Administrator" role or higher

param (
    [string] $AppRegistrationId,  # The id of the application registration
    [string] $SecurityGroupId,    # The ID of the group for policy application
    [string] $Environment,         # The environment (Production, Staging, etc.)
    [string] $TenantId,           # The tenant ID
    [string] $ConnectionType = "User"  # Authentication method
)

# Fail immediately on any error
$ErrorActionPreference = "Stop"

# Check and install MicrosoftTeams module if needed
if (Get-Module -ListAvailable -Name MicrosoftTeams) {
    Write-Host "Module MicrosoftTeams are imported"
} else {
    Install-Module MicrosoftTeams -Force
    Import-Module MicrosoftTeams
}

Write-Host -ForegroundColor Yellow @"
Creating a new access policy for the application registration 
with ID '$AppRegistrationId' and applying it to the group 
with ID '$SecurityGroupId'
"@

# Connect to Microsoft Teams
if ($ConnectionType -eq "ManagedIdentity") {
    Write-Host -ForegroundColor Yellow "Connecting with Managed Identity"
    Connect-MicrosoftTeams -Identity -TenantId $TenantId
} else {
    Write-Host -ForegroundColor Yellow "Connecting with Tenant ID: $TenantId"
    Connect-MicrosoftTeams -TenantId $TenantId
}

# Create the application access policy
$policyName = "Bookme-OnlineMeetingAccess-Policy-$Environment"
New-CsApplicationAccessPolicy `
    -Identity $policyName `
    -AppIds "$AppRegistrationId" `
    -Description "&Money Bookme Online Meeting Policy"

# Apply the policy to the security group
Grant-CsApplicationAccessPolicy `
    -PolicyName $policyName `
    -Group "$SecurityGroupId" 

Write-Host -ForegroundColor Cyan @"
Applied policy for application '$AppRegistrationId' 
on group '$SecurityGroupId'
"@
```

</details>

## Script Breakdown

### 1. Module Installation
{: .text-delta }

The script first checks if the MicrosoftTeams PowerShell module is installed:

```powershell
if (Get-Module -ListAvailable -Name MicrosoftTeams) {
    Write-Host "Module MicrosoftTeams are imported"
} else {
    Install-Module MicrosoftTeams -Force
    Import-Module MicrosoftTeams
}
```

### 2. Authentication
{: .text-delta }

Connects to Microsoft Teams using either user credentials or managed identity:

```powershell
# For managed identity (automation scenarios)
Connect-MicrosoftTeams -Identity -TenantId $TenantId

# For interactive user authentication
Connect-MicrosoftTeams -TenantId $TenantId
```

### 3. Policy Creation
{: .text-delta }

Creates a new application access policy with a standardized naming convention:

```powershell
New-CsApplicationAccessPolicy `
    -Identity "Bookme-OnlineMeetingAccess-Policy-$Environment" `
    -AppIds "$AppRegistrationId" `
    -Description "&Money Bookme Online Meeting Policy"
```

### 4. Policy Application
{: .text-delta }

Applies the policy to the specified security group:

```powershell
Grant-CsApplicationAccessPolicy `
    -PolicyName "Bookme-OnlineMeetingAccess-Policy-$Environment" `
    -Group "$SecurityGroupId"
```

## Verification

After running the script, verify the policy was created and applied:

### Check Policy Exists

```powershell
Get-CsApplicationAccessPolicy | 
    Where-Object {$_.Identity -like "*Bookme*"} | 
    Format-Table Identity, AppIds, Description
```

### Verify Group Assignment

```powershell
Get-CsApplicationAccessPolicy -Identity "Bookme-OnlineMeetingAccess-Policy-$Environment" | 
    Select-Object -ExpandProperty GrantedToGroup
```

### Test User Assignment

```powershell
# Check if a specific user has the policy applied (via group membership)
Get-CsOnlineUser -Identity "user@domain.com" | 
    Select-Object DisplayName, ApplicationAccessPolicy
```

## Troubleshooting

{: .warning }
> **Policy Propagation:** It can take up to 30 minutes for policy changes to propagate throughout Teams.

### Common Issues

<details markdown="1">
<summary>Error: "Insufficient privileges to complete the operation"</summary>

**Solution:** Ensure the account running the script has one of these roles:
- Teams Communications Administrator
- Teams Administrator
- Global Administrator

Verify roles with:
```powershell
Get-MgUserMemberOf -UserId "admin@domain.com" | 
    Where-Object {$_.DisplayName -like "*Teams*"}
```
</details>

<details markdown="1">
<summary>Error: "Policy already exists"</summary>

**Solution:** Remove the existing policy before re-running:
```powershell
Remove-CsApplicationAccessPolicy -Identity "Bookme-OnlineMeetingAccess-Policy-$Environment"
```
</details>

<details markdown="1">
<summary>Error: "Cannot find group with specified ID"</summary>

**Solution:** Verify the security group exists and ID is correct:
```powershell
Get-MgGroup -GroupId $SecurityGroupId | 
    Select-Object DisplayName, Id, GroupTypes
```
</details>

## Security Considerations

{: .important }
> **Best Practices:**
> - Use dedicated security groups for policy application
> - Apply principle of least privilege
> - Regularly audit policy assignments
> - Use managed identities for automation scenarios

## Next Steps

After successfully applying the Teams access policy:

1. ✅ Verify policy application using the verification commands
2. ✅ Test meeting creation with the platform application
3. ✅ Configure [Microsoft 365 Integration](microsoft-365-integration)
4. ✅ Set up [Graph Proxy Configuration](../reference/graph-proxy)

## Related Documentation

- [Microsoft Teams Integration](teams-integration)
- [App Registration Setup](app-registration-setup)
- [Teams PowerShell Reference](https://docs.microsoft.com/en-us/powershell/module/teams/)
- [Application Access Policies](https://docs.microsoft.com/en-us/microsoftteams/app-policies)