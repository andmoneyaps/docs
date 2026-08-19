---
layout: default
title: Salesforce Package (AppExchange)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 3
---

# Salesforce Package (AppExchange)
{: .no_toc }

{: .warning }
> **Stable implementation.** Mature and fully supported. New implementations typically use the Next platform (the entity-pattern-based [Internal Meetings]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) and [Playbook Portals]({{ site.baseurl }}/bookme/meeting-creation/playbooks/)), but this remains a supported option.

The **Schedule managed package** (the AppExchange package, historically *&bookme – Scheduler*) is installed in your Salesforce org and creates meetings **inside your org**. This page covers the two booking experiences it offers, the customer flow and the employee flow, and the options you have for controlling the field values.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## One shared way of creating the meeting

Both experiences are components you place on a page:

- the **customer flow**, a public, self-service booking component, typically on an Experience Cloud (community) site; and
- the **employee flow**, an advisor booking component on a Salesforce record page.

They both run the **same record-creation logic in your org**. When someone confirms a booking, the package reserves the time slot with the &money platform and then creates the records directly in your Salesforce org. Everything a customer or advisor entered flows through the package's field-mapping configuration to decide what ends up on each record.

The two experiences differ only in **what the person is allowed to enter**, not in how the records are created.

---

## What gets created

The package creates the following records, in this order:

| # | Record | When | Notes |
|---|---|---|---|
| 1 | Schedule meeting detail (`AMB_Event_Detail__c`) | **Always** | Holds all Schedule-specific meeting information. Its field values are **fixed by the package** and are not part of the configurable field mapping. |
| 2 | Meeting contact (`AMB_Meeting_Contact__c`) | Per participant | Links contacts to the meeting detail record. |
| 3 | Activity object / participant | When the booking isn't attached to an existing record | **`Opportunity` by default.** The meeting is related to the Account and, via a **hardcoded** chain, an `Opportunity` or `Lead` (see [Constraints](#constraints-and-things-to-know)). |
| 4 | `Event` | Always | The meeting itself. |
| 5 | `EventRelation` | Per additional advisor / invitee | Requires **Shared Activities** enabled in your org. |
| - | Address (`AMB_Address__c`) | Optional | Created for start/end addresses when present. |

### Fields written to the Schedule meeting detail (`AMB_Event_Detail__c`)

These are populated by the package (fixed, not part of the configurable field mapping):

| Field | Value |
|---|---|
| `BookingFlowId__c` | The booking's unique id (the key for every later lookup/update) |
| `IsCustomerInitiated__c` | `true` for the customer flow, `false` for the employee flow |
| `Comment__c` | The booking comment |
| `MeetingTaxonomy__c` | The booking theme, translated to your CRM's taxonomy value |
| `MeetingType__c` / `MeetingTypeLabel__c` | The selected meeting type |
| `AdvisorEmail__c` / `AdvisorName__c` | The advisor |
| `OwnerId` | The advisor (resolved to a Salesforce user) |
| `Location__c` / `RoomId__c` / `RoomName__c` | The selected location / room |
| `TeamsMeetingLink__c` | The online meeting link, when the meeting is online |
| `SendMeetingInvite__c` | Passive notification-intent flag, set to `true` by default. Schedule sends **nothing** based on it: it's there for your own automation (e.g. a Marketing Cloud journey). The booking can supply the value, so an advisor flow may expose it as a choice. |
| `StartAddress__c` / `EndAddress__c` | Links to address records, when addresses are provided |
| `CancellationReason__c` / `CancelledBy__c` | Set **only** when the meeting is cancelled |

{: .note }
> **The meeting detail record is the anchor.** `BookingFlowId__c` is the key used for every later lookup and update. `SendMeetingInvite__c` is a **passive** flag (default `true`): it records that participants should be notified but does not itself send anything, and the package ships no customer-invite email. The advisor's time (and a room, if configured) is reserved via a separate Microsoft 365 calendar appointment.

### Fields written to the `Event`

| Field | Value |
|---|---|
| `StartDateTime` / `EndDateTime` | The chosen time slot |
| `Subject` | The meeting title (any configured title override **is** applied here) |
| `Description` | The booking comment |
| `Location` | The selected location (stored **as selected**, see note) |
| `OwnerId` | The advisor |
| `ShowAs` | Constant `Busy` (set to `Free` on cancellation) |
| `IsAllDayEvent` | Constant `false` |
| `AMB_Event_Detail__c` | Link to the meeting detail record |

**Not set on the `Event` by default:**

| Field | Why |
|---|---|
| `WhoId` / `WhatId` | Not written directly: the who/what link is established through `EventRelation` (requires **Shared Activities**) |
| `RecordTypeId` | **No record type is assigned** out of the box; configure it explicitly if you need one |

### Fields written to the default activity object (`Opportunity`)

Created only when the booking isn't attached to an existing record. (If you configure a different activity object, its fields come from your field mapping instead.)

| Field | Value |
|---|---|
| `Name` | The meeting title |
| `AccountId` | The account the booking is for |
| `OwnerId` | The advisor |
| `Description` | The booking comment |
| `CloseDate` | The meeting date, offset by your configured number of days |
| `StageName` | Constant `Open` |

