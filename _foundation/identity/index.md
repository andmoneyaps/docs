---
layout: default
title: Identity
nav_order: 1
parent: Foundation
has_children: true
permalink: /foundation/identity/
---

# Identity

Microsoft Entra ID is the identity backbone for the Engage platform. Every sign-in flow — Management Portal staff access, Customer Portal access from your enterprise customers, and outbound OAuth tokens that the Engage Integration layer needs for Microsoft 365 and Dynamics 365 — flows through Entra.

The Engage platform owns the enterprise app registrations and publishes them as multi-tenant apps in its own external Entra tenant. Your tenant grants admin consent to install them; you do not create app registrations on your side for portal authentication.

## Pages in this section

| Page | When to read |
|---|---|
| [Microsoft Entra Integration]({{ site.baseurl }}/foundation/identity/entra-integration/) | The integration architecture between your Entra tenant and the Engage platform — multi-tenant app model, admin consent flow, tenant lookup, user-to-role mapping |
| [App Registration Installation]({{ site.baseurl }}/foundation/identity/app-registration-installation/) | Step-by-step installation of the Engage-owned app registrations into your Entra tenant via admin-consent links |
| [Approving Engage in Your Microsoft Entra]({{ site.baseurl }}/foundation/identity/engage-admin-consent/) | Step-by-step walkthrough to approve the Engage app registration (one-time admin consent) |

## Related

- [SCIM Provisioning]({{ site.baseurl }}/foundation/scim/) — once Entra is set up, SCIM keeps the directory data flowing into Engage automatically.
- [Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/#2-identity-and-portal-authentication) — see section 2 for the full architectural treatment of portal authentication and the three identity paths.
