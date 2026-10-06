---
layout: default
title: Entra
nav_order: 2
parent: Scripts
grand_parent: Foundation
has_children: true
permalink: /foundation/scripts/entra/
---

# Entra scripts

Scripts that set up Microsoft Entra to provision employees and meeting rooms to Engage with SCIM.
Use `new-scim-provisioning-apps.ps1` unless you are installing the Azure Marketplace offer.

| Script | What it does |
|---|---|
| [new-scim-provisioning-apps.ps1]({{ site.baseurl }}/foundation/scripts/entra/new-scim-provisioning-apps/) | Creates the Advisors and Rooms SCIM provisioning applications, points them at Engage with your SCIM token, sets their attribute mappings, and starts provisioning. |
| [Enable-SCIM-Provisioning.ps1 (Marketplace)]({{ site.baseurl }}/foundation/scripts/entra/enable-scim-provisioning/) | Creates the app registration the Graph proxy uses and the two SCIM provisioning applications. Used only when installing the Azure Marketplace offer in multi-tenant mode. |
