---
layout: default
title: Onboarding
nav_order: 1
parent: Schedule
has_children: true
permalink: /schedule/onboarding/
redirect_from:
  - /bookme/onboarding/
---

# Schedule Onboarding

Schedule-specific onboarding for new customer tenants. The platform-level foundations — [Microsoft 365]({{ site.baseurl }}/foundation/m365/), [Identity]({{ site.baseurl }}/foundation/identity/), and [SCIM]({{ site.baseurl }}/foundation/scim/) — are configured once and reused across products; this section covers the Schedule-specific work on top of those foundations.

## Before you start

Make sure the Foundation surfaces are in place first:

- [Microsoft 365 integration]({{ site.baseurl }}/foundation/m365/) installed (either Graph-Proxy mode or direct Graph access).
- [Entra Identity]({{ site.baseurl }}/foundation/identity/) — admin consent granted on the Engage management and customer-portal apps; users mapped to app roles.
- [SCIM provisioning]({{ site.baseurl }}/foundation/scim/) — employees and rooms syncing from your Entra tenant.

If you are onboarding a brand-new tenant, the [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/) is the cross-cutting reference that ties these together.

## Pages in this section

| Page | When to read |
|---|---|
| [Salesforce Schedule Integration Setup]({{ site.baseurl }}/schedule/onboarding/salesforce-setup/) | First page for the Salesforce CRM integration. Covers the metadata model, Schedule-Salesforce repository setup, and field-mapping concepts |
| [Salesforce Connection Setup]({{ site.baseurl }}/schedule/onboarding/salesforce-connection-setup/) | Walk-through for establishing the OAuth2 client-credentials connection between Schedule and your Salesforce org via the Management UI |
| [CRM Integration Security]({{ site.baseurl }}/schedule/onboarding/crm-integration-security/) | Security model for Schedule-CRM data access — authentication, authorisation, and scoping |
| [Implementation Guide]({{ site.baseurl }}/schedule/onboarding/implementation-guide/) | The full Schedule implementation lifecycle in five phases — pre-analysis, clarifications, adaptation, deployment, operations |

## Related

- [Foundation: Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/) — cross-cutting onboarding reference covering Foundation surfaces and product-specific integration points.
- [Schedule]({{ site.baseurl }}/schedule/) — top-level Schedule documentation. Once onboarding is complete, the rest of the Schedule collection covers day-to-day feature configuration (portals, employee schedules, playbooks, etc.).
- If your CRM is Dynamics 365 rather than Salesforce, see [section 5 of the Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration).
