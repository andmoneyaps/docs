---
layout: default
title: Foundation
nav_order: 2
has_children: true
collection: foundation
---

# Foundation

Technical foundations that all Engage platform products (BookMe, Meet, Present, Insights) sit on. This section covers identity and access, SCIM provisioning, and the Microsoft 365 integration — features that are configured once per tenant and reused across products.

## What lives here

- [Identity]({{ site.baseurl }}/foundation/identity/) — Microsoft Entra ID setup, app registration patterns, portal authentication
- [SCIM Provisioning]({{ site.baseurl }}/foundation/scim/) — directory synchronisation for employees and rooms
- [Microsoft 365]({{ site.baseurl }}/foundation/m365/) — Azure Marketplace App Offer, Graph-Proxy, Teams access policy
- [Engage Platform Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/) — customer-facing onboarding reference covering all foundation surfaces and product-specific integrations

## When to read this

If you're configuring the platform for the first time, or troubleshooting tenant-level concerns (sign-in, provisioning, Teams meetings), start here. Product-specific configuration (BookMe portals, Present templates, etc.) is documented in the product collections.
