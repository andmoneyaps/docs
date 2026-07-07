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
> **This is the oldest platform-hosted approach and is being superseded** by [Entity Patterns]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) and [Playbooks]({{ site.baseurl }}/bookme/meeting-creation/playbooks/). It applies only to portals that are **not** using the Playbook strategy. New portals should use the Playbook approach.

---

## When it applies

CRM Configuration is used when a **legacy portal** books a meeting and the portal is not configured to use playbooks. The meeting is created by the &money platform using a fixed set of records, and your **CRM Configuration** field map fills in the values. See [Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/) for the shared behaviour.

---

## What gets created — a fixed Lead-based set

This approach always creates the same set of records:

| Record | Details |
|---|---|
| `Lead` | **Always created first**, as the meeting's attendee. Uses placeholder values (e.g. a placeholder last name and company) unless your field map overrides them; the meeting owner is set when the advisor's email resolves. |
| `Event` | The meeting, with the newly-created `Lead` as its attendee (`WhoId`). |
| BookMe meeting detail (`AMB_Event_Detail__c`) | Holds the BookMe information; the theme is translated to your CRM's meeting-taxonomy value. |
| `EventRelation` | One per **additional advisor** (invitee, not the owner). |

---

## Why it is Leads-only

{: .important }
> The attendee is **always a newly-created placeholder `Lead`**, and the `Event` is hardwired to point at that `Lead`. This is not a setting — it's built into this approach.

As a result:

- No `Contact` or Person Account is created, and there is **no matching against an existing person**.
- The account the booking came from is **ignored** on this path.
- **External attendees are not written** as separate contact records.
- A field map that targeted a different object would create it as a **stray extra record** — it could never become the meeting's attendee.

If you need meetings on Contacts, Accounts, or existing records, use the [Entity Pattern]({{ site.baseurl }}/bookme/meeting-creation/entity-patterns/) or [Playbook]({{ site.baseurl }}/bookme/meeting-creation/playbooks/) approaches instead.

---

## How you configure field values

A **CRM Configuration** is a field map bound to a portal. It can **override or add field values** on the records above — but it cannot remove a record or change which object is the attendee.

It has two kinds of mapping:

| Mapping | What it does |
|---|---|
| **Standard field mapping** | Maps a **source value from the meeting** (for example, the advisor's email) to a **target Salesforce field** (for example, `Event.Description`). |
| **Custom field mapping** | Writes a **custom value** you provide into a target Salesforce field. |

### Where it is authored

CRM Configurations are created in the **Management UI**, under **BookMe → Portals → Configurations**, and bound to a portal there. The dropdowns are populated from the available meeting fields (as source options) and from your CRM's objects and fields (as target options). Each portal has at most one configuration.

{: .note }
> The configuration is **optional and resilient.** If a portal has no configuration, the meeting is still created with the standard records — the field map simply contributes nothing.

---

## What you control here

| Option | Effect |
|---|---|
| Standard / custom field mappings | Which meeting values are written to which `Lead` / `Event` / meeting-detail fields |
| Portal strategy | Switch a portal to **Playbook** to move it off this approach entirely |
| Theme → taxonomy mapping | Translates the booking theme to your CRM's meeting-taxonomy value |

---

## Related pages

- [Portals]({{ site.baseurl }}/bookme/portals/)
- [Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/)
- [Technology & Feature Matrix]({{ site.baseurl }}/bookme/meeting-creation/technology-and-feature-matrix/)
