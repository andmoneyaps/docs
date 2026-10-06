---
layout: default
title: new-scim-provisioning-apps.ps1
nav_order: 1
parent: Entra
grand_parent: Scripts
---

# new-scim-provisioning-apps.ps1

Creates the Advisors and Rooms SCIM provisioning applications, points them at Engage with your SCIM token, sets their attribute mappings, and starts provisioning. Safe to re-run: it reuses the applications it finds.

| | |
|---|---|
| Used in | [Schedule on Dynamics, Step 5]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#step-5--provision-employees-and-rooms-with-scim) |
| Run as | *Application Administrator* or *Cloud Application Administrator* |
| Download | [new-scim-provisioning-apps.ps1]({{ site.baseurl }}/foundation/scripts/entra/new-scim-provisioning-apps.ps1) |

## Before you run it

```powershell
Install-Module Microsoft.Graph.Authentication
```

A missing module stops the script at startup, before it changes anything. Ask your &money contact for the SCIM token; the script prompts for it.

{: .note }
> **Signing in leaves a consent behind.** It consents Microsoft's own *Microsoft Graph Command Line
> Tools* application to the scopes the script asks for. Revoke it afterwards under **Enterprise
> applications → Microsoft Graph Command Line Tools → Permissions** if your policy does not allow
> standing admin-tooling consent.

## Script

```powershell
{% include_relative new-scim-provisioning-apps.ps1 %}
```
