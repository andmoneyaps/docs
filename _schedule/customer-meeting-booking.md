---
layout: default
title: Customer Meeting Booking
nav_order: 12
parent: Schedule
collection: schedule
redirect_from:
  - /bookme/customer-meeting-booking/
---

# Customer Meeting Booking
{: .no_toc }

How a customer books a meeting on a Schedule portal: they choose what the meeting is about, find a time, briefly hold a slot, and confirm it. This page describes that flow as a **feature**. For the API that drives it (endpoints, parameters, request/response shapes, authentication, and error codes), see the [Schedule (Schedule) Public API]({{ site.baseurl }}/api/schedule/).

![Customer Meeting Booking Sequence Diagram]({{ site.baseurl }}/assets/images/schedule_customer_meeting_sequence_diagram.png)

---

## The booking flow

1. **Choose what the meeting is about.** The customer picks a meeting theme (and, where relevant, their customer type). These determine which advisors, rooms, and meeting types apply: the options come from your organization's configuration.
2. **Find a time.** Schedule searches for available slots that satisfy the chosen theme, meeting type, location, and advisor/room requirements, and returns the open times.
3. **Hold the slot.** The customer reserves a slot to hold it while they finish. **A reservation expires after exactly 5 minutes** if the meeting isn't confirmed, after which the slot is released for others.
4. **Confirm the meeting.** Confirming within the hold window creates the meeting and its CRM records (see [Meeting Creation]({{ site.baseurl }}/schedule/meeting-creation/)).
5. **Add to calendar (optional).** On portals with iCal enabled, the customer can download the meeting as a calendar file (see [Add to Calendar (iCal)]({{ site.baseurl }}/schedule/ical-generation/)).

---

## Key rule: the 5-minute hold

Reserving a slot is a **temporary hold**, not the booking itself. It gives the customer a short, exclusive window to complete the booking without the slot being taken by someone else. If they don't confirm within **5 minutes**, the hold is released automatically and they'll need to choose a slot again.

---

## Booking via the Public API

The whole flow above is available through the Public API, for integrators who build their own booking front end. The endpoints (fetch configuration, search availability, reserve a slot, create a meeting, generate an iCal), their parameters, request/response bodies, authentication, and error codes are documented in the **[Schedule (Schedule) Public API]({{ site.baseurl }}/api/schedule/)**, along with a shared Postman collection.

{: .note }
> This page describes the *feature*; the [Public API reference]({{ site.baseurl }}/api/schedule/) is the source of truth for endpoints and payloads. Where the two disagree, the API reference wins.
