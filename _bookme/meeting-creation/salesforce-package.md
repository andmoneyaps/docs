---
layout: default
title: Salesforce Package (AppExchange)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 1
---

# Salesforce Package (AppExchange)
{: .no_toc }

The **BookMe AppExchange package** (managed, namespace `andmoney`; also shipped as per-customer unlocked packages) is **Architecture A**: it writes Salesforce records **in-org, in Apex**. This page covers the customer flow, the employee flow, and the configuration engine that lets you shape every field value.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## One shared write path

Both flows are Lightning Web Components that call **one shared Apex entry point**:

```text
LWC → AMBBookingController.bookMeeting(dto, configId)
        → reserve slot in the &money booking engine (Named Credential)
        → AMBMeetingController.createSFMeeting(dto)
             → AMBCRUDProvider → AMBConfigUtils.applyDTOToSObject → DML
```

The customer flow (`c-bookme-customer-flow`, on an Experience Cloud community site) and the employee flow (`c-bookme-employee-flow`, on a Lightning record page) run the **same Apex code**. They differ only in the **DTO** the front-end assembles and in one server-side guard.

This path **never touches the &money .NET backend** for the Salesforce write — it books the external engine over a Named Credential and then performs DML directly in the org.

---

## What gets created

`createSFMeeting` inserts records in a fixed order:

| # | Object | When | Notes |
|---|---|---|---|
| 1 | `AMB_Event_Detail__c` | **Always** | Written from a **hardcoded** map (`AMBDefaultConfigUtil.getEventDetailConfig`). **Not** overridable via field-map config. |
| 2 | `AMB_Meeting_Contact__c` | Per participant/contact | Junction rows linking contacts to the detail record. |
| 3 | Activity object / participant | When `relatedRecordId` is blank | **Opportunity by default**; a config can substitute Lead / Contact / Account / Case / Campaign / Contract / Asset / Product / Solution / Order. |
| 4 | `Event` (standard Activity) | Always | The actual meeting. |
| 5 | `EventRelation` | Per additional advisor / invitee | Requires **Shared Activities** enabled in the org. |
| — | `AMB_Address__c` | Optional | Upserted for start/end addresses when present. |

{: .note }
> **`AMB_Event_Detail__c` is the anchor.** Its `BookingFlowId__c` field is set to the booking-engine meeting id and is the correlation key for all later lookups and updates. `SendMeetingInvite__c = true` triggers the package's own in-org Apex to send the calendar invite.

### Key `Event` field sources

| Field | Value comes from |
|---|---|
| `StartDateTime` / `EndDateTime` | `dto.startDate` / `dto.endDate` |
| `Subject` | `dto.meetingTitle` (see title rules below) |
| `Description` | `dto.description` |
| `Location` | **raw** `dto.location` |
| `OwnerId` | advisor `User`, resolved from the advisor's email |
| `ShowAs` | hardcoded `Busy` on create/update (`Free` on cancel) |
| `IsAllDayEvent` | hardcoded `false` |
| `AMB_Event_Detail__c` | link to the detail record |
| `WhoId` / `WhatId` | **not** set directly by the default map — established via `EventRelation` (Shared Activities) |

{: .note }
> **Corrected fact — Location is stored raw.** The `String` provider's `getLocationPrettyPrint` is a **display-only** transform applied to *read* responses. It does **not** change the stored `Event.Location` / `AMB_Event_Detail__c.Location__c`, which take the raw `dto.location`. By contrast, `getMeetingTitle` **does** flow to `Event.Subject` / `Opportunity.Name`, because `dto.meetingTitle` is overwritten before booking.

{: .note }
> **Corrected fact — no active record-type mechanism.** On the default path there is **no** working record-type-setting mechanism: the `Event.RecordTypeId` map is commented out, and `AMB_Booking_Record_Type_Default__mdt` has **no consumer anywhere** in the package.

---

## Customer flow vs employee flow

The two flows share the write path and diverge only in the DTO and one guard.

| Aspect | Customer flow | Employee flow |
|---|---|---|
| Placement | Experience Cloud community LWC (`c/bookmeCustomerFlow`) | Lightning record page (`c/bookmeEmployeeFlow`), gated by the `BookingPlatformAdvisor` permission set |
| `bookedByCustomer` | `true` → `AMB_Event_Detail__c.IsCustomerInitiated__c = true` | `false` |
| Custom meeting title | **Rejected** — `bookMeeting` throws if a non-advisor sets a title | Allowed (advisor-only server guard) |
| Additional advisors | Hardcoded `[]` | `additionalAdvisors` supported |
| Explicit owner | Advisor from the resolved variant | `meetingOwner` can be set explicitly |
| Reuse existing record | No (see note) | Yes — a checkbox sets `relatedRecordId`, skipping Opportunity creation |
| `sendMeetingInvites` | Hardcoded `true` | Advisor checkbox (default from config) |

{: .note }
> **Corrected fact — the customer flow's `recordId` is inert.** The customer LWC sends a `recordId` key in its DTO JSON, but `AMBBookMeetingDTO` has no `recordId` property (only `relatedRecordId`). Salesforce deserialization silently drops it, so the **customer flow never populates `relatedRecordId`** and always creates a new activity object (Opportunity). Only the employee flow (via the checkbox) ever reuses an existing record.

The decisive **data** difference between the two flows is simply `bookedByCustomer` (and thus `IsCustomerInitiated__c`); everything else is UI capability gating.

---

## How you configure field values

The package's whole customization substrate is the **SObject Configuration Service** — a Custom-Metadata field-mapping engine plus an Apex dependency-injection layer. See [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/) for the day-to-day admin view; this section is the mechanics.

### 1. Custom Metadata field mapping

