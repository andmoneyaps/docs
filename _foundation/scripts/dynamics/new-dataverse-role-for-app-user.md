---
layout: default
title: new-dataverse-role-for-app-user.ps1
nav_order: 2
parent: Dynamics 365
grand_parent: Scripts
---

# new-dataverse-role-for-app-user.ps1

Creates the Dataverse security role for the Engage application user, trims it to the privileges the integration needs, and assigns it.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 4b]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#4b--create-and-assign-the-security-role) · [Schedule on Dynamics, Step 4b]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#4b--create-and-assign-the-security-role) |
| Run as | *System Administrator* of the Dataverse environment |
| Download | [new-dataverse-role-for-app-user.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/new-dataverse-role-for-app-user.ps1) |

## Before you run it

The script uses no Microsoft Graph modules. It needs the [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) for the sign-in (`az login --tenant {YourTenantId}`), or a token passed with `-accessToken`.

## Script

```powershell
{% include_relative new-dataverse-role-for-app-user.ps1 %}
```
