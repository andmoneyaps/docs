---
layout: default
title: Microsoft Teams Integration
nav_order: 2
parent: Configuration
grand_parent: Platform Deployment
---

# Microsoft Teams Integration

Configure Microsoft Teams access policies and permissions for the platform to create online meetings with transcription capabilities.

## Overview

The platform integrates with Microsoft Teams to:
- Create Teams meetings programmatically via Microsoft Graph API
- Retrieve meeting transcripts after meetings conclude
- Enable recording capabilities for meetings

## Prerequisites

Before configuring Teams integration:
- [ ] Platform app registrations created (see [App Registration Setup](app-registration-setup))
- [ ] Teams Administrator or Teams Communications Administrator role
- [ ] Microsoft Teams PowerShell module installed

## Required Permissions

The platform's app registration requires these Microsoft Graph API permissions:

| Permission | Type | Purpose |
|------------|------|---------|
| `OnlineMeetings.ReadWrite.All` | Application | Create and manage Teams meetings |
| `OnlineMeetingTranscript.Read.All` | Application | Retrieve meeting transcripts |
| `Calendars.ReadWrite` | Delegated | Calendar integration |

To verify permissions:
1. Navigate to **Microsoft Entra ID** → **App registrations**
2. Find your platform's app registration
3. Click **API permissions**
4. Verify the above permissions are granted with admin consent

## Configure Teams Access Policy

The platform requires a Teams access policy to interact with user calendars and create meetings on their behalf.

Use the provided PowerShell script documented in [Teams Access Policy Setup](teams-access-policy). This script:
- Creates the application access policy
- Applies it to a specified security group
- Supports both user and managed identity authentication

### Quick Reference

```powershell
.\Add-Teams-Access-Policy.ps1 `
    -AppRegistrationId "[YOUR-APP-ID]" `
    -SecurityGroupId "[YOUR-GROUP-ID]" `
    -Environment "Production" `
    -TenantId "[YOUR-TENANT-ID]"
```

The script will create a policy named `Bookme-OnlineMeetingAccess-Policy-[Environment]` and apply it to the specified group.

## Enable Meeting Features

### Transcription Settings

Ensure your organization's Teams meeting policies allow transcription:

1. In [Teams Admin Center](https://admin.teams.microsoft.com)
2. Navigate to **Meetings** → **Meeting policies**
3. Select the policy applied to your users
4. Verify **Allow transcription** is enabled
5. Save changes if modified

**Note:** Users must have appropriate Teams licenses that include transcription capabilities.

### Recording Settings

If recording is required:
1. In the same meeting policy
2. Enable **Allow cloud recording**
3. Save changes


## Verification

After configuration:

1. **Check Graph API connectivity:**
   ```powershell
   # Test Graph API access
   Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/me" `
       -Headers @{Authorization = "Bearer [ACCESS-TOKEN]"}
   ```

2. **Verify Teams policy is active:**
   ```powershell
   Get-CsApplicationAccessPolicy | Select-Object Identity, AppIds
   ```

3. **Confirm app permissions:**
   - Check audit logs in Entra ID for consent grants
   - Review app registration API permissions tab

## Troubleshooting

### Policy Not Taking Effect

**Issue:** Application cannot create meetings despite policy configuration

**Solution:**
```powershell
# Force policy sync (may take up to 30 minutes)
Grant-CsApplicationAccessPolicy -PolicyName "BookingPlatformPolicy" -Global

# Verify with specific user
Get-CsOnlineUser -Identity "user@domain.com" | Select-Object ApplicationAccessPolicy
```

### Permission Errors

**Issue:** "Insufficient privileges" when creating meetings

**Verify:**
1. Admin consent granted for all required permissions
2. No Conditional Access policies blocking the application
3. App registration not disabled in Entra ID

### Transcript Access Issues

**Issue:** Transcripts not accessible after meetings

**Check:**
1. Meeting policy has transcription enabled
2. Users have appropriate Teams licenses
3. Allow 5-15 minutes after meeting ends for transcript processing
4. Application has `OnlineMeetingTranscript.Read.All` permission

## Next Steps

- Complete [SCIM Provisioning](scim-provisioning) for user synchronization
- Configure [Microsoft 365 Integration](microsoft-365-integration) for authentication
- Review [Graph Proxy Configuration](../reference/graph-proxy) for API access

## Related Documentation

- [Teams Access Policy Script](teams-access-policy)
- [Microsoft Graph Permissions Reference](https://docs.microsoft.com/en-us/graph/permissions-reference)
- [Teams PowerShell Module](https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-overview)