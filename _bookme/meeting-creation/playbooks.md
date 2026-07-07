---
layout: default
title: Playbooks (New Portals & UWC)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 5
---

# Playbooks (New Portals & UWC)
{: .no_toc }

The newest path. New **Portals** and the **Universal Web Client (UWC)** create meetings through **Playbooks** — a forkable, visual block graph that writes *through* the same [Entity-Pattern engine]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) as internal meetings. This is the third generation of [Architecture B]({{ site.baseurl }}/bookme/meeting-creation/backend-core/).

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

{: .note }
> This page focuses on **how a meeting is created** via a playbook. For authoring playbooks, blocks, and the visual editor, see the [Playbooks]({{ site.baseurl }}/bookme/playbooks/) subsection.

---

## When it runs

The playbook path runs for **portal bookings** whose portal has `CrmCreationStrategy = Playbook`. Otherwise the legacy [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path handles the same event.

```text
New portal / UWC books a meeting (portal CrmCreationStrategy = Playbook)
  → Calendar publishes CreateCrmMeetingEvent (IsPortalMeeting=true, CreateUsingPlaybooks=true)
  → Playbook: MeetingCreatedEventConsumer runs the portal's playbook (PortalMeetings trigger)
       → EntityPatternCreate block maps its InputRelations onto a mutate payload
       → CreateEntityPatternInstanceBySemanticIdAsync
       → CRM-Integration: SalesforceAdapter.CreateEntityPatternInstanceAsync → POST composite/graph
```

{: .note }
> On the `CreateUsingPlaybooks` branch, the CRM-Integration `CreateCrmMeetingEventHandler` **returns early** — so the legacy `StandardRecordsHelper` graph does **not** run for playbook portals.

---

## What gets created — pattern-defined, not hardcoded

{: .important }
> The exact objects and fields are **not hardcoded in the playbook service**. They are **entirely determined by the entity-pattern definition** referenced by the `EntityPatternCreate` block. `SalesforceAdapter.CreateEntityPatternInstanceAsync` is fully generic and never references `StandardRecordsHelper` or any BookMe-specific object.

For the **andmoney-managed BookMe meeting pattern**, that resolves to `Event` + `AMB_Event_Detail__c` + `EventRelation`. A different pattern would create a different set.

{: .warning }
> **Corrected fact — this path creates no `Lead` and no `AMB_Meeting_Contact__c`.** Earlier drafts attributed a `Lead` and `AMB_Meeting_Contact__c` to this path. Those come from the **legacy** `StandardRecordsHelper` composite (`Lead`) or from **separate post-creation attendee-sync** code (`AMB_Meeting_Contact__c`) — **not** from the playbook write. The `Lead`-graph belongs to [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/), and attendee sync belongs to the [backend core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/#what-bypasses-the-sink).

---

## How you configure field values

Two layers stack:

### 1. The playbook editor (`EntityPatternCreate` block)

The block's **`InputRelations`** map `SourceField → DestinationField` with optional **transformations (JMESPath / Liquid)**. This is where a customer decides *which SObject fields are written and from what value*. `Template` blocks (Liquid) can pre-format text values (e.g. a description) that feed into the create block.

Under the hood, `EntityPatternMutateHelper.GetSourceValue` + `PathBasedEntityPatternBuilder.ParsePath` resolve dotted paths into pattern parts, and the executor validates required fields and types against the pattern describe **before** writing.

{: .note }
> The block supports a **dry-run mode** (`IsDryRun`) that performs the full parse / describe / map / validate and echoes the mapped payload **without** writing to the CRM — the way to verify your field mappings in the editor.

### 2. The entity pattern definition (Admin → Entities)

Below the editor, the [Entity Pattern]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) definition determines which parts/objects exist and how abstract field names map to real CRM fields. The playbook path and the internal-meeting path **share this engine**.

### Gating and forking

| Hook | Effect |
|---|---|
| Portal `CrmCreationStrategy = Playbook` | Whether the playbook path runs at all |
| `PortalMeetings` trigger (scoping via `AdditionalBlockData`) | Which portals activate the playbook; portal custom fields become trigger output fields |
| `EntityPatternCreate` block `InputRelations` | Which fields are written and their values |
| Entity Pattern definition | Which objects/parts are created; abstract → CRM field mapping |
| **Fork managed playbook** | Creates an editable bank-owned copy so you can change the above |

{: .note }
> A managed playbook is forkable only when `Origin == System && Visibility == Open && !HasExistingFork`. Forking yields a customer-editable copy (`IsForked`, `ClonedFromSemanticId`).

---

## Where it runs

- **New Portals** (`engageme-web-portals`) — customer self-service bookings.
- **UWC** (`ui-components` / `engage-web`) — the drag-and-drop playbook editor and employee contexts.

Both funnel through the same Calendar → Playbook → Entity-Pattern → `composite/graph` path.

---

## Related pages

- [Playbooks (authoring)]({{ site.baseurl }}/bookme/playbooks/)
- [Entity Patterns (Internal Meetings)]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) — the shared write engine
- [Backend Meeting Core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/)
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
