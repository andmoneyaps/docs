---
layout: "default"
title: "Employee guide – Advisor flow (Salesforce)"
parent: "English"
grand_parent: "Schedule"
nav_order: 301
lang: "en"
---
# Schedule – employee guide: Advisor flow
_How to book a customer meeting from Salesforce · v1.0 · 14.09.2026_

<!-- download: 📄 Download this guide: DOCX/PDF links go here once the files exist under files/business-implementation/schedule/en/ -->

## Purpose and value

With the advisor flow you book a customer meeting directly from the customer's page in Salesforce. You choose a theme, a location and a meeting type, and Schedule finds the available times. When you confirm, the meeting lands in your calendar and in Salesforce in one go.


## Before you start

- You are on a **customer** in Salesforce: an Account, Opportunity, Lead or Case. You cannot book from a Contact.
- You have access to **Meeting Booking** on the customer's page. If the button is missing, contact your super-user.

{: .note }
> **Note:** Your bank can rename buttons and fields. The names in this guide are the defaults.


## Overview

1. Open the customer → **Book meeting**.
2. Choose a **theme**.
3. Choose a **location**, an advisor and an **available time** → **Continue**.
4. Choose a **meeting type**, add participants and any addresses → **Book Meeting**.
5. See the **confirmation** → **Close Meeting Booking**.

At the top of the flow you see three steps: **Theme**, **Date and time** and **Confirmation**. The arrow in the top left takes you one step back.


## Step-by-step (Salesforce)


### Step 1 · Start the booking from the customer

- Open the customer in Salesforce and find the **Meeting Booking** area.
- Click **Book meeting**.

<!-- screenshot: the customer's page in Salesforce with the "Meeting Booking" area and the "Book Meeting" button -->


### Step 2 · Choose a theme

_The theme decides which advisors, meeting types and meeting lengths Schedule offers._

- Click the **theme** the meeting is about. If the theme has sub-themes, you also choose a **sub-theme**.

{: .note }
> **Note:** If a theme is missing from the list, it is not set up for booking at your organisation. Ask your super-user.


### Step 3 · Choose location, advisor and time

The screen is called **Customize which available times you see**.

- Under **Advisor Selection** you choose **Specific Employee**, **At Location** (everyone at the location) or **All Available**.
- Under **Select Location** the customer's own location is shown. If the meeting is held elsewhere, type part of the name and pick from the list.
- Under **Select Time Slot** you see the available times. Choose **Custom** if you want to enter the date and time yourself.
- Click the time you want to book. If you see no suitable time, click **Load More Times** or try **Filters**.
- Click **Continue**.

<!-- screenshot: the "Customize which available times you see" screen with "Advisor Selection", "Select Location" (showing a display name), "Select Time Slot" and the list of available times -->

{: .note }
> **Note:** Locations are shown with the name you use every day, e.g. “Branch Aarhus C”. Your super-user sets that name under **Meeting setup → Locations**. If no name is set, you see the internal name. Requires BookMe package 1.30.0 or later.


### Step 4 · Choose meeting type and fill in the meeting

The screen is called **Book the Meeting**. First check that **Location**, **Date**, **Time** and **Meeting Theme** at the top are correct. If you want a different time, click **Choose a Different Meeting**.

- Under **Choose Meeting Type** you choose in person, online, by phone or out of office.
- In-person meeting: choose a room under **Meeting Room**.
- Out of office: fill in **Start address** and **End address**. See Step 5.
- Give the meeting a **Meeting Title** if you like, and write a description of what the customer wants to talk about.
- Add the customer's participants with **Search in Customer Contacts** or **Add Customer Participant**.
- **Send meeting confirmation to customer participants** stores whether the customer should be notified. Your organisation's own Salesforce setup sends the notification itself.

<!-- screenshot: the "Book the Meeting" screen with "Choose Meeting Type", "Meeting Title", "Meeting Room", the description field, participants and the "Book Meeting" button -->

{: .note }
> **Note:** The **Book Meeting** button is greyed out until the meeting is complete: a meeting type, at least one participant and, for out-of-office meetings, an end address.


### Step 5 · Out-of-office meetings: start and end address

_Schedule uses the addresses to calculate travel time and reserve it in your calendar. The bank also uses the end address in its templates, so it is mandatory._

- **Start address** is filled in already if you have a fixed address on your profile.
- Under **End address** type where the meeting takes place. Type at least three characters and pick the address from the list.
- If you click a **street name** in the list, Schedule shows the addresses on that street.

Below the field you see whether it worked:

- **Address found** ✓: The address was picked from the list, and Schedule calculates travel time.
- **Address not found**: You typed a text without picking from the list. You can still book, but without travel time.
- **An error occurred. Address search is not available at the moment.**: The address service is not responding. Try again shortly, or book with the address as text.

<!-- screenshot: the "Start address" and "End address" fields with a suggestion list open under the end address and the text "Address found" under the start address -->

{: .important }
> **Remember:** **End address** must be filled in for out-of-office meetings. Otherwise **Book Meeting** is greyed out.

{: .note }
> **Note:** Search for the street address, e.g. “Vesterbrogade 3, 1630 København V”. Place names such as “Tivoli” no longer work.


### Step 6 · Book and confirm

_Schedule holds the chosen time for you for five minutes. If you do not click **Book Meeting** within that time, the slot becomes available again._

- Click **Book Meeting**.
- The **Confirmation** screen shows the date, time, location, meeting type, theme and advisors.
- Click **Close Meeting Booking**.

<!-- screenshot: the "Confirmation" screen with "Location" showing the display name, "Meeting type", "Meeting Theme" and "Advisors" -->

{: .hint }
> ✓ **How you know it worked:** The meeting is listed under **Meeting Booking** on the customer and in your calendar.


## Troubleshooting

- **Book Meeting** is greyed out: Check meeting type, participant and end address. Right after you pick an address, Schedule fetches its position; wait a second.
- **Address not found**: Type part of the address again and click the right suggestion.
- The address list is empty: Type at least three characters, and search for the street address, not a place name.
- No available times: Try **All Available** under **Advisor Selection**, remove filters, or click **Load More Times**.
- The location shows an internal name: Your super-user has not set a display name yet.
- I cannot find the location: If it is not in the list, it is not set up in Schedule. Ask your super-user.


### See also
- [Address Lookup for Offsite Meetings]({{ site.baseurl }}/bookme/address-lookup/) — technical description of the address search.
- **Schedule – super-user guide: Meeting setup** — locations, display names and meeting types.


## Latest update

- 14.09.2026 (v1.0) — First version (booking from Salesforce, location display name, address search and the mandatory end address).


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 14.09.2026_
