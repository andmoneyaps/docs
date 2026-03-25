---
layout: default
title: Employee Schedules
nav_order: 8.5
parent: BookMe
---

# Employee Schedules

Employee schedules control when each employee is available for meeting bookings. Schedules are managed in the Management UI under **BookMe → Advisors → Manage Availability**.

---

## Prerequisites

- Employees must be provisioned via [SCIM]({{ site.baseurl }}/bookme/scim-provisioning-setup/) before they appear in the Manage Availability page
- [Locations]({{ site.baseurl }}/bookme/implementation-guide/phase3-adaptation/#location-matching-between-entra-and-salesforce) must be configured before assigning per-weekday locations

---

## Schedule Settings

Each employee has the following top-level settings:

| Setting | Description |
|---------|-------------|
| **CanBeBooked** | Must be `true` for the employee to appear in available timeslot searches. If `false`, the employee is excluded from all booking flows. |
| **IsOnlyExplicitlyAvailable** | When `true`, the employee only appears when explicitly selected by name — they won't show up in "local" or "all employees" searches. |
| **MaxMeetingTimePerDay** | Optional override for the bank-wide `MaxMeetingTimePerDay` setting. When set, this limit applies instead of the bank default. Note: this limit is not enforced for [internal meetings]({{ site.baseurl }}/bookme/internal-meetings-deployment-guide/). |

---

## Workday Configuration

Each weekday (Monday–Sunday) is configured independently:

| Setting | Description |
|---------|-------------|
| **IsAvailable** | Whether the employee is available for bookings on this day. |
| **From / To** | The time window during which the employee can be booked. Times outside this window are not offered. |
| **AvailableMeetingTypes** | Which meeting types (Physical, Online, Telephone, OffSite) are available on this day. Only the selected types are offered to customers and employees. |
| **Location** | The employee's location for this day. This determines which customers and rooms the employee is matched with — the location string must exactly match the [location configuration]({{ site.baseurl }}/bookme/implementation-guide/phase3-adaptation/#location-matching-between-entra-and-salesforce) in the Management UI and SCIM. |

{: .hint }
> An employee can have different locations on different weekdays — for example, working from the Copenhagen office on Monday–Wednesday and the Aarhus office on Thursday–Friday.

---

## Manage Availability Page

The **Manage Availability** page provides an overview of all employees and their schedule status.

- **Red crosses** indicate configuration problems that must be resolved before the employee can be booked. Common issues include missing workday configurations, no available meeting types, or location mismatches.
- Always check this page after initial setup or after changes to SCIM provisioning.

---

## How Schedules Affect Availability

When the system searches for available timeslots:

1. Employees without `CanBeBooked = true` are excluded
2. The requested day's workday configuration is checked — if `IsAvailable` is `false`, the employee is skipped
3. Only meeting types listed in `AvailableMeetingTypes` for that day are offered
4. The employee's location for that day must match the booking context (customer location for customer bookings, or selected location for internal meetings)
5. The `From` / `To` time window is intersected with existing calendar events to determine free slots
6. If `MaxMeetingTimePerDay` is set and the employee has reached their daily limit, they are excluded (does not apply to internal meetings)

---

## Interaction with Service Groups

Service groups can override the `MaxMeetingTimePerDay` setting for their members. If an employee belongs to multiple service groups, the **highest** (most permissive) limit applies. Individual employee overrides take precedence over service group limits.

For details, see [Service & Competence Groups — Daily Meeting Time Limits]({{ site.baseurl }}/bookme/service-competence-groups/#daily-meeting-time-limits).

---

## Related Documentation

- [SCIM Provisioning Setup]({{ site.baseurl }}/bookme/scim-provisioning-setup/) — how employees are synced from Entra ID
- [Service & Competence Groups]({{ site.baseurl }}/bookme/service-competence-groups/) — grouping employees and configuring service levels
- [Internal Meetings Deployment Guide]({{ site.baseurl }}/bookme/internal-meetings-deployment-guide/) — schedule requirements specific to internal meetings
- [Location Matching]({{ site.baseurl }}/bookme/implementation-guide/phase3-adaptation/#location-matching-between-entra-and-salesforce) — how location strings are matched
