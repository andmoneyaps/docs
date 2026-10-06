---
layout: default
title: Scripts
nav_order: 10
parent: Foundation
permalink: /foundation/scripts/
---

# Scripts

The PowerShell scripts the onboarding guides ask you to run in your own tenant. Each guide step
shows how to call a script; this page holds the script itself.

Download a script with:

```powershell
Invoke-WebRequest https://andmoneyaps.github.io/docs/scripts/<script-name>.ps1 -OutFile <script-name>.ps1
```

{: .note }
> **The Microsoft Graph scripts leave a consent behind.** Signing in consents Microsoft's own
> *Microsoft Graph Command Line Tools* application to the scopes the script asks for. Revoke it
> afterwards under **Enterprise applications → Microsoft Graph Command Line Tools → Permissions** if
> your policy does not allow standing admin-tooling consent.

## Before you run any of them

The Microsoft Graph scripts need specific Microsoft Graph PowerShell modules, published by Microsoft on
the PowerShell Gallery. Install them however your organisation sources PowerShell modules:

```powershell
# add-delegated-grant-to-service-principal.ps1
Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns

# add-site-permission-for-app.ps1
Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Sites

# enable-scim-provisioning.ps1
Install-Module Microsoft.Graph.Authentication
```

A missing module stops the script at startup with *"the following modules that are specified by the
`#requires` statements of the script are missing"*, before it changes anything.

`new-dataverse-role-for-app-user.ps1` uses no Graph modules. It needs the
[Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli) for the sign-in, or a token passed
with `-accessToken`.

## add-delegated-grant-to-service-principal.ps1

Records a delegated permission directly on a service principal in your tenant — the one thing an
admin-consent link cannot do.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 3]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#step-3--authorise-engage-to-act-as-your-advisors) · [Schedule on Dynamics, Step 3]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#step-3--authorise-engage-to-act-as-your-advisors-in-dynamics) |
| Run as | *Application Administrator* or *Cloud Application Administrator* |
| Download | [add-delegated-grant-to-service-principal.ps1]({{ site.baseurl }}/scripts/add-delegated-grant-to-service-principal.ps1) |

```powershell
{% include scripts/add-delegated-grant-to-service-principal.ps1 %}
```

## new-dataverse-role-for-app-user.ps1

Creates the Dataverse security role for the Engage application user, trims it to the privileges the
integration needs, and assigns it.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 4b]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#4b--create-and-assign-the-security-role) · [Schedule on Dynamics, Step 4b]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#4b--create-and-assign-the-security-role) |
| Run as | *System Administrator* of the Dataverse environment |
| Download | [new-dataverse-role-for-app-user.ps1]({{ site.baseurl }}/scripts/new-dataverse-role-for-app-user.ps1) |

```powershell
{% include scripts/new-dataverse-role-for-app-user.ps1 %}
```

## add-site-permission-for-app.ps1

Grants an application access to a single SharePoint site, which is what `Sites.Selected` needs before
it reaches any site at all.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 5b]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site) |
| Run as | *SharePoint Administrator* or *Global Administrator* |
| Download | [add-site-permission-for-app.ps1]({{ site.baseurl }}/scripts/add-site-permission-for-app.ps1) |

```powershell
{% include scripts/add-site-permission-for-app.ps1 %}
```

## enable-scim-provisioning.ps1

Creates the Advisors and Rooms SCIM provisioning applications, points them at Engage with your SCIM
token, sets their attribute mappings, and starts provisioning.

| | |
|---|---|
| Used in | [Schedule on Dynamics, Step 5]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#step-5--provision-employees-and-rooms-with-scim) |
| Run as | *Application Administrator* or *Cloud Application Administrator* |
| Download | [enable-scim-provisioning.ps1]({{ site.baseurl }}/scripts/enable-scim-provisioning.ps1) |

```powershell
{% include scripts/enable-scim-provisioning.ps1 %}
```

## Azure Marketplace offer scripts

Used only when installing the Azure Marketplace offer in multi-tenant mode, as described in
[Marketplace Installation]({{ site.baseurl }}/foundation/m365/marketplace-installation/).

| Script | Download |
|---|---|
| [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/foundation/scim/enable-scim-provisioning/) | [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/scripts/marketplace/Enable-SCIM-Provisioning.ps1) |
| [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/foundation/m365/add-teams-access-policy/) | [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/scripts/marketplace/Add-Teams-Access-Policy.ps1) |
