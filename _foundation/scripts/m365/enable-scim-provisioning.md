---
layout: default
title: Enable-SCIM-Provisioning.ps1 (Marketplace)
nav_order: 1
parent: Microsoft 365
grand_parent: Scripts
---

# Enable-SCIM-Provisioning.ps1 (Marketplace)

Creates the app registration the Graph proxy uses and the two SCIM provisioning applications. Used only when installing the Azure Marketplace offer in multi-tenant mode.

| | |
|---|---|
| Used in | [Marketplace Installation]({{ site.baseurl }}/foundation/m365/marketplace-installation/) |
| Run as | *Application Administrator* or *Cloud Application Administrator* |
| Download | [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/foundation/scripts/m365/Enable-SCIM-Provisioning.ps1) |

## Before you run it

The script installs the `Microsoft.Graph.Applications` and `Microsoft.Graph.Authentication` modules if they are missing. Ask your &money contact for the SCIM token.

## Script

```powershell
{% include_relative Enable-SCIM-Provisioning.ps1 %}
```
