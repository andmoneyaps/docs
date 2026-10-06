---
layout: default
title: Microsoft 365
nav_order: 3
parent: Scripts
grand_parent: Foundation
has_children: true
permalink: /foundation/scripts/m365/
---

# Microsoft 365 scripts

Scripts for the Microsoft 365 integration delivered through the Azure Marketplace offer.

| Script | What it does |
|---|---|
| [Enable-SCIM-Provisioning.ps1 (Marketplace)]({{ site.baseurl }}/foundation/scripts/m365/enable-scim-provisioning/) | Creates the app registration the Graph proxy uses and the two SCIM provisioning applications. |
| [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/foundation/scripts/m365/add-teams-access-policy/) | Creates the Teams application access policy that lets the app registration read online meetings. |
| [Enable-Graph-Transcript-Access.ps1]({{ site.baseurl }}/foundation/scripts/m365/enable-graph-transcript-access/) | Turns on the tenant settings that let Microsoft Graph read Teams meeting transcripts. |
