---
layout: default
title: Teams Access Policy Setup
nav_order: 7
parent: Configuration
grand_parent: Platform Deployment
collection: deployment
---

# Add-Teams-Access-Policy.ps1
```PowerShell
#Running this script requires that the identity (user or managed identity) has the "Teams Communications Administrator" role or higher

param (
  [string] $AppRegistrationId, # The id of the application registration created via the Enable-SCIM-Provisioning.ps1 script.
  [string] $SecurityGroupId, # The ID of the group to which the policy should be applied.
  [string] $Environment, # The environment in which the script is running.
  [string] $TenantId, # The tenant ID where the application registration exists.
  [string] $ConnectionType = "User" # If true, the script will connect using a managed identity.
)

# Fail immediately on any error
$ErrorActionPreference = "Stop"

if (Get-Module -ListAvailable -Name MicrosoftTeams)
{
  Write-Host "Module MicrosoftTeams are imported"
} else
{
  Install-Module MicrosoftTeams -Force
  Import-Module MicrosoftTeams
}

Write-Host -ForegroundColor Yellow "Creating a new access policy for the application registration with ID '$AppRegistrationId' and applying it to the group with ID '$SecurityGroupId'"

if ($ConnectionType -eq "ManagedIdentity") {
  Write-Host -ForegroundColor Yellow "Connecting with Managed Identity"
  Connect-MicrosoftTeams -Identity -TenantId $TenantId
} else {
  Write-Host -ForegroundColor Yellow "Connecting with Tenant ID: $TenantId"
  Connect-MicrosoftTeams -TenantId $TenantId
}

New-CsApplicationAccessPolicy -Identity "Bookme-OnlineMeetingAccess-Policy-$Environment" -AppIds "$AppRegistrationId" -Description "&Money Bookme Online Meeting Policy"

Grant-CsApplicationAccessPolicy -PolicyName "Bookme-OnlineMeetingAccess-Policy-$Environment" -Group "$SecurityGroupId" 

Write-Host -ForegroundColor Cyan "Applied policy for application '$AppRegistrationId' on group '$SecurityGroupId'"
```