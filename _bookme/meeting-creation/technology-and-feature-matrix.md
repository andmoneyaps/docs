---
layout: default
title: Technology & Feature Matrix
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 6
---

# Technology & Feature Matrix
{: .no_toc }

The canonical side-by-side reference for every meeting-creation mechanism. Use it to answer "which mechanism does X?" at a glance; follow the links for detail.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## Technology matrix

*How each mechanism is built and where it writes.*

| Mechanism | Front-end | Backend / write executor | Salesforce write path | Config surface | Extension mechanism |
|---|---|---|---|---|---|
| **[SF Package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) — Customer flow** | LWC on Experience Cloud (community) site | In-org Apex: `bookMeeting → createSFMeeting`; external engine over Named Credential | Direct in-org Apex DML (`AMBCRUDProvider`) | Custom Metadata `AMB_Config__mdt` chain (or hardcoded default) | Apex `Callable` resolvers + ~11 DI provider swaps + LWC `configOverride` |
| **[SF Package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) — Employee flow** | LWC on a Lightning record page (gated by `BookingPlatformAdvisor`) | Same in-org Apex path (`bookMeeting → createSFMeeting / editSFMeeting`) | Direct in-org Apex DML | Same CMDT chain + config-object flags via `configOverride` | Callable + DI + advisor-only UI flags |
| **[SF Package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) — Config / DI engine** | *(Apex service layer shared by both flows)* | `AMBConfigUtils.applyDTOToSObject → AMBCRUDProvider` | In-org Apex DML, with/without sharing per config | `AMB_Config` / `_Relation` / `_SObject` / `_Field_Mapping` `__mdt` + DI implementations mdt | Apex `Callable` transforms + ~11 swappable provider interfaces |
| **[CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) (legacy portals)** | Legacy portal → Calendar service (sets `PortalId`) | .NET: `CreateMeetingWithCrmMapping → SalesforceAdapter.CreateMeeting → CompositeRequestHelper` | REST Composite Graph (`POST composite/graph`) | `CrmMappingConfiguration` (Postgres), authored in engageme-web-management, bound per-portal | Flat Standard/Custom field-map merged onto a hardcoded `StandardRecordsHelper` graph |
| **[Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) (embeddable internal)** | Next.js/React embeddable iframe | .NET: `CrmMeetingService.CreateMeeting → CreateCompositeGraphStrategy` | Composite Graph (CRM-agnostic; Dynamics also supported) | Entity Definitions + Entity Patterns (Postgres) via *Admin → Entities* | `EntityPatternMapper` per use case + pattern parts/requirements/defaults |
| **[Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) (new portals & UWC)** | New portals + UWC drag-and-drop playbook editor | .NET Playbook engine: `MeetingCreatedEventConsumer → EntityPatternCreateBlockExecutor` → CRM-Integration | Composite Graph via `CreateEntityPatternInstanceAsync` | Playbook block graph (blocks + `InputRelations`) + Entity Pattern definitions | Visual block editor `InputRelations` (JMESPath/Liquid) + fork managed playbook |
| **[Backend core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/)** *(shared, context)* | All Architecture-B front-ends | Calendar publishes `CreateCrmMeetingEvent`; CRM-Integration + Playbook consumers branch on flags | Single sink: `SendGraphRequest → POST composite/graph` | Entity Patterns / CRM Mapping Config / Playbooks all feed one `SalesforceAdapter` | Route on `IsPortalMeeting` / `CreateUsingPlaybooks` |

---

## Feature matrix

*What each mechanism supports.*

