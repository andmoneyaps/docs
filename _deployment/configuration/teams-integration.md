---
layout: default
title: Microsoft Teams Integration
nav_order: 2
parent: Configuration
grand_parent: Platform Deployment
---

# Microsoft Teams Integration

Configure Microsoft Teams access policies to enable the platform to create online meetings.

## Prerequisites

- Platform app registrations created (see [App Registration Setup](app-registration-setup))
- Teams Administrator or Teams Communications Administrator role
- Microsoft Teams PowerShell module v5.0+
- Security group for policy application

## Required API Permissions

Configure these Microsoft Graph API permissions in your app registration:

| Permission | Type | Purpose | Admin Consent |
|:-----------|:-----|:--------|:--------------|
| `OnlineMeetings.ReadWrite.All` | Application | Create and manage Teams meetings | Required |
| `OnlineMeetingTranscript.Read.All` | Application | Retrieve meeting transcripts | Required |
| `Calendars.ReadWrite` | Delegated | Calendar integration | Required |
| `User.Read.All` | Application | User profile access | Required |

## Configure Teams Access Policy

The platform requires a Teams application access policy to create meetings on behalf of users.

### Run Configuration Script

```powershell
.\Add-Teams-Access-Policy.ps1 `
    -AppRegistrationId "[YOUR-APP-ID]" `
    -SecurityGroupId "[YOUR-GROUP-ID]" `
    -Environment "Production" `
    -TenantId "[YOUR-TENANT-ID]"
```

This script:
1. Creates an application access policy named `Bookme-OnlineMeetingAccess-Policy-[Environment]`
2. Applies the policy to the specified security group
3. Grants the app permission to create meetings for group members

{: .note }
> Policy propagation may take up to 30 minutes.

## Enable Meeting Features

### Transcription

To enable transcription in Teams Admin Center:

1. Navigate to **Meetings** → **Meeting policies**
2. Select the policy applied to your users
3. Enable **Transcription** in the Recording & transcription section
4. Save changes

{: .note }
> Users must have Teams E3/E5 licenses for transcription features.

## Verification

### Test Graph API Access

```powershell
# Test user profile access
Invoke-RestMethod -Uri "https://graph.microsoft.com/v1.0/users" `
    -Headers @{Authorization = "Bearer $token"} -Method GET
```

### Verify Teams Policy

```powershell
# List application access policies
Get-CsApplicationAccessPolicy | 
    Where-Object {$_.Identity -like "*Bookme*"} | 
    Format-Table Identity, AppIds
```

## Troubleshooting

### Policy Not Taking Effect

- Wait for propagation (up to 30 minutes)
- Verify group membership
- Check policy assignment with `Get-CsApplicationAccessPolicy`

### Permission Errors

- Verify admin consent in Azure Portal → App registrations → API permissions
- Ensure all permissions show "Granted for [Tenant]"
- Check app registration is enabled

### Transcript Access Issues

- Confirm meeting policy has transcription enabled
- Verify users have appropriate Teams licenses
- Wait 5-15 minutes after meeting ends for transcript availability

## Next Steps

- Complete [SCIM Provisioning](scim-provisioning) for user management
- Configure [Microsoft 365 Integration](microsoft-365-integration) for full suite access

## References

- [Teams PowerShell Module Documentation](https://docs.microsoft.com/en-us/microsoftteams/teams-powershell-overview)
- [Microsoft Graph Permissions Reference](https://docs.microsoft.com/en-us/graph/permissions-reference)
- [Application Access Policies](https://docs.microsoft.com/en-us/graph/cloud-communication-online-meeting-application-access-policy)