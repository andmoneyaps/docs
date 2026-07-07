---
layout: default
title: Playbooks (New Portals & UWC)
parent: Meeting Creation in Salesforce
grand_parent: BookMe
nav_order: 5
---

# Playbooks (New Portals & UWC)
{: .no_toc }

The newest approach. New **Portals** and the **Universal Web Client (UWC)** create meetings through **Playbooks** — a visual, forkable automation that writes through the same [Entity-Pattern mapping]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) used by internal meetings.

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

When a meeting is booked on a playbook-enabled portal, the portal's playbook runs and its **create-meeting block** writes the records to your CRM — through the same entity-pattern mapping described in [Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/).

---

## What gets created — defined by your pattern

{: .important }
> The objects and fields are **not fixed by the playbook** — they are defined by the **entity pattern** the create-meeting block references. For the standard BookMe meeting pattern, that is an `Event`, the BookMe meeting detail record, and advisor relations. A different pattern would create a different set.

{: .warning }
> **This approach creates no `Lead` and no meeting-contact record.** The `Lead`-based set belongs to the legacy [CRM Configuration]({{ site.baseurl }}/bookme/meeting-creation/crm-configuration/) approach, and meeting-contact records are written by separate attendee-sync behaviour ([see Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/#updating-rescheduling-and-cancelling)) — not by the playbook.

---

## How you configure field values

Two layers work together:

### 1. The playbook editor

In the visual editor, the **create-meeting block** maps a **source value → a destination field**, with optional transformations, so you decide which fields are written and from what value. **Template blocks** let you format text (for example, a description) to feed into those fields. The editor validates your field mappings against the pattern before anything is written.

{: .note }
> The editor supports a **dry-run mode** that runs the full mapping and shows you the resulting values **without** writing to your CRM — the way to verify your mappings before going live.

### 2. The entity pattern

Beneath the editor, the [entity pattern]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) determines which objects/parts exist and how abstract field names map to your CRM's real fields. Playbooks and internal meetings **share this mapping**.

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

- **New Portals** — customer self-service bookings.
- **The Universal Web Client (UWC)** — the visual playbook editor and employee contexts.

Both create the meeting through the same playbook → entity-pattern path.

---

## Related pages

- [Playbooks (authoring)]({{ site.baseurl }}/bookme/playbooks/)
- [Entity Patterns (Internal Meetings)]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) — the shared mapping
- [Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/)
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
