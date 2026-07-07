---
layout: default
title: Salesforce Package (AppExchange)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 1
---

# Salesforce Package (AppExchange)
{: .no_toc }

The **BookMe managed package** is installed in your Salesforce org and creates meetings **inside your org**. This page covers the two booking experiences it offers — the customer flow and the employee flow — and the options you have for controlling the field values.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## One shared way of creating the meeting

Both experiences are components you place on a page:

- the **customer flow** — a public, self-service booking component, typically on an Experience Cloud (community) site; and
- the **employee flow** — an advisor booking component on a Salesforce record page.

They both run the **same record-creation logic in your org**. When someone confirms a booking, the package reserves the time slot with the &money platform and then creates the records directly in your Salesforce org. Everything a customer or advisor entered flows through the package's field-mapping configuration to decide what ends up on each record.

The two experiences differ only in **what the person is allowed to enter** — not in how the records are created.

---

## What gets created

The package creates the following records, in this order:

| # | Record | When | Notes |
|---|---|---|---|
| 1 | BookMe meeting detail (`AMB_Event_Detail__c`) | **Always** | Holds all BookMe-specific meeting information. Its field values are **fixed by the package** and are not part of the configurable field mapping. |
| 2 | Meeting contact (`AMB_Meeting_Contact__c`) | Per participant | Links contacts to the meeting detail record. |
| 3 | Activity object / participant | When the booking isn't attached to an existing record | **`Opportunity` by default**; you can configure a different object (e.g. `Lead`, `Contact`, `Account`, `Case`, `Campaign`, `Contract`). |
| 4 | `Event` | Always | The meeting itself. |
| 5 | `EventRelation` | Per additional advisor / invitee | Requires **Shared Activities** enabled in your org. |
| — | Address (`AMB_Address__c`) | Optional | Created for start/end addresses when present. |

{: .note }
> **The meeting detail record is the anchor.** Its `BookingFlowId__c` field carries the booking id and is the key used for every later lookup and update. Setting its `SendMeetingInvite__c` field to `true` is what triggers the calendar invitation.

### Where the `Event` field values come from

| Field | Value |
|---|---|
| `StartDateTime` / `EndDateTime` | The chosen time slot |
| `Subject` | The meeting title |
| `Description` | The booking comment |
| `Location` | The selected location |
| `OwnerId` | The advisor |
| `ShowAs` | Always `Busy` |
| `IsAllDayEvent` | Always `false` |
| `WhoId` / `WhatId` | Established through `EventRelation` (Shared Activities), not set directly |

{: .note }
> **The stored location is the raw selected value.** Any "pretty" location formatting BookMe shows in its own screens is display-only and does **not** change the `Event.Location` / meeting-detail location stored in your CRM. The meeting **title**, by contrast, does apply any configured title override to `Event.Subject` and the activity object's name.

{: .note }
> **No record-type is set on the default path.** Out of the box, BookMe does not assign a record type to the created `Event`. If you need specific record types, that must be configured explicitly.

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
| Attach to an existing record | No — always creates a new activity object | Yes — can reuse an existing record and skip creating one |
| Send calendar invite | Always on | Advisor choice (defaults from configuration) |

The single meaningful **data** difference is that the customer flow marks the meeting as customer-initiated. Everything else is about which fields and controls the person sees.

---

## How you configure field values

The package's configuration is Salesforce-native and lives entirely in your org. For the day-to-day admin view, see [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/); this is a summary of the **options available to you**.

### 1. Custom-metadata field mappings

You define a named **configuration** and map, field by field, a **source value** from the booking to a **target field** on a record (`Event`, the activity object, and so on). A configuration decides:

- **which objects** are created (for example, an `Opportunity`, a `Lead`, or a `Contact` as the activity object/participant); and
- **which field** each booking value is written to.

If you don't supply a configuration, BookMe uses a sensible default (an `Opportunity` plus an `Event`).

{: .warning }
> The BookMe **meeting detail record** is always populated by the package and **cannot** be re-mapped through this configuration. Field mapping controls the `Event`, the activity object/participant, and any additional objects you configure.

Two behaviours are worth knowing:

- A mapping is **skipped when its source value is empty** — you cannot use a mapping to *clear* a field.
- A mapping can write a **constant** value (for example, always setting an opportunity stage to `Open`).

### 2. Apex hooks (per-field transformations)

For any target field, you can route the value through **your own Apex logic** to transform or compute it before it's written. This is the primary extension point for customers who need values that aren't a direct copy of a booking field. BookMe ships several example transformations you can study or replace.

### 3. Swappable provider logic

Beyond individual fields, you can **replace whole pieces of behaviour** with your own Apex — for example, how records are written, how advisors and users are resolved, how the meeting title or location string is produced, or how activity relations are handled. This lets you adapt the package deeply without modifying it.

### 4. Additional configuration

| Option | Effect |
|---|---|
| Title / location overrides | Compute the meeting title or location with your own logic |
| Opportunity close-date offset | Set how far after the meeting an opportunity's close date falls |
| Validation rules | Surface booking validation messages in the UI (advisory only; they don't block the write) |

### 5. Component configuration

When you place the flow components, a **wrapping component** can pass configuration to them — which named configuration to use, branding, the starting theme, and advisor-only UI options (such as whether the custom-title field is shown). These are set programmatically by the wrapper, not as page-level design attributes.

---

## Constraints and things to know

- **Shared Activities** must be enabled for advisor/multi-contact linking via `EventRelation`.
- **Reschedule and cancel** update the `Event` and the meeting detail record, but **not** the related activity object (e.g. an `Opportunity`). Only an explicit edit updates the activity object.
- When a configuration specifies **both** an activity object (a "what", e.g. Opportunity) and a participant (a "who", e.g. Contact), the **activity object takes precedence**.

---

## Not Leads-only

Unlike the [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path, this implementation is **not** restricted to Leads. The default creates an `Opportunity` + `Event`; you can configure any supported activity object (`Opportunity`, `Account`, `Case`, `Campaign`, `Asset`, `Contract`, `Product`, `Solution`, `Order`) or participant (`Contact`, `Lead`).

---

## Related pages

- [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/) — admin view of configuration
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) — embedding the flows
- [Customer Meeting Booking]({{ site.baseurl }}/bookme/customer-meeting-booking/) — the end-user booking experience
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
