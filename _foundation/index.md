---
layout: default
title: Foundation
nav_order: 2
has_children: true
collection: foundation
permalink: /foundation/
---

# Foundation

Technical foundations that every Engage platform product — BookMe, Meet, Present, Insights — sits on. The work in this section is done once per tenant; the resulting configuration is reused across products without reconfiguration.

## What lives here

| Area | Purpose | Owned by |
|---|---|---|
| [Identity]({{ site.baseurl }}/foundation/identity/) | Microsoft Entra ID setup, app registrations, portal authentication (Management Portal, Customer Portal). The identity backbone for staff and customers. | Azure / Entra admin |
| [SCIM Provisioning]({{ site.baseurl }}/foundation/scim/) | Push-from-source synchronisation of employees and meeting rooms from your Entra tenant into the platform. Runs on a ~40-minute cycle. | Azure / Entra admin |
| [Microsoft 365]({{ site.baseurl }}/foundation/m365/) | Microsoft Graph integration for Teams meetings, Outlook calendar free/busy, and employee calendar operations. Delivered through the Azure Marketplace App Offer (Graph-Proxy mode) or via direct Graph API access. | Azure / Entra admin |
| [Engage Platform Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/) | The customer-facing onboarding reference. Architecture overview and prerequisites for every integration surface — Foundation surfaces here, plus product-specific surfaces in BookMe/Meet/Present. Start here if you are onboarding a new tenant. | Cross-functional |

## How to use this section

If you are onboarding a new tenant:

1. Start with the **[Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/)** for the cross-cutting architecture and the per-surface prerequisites.
2. Drill into each Foundation surface ([Identity]({{ site.baseurl }}/foundation/identity/), [SCIM]({{ site.baseurl }}/foundation/scim/), [Microsoft 365]({{ site.baseurl }}/foundation/m365/)) for the step-by-step configuration.
3. Once Foundation surfaces are configured, move on to product-specific onboarding:
   - [BookMe Onboarding]({{ site.baseurl }}/bookme/onboarding/) — CRM (Salesforce) setup and BookMe implementation phases
   - [Public API]({{ site.baseurl }}/api/) — programmatic access for your bespoke systems

## Foundation vs product-specific

If you are touching anything in this section, the change typically affects every product on the platform. Product-specific configuration (BookMe portals, Present templates, Meet meeting settings) belongs in the product collections, not here.
