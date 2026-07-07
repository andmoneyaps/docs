---
layout: default
title: CRM Configuration (Legacy Portals)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 3
---

# CRM Configuration (Legacy Portals)
{: .no_toc }

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

{: .warning }
> **This is the oldest Architecture-B path and is being superseded** by [Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) and [Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/). It runs only for portal meetings whose portal `CrmCreationStrategy` is **not** `Playbook`. New portals should use the Playbook path.

---

## When it runs

This path handles **portal meetings** (`PortalId` is set) where the portal's `CrmCreationStrategy` is not `Playbook`:

```text
Old portal books a meeting (sets PortalId)
  → Calendar publishes CreateCrmMeetingEvent (IsPortalMeeting=true, CreateUsingPlaybooks=false)
  → CRM-Integration: CreateCrmMeetingEventHandler
       → CrmIntegrationService.CreateMeetingWithCrmMapping
            → StandardRecordsHelper builds a hardcoded composite graph
            → merge the portal's CrmMappingConfiguration field map
            → SalesforceAdapter → POST composite/graph
```

See [Backend Meeting Core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/) for how it fits the shared sink.

---

## What gets created — a hardcoded Lead graph

`StandardRecordsHelper.GetStandardRecordRequests` always builds the same base graph:

| Object | Details |
|---|---|
| `Lead` | **Always created first.** Placeholder `LastName = 'LastName'`, `Status = 'Open'`, `Company = 'Company'` (only when the org marks `Company` non-nillable). `OwnerId` set to the resolved advisor when the owner email resolves. |
| `Event` | `WhoId` is **hardwired** to `@{LeadRef.id}` — the placeholder Lead is the attendee. |
| `{ns}AMB_Event_Detail__c` | Also writes `SendMeetingInvite__c = true`, `CancellationReason__c = ""`, `CancelledBy__c = null`. `MeetingTaxonomy__c` resolved from the theme (`GetTaxonomySalesforceId(ThemeId)`). |
| `EventRelation` | One per **additional advisor** (`User`, `IsInvitee = true`, `IsParent = false`). Not for the owner. |

---

## Why it is structurally Leads-only

{: .important }
> The attendee is **always a newly-created placeholder `Lead`**, and `Event.WhoId` is hardwired to `@{LeadRef.id}`. This is not a configuration choice — it is baked into `StandardRecordsHelper`.

Consequences:

- There is **no** `Contact` or Person Account creation, and **no matching against an existing person**.
- `MeetingMappingDto.SalesforceId` (the account id) is **ignored** on this path — it is only consumed by the newer Entity-Pattern path.
- `MeetingMappingDto.ExternalAttendees` is **ignored** — no `Contact` records are created for external attendees.
- A field map that named a different top-level object (e.g. `Contact`) would create it as a **stray standalone record**, but it could **never** become the `Event`'s attendee.

If you need meetings on Contacts, Accounts, or existing records, use the [Entity Pattern]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) or [Playbook]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) paths instead.

---

## How you configure field values

A **`CrmMappingConfiguration`** (stored in Postgres, owned per bank, soft-deletable) is bound to a portal via `Portals.CrmMappingConfigurationId`. It can **override or add field values** on the hardcoded records — but it cannot remove a standard record or re-point `Event.WhoId`.

It owns two child collections:

| Collection | Source → Target |
|---|---|
| `StandardFieldMapping` | `InternalFieldName` (a **C# property path** on `MeetingMappingDto`, e.g. `MeetingOwner.Email`) → `ExternalFieldName` (a Salesforce path, e.g. `Lead.Company`, `Event.Description`) |
| `CustomFieldMapping` | `ExternalFieldName` ← a `Key` into `MeetingMappingDto.CustomFields` |

{: .note }
> **Corrected fact — internal fields are property paths, not labels.** The stored `InternalFieldName` must be the **actual C# property path** (e.g. `MeetingOwner.Email`). The friendly `[DisplayName]` labels (e.g. "Advisor") are only shown in the authoring dropdown; they are not what gets stored or resolved.

### Where it is authored

The configuration is authored in **engageme-web-management** under **BookMe → Portals → Configurations** (`CrmMappingController`, `POST/PATCH api/v1/CrmMapping/configurations`). The dropdowns are populated from:

- **Internal** source options → reflection over `MeetingMappingDto` `[DisplayName]` properties.
- **External** target options → the Salesforce global describe (`configurationGetCrmEntityNames` + `configurationGetCrmEntityDescribe`).

The old **end-user portal** front-end does **not** author the config (it holds no `CrmMapping` code).

{: .note }
> The config load is **resilient/optional.** If a portal has no config, or the load fails/authorization is denied, the write proceeds with **only the hardcoded standard records** (the field map contributes nothing).

---

## Hooks summary

| Hook | Effect |
|---|---|
| `CrmMappingConfiguration` (Standard/Custom field mappings) | Which `MeetingMappingDto` values are written to which `Lead` / `Event` / `AMB_Event_Detail__c` field |
| `Portal.CrmCreationStrategy` | Set to `Playbook` to opt this portal **out** of this path entirely |
| Theme → taxonomy mapping | `GetTaxonomySalesforceId(ThemeId)` resolves `AMB_Event_Detail__c.MeetingTaxonomy__c` (Salesforce-side data, not part of the field map) |

---

## Related pages

- [Portals]({{ site.baseurl }}/bookme/portals/)
- [Backend Meeting Core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/)
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
