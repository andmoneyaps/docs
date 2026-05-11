---
layout: default
title: BookMe
nav_order: 3
has_children: true
collection: bookme
---

# BookMe

BookMe is our booking and scheduling solution designed for the financial sector. This section covers BookMe's product-specific configuration: portals, playbooks, CRM-driven booking flows, employee schedules, and the day-to-day features.

> **Looking for platform-wide setup?** Microsoft 365, Entra identity, and SCIM provisioning are platform-wide foundations used by every Engage product. They live under [Foundation]({{ site.baseurl }}/foundation/), not here.

## Where to start

| If you are… | Read |
|---|---|
| Onboarding a new customer tenant to BookMe | [BookMe Onboarding]({{ site.baseurl }}/bookme/onboarding/) — Salesforce setup, implementation phases, BookMe-CRM security |
| Onboarding a new tenant to the platform (cross-cutting) | [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/) — covers Foundation surfaces + product-specific surfaces in one reference |
| Configuring BookMe portals or customer-facing flows | [Portals]({{ site.baseurl }}/bookme/portals/), [Customer Meeting Booking]({{ site.baseurl }}/bookme/customer-meeting-booking/) |
| Building playbooks or working with the CRM abstraction | [Playbooks]({{ site.baseurl }}/bookme/playbooks/), [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) |
| Managing employee schedules, services, or priority rules | [Employee Schedules]({{ site.baseurl }}/bookme/employee-schedules/), [Service Competence Groups]({{ site.baseurl }}/bookme/service-competence-groups/), [Advisor Priority Rules]({{ site.baseurl }}/bookme/advisor-priority-rules/) |

## Key features

- Microsoft 365 calendar integration (foundation — configured under [Foundation/M365]({{ site.baseurl }}/foundation/m365/))
- CRM-driven booking flows (Salesforce or Dynamics 365)
- Customer-facing booking portals
- Playbook automation workflows
- Reporting dashboard with portal source tracking
- Reusable templates, labels, and meeting iCal generation
- Service competence groups and advisor priority rules
- Internal-meeting handling

## Documentation areas

- **[Onboarding]({{ site.baseurl }}/bookme/onboarding/)** — Salesforce setup, implementation phases, CRM integration security
- **[Playbooks]({{ site.baseurl }}/bookme/playbooks/)** — Automation workflows, the visual editor, managed playbooks
- **Booking configuration** — portals, employee schedules, service competence groups, advisor priority rules, customer meeting booking
- **CRM integration** — entities and entity patterns, entity configuration management
- **Operational features** — reporting, labels, templates, iCal generation, internal meetings

## Related

- [Foundation]({{ site.baseurl }}/foundation/) — Microsoft 365, Entra identity, SCIM provisioning (platform-wide, used by all Engage products)
- [Public API]({{ site.baseurl }}/api/) — programmatic access to BookMe data for your bespoke systems
- [Embeddable UI]({{ site.baseurl }}/embeddable-ui/) — BookMe components for embedding in your Salesforce iframe or other surfaces
