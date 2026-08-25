---
layout: default
title: Comparison Matrix
parent: Meeting Creation in Salesforce
grand_parent: Schedule
nav_order: 6
redirect_from:
  - /bookme/meeting-creation/technology-and-feature-matrix/
---

# Comparison Matrix
{: .no_toc }

The side-by-side reference for every meeting-creation implementation. Use it to answer "which implementation does X?" at a glance; follow the links for detail.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## Comparison matrix

*Every meeting-creation implementation side by side. Newest first; the year after each name is roughly when it was introduced.*

<style>
/* Light-grey background marks the Stable section of the matrix below.
   The tbody is: row 1 "Next wave", 3 Next rows (UWC, Playbook, Internal), row 5 "Stable", then the Stable rows.
   Shading starts at row 5; update the nth-child start if rows are added above "Stable". */
.matrix-wrap tbody tr:nth-child(n+5) td { background-color: #f2f2f2 !important; }
</style>

<div class="matrix-wrap" markdown="block">

| Implementation | Who books | Records created | Customer / party record | How you configure it |
|---|---|---|---|---|
| **Next wave** | | | | |
| **[UWC]({{ site.baseurl }}/schedule/meeting-creation/#roadmap-2026)** (roadmap 2026) | Customer, employee, and (roadmap) partner | **Completely open**, configuration-defined | Configuration-defined | Playbooks + Entity Patterns |
| **[Playbook portals]({{ site.baseurl }}/schedule/meeting-creation/playbooks/)** (2025) | Customer: self-service on a portal | **Completely open**, configuration-defined (standard: `Event`, meeting detail, relations) | Configuration-defined | Playbook editor + Entity Patterns |
| **[Internal meetings]({{ site.baseurl }}/schedule/meeting-creation/internal-meetings/)** (embeddable, 2025) | Employee: advisor books from the embeddable widget | `Event`, meeting detail, advisor relations | Existing Account (linked) | Entity Definitions + Patterns (Admin → Entities) |
| **Stable** | | | | |
| **[CRM Configuration portals]({{ site.baseurl }}/schedule/meeting-creation/crm-configuration/)** (2024) | Customer: on an older portal | `Event`, meeting detail, `Lead`, `EventRelation` | Lead (fixed placeholder) | Field map only; record set is fixed |
| **[Salesforce package]({{ site.baseurl }}/schedule/meeting-creation/salesforce-package/): customer flow** (2022) | Customer: public / Experience Cloud | `Event`, meeting detail, meeting contact, `Opportunity`, `EventRelation` | Opportunity (default) | Field mappings + Apex hooks |
| **[Salesforce package]({{ site.baseurl }}/schedule/meeting-creation/salesforce-package/): employee flow** (2022) | Employee: advisor on a record page (can also book for the customer) | Same set, or reuse an existing record | Account, Opportunity, or Lead (hardcoded) | Field mappings + Apex hooks; advisor UI options |

</div>

{: .note }
> Years are *approximate introduction* years. The Salesforce package's flows shipped in 2022 (AppExchange distribution came in 2024); Internal Meetings and Playbook Portals both landed in 2025.

{: .note }
> Cells describe the **default** behaviour. Because the package field mapping, Entity Patterns, and Playbooks are all customizable, a specific org may extend some of these.

---

## Where each field value comes from

Two records are written by **every** implementation: the `Event` and the Schedule meeting detail record, whose `BookingFlowId__c` always carries the booking id. What differs is the additional records and where each value originates.

| Implementation | Field-value source |
|---|---|
| **Salesforce package** | Values come from what the customer or advisor entered. The meeting detail record is populated by the package; the `Event` and activity object are filled by your **field mappings**: each field is a direct copy of a booking value, a constant, or the result of an **Apex hook**. |
| **CRM Configuration** | The `Lead` is written with placeholders; your **field map** then overrides or adds values: either a value taken from the meeting or a custom value you supply. |
| **Entity Patterns & Playbooks** | Abstract field names resolve to your CRM's real fields via **entity definitions**; a field you don't declare is skipped, and defaults apply only where the booking is empty. In **Playbooks**, values are additionally shaped by the editor's mappings and transformations before reaching the same pattern. |

---

## Points that are easy to get wrong

{: .important }
> **No record type is set on the package's default path.** If you need specific `Event` record types, configure them explicitly. See [Salesforce Package]({{ site.baseurl }}/schedule/meeting-creation/salesforce-package/#what-gets-created).

{: .important }
> **Location is stored as selected.** Schedule's "pretty" location formatting is display-only and doesn't change the stored `Event.Location`. The meeting **title** override, however, does apply to the stored `Event.Subject`.

{: .important }
> **The Playbook approach is fully configurable, not restricted.** It writes through entity patterns, so it creates whatever records your pattern and playbook define. The standard pattern creates no `Lead` by default, but you can configure one if your CRM model needs it (by contrast, the CRM Configuration path always creates a `Lead`). See [Playbooks]({{ site.baseurl }}/schedule/meeting-creation/playbooks/#what-gets-created-defined-by-your-pattern).

{: .important }
> **Only CRM Configuration is Leads-only**, and it is Leads-only by design: the attendee is always a placeholder `Lead` that cannot be changed to another object.

---

## Related pages

- [Meeting Creation overview]({{ site.baseurl }}/schedule/meeting-creation/)
- [UWC (Roadmap 2026)]({{ site.baseurl }}/schedule/meeting-creation/#roadmap-2026) (Next wave)
- [Internal Meetings (Embeddable)]({{ site.baseurl }}/schedule/meeting-creation/internal-meetings/) (Next wave)
- [Playbook Portals]({{ site.baseurl }}/schedule/meeting-creation/playbooks/) (Next wave)
- [Platform-Hosted Booking]({{ site.baseurl }}/schedule/meeting-creation/platform-booking/)
- [Salesforce Package (AppExchange)]({{ site.baseurl }}/schedule/meeting-creation/salesforce-package/) (Stable)
- [CRM Configuration Portals]({{ site.baseurl }}/schedule/meeting-creation/crm-configuration/) (Stable)