### Other records

- **Meeting contact (`AMB_Meeting_Contact__c`)**: one per participant, carrying the contact link, name, and email.
- **`EventRelation`**: one per invitee/additional advisor; advisors are marked as invitees, and the related who/what record as the parent. Requires **Shared Activities**.
- **Address (`AMB_Address__c`)**: created only when start/end addresses are supplied.

{: .note }
> **The stored location is the raw selected value.** Any "pretty" location formatting Schedule shows in its own screens is display-only and does **not** change the `Event.Location` / meeting-detail location stored in your CRM. The meeting **title** override, by contrast, **does** apply to `Event.Subject` and the activity object's `Name`.

---

## Customer flow vs employee flow

The two experiences share the record-creation logic and differ only in what the person can do.

| Capability | Customer flow | Employee flow |
|---|---|---|
| Placement | Public / Experience Cloud site | Salesforce record page (advisor, permission-gated) |
| Marked as customer-initiated | Yes | No |
| Custom meeting title | Not allowed | Allowed (advisors only) |
| Additional advisors | No | Yes |
| Explicit meeting owner | No | Yes |
| Attach to an existing record | No: always creates a new activity object | Yes: can reuse an existing record and skip creating one |
| `SendMeetingInvite__c` flag (notification intent) | Set `true` | Set `true` by default; the booking can supply the value |

The single meaningful **data** difference is that the customer flow marks the meeting as customer-initiated. Everything else is about which fields and controls the person sees.

---

## How you configure field values

The package's configuration is Salesforce-native and lives entirely in your org. For the day-to-day admin view, see [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/); this is a summary of the **options available to you**.

### 1. Custom-metadata field mappings

You define a named **configuration** and map, field by field, a **source value** from the booking to a **target field** on a record (`Event`, the activity object, and so on). A configuration decides:

- **which activity object** is created (default `Opportunity`) and how its fields are populated; and
- **which field** each booking value is written to.

If you don't supply a configuration, Schedule uses a sensible default (an `Opportunity` plus an `Event`).

{: .warning }
> The Schedule **meeting detail record** is always populated by the package and **cannot** be re-mapped through this configuration. Field mapping controls the `Event`, the activity object/participant, and any additional objects you configure.

Two behaviours are worth knowing:

- A mapping is **skipped when its source value is empty**: you cannot use a mapping to *clear* a field.
- A mapping can write a **constant** value (for example, always setting an opportunity stage to `Open`).

### 2. Apex hooks (per-field transformations)

For any target field, you can route the value through **your own Apex logic** to transform or compute it before it's written. This is the primary extension point for customers who need values that aren't a direct copy of a booking field. Schedule ships several example transformations you can study or replace.

### 3. Swappable provider logic

Beyond individual fields, you can **replace whole pieces of behaviour** with your own Apex: for example, how records are written, how advisors and users are resolved, how the meeting title or location string is produced, or how activity relations are handled. This lets you adapt the package deeply without modifying it.

### 4. Additional configuration

| Option | Effect |
|---|---|
| Title / location overrides | Compute the meeting title or location with your own logic |
| Opportunity close-date offset | Set how far after the meeting an opportunity's close date falls |
| Validation rules | Surface booking validation messages in the UI (advisory only; they don't block the write) |

### 5. Component configuration

When you place the flow components, a **wrapping component** can pass configuration to them: which named configuration to use, branding, the starting theme, and advisor-only UI options (such as whether the custom-title field is shown). These are set programmatically by the wrapper, not as page-level design attributes.

---

## Constraints and things to know

- **The advisor flow must be launched from an `Account`, `Opportunity`, `Lead`, or `Case` record page**: each resolves up to the Account (`Lead` resolves only in Financial Services Cloud orgs, via the related-account field). **Launching from a `Contact` is not supported** and fails with an "Unsupported record type" error.
- **Event-to-record resolution is hardcoded** as `Account → Opportunity/Lead → Event`: the `Event` is related to the Account and, optionally, an `Opportunity` (`WhatId`) or `Lead` (`WhoId`). Other object types are not resolved into this chain.
- **Shared Activities** must be enabled for advisor/multi-contact linking via `EventRelation`.
- **Reschedule and cancel** update the `Event` and the meeting detail record, but **not** the related activity object (e.g. an `Opportunity`). Only an explicit edit updates the activity object.
- When a configuration specifies **both** an activity object (a "what", e.g. `Opportunity`) and a participant (a "who", e.g. `Lead`), the **activity object takes precedence**.

---

## What the meeting relates to

Unlike the [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path, which is always a `Lead`, the package relates the meeting to an **`Account`, `Opportunity`, or `Lead`**, resolved by a **hardcoded** chain (`Account → Opportunity/Lead → Event`), not a free-form mapping. The default creates an `Opportunity`. You can still customize the **field values** (via field mappings + Apex hooks), but the objects and relationships themselves are fixed, the key contrast with the Next-platform Entity-Pattern approaches, where they are fully configurable.

---

## Related pages

- [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/) (admin view of configuration)
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) (embedding the flows)
- [Customer Meeting Booking]({{ site.baseurl }}/bookme/customer-meeting-booking/) (the end-user booking experience)
- [Comparison Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
