---
layout: default
title: Confirmation Screen
parent: Embeddable UI
nav_order: 3
---

# Confirmation Screen

The confirmation screen displays all meetings booked during the current session. After booking a meeting, users are automatically redirected here to see their newly created appointment.

## How It Works

1. User books a meeting (either a customer meeting or internal case processing meeting)
2. User is redirected to the confirmation screen
3. The new meeting appears in the list
4. User can book additional meetings or return to the meeting overview

Users can continue booking multiple meetings in sequence. Each new meeting is added to the confirmation screen list.

## Events

The confirmation screen emits events that your Salesforce implementation can listen for.

### meetingclicked

When a user clicks on a meeting card, this event is emitted with the Salesforce Event ID.

| Property | Value |
| -------- | ----- |
| Event name | `meetingclicked` |
| Data | Salesforce Event ID (string) |

Use this event to open the meeting record in Salesforce or trigger custom workflows.

### close

When the user clicks "Meeting Overview" to return to the main list, this event is emitted.

| Property | Value |
| -------- | ----- |
| Event name | `close` |
| Data | `null` |

Use this event to return to the parent view (if needed). The session data is being cleared.

## Available Actions

From the confirmation screen, users can:

- Click a meeting card to trigger the `meetingclicked` event
- Book a customer meeting
- Create a calendar reservation (internal meeting)
- Return to the meeting overview

## Meeting Types

The confirmation screen displays both:

- **Customer meetings** – Scheduled through the BookMe booking system
- **Internal meetings** – Case processing appointments and calendar reservations

Each type is visually distinguished with a different icon.
