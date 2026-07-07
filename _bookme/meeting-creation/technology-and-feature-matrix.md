---
layout: default
title: Technology & Feature Matrix
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 6
---

# Technology & Feature Matrix
{: .no_toc }

The side-by-side reference for every meeting-creation implementation. Use it to answer "which implementation does X?" at a glance; follow the links for detail.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## Technology matrix

*How each implementation works and how you configure it.*

| Implementation | Where booking runs | What creates the CRM records | How you configure fields | Extension mechanism |
|---|---|---|---|---|
| **[Salesforce package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) — customer flow** | Your Salesforce org | The package, inside your org | Custom-metadata field mappings | Apex hooks + swappable providers |
| **[Salesforce package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) — employee flow** | Your Salesforce org | The package, inside your org | Custom-metadata field mappings | Apex hooks + swappable providers + advisor UI options |
| **[CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) (legacy portals)** | &money platform | The platform, on your behalf | CRM Configuration field map (Management UI) | Standard / custom field mappings over a fixed Lead-based set |
| **[Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) (embeddable internal)** | &money platform | The platform, on your behalf (Salesforce or Dynamics) | Entity Definitions + Entity Patterns (Admin → Entities) | Pattern parts, relationships, defaults, and per-org field mapping |
| **[Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) (new portals & UWC)** | &money platform | The platform, on your behalf | Playbook editor + Entity Patterns | Visual field mappings & transformations + fork a managed playbook |

---

## Feature matrix

*What each implementation supports.*

| Implementation | Customer flow | Employee flow | Records created | Leads only | Field customization | Multi-advisor | Status / vintage |
|---|---|---|---|---|---|---|---|
| **Salesforce package — customer flow** | ✅ Public / Experience Cloud | — (shares the logic) | Meeting detail, meeting contact, `Opportunity` (default), `Event`, `EventRelation` | ❌ Opportunity + Event by default | Field mappings + Apex hooks | Single advisor | Current |
| **Salesforce package — employee flow** | Advisor can book as-customer | ✅ Advisor on a record page | Same set, or reuse an existing record | ❌ Any activity object/participant | Field mappings + Apex hooks; advisor UI options | ✅ Additional advisors + explicit owner | Current |
| **CRM Configuration (legacy portals)** | ✅ Customer books on an old portal | ❌ No advisor booking UI | **`Lead` (always)**, meeting detail, `Event`, `EventRelation` | ✅ **Yes** — attendee is always a placeholder `Lead` | Field map only; record set is fixed | Additional advisors | **Legacy** — being superseded |
| **Entity Patterns (embeddable internal)** | ❌ Advisor-facing internal widget | ✅ Advisor books, links to an Account | `Event`, meeting detail, advisor relations; **no Lead / no Opportunity** | ❌ Links to an existing Account | Entity Definitions + Patterns (Admin → Entities) | ✅ Additional advisors | Current — Salesforce or Dynamics |
| **Playbooks (new portals & UWC)** | ✅ New portal / UWC (Playbook strategy) | ✅ UWC also serves employee contexts | **Pattern-defined** (standard pattern → `Event`, meeting detail, relations); **no Lead** | ❌ Pattern-defined | Playbook editor + Entity Patterns | Pattern-defined | **Newest** |

{: .note }
> ✅ / ❌ describe the **default** behaviour. Because the package field mapping, Entity Patterns, and Playbooks are all customizable, a specific org may extend some of these.

---

## Where each field value comes from

Two records are written by **every** implementation: the `Event` and the BookMe meeting detail record, whose `BookingFlowId__c` always carries the booking id. What differs is the additional records and where each value originates.

| Implementation | Field-value source |
|---|---|
| **Salesforce package** | Values come from what the customer or advisor entered. The meeting detail record is populated by the package; the `Event` and activity object are filled by your **field mappings** — each field is a direct copy of a booking value, a constant, or the result of an **Apex hook**. |
| **CRM Configuration** | The `Lead` is written with placeholders; your **field map** then overrides or adds values — either a value taken from the meeting or a custom value you supply. |
| **Entity Patterns & Playbooks** | Abstract field names resolve to your CRM's real fields via **entity definitions**; a field you don't declare is skipped, and defaults apply only where the booking is empty. In **Playbooks**, values are additionally shaped by the editor's mappings and transformations before reaching the same pattern. |

---

## Points that are easy to get wrong

{: .important }
> **No record type is set on the package's default path.** If you need specific `Event` record types, configure them explicitly. See [Salesforce Package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/#what-gets-created).

{: .important }
> **Location is stored as selected.** BookMe's "pretty" location formatting is display-only and doesn't change the stored `Event.Location`. The meeting **title** override, however, does apply to the stored `Event.Subject`.

{: .important }
> **The Playbook approach creates no `Lead` and no meeting-contact record.** The `Lead` set belongs to the legacy CRM-Configuration approach; meeting-contact records come from attendee sync. See [Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/#what-gets-created--defined-by-your-pattern).

{: .important }
> **Only CRM Configuration is Leads-only** — and it is Leads-only by design: the attendee is always a placeholder `Lead` that cannot be changed to another object.

---

## Related pages

- [Meeting Creation overview]({{ site.baseurl }}/bookme/meeting-creation/)
- [Salesforce Package (AppExchange)]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/)
- [Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/)
- [CRM Configuration (Legacy Portals)]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/)
- [Entity Patterns (Internal Meetings)]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/)
- [Playbooks (New Portals & UWC)]({{ site.baseurl }}/bookme/meeting-creation/playbooks/)
