---
layout: default
title: Add-Teams-Access-Policy.ps1
nav_order: 1
parent: Microsoft 365
grand_parent: Scripts
---

# Add-Teams-Access-Policy.ps1

Creates the Teams application access policy that lets the app registration read online meetings. Used when installing the Azure Marketplace offer in multi-tenant mode.

| | |
|---|---|
| Used in | [Marketplace Installation]({{ site.baseurl }}/foundation/m365/marketplace-installation/) |
| Run as | *Teams Communications Administrator* or *Teams Administrator* |
| Download | [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/foundation/scripts/m365/Add-Teams-Access-Policy.ps1) |

## Before you run it

The script installs the `MicrosoftTeams` module if it is missing.

## Script

```powershell
{% include_relative Add-Teams-Access-Policy.ps1 %}
```
