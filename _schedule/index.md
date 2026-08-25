---
layout: default
title: Schedule
nav_order: 3
has_children: true
collection: schedule
permalink: /schedule/
redirect_from:
  - /bookme/
---

# Schedule

Schedule is our booking and scheduling solution designed for the financial sector. This section covers Schedule's product-specific configuration: portals, playbooks, CRM-driven booking flows, employee schedules, and the day-to-day features.

> **Looking for platform-wide setup?** Microsoft 365, Entra identity, and SCIM provisioning are platform-wide foundations used by every Engage product. They live under [Foundation]({{ site.baseurl }}/foundation/), not here.

## Where to start

| If you are… | Read |
|---|---|
| Trying to understand **how a meeting is created in Salesforce** (and which options you have) | [Meeting Creation in Salesforce]({{ site.baseurl }}/schedule/meeting-creation/) — authoritative reference for every scheduling implementation, with a [comparison matrix]({{ site.baseurl }}/schedule/meeting-creation/technology-and-feature-matrix/) |
| Onboarding a new customer tenant to Schedule | [Schedule Onboarding]({{ site.baseurl }}/schedule/onboarding/) — Salesforce setup, implementation phases, Schedule-CRM security |
| Onboarding a new tenant to the platform (cross-cutting) | [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/) — covers Foundation surfaces + product-specific surfaces in one reference |
| Configuring Schedule portals or customer-facing flows | [Portals]({{ site.baseurl }}/schedule/portals/), [Customer Meeting Booking]({{ site.baseurl }}/schedule/customer-meeting-booking/) |
| Building playbooks or working with the CRM abstraction | [Playbooks]({{ site.baseurl }}/schedule/playbooks/), [Entities and Entity Patterns]({{ site.baseurl }}/schedule/entities-and-entity-patterns/) |
| Managing employee schedules, services, or priority rules | [Employee Schedules]({{ site.baseurl }}/schedule/employee-schedules/), [Service Competence Groups]({{ site.baseurl }}/schedule/service-competence-groups/), [Advisor Priority Rules]({{ site.baseurl }}/schedule/advisor-priority-rules/) |

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

- **[Onboarding]({{ site.baseurl }}/schedule/onboarding/)** — Salesforce setup, implementation phases, CRM integration security
- **[Playbooks]({{ site.baseurl }}/schedule/playbooks/)** — Automation workflows, the visual editor, managed playbooks
- **Booking configuration** — portals, employee schedules, service competence groups, advisor priority rules, customer meeting booking
- **CRM integration** — entities and entity patterns, entity configuration management
- **Operational features** — reporting, labels, templates, iCal generation, internal meetings

## Related

- [Foundation]({{ site.baseurl }}/foundation/) — Microsoft 365, Entra identity, SCIM provisioning (platform-wide, used by all Engage products)
- [Public API]({{ site.baseurl }}/api/) — programmatic access to Schedule data for your bespoke systems
- [Embeddable UI]({{ site.baseurl }}/embeddable-ui/) — Schedule components for embedding in your Salesforce iframe or other surfaces
