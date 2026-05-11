---
layout: default
title: Microsoft 365
nav_order: 3
parent: Foundation
has_children: true
---

# Microsoft 365

The Engage platform integrates with Microsoft 365 via Microsoft Graph to read employee calendar free/busy data, create and update Teams meetings tied to booked appointments, and manage calendar events on behalf of your employees.

## Two access modes

| Mode | Where Graph calls originate from | Customer-side infrastructure |
|---|---|---|
| **Direct Graph API access** | Engage Integration layer calls Microsoft Graph directly using OAuth tokens from your Entra tenant | None — only Entra resources |
| **Graph-Proxy mediated access** | Engage Integration layer calls a Graph-Proxy container in your Azure perimeter, which forwards the call to Microsoft Graph | Container App + Key Vault in your Azure subscription |

**Direct mode** is suitable when your existing audit and monitoring at the Graph API / M365 endpoint level already meet your control requirements. No Engage-provided infrastructure runs inside your Azure perimeter.

**Graph-Proxy mode** is suitable when your audit framework specifies that integrations must transit infrastructure you operate, or when you need an additional customer-controlled control point inside your perimeter — for example a centralised egress log or local enforcement beyond what Microsoft's native logs provide. Delivered through the Azure Marketplace App Offer.

The Engage runtime behaviour is identical in either mode; the choice is driven by your operational and audit model.

## Pages in this section

| Page | When to read |
|---|---|
| [Microsoft 365 Integration]({{ site.baseurl }}/foundation/m365/microsoft-365-integration/) | Conceptual overview of the M365 integration architecture, the Graph permission model, and what you are configuring |
| [Marketplace Installation]({{ site.baseurl }}/foundation/m365/marketplace-installation/) | Step-by-step Azure Marketplace App Offer installation — single-tenant and multi-tenant deployment modes |
| [Graph Proxy]({{ site.baseurl }}/foundation/m365/graph-proxy/) | The Graph-Proxy container's role, the components it ships with (Container App, Key Vault, Managed Identity), and how it forwards Graph traffic |
| [Graph Proxy Tenant Migration]({{ site.baseurl }}/foundation/m365/graph-proxy-tenant-migration/) | Reference for moving an existing Graph-Proxy deployment to a different tenant (rare; usually an operational concern, not a first-time onboarding step) |
| [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/foundation/m365/add-teams-access-policy/) | PowerShell script reference used by the multi-tenant deployment to create and grant the Teams access policy against the chosen security group |

## Related

- [Identity]({{ site.baseurl }}/foundation/identity/) — the Entra app registrations that back both M365 access modes.
- [SCIM Provisioning]({{ site.baseurl }}/foundation/scim/) — the SCIM service principals provisioned alongside the M365 integration in the Marketplace App Offer.
- [Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/#1-microsoft-365-integration) — section 1 covers the M365 integration architecture in context.
