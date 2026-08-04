---
layout: default
title: Enable-Graph-Transcript-Access.ps1
nav_order: 8
parent: Microsoft 365
grand_parent: Foundation
---

# Enable-Graph-Transcript-Access.ps1

Microsoft Graph API access to Teams meeting transcripts is governed by a tenant-level setting that is **off by default**. While it is off, Engage cannot create or renew a transcript change-notification subscription — Graph returns `403 Forbidden` with the `GraphAccessToTranscriptsDisabled` inner-error code — and meeting summaries stop being produced. The app registration's Graph permissions and its Teams application access policy have no bearing on this; the tenant setting overrides both.

Two settings are required. `EnableGraphTranscriptAccess` lifts the block. `EnableAttributedTranscripts` permits the speaker-attributed transcript format, which Engage requests; without it transcript content requests fail with `SpeakerAttributionNotAllowed` even once access is enabled.

The setting is tenant-wide. It does not widen which users an application may read — the Teams application access policy and its security group continue to govern that.

Teams administrators can apply the same change without PowerShell in the Teams admin center under **Meetings → Meeting settings → Transcript API access**.

Background: [MC1393806](https://mc.merill.net/message/MC1393806) and [Manage transcript API access for Teams meetings](https://learn.microsoft.com/en-us/microsoftteams/meeting-transcript-api-access).

```PowerShell
#Running this script requires that the identity has the "Teams Administrator" role or higher

# Graph API access to Teams transcripts is off by default per tenant. While it is off, creating or
# renewing a transcript change-notification subscription fails with 403 / GraphAccessToTranscriptsDisabled,
# regardless of the app registration's Graph permissions or its application access policy.
# Both settings are needed: the M365 service requests transcript content as "text/vtt", the
# speaker-attributed format, so attribution must be on too or the content fetch still 403s.
# Tenant-wide (Global is the only valid identity); it does not change which users an app may read.
# Background: https://mc.merill.net/message/MC1393806

param (
  [string] $ExpectedTenantId, # Abort unless the signed-in tenant matches.
  [switch] $DryRun, # Report current values and exit.
  [switch] $Force, # Skip the confirmation prompt.
  [switch] $UseDeviceAuthentication # Default on non-Windows hosts.
)

# Fail immediately on any error
$ErrorActionPreference = "Stop"

$MinimumModuleVersion = [version] "7.9.0"

# Version, not just presence: EnableGraphTranscriptAccess landed in 7.9.0 and older builds fail with
# a "parameter cannot be found" error that does not implicate the module.
$module = Get-Module MicrosoftTeams -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1

if (-not $module -or $module.Version -lt $MinimumModuleVersion)
{
  $found = if ($module) { $module.Version } else { "not installed" }
  Write-Host -ForegroundColor Yellow "MicrosoftTeams is $found - installing $MinimumModuleVersion or later"

  Install-Module MicrosoftTeams -Force -AllowClobber -Scope CurrentUser
  Remove-Module MicrosoftTeams -ErrorAction SilentlyContinue

  $module = Get-Module MicrosoftTeams -ListAvailable | Sort-Object Version -Descending | Select-Object -First 1

  if (-not $module -or $module.Version -lt $MinimumModuleVersion)
  {
    throw "MicrosoftTeams is still $($module.Version) after install; $MinimumModuleVersion or later is required."
  }
}

Import-Module MicrosoftTeams -MinimumVersion $MinimumModuleVersion
Write-Host -ForegroundColor Cyan "Using MicrosoftTeams $($module.Version)"

# $IsWindows only exists on PowerShell 6+; 5.1 is Windows by definition.
$onWindows = if ($null -eq $IsWindows) { $true } else { $IsWindows }

# The default interactive sign-in P/Invokes kernel32, so it resolves only on Windows.
$connectParams = @{}
if ($UseDeviceAuthentication -or -not $onWindows)
{
  $connectParams["UseDeviceAuthentication"] = $true
  Write-Host -ForegroundColor Yellow "Using device-code sign-in - open the URL printed below and enter the code"
}

Write-Host -ForegroundColor Yellow "Sign in as a Teams Administrator of the TARGET tenant"
$connection = Connect-MicrosoftTeams @connectParams

$tenantId = $connection.TenantId
$tenantName = try { (Get-CsTenant).DisplayName } catch { "(display name unavailable)" }

Write-Host "Tenant : $tenantName"
Write-Host "Id     : $tenantId"
Write-Host "Account: $($connection.Account.Id)"

if ($ExpectedTenantId -and $tenantId -ne $ExpectedTenantId)
{
  throw "Connected tenant $tenantId does not match expected $ExpectedTenantId. Aborting."
}

# Read before writing: if access is already on, the failure has another cause.
$before = Get-CsTeamsMeetingConfiguration -Identity Global
Write-Host "EnableGraphTranscriptAccess : $($before.EnableGraphTranscriptAccess)"
Write-Host "EnableAttributedTranscripts : $($before.EnableAttributedTranscripts)"

if ($before.EnableGraphTranscriptAccess -and $before.EnableAttributedTranscripts)
{
  Write-Host -ForegroundColor Yellow "Both settings are already enabled - nothing to change"
  return
}

if ($DryRun)
{
  Write-Host -ForegroundColor Yellow "DryRun: would set both settings to True on '$tenantName'. No change made."
  return
}

Write-Host -ForegroundColor Yellow "This is a TENANT-WIDE change to '$tenantName'"

if (-not $Force)
{
  # Fails safe: a non-interactive host yields an empty answer and aborts.
  if ((Read-Host "Type 'yes' to apply") -ne "yes")
  {
    Write-Host -ForegroundColor Yellow "Aborted - no changes made"
    return
  }
}

Set-CsTeamsMeetingConfiguration -Identity Global -EnableGraphTranscriptAccess $true -EnableAttributedTranscripts $true

$after = Get-CsTeamsMeetingConfiguration -Identity Global

if (-not ($after.EnableGraphTranscriptAccess -and $after.EnableAttributedTranscripts))
{
  throw "Settings did not take effect. Check the account holds the Teams Administrator role."
}

Write-Host -ForegroundColor Cyan "EnableGraphTranscriptAccess : $($before.EnableGraphTranscriptAccess) -> $($after.EnableGraphTranscriptAccess)"
Write-Host -ForegroundColor Cyan "EnableAttributedTranscripts : $($before.EnableAttributedTranscripts) -> $($after.EnableAttributedTranscripts)"
Write-Host -ForegroundColor Cyan "Enabled on '$tenantName'. Existing transcript subscriptions recover on their next renewal attempt."
```
