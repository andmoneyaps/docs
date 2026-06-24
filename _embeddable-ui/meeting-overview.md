---
layout: default
title: Meeting Overview
parent: Embeddable UI
nav_order: 3
---

# Meeting Overview

The meeting overview is the landing page component shown when the BookMe embeddable loads on a Salesforce record page. It displays the employee's upcoming and past meetings for the current Account, and provides entry points for booking new meetings.

---

## Landing Page Buttons

When the employee is authenticated, the landing page shows two action buttons:

| Button | Action |
|--------|--------|
| **Internal Meeting** | Opens the internal meeting booking form |
| **Book Meeting** | Switches to the Salesforce LWC customer booking flow |

### Button states

| Behavior | Condition | What the employee sees |
|----------|-----------|----------------------|
| Both buttons shown | Employee is authenticated via Entra ID | Both buttons visible |
| Not signed in | Employee not authenticated | Welcome message with "not signed in" text; no buttons or meeting list |
| "Book Meeting" disabled | Component placed on an unsupported sObject type | Button is grayed out. Supported types: Account, Event, Opportunity |
| Auto-redirect | `disableCustomerMeetings` set to `true` in [configOverride]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) | Landing page is skipped; employee is redirected to the LWC booking flow |
| Error banner | Account resolution fails | Sticky error banner at top of page with error code. Buttons remain visible below the banner. |

---

## Meeting List

Below the action buttons, the meeting overview displays meetings associated with the current Account. Meetings are split into two groups:

### Upcoming meetings

Meetings with a start date in the future are shown as timeline cards.

Each card displays:
- Meeting title, date, and time
- Meeting type
- Additional employees (if any)

| Behavior | Condition | What the employee sees |
|----------|-----------|----------------------|
| Internal meeting icon | Meeting was booked as an internal meeting | Work icon with brand color |
| Customer meeting icon | Meeting was booked as a customer meeting | Groups icon with Salesforce color |
| "Start" button | Meeting is upcoming **and** has a Teams meeting link | Button to join the Teams meeting |
| "Start" button hidden | Meeting is in the past, or no Teams link configured | No start button on the card |
| Edit / Cancel menu | Meeting is upcoming | Context menu with Edit and Cancel options |

### Historic meetings

Meetings with a start date in the past are collapsed by default.

| Behavior | Condition | What the employee sees |
|----------|-----------|----------------------|
| Toggle shown | Past meetings exist for this Account | Expandable "Historic meetings" section below upcoming meetings |
| Toggle hidden | No past meetings | Section not shown |
| Edit / Cancel menu hidden | Always for historic meetings | No context menu — past meetings cannot be modified |

### Empty state

When no meetings exist for the current Account, the meeting overview shows an empty state illustration with a message indicating there are no planned meetings.

---

## Related Documentation

- [Internal Meetings Deployment Guide]({{ site.baseurl }}/bookme/internal-meetings-deployment-guide/) — configuration guide for the internal meeting flow
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) — configOverride property reference
- [Setup in Salesforce]({{ site.baseurl }}/embeddable-ui/setup-in-salesforce/) — placing the component on record pages
