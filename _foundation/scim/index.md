---
layout: default
title: SCIM Provisioning
nav_order: 2
parent: Foundation
has_children: true
---

# SCIM Provisioning

SCIM is the standard provisioning protocol Microsoft Entra exposes natively. The Engage platform consumes it to keep employee and meeting-room records synchronised from your Entra tenant automatically. Entra's SCIM service pushes user and group changes to the Engage SCIM endpoint on a ~40-minute cycle whenever your directory changes.

Provisioning is **push-from-the-source**: Engage receives writes from your tenant. Engage holds no standing credentials in your directory, and no scheduled job on the Engage side reaches into your tenant. The integration is platform-wide — once SCIM is configured, every product (BookMe, Meet, Present, Insights) sees the same directory data.

## Resource model

Two SCIM-enabled enterprise applications are created in your Entra tenant, targeting separate endpoints:

- **Employees** — your staff who will use the platform (formerly "advisors" in earlier endpoint naming)
- **Rooms** — meeting-room resource accounts used by BookMe

You can configure, ramp, and operate the two independently.

## Pages in this section

| Page | When to read |
|---|---|
| [SCIM Provisioning Setup]({{ site.baseurl }}/foundation/scim/scim-provisioning-setup/) | Step-by-step configuration of the SCIM enterprise apps in Entra: tenant URLs per environment, attribute mappings, user/group assignment, and how to enable failure email alerts |
| [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/foundation/scim/enable-scim-provisioning/) | PowerShell script reference used by the multi-tenant Marketplace deployment to create the SCIM service principals automatically |

## Related

- [Identity]({{ site.baseurl }}/foundation/identity/) — the Entra app registrations that the SCIM service principals attach to.
- [Microsoft 365]({{ site.baseurl }}/foundation/m365/marketplace-installation/) — the Marketplace App Offer's PowerShell scripts create the SCIM service principals automatically in multi-tenant mode.
- [Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/#3-entra-scim-provisioning) — section 3 covers SCIM architecture and prerequisites in context.
