---
layout: default
title: Add to Calendar (iCal)
nav_order: 8.5
parent: BookMe
---

# Add to Calendar (iCal)
{: .no_toc }

After booking a meeting on a Schedule **portal**, the customer can download the appointment as a calendar file (`.ics`) and add it to their own calendar. This is the only customer-facing "add to calendar" option: Schedule does **not** email a meeting invitation. For how the advisor's calendar and meeting rooms are handled, see [Meeting Creation → Platform-Hosted Booking]({{ site.baseurl }}/bookme/meeting-creation/platform-booking/#calendars-rooms-and-notifications).

---

## What the customer sees

When iCal is enabled for a portal, the portal's **confirmation screen** shows a **"Download calendar invitation"** button. Clicking it downloads a `meeting.ics` file the customer can open in Outlook, Google Calendar, or Apple Calendar.

The file is a **plain calendar entry** (subject, description, location, and start/end time) with **no organiser and no attendees**. Importing it simply adds the appointment to the customer's own calendar; it does not notify the advisor or anyone else, and nothing is sent by email. Times are stored in UTC and shown in the customer's local calendar.

{: .note }
> This download appears on **portals** only, and only when the host has enabled iCal for that portal. The embeddable internal-meeting widget does not offer it.

---

## Enabling and configuring it

| What you configure | Where |
|---|---|
| Turn the download on for a portal | The portal's settings (iCal enabled) |
| Default **title** and **description** of the `.ics` | Organization settings: `iCalMeetingTitle` / `iCalMeetingDescription` |

The customer is never asked for a title or description; the file uses the bank-configured defaults. Those fields are localizable (see [Multilingual Support]({{ site.baseurl }}/api/multilingual/)).

---

## Generating an iCal from an integration

If you need to produce the same `.ics` from your own integration rather than the portal UI, use the **Public API** (see [Schedule (BookMe) API → Generate iCal]({{ site.baseurl }}/api/bookme/#generate-ical-v2-only)). The endpoint reference (route, request, response) lives with the rest of the API there; this product page intentionally does not restate it.
