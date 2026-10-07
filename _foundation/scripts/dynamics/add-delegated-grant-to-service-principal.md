---
layout: default
title: add-delegated-grant-to-service-principal.ps1
nav_order: 1
parent: Dynamics 365
grand_parent: Scripts
---

# add-delegated-grant-to-service-principal.ps1

Records a delegated permission directly on a service principal in your tenant — the one thing an admin-consent link cannot do.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 3]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#step-3--authorise-engage-to-act-as-your-advisors) · [Schedule on Dynamics, Step 3]({{ site.baseurl }}/schedule/onboarding/schedule-on-dynamics/#step-3--authorise-engage-to-act-as-your-advisors-in-dynamics) |
| Run as | *Application Administrator* or *Cloud Application Administrator* |
| Download | [add-delegated-grant-to-service-principal.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-delegated-grant-to-service-principal.ps1) |

## Before you run it

```powershell
Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns
```

A missing module stops the script at startup, before it changes anything.

{: .note }
> **Signing in leaves a consent behind.** It consents Microsoft's own *Microsoft Graph Command Line
> Tools* application to the scopes the script asks for. Revoke it afterwards under **Enterprise
> applications → Microsoft Graph Command Line Tools → Permissions** if your policy does not allow
> standing admin-tooling consent.

## Script

```powershell
{% include_relative add-delegated-grant-to-service-principal.ps1 %}
```