| Mechanism | Customer flow | Employee flow | SObjects created | Leads only | Field customization | Multi-advisor | Status / vintage |
|---|---|---|---|---|---|---|---|
| **SF Package — Customer flow** | ✅ Experience Cloud LWC (`bookedByCustomer=true`) | — (shares the write path) | `AMB_Event_Detail__c`, `AMB_Meeting_Contact__c`, `Opportunity` (default), `Event`, `EventRelation`, `AMB_Address__c` | ❌ Opportunity+Event by default | CMDT field-map + Callables; `AMB_Event_Detail__c` map is hardcoded | Single advisor (`additionalAdvisors=[]`) | Current — AppExchange managed package |
| **SF Package — Employee flow** | Advisor can reserve as-customer | ✅ Advisor on a record page (`bookedByCustomer=false`) | Same set; or **reuse** an existing record | ❌ Any activity object/participant | Same CMDT + Callables; advisor UI flags | ✅ `additionalAdvisors` + explicit owner | Current — AppExchange managed package |
| **SF Package — Config / DI engine** | *(substrate for both flows)* | *(substrate for both flows)* | Config-selected activity + object/participant; **always** `AMB_Event_Detail__c` | ❌ Lead is one supported target | **This is the surface**: `Source → Target` mappings + Callable transforms | Config-driven advisor `EventRelation`s | Current — in-org Apex config layer |
| **CRM Configuration (legacy portals)** | ✅ Customer books on an old portal | ❌ No advisor booking UI | **`Lead` (always)**, `AMB_Event_Detail__c`, `Event`, `EventRelation` | ✅ **Yes** — attendee is always a placeholder `Lead`; `Event.WhoId` hardwired | Flat `CrmMappingConfiguration`; base records hardcoded | `EventRelation` per additional advisor | **Legacy** — superseded by Entity Patterns / Playbooks |
| **Entity Patterns (embeddable internal)** | ❌ Advisor-facing internal iframe | ✅ Advisor books internal meeting (references an Account) | `Event`, `EventDetail`, `EventRelation`; reads Account + User; **no Lead / no Opportunity** | ❌ No Lead; references existing Account | Entity Definitions + Patterns via *Admin → Entities* | ✅ `advisorEventRelations` part | Current — CRM-agnostic (SF + Dynamics) |
| **Playbooks (new portals & UWC)** | ✅ New portal / UWC (`CrmCreationStrategy=Playbook`) | ✅ UWC also serves employee contexts | **Pattern-defined** (managed pattern → `Event` + `AMB_Event_Detail__c` + `EventRelation`); **no Lead / no MeetingContact** | ❌ Pattern-defined | Playbook editor `InputRelations` + Entity Pattern mappings | Pattern-defined `EventRelation` part | **Newest** — visual engine over the Entity-Pattern write |

{: .note }
> ✅ / ❌ describe the **default** behaviour. Because the package config engine, Entity Patterns, and Playbooks are all customizable, a specific customer org may extend some of these.

---

## Where each field value comes from

Two records are written by **every** mechanism: the standard `Event` and a namespaced `AMB_Event_Detail__c`, whose `BookingFlowId__c` always equals the backend/Calendar meeting id. What differs is the additional objects and the **source** of each field value.

| Mechanism | Field-value source model |
|---|---|
| **SF Package** | Values originate in the `AMBBookMeetingDTO` the LWC builds. `AMB_Event_Detail__c` from a **hardcoded** map; `Event` / activity object from the config engine — each field is a **direct DTO copy** or a **customer `Callable` return**. Constants (e.g. `StageName='Open'`, `ShowAs='Busy'`) come from Callables with a blank source. |
| **CRM Configuration** | Values originate in `MeetingMappingDto`. The `Lead` is written with hardcoded placeholders; the field map then overrides/adds values by **C# property reflection** (`StandardFieldMapping`) or by **`CustomFields` key** (`CustomFieldMapping`). |
| **Entity Patterns & Playbooks** | Abstract field names resolve to real API names via each org's **Entity Definitions** (`MappedName`); a field absent or `ReadOnly` is **silently dropped**; defaults apply only when the DTO is empty. FKs are wired by pattern **requirement edges**, not literal values. In Playbooks, values are additionally shaped by editor **`InputRelations`** (JMESPath/Liquid) before reaching the same engine. |

---

## Corrected facts worth remembering

These are the places where the intuitive answer is wrong. Each was verified against the code.

{: .important }
> **No active record-type mechanism on the package default path.** The `Event.RecordTypeId` map is commented out and `AMB_Booking_Record_Type_Default__mdt` has no consumer. See [Salesforce Package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/#what-gets-created).

{: .important }
> **`getLocationPrettyPrint` is display-only.** It never changes the stored `Event.Location` / `AMB_Event_Detail__c.Location__c`; those take the raw `dto.location`. (`getMeetingTitle` **does** flow to `Event.Subject` / `Opportunity.Name`.)

{: .important }
> **The Playbook path creates no `Lead` and no `AMB_Meeting_Contact__c`.** The `Lead` graph is the legacy CRM-Configuration path; `AMB_Meeting_Contact__c` is written by separate post-creation attendee-sync code. See [Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/#what-gets-created--pattern-defined-not-hardcoded).

{: .important }
> **Only CRM Configuration is Leads-only.** It is Leads-only *structurally* — `Event.WhoId` is hardwired to a placeholder `Lead` and cannot be re-pointed by config.

---

## Related pages

- [Meeting Creation overview]({{ site.baseurl }}/bookme/meeting-creation/)
- [Salesforce Package (AppExchange)]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/)
- [Backend Meeting Core]({{ site.baseurl }}/bookme/meeting-creation/backend-core/)
- [CRM Configuration (Legacy Portals)]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/)
- [Entity Patterns (Internal Meetings)]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/)
- [Playbooks (New Portals & UWC)]({{ site.baseurl }}/bookme/meeting-creation/playbooks/)