A named configuration is passed to the LWC as `configId` and resolved at runtime:

```text
AMB_Config__mdt (Config_Id__c)
  └─ AMB_Config_Relation__mdt
       └─ AMB_SObject_Config__mdt (sObject_Type__c, With_Sharing__c)
            └─ AMB_Config_Field_Mapping__mdt
                 • Source_Field_Name__c   → a DTO attribute
                 • Target_Field_Name__c   → the SObject field to set
                 • Util_Class_Name__c     → optional Apex Callable transform
                 • Util_Method_Name__c
                 • With_Security__c
```

For each mapping, `applyDTOToSObject` either **copies a DTO attribute directly** or **invokes your Apex `Callable`** to compute the value. If `configId` is blank, a hardcoded default (`Opportunity` + `Event`) is used.

{: .warning }
> The `AMB_Event_Detail__c` mapping is **always hardcoded** and cannot be overridden through `configId`. Field-map config only controls the activity object/participant, the `Event`, and any additional configured objects.

Two behaviours worth knowing:

- A mapping whose `Source_Field_Name__c` is set but whose DTO value is `null` is **skipped** — you cannot use it to *clear* a field.
- A mapping with a **blank** source but a util class **always runs** — this is how constants are written (e.g. `Opportunity.StageName = 'Open'`, `Event.ShowAs = 'Busy'`).

{: .note }
> **Validation runs only for non-default configs.** `AMBConfigValidator` (which rejects unknown DTO sources, unknown target fields, or util classes that don't implement `Callable`) runs only when a non-blank `configId` is supplied. The hardcoded default config is used unvalidated.

### 2. Apex Callable transforms (hooks)

Any target field can be routed through **your own Apex class implementing `Callable`**, named in `Util_Class_Name__c` / `Util_Method_Name__c`. The class is called as `callable.call(method, {sourceValue, sourceName, dto})` and its return value is written to the target field. The DTO itself is a `Callable`, so your transform can pull strongly-typed source values (e.g. `dto.call('endDate')`).

Shipped examples you can study or replace: `AMBOpportunityUtil`, `AMBLeadUtil`, `AMBEventUtil`, `AMBEventDetailConfigUtil`.

### 3. Dependency-injection provider swaps

`AMB_Booking_Platform_DI_Implementations__mdt` (`DeveloperName → Apex_Class_Name__c`) lets you replace whole subsystems, resolved by `AMBInterfaceImplementationProvider`:

| Provider key | What you can replace |
|---|---|
| `CRUD_Provider_Implementation` | Record create/update/delete entirely |
| `Activity_Provider_Implementation` | `Event` creation and `EventRelation` handling |
| `Opportunity_Provider_Implementation` | Opportunity resolution (owner, close date, stage) |
| `Account_` / `Contact_` / `User_Provider_Implementation` | Record/user resolution |
| `Taxonomy_Provider_Implementation` | Theme → taxonomy resolution |
| `String_Provider_Implementation` | Meeting title and location pretty-print |
| `Competence_` / `Search_` / `Sla_Provider_Implementation` | Competence, search, SLA (location/category) |

{: .note }
> A wrong `DeveloperName` silently yields **no** override (the lookup returns null and the default provider is used).

### 4. Other configuration metadata

| Metadata | Effect |
|---|---|
| `AMB_Meeting_Configuration__mdt` | Overrides `Title` / `Location` / `StartAddress` / `EndAddress` via a Callable (`AMBMeetingOverrideUtils`) |
| `AMB_Booking_Limit__mdt` | `Opportunity_Close_Default_Days` → offsets `Opportunity.CloseDate` from the meeting end date |
| `AMB_Booking_Validation_Rule__mdt` | Toggles named validation rules — **advisory / UI-side only**, surfaced via `getValidationRules`; does **not** enforce anything on the server write path |

### 5. LWC-level configuration

The flows accept a `configOverride` object (and `configid` / `brand` / `subthemeid` / `customflow`) that a **wrapping component** supplies programmatically. This is how you embed and parameterize the flow.

{: .note }
> **Corrected fact — these are not App Builder attributes.** `configOverride` and the advisor flags (`disablecustommeetingtitle`, `sendmeetinginvitedefaultvalue`, `advisortypewhitelist`, etc.) are **not** exposed as Lightning App Builder design properties on `c-bookme-employee-flow`. They are properties of the config object passed via `configOverride` from a custom wrapping LWC, and take effect only when such a wrapper supplies them.

---

## Constraints and gotchas

- **Shared Activities** must be enabled for `EventRelation`-based advisor/multi-contact linking.
- `createSFMeeting` runs **without sharing** when a config's `With_Sharing__c` is `false` (the default), even though the enclosing `AMBMeetingController` is declared `with sharing`.
- **Reschedule/cancel** (`updateSFMeeting`) updates only the `Event` and `AMB_Event_Detail__c` — it **never** updates the who/what (Opportunity/Lead) record (a documented TODO). Only `editSFMeeting` updates the who/what, and only when the existing record's type matches the configured type.
- When a config declares **both** an activity object (What) and a participant (Who), the **What wins** — the participant config is ignored for the who/what record.

---

## Not Leads-only

Unlike the [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path, this mechanism is **not** restricted to Leads. The default creates an `Opportunity` + `Event`; a config can target any supported activity object (`Opportunity`, `Account`, `Case`, `Campaign`, `Asset`, `Contract`, `Product`, `Solution`, `Order`) or participant (`Contact`, `Lead`).

---

## Related pages

- [Entity Configuration Management]({{ site.baseurl }}/bookme/entity-configuration-management/) — admin view of configuration
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) — embedding the flows
- [Customer Meeting Booking]({{ site.baseurl }}/bookme/customer-meeting-booking/) — the end-user booking experience
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
