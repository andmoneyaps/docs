---
layout: default
title: Dynamics 365
nav_order: 1
parent: Scripts
grand_parent: Foundation
has_children: true
permalink: /foundation/scripts/dynamics/
---

# Dynamics 365 scripts

Scripts for connecting Engage to Microsoft Dynamics 365, used by the Present and Schedule on Dynamics onboarding guides.

| Script | What it does |
|---|---|
| [add-delegated-grant-to-service-principal.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-delegated-grant-to-service-principal/) | Records a delegated permission directly on a service principal in your tenant — the one thing an admin-consent link cannot do. |
| [new-dataverse-role-for-app-user.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/new-dataverse-role-for-app-user/) | Creates the Dataverse security role for the Engage application user, trims it to the privileges the integration needs, and assigns it. |
| [add-site-permission-for-app.ps1]({{ site.baseurl }}/foundation/scripts/dynamics/add-site-permission-for-app/) | Grants an application access to a single SharePoint site, which is what `Sites.Selected` needs before it reaches any site at all. |
