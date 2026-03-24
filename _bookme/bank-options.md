---
layout: default
title: Bank Options
nav_order: 7
parent: BookMe
---

# Bank Options

Bank Options define the organization-wide defaults for meeting booking. They are configured in the Management UI under **BookMe → Settings → Bank Options**.

---

## General Settings

| Setting | Description |
|---------|-------------|
| **openingTime** | Business hours start. Defines the earliest time employees and customers can select when booking meetings. |
| **closingTime** | Business hours end. Defines the latest selectable time. |
| **timeZoneId** | Organization timezone. All meeting times are displayed and stored relative to this timezone. |

---

## Meeting Settings

| Setting | Description |
|---------|-------------|
| **meetingTypeLabels** | Custom labels for meeting types (Physical, Online, Telephone, OffSite). These labels are shown in the meeting type selector during booking. If not configured, the meeting type selection will be empty. |
| **maxMeetingTimePerDay** | The maximum total meeting time an employee can have booked per day. When this limit is reached, the employee is excluded from available timeslot searches for that day. Note: this limit is not enforced for [internal meetings]({{ site.baseurl }}/bookme/internal-meetings-deployment-guide/). |
| **maxTimeFromBookingToMeeting** | The maximum number of days into the future that meetings can be booked. |

---

## Calendar Settings

| Setting | Description |
|---------|-------------|
| **closingDays** | Bank holidays and other closed dates. Meetings cannot be booked on these days. |
| **iCalMeetingTitle** | Custom format for calendar invite titles sent to participants. |
| **iCalMeetingDescription** | Custom format for calendar invite descriptions. |

---

## Customer-Facing Settings

| Setting | Description |
|---------|-------------|
| **isFilterShowTimesAsCustomerEnabled** | When enabled, employees can toggle a filter to view available times from the customer's perspective. |
| **extendedOpeningHoursEmail** | Contact email shown to customers when no times are available within normal hours. |
| **advisorLabels** | Custom labels for employee selection options in the booking UI (e.g., "My advisor", "Other advisors"). |

---

## Default Behavior

Bank Options are automatically created with default values when a new bank is provisioned. Updates are applied via the Management UI. All settings take effect immediately — no restart or redeployment is required.

---

## Related Documentation

- [Employee Schedules]({{ site.baseurl }}/bookme/employee-schedules/) — per-employee availability overrides
- [Service & Competence Groups]({{ site.baseurl }}/bookme/service-competence-groups/) — service group overrides for daily meeting limits
- [Timezone Configuration]({{ site.baseurl }}/bookme/timezone-configuration/) — timezone handling details
