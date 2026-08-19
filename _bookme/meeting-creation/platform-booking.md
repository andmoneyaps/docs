---
layout: default
title: Platform-Hosted Booking
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 5
---

# Platform-Hosted Booking
{: .no_toc }

The embeddable internal-meeting widget and the portals all book through the **&money platform**, which then creates the meeting in your CRM. This page describes the behaviour those implementations **share**: the records they create and the rules around updating them. They differ only in how you configure the field values: the [Internal Meetings]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) and [Playbook Portals]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) paths, and the [CRM Configuration Portals]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path.

{: .note }
> The [Salesforce package]({{ site.baseurl }}/bookme/meeting-creation/salesforce-package/) is the one implementation that does **not** work this way: it creates records in your org directly, not through the platform.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

---

## The platform creates the records for you

With these implementations, booking happens **in the &money platform** rather than inside your CRM. When a meeting is booked, the platform records it and then creates the corresponding records in your CRM, whether that CRM is **Salesforce or Dynamics 365**.

Because the write is done by the platform on your behalf, you don't install anything in your org for these paths; you configure them through the &money **Management UI** and **Admin → Entities**.

---

## The records every platform-hosted meeting creates

| Record | Created |
|---|---|
| `Event` | Every meeting |
| Schedule meeting detail (`AMB_Event_Detail__c`) | Every meeting: holds all Schedule information; its `BookingFlowId__c` carries the booking id used for later lookups |
| `EventRelation` | One per **additional advisor** whose email resolves to a user (not the meeting owner) |
| `Lead` | **CRM Configuration path only** (see below) |
| Account / owner / advisors | **Referenced, not created**: existing records are linked to the meeting |

{: .important }
> A **`Lead` is created only on the [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) path.** The [Entity Pattern]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) and [Playbook]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) paths do **not** create a `Lead`; they link the meeting to an **existing Account**.

---

## Calendars, rooms, and notifications

Booking a meeting reserves the **advisor's** time: &money creates a **Microsoft 365 calendar appointment** in the meeting owner's calendar. Any additional advisors are added as attendees, and, when the timeslot has a meeting room assigned (governed by your [location configuration]({{ site.baseurl }}/bookme/available-timeslots-guide/)), the room's Microsoft 365 room mailbox is added to the same appointment as a **resource**, so Exchange reserves the room. The **customer is not added** to this appointment and receives no invitation from it.

The meeting detail record also carries a `SendMeetingInvite__c` flag, set to `true` by default. This is a **passive marker**: it records that participants *should* be notified, but &money sends nothing based on it. Use it to drive your own downstream automation (for example, a Salesforce Marketing Cloud journey) if you want the customer to receive a notification.

The one customer-facing calendar affordance is an optional **iCal download**, a "Download calendar invitation" button shown on the **portal** confirmation screen when iCal is enabled for that portal. It produces a plain `.ics` file (a calendar entry with no organiser or attendees) that the customer imports themselves; nothing is emailed.

---

## Updating, rescheduling and cancelling

A few behaviours are important to know when planning your process:

- **Only additional-advisor relations are reconciled** on reschedule. Relations to an Account, Contact, or Lead are deliberately **left in place** and never removed automatically.
- **Cancelling a meeting does not remove additional-advisor relations**: this is a known limitation.
- **Portal meetings currently cannot be edited** after creation; only internal meetings can be updated.
- Attendee-status synchronisation (keeping attendee responses in step) runs **after** the meeting exists and is controlled by a per-bank setting. It updates an existing meeting; it does not create one.

---

## How the three approaches relate

All platform-hosted implementations produce the same core records; they only differ in **how you shape the field values**:

```mermaid
graph TD
    EMB["Internal meetings<br/><small>current</small>"] --> C2["Entity Patterns<br/><small>CRM-agnostic mapping</small>"]
    NP["Playbook portals<br/><small>current</small>"] --> C3["Playbooks<br/><small>visual automation over Entity Patterns</small>"]
    OP["CRM Configuration portals<br/><small>stable</small>"] --> C1["CRM Configuration<br/><small>simple field map</small>"]
    C1 --> REC["Meeting records created in your CRM"]
    C2 --> REC
    C3 --> REC
```

{: .note }
> **Entity Patterns are the shared foundation** for internal meetings and for playbooks. A playbook ultimately writes through the same Entity-Pattern mapping: the playbook just adds a visual, configurable layer on top.

---

## Related pages

- [Internal Meetings (Embeddable)]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) (current)
- [Playbook Portals]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) (current)
- [CRM Configuration Portals]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) (stable)
- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) (the abstraction model)
