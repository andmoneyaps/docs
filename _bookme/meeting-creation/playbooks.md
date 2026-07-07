---
layout: default
title: Playbook Portals
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 2
---

# Playbook Portals
{: .no_toc }

{: .note }
> **Current implementation.** This is the recommended approach for customer self-service booking on a portal.

**Portals** create meetings through **Playbooks** — a visual, forkable automation that writes through the same [entity-pattern mapping]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) used by internal meetings.

<details open markdown="block">
  <summary>On this page</summary>
  {: .text-delta }
- TOC
{:toc}
</details>

{: .note }
> This page focuses on **how a meeting is created** by a playbook. For authoring playbooks, blocks, and the visual editor, see the [Playbooks]({{ site.baseurl }}/bookme/playbooks/) subsection.

---

## When it applies

The playbook approach runs for **portal bookings** whose portal uses the **Playbook** strategy. Otherwise the legacy [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) approach handles the booking.

When a meeting is booked on a playbook-enabled portal, the portal's playbook runs and its **create-meeting block** writes the records to your CRM — through the same entity-pattern mapping described in [Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/).

---

## What gets created — defined by your pattern

{: .important }
> The objects and fields are **not fixed by the playbook** — they are defined by the **entity pattern** the create-meeting block references, plus whatever field mappings you add in the editor. A different pattern creates a different set.

For the **standard BookMe meeting pattern**, the records and fields are the same as for internal meetings — an `Event`, the BookMe meeting detail record (with `BookingFlowId__c`), and advisor relations. See the [Entity Patterns field tables]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/#fields-written) for the exact fields; the same "silently skipped if your definition doesn't declare it" rule applies.

On top of the pattern, the create-meeting block lets you **map additional values** — including a portal's own custom fields — onto any field the pattern exposes.

{: .warning }
> **This approach creates no `Lead` and no meeting-contact record.** The `Lead`-based set belongs to the legacy [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) approach, and meeting-contact records are written by separate attendee-sync behaviour ([see Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/#updating-rescheduling-and-cancelling)) — not by the playbook.

{: .note }
> The precise CRM field names depend on **your** entity definitions and the mappings you configure, so exact field values are org-specific rather than fixed by BookMe.

---

## How you configure field values

Two layers work together:

### 1. The playbook editor

In the visual editor, the **create-meeting block** maps a **source value → a destination field**, with optional transformations, so you decide which fields are written and from what value. **Template blocks** let you format text (for example, a description) to feed into those fields. The editor validates your field mappings against the pattern before anything is written.

{: .note }
> The editor supports a **dry-run mode** that runs the full mapping and shows you the resulting values **without** writing to your CRM — the way to verify your mappings before going live.

### 2. The entity pattern

Beneath the editor, the [entity pattern]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) determines which objects/parts exist and how abstract field names map to your CRM's real fields. Playbooks and internal meetings **share this mapping**.

### Turning it on and making it your own

| Option | Effect |
|---|---|
| Portal **Playbook** strategy | Whether the playbook approach runs for a portal at all |
| Portal scoping | Which portals activate the playbook; a portal's custom fields become available in the editor |
| Create-meeting block mappings | Which fields are written and their values |
| Entity pattern | Which objects are created and how fields map to your CRM |
| **Fork a managed playbook** | Create an editable copy so you can change any of the above |

{: .note }
> A &money-managed playbook can be **forked** into an editable copy that belongs to you. Choosing the Playbook strategy gives you more flexibility than CRM Configuration — playbooks can also run AI processing, read additional CRM data, and apply business logic when a meeting is booked.

---

## Where it runs

Portals that use the **Playbook** strategy — customer self-service bookings. The playbook is authored in the visual editor and creates the meeting through the playbook → entity-pattern path.

---

## Related pages

- [Playbooks (authoring)]({{ site.baseurl }}/bookme/playbooks/)
- [Internal Meetings (Embeddable)]({{ site.baseurl }}/bookme/meeting-creation/internal-meetings/) — the shared mapping
- [Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/)
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
