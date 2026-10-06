---
layout: default
title: Enable-Graph-Transcript-Access.ps1
nav_order: 3
parent: Microsoft 365
grand_parent: Scripts
---

# Enable-Graph-Transcript-Access.ps1

Turns on the tenant settings that let Microsoft Graph read Teams meeting transcripts.

| | |
|---|---|
| Used in | [Enable Graph transcript access]({{ site.baseurl }}/foundation/m365/enable-graph-transcript-access/) |
| Run as | *Teams Administrator* |
| Download | [Enable-Graph-Transcript-Access.ps1]({{ site.baseurl }}/foundation/scripts/m365/Enable-Graph-Transcript-Access.ps1) |

## Before you run it

The script installs or updates the `MicrosoftTeams` module to version 7.9.0 or later if needed.

## Script

```powershell
{% include_relative Enable-Graph-Transcript-Access.ps1 %}
```
