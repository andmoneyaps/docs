---
layout: default
title: add-site-permission-for-app.ps1
nav_order: 3
parent: Dynamics 365
grand_parent: Scripts
---

# add-site-permission-for-app.ps1

Grants an application access to a single SharePoint site, which is what `Sites.Selected` needs before it reaches any site at all.

| | |
|---|---|
| Used in | [Present on Dynamics, Step 5b]({{ site.baseurl }}/present/onboarding/present-on-dynamics/#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site) |
| Run as | *SharePoint Administrator* |
| Download | [add-site-permission-for-app.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-site-permission-for-app.ps1) |

## Before you run it

```powershell
Install-Module Microsoft.Graph.Authentication, Microsoft.Graph.Sites
```

A missing module stops the script at startup, before it changes anything.

{: .note }
> **Consent at first sign-in.** The script asks for `Sites.FullControl.All` (Microsoft Graph) for
> *Microsoft Graph Command Line Tools*. An *Application Administrator* or *Cloud Application
> Administrator* must approve it by signing in and ticking **Consent on behalf of your organization**.
> Until then, a SharePoint Administrator sees "Need admin approval".

{: .note }
> **Signing in leaves a consent behind.** It consents Microsoft's own *Microsoft Graph Command Line
> Tools* application to the scopes the script asks for. Revoke it afterwards under **Enterprise
> applications → Microsoft Graph Command Line Tools → Permissions** if your policy does not allow
> standing admin-tooling consent.

## Script

```powershell
{% include_relative add-site-permission-for-app.ps1 %}
```
