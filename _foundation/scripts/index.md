---
layout: default
title: Scripts
nav_order: 10
parent: Foundation
has_children: true
permalink: /foundation/scripts/
---

# Scripts

The PowerShell scripts the onboarding guides ask you to run in your own tenant. Each guide step shows
how to call a script; each script has its own page with what it does, who runs it, what it needs, and
the script itself.

Download a script from its page, or with:

```powershell
Invoke-WebRequest https://andmoneyaps.github.io/docs/foundation/scripts/<area>/<script-name>.ps1 -OutFile <script-name>.ps1
```

## [Dynamics 365]({{ site.baseurl }}/foundation/scripts/dynamics/)

| Script | What it does |
|---|---|
| [add-delegated-grant-to-service-principal.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-delegated-grant-to-service-principal/) | Records a delegated permission directly on a service principal in your tenant — the one thing an admin-consent link cannot do. |
| [new-dataverse-role-for-app-user.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/new-dataverse-role-for-app-user/) | Creates the Dataverse security role for the Engage application user, trims it to the privileges the integration needs, and assigns it. |
| [add-site-permission-for-app.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-site-permission-for-app/) | Grants an application access to a single SharePoint site, which is what `Sites.Selected` needs before it reaches any site at all. |

## [SCIM]({{ site.baseurl }}/foundation/scripts/scim/)

| Script | What it does |
|---|---|
| [enable-scim-provisioning.ps1]({{ site.baseurl }}/foundation/scripts/scim/enable-scim-provisioning/) | Creates the Advisors and Rooms SCIM provisioning applications, points them at Engage with your SCIM token, sets their attribute mappings, and starts provisioning. |

## [Microsoft 365]({{ site.baseurl }}/foundation/scripts/m365/)

| Script | What it does |
|---|---|
| [Enable-SCIM-Provisioning.ps1 (Marketplace)]({{ site.baseurl }}/foundation/scripts/m365/enable-scim-provisioning/) | Creates the app registration the Graph proxy uses and the two SCIM provisioning applications. |
| [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/foundation/scripts/m365/add-teams-access-policy/) | Creates the Teams application access policy that lets the app registration read online meetings. |
| [Enable-Graph-Transcript-Access.ps1]({{ site.baseurl }}/foundation/scripts/m365/enable-graph-transcript-access/) | Turns on the tenant settings that let Microsoft Graph read Teams meeting transcripts. |
