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

With the advisor flow you book a customer meeting directly from the customer's page in Salesforce. You choose the theme, location and meeting type, and Schedule finds the available times for you. When you confirm, Schedule puts the meeting in your calendar and creates it in Salesforce. That saves you from checking calendars and entering the meeting in two places.

### Glossary
- **Advisor flow**: The booking component on the customer's page in Salesforce, where you as an employee book a meeting for or with a customer.
- **Theme and sub-theme**: What the meeting is about (e.g. “Housing” → “Buying a home”). The theme controls which advisors, meeting types and durations are offered.
- **Location**: The branch or centre where the meeting takes place. The location decides which advisors and rooms are in play.
- **Display name**: The name of a location that your super-user has chosen in Schedule. If no display name is set, you see the internal name from your user directory.
- **Meeting type**: How the meeting is held: in person, online, by phone or out of office. Your bank decides what the meeting types are called.
- **Out of office**: A meeting where you drive to the customer. Here you enter a start address and an end address, so Schedule can reserve travel time in your calendar.
- **Adressevælgeren**: The national Danish address service that suggests addresses as you type.


## Audience and prerequisites

- Audience: an advisor or other employee who books customer meetings from Salesforce.
- You have **access to meeting booking** in Salesforce. If the button is missing, contact your super-user.
- You are on a **customer** in Salesforce, i.e. an Account, Opportunity, Lead or Case. You cannot book from a Contact.
- Your browser can reach the address service, if you book out-of-office meetings. This is normally already in place at your organisation.

{: .note }
> **Note:** Buttons and fields may have slightly different names at your organisation. Your bank can rename the texts in the package. The names in this guide are the default names.


## What you get out of it

After this guide you can:

- Start a booking from the customer's page and choose a theme.
- Choose the right location by the name you use every day.
- Find an available time for one advisor, for a location or for everyone.
- Choose a meeting type and fill in the meeting.
- Book an out-of-office meeting with a correct end address.
- Understand what Schedule tells you along the way, and what to do if something goes wrong.


## Overview

- Open the customer → **Book meeting**.
- Choose a **theme** (and a sub-theme, if any).
- Choose a **location**, who holds the meeting, and an **available time** → **Continue**.
- Choose a **meeting type**, add participants and any addresses → **Book Meeting**.
- See the **confirmation** → **Close Meeting Booking**.

At the top of the flow you see three steps: **Theme**, **Date and Time** and **Confirmation**. You can always go one step back with the arrow in the top left.


## Step-by-step (Salesforce)


### Step 1 · Start the booking from the customer

_Why: The meeting must belong to the right customer, so it lands in the right place in Salesforce._

- Open the customer in Salesforce.
- Find the **Meeting Booking** area. Here you see the customer's upcoming meetings.
- Click **Book meeting**.

<!-- screenshot: the customer's page in Salesforce with the "Meeting Booking" area and the "Book Meeting" button -->

{: .hint }
> ✓ **How you know it worked:** You see the **Choose Theme** screen.


### Step 2 · Choose a theme

_Why: The theme decides which advisors, meeting types and meeting lengths Schedule offers._

- Click the **theme** the meeting is about.
- If the theme has sub-themes, you see the **Choose subtheme** screen. Click the sub-theme that fits best.

{: .note }
> **Note:** If you don't see the theme you are looking for, it is not set up for booking at your organisation. Ask your super-user.


### Step 3 · Choose location, advisor and time

_Why: Here you tell Schedule where and with whom the meeting is held. Then Schedule shows only the times that are actually available._

The screen is called **Customize which available times you see**.

- Under **Advisor Selection** you choose who holds the meeting:
  - **Specific Employee**: You search for a particular advisor.
  - **At Location**: All advisors at the chosen location.
  - **All Available**: All advisors who can take the meeting.
- Under **Select Location** the customer's own location is shown by default. If the meeting is held elsewhere, type part of the name and pick the location from the list.
- Under **Meeting Room** you can choose a room, if your setup requires it.
- Under **Select Time Slot** you choose **Select Available Time** to see available times, or **Custom** to enter the date, start time and duration yourself.
- Use **Filters** to narrow the times, e.g. **Show only times with available meeting rooms** or **Show timeslots as seen by the customer**.
- Click the time you want to book. If you don't see a suitable time, click **Load More Times**.
- Click **Continue**.

<!-- screenshot: the "Customize which available times you see" screen with "Advisor Selection", "Select Location" (showing a display name), "Select Time Slot" and the list of available times -->

{: .hint }
> ✓ **How you know it worked:** You see the **Book the Meeting** screen with **Location**, **Date**, **Time** and **Meeting Theme** filled in at the top.

{: .note }
> **Note:** The location is shown with the name you use every day, not the internal name. Read more under **The location's name** below.


### Step 4 · Choose meeting type and fill in the meeting

_Why: The meeting type decides whether Schedule finds a room, sends an online link or reserves travel time._

The screen is called **Book the Meeting**.

- Under **Choose Meeting Type** you choose how the meeting is held: in person, online, by phone or out of office.
- For an in-person meeting you choose a room under **Meeting Room**. If it says **No rooms available**, all rooms are taken at that time.
- For an out-of-office meeting you fill in **Start address** and **End address**. See Step 5.
- Give the meeting a **Meeting Title** if you like.
- Write a **description** of what the customer wants to talk about. The text goes into the meeting.
- Add the customer's participants with **Search in Customer Contacts** or **Add Customer Participant**. Under **Bank's Participants** you see the advisors who take part.
- Leave **Send meeting confirmation to customer participants** ticked if the customer should be notified. Schedule only stores your choice on the meeting. Your organisation's own Salesforce setup sends the notification based on that field.

<!-- screenshot: the "Book the Meeting" screen with "Choose Meeting Type", "Meeting Title", "Meeting Room", the description field, participants and the "Book Meeting" button -->

{: .note }
> **Note:** The **Book Meeting** button is greyed out until the meeting is complete. That is typically because a meeting type, a participant or an end address for an out-of-office meeting is missing.


### Step 5 · Out-of-office meetings: start and end address

_Why: Schedule uses the addresses to calculate travel time and reserve it in your calendar. The bank also uses the end address in its templates, so it is mandatory._

- Under **Start address** your fixed start address is shown, if it is set up on your profile. Otherwise type where you drive from.
- Under **End address** type where the meeting takes place, typically the customer's address.
- Type at least three characters, e.g. “Vesterbrog”. The suggestions appear after a brief moment.
- Pick the right address from the list. The address then gets a position, and Schedule can calculate travel time.
- If you see a **street-name row** without a house number, you can click it. Schedule then fills in the street name and shows the addresses on that street.

Below the field Schedule tells you how far you are:

- **Address found** with a green tick: The address was picked from the list and has a position.
- **Address not found** with a warning: You typed a text but did not pick from the list. The address is saved as text, but Schedule calculates no travel time.
- **An error occurred. Address search is not available at the moment.**: The address service is not responding. Try again shortly. You can still book with the address as plain text.

<!-- screenshot: the "Start address" and "End address" fields with a suggestion list open under the end address and the text "Address found" under the start address -->

{: .important }
> **Remember:** **End address** must be filled in for out-of-office meetings. If the field is empty, the **Book Meeting** button is greyed out and you cannot book. This applies to all banks.

{: .note }
> **Note:** You can no longer search for place names such as “Tivoli”. Type the street address instead, e.g. “Vesterbrogade 3, 1630 København V”.

{: .note }
> **Note:** If you have fixed addresses on your profile, Schedule finds them again every time you open a booking. You don't need to do anything.


### Step 6 · Book and confirm

_Why: When you pick a time, Schedule holds it for you for five minutes, so nobody else can book it meanwhile. If you do not click **Book Meeting** within that time, the slot becomes available again. **Book Meeting** confirms the time and creates the meeting in Salesforce._

- Check that **Location**, **Date**, **Time** and **Meeting Theme** at the top are correct.
- If you want a different time, click **Choose a Different Meeting**.
- Click **Book Meeting**.
- The **Confirmation** screen shows the meeting's date, time, location, room, meeting type, theme and advisors.
- Click **Close Meeting Booking**.

<!-- screenshot: the "Confirmation" screen with "Location" showing the display name, "Meeting type", "Meeting Theme" and "Advisors" -->

{: .hint }
> ✓ **How you know it worked:** The meeting is listed under **Meeting Booking** on the customer and in your calendar.


## The location's name – what you see

When you choose a location, Schedule shows the **display name** your super-user has set up in Schedule. That is typically the name you use every day, e.g. “Aarhus C branch” rather than an internal code. If the super-user has not set a display name, you see the internal name from your user directory.

The display name follows the meeting all the way: in the location picker, at the top of **Book the Meeting** and on **Confirmation**. Behind the screen Schedule still uses the internal name, so the meeting lands in the right place.

Requires BookMe package 1.30.0 or later.

{: .note }
> **Note:** If you still see internal names, your super-user may not have set up display names yet. The super-user does that under **Meeting setup → Locations** in Schedule.


## What do the fields mean?

Here is what each choice controls, so you know what you are choosing:


| Field / choice | What it controls | Effect on the meeting |
|---|---|---|
| Theme / sub-theme | What the meeting is about | Controls which advisors, meeting types and durations you are offered. |
| Advisor Selection | Who can take the meeting | A specific employee, everyone at the location (**At Location**) or all available. |
| Select Location | Where the meeting is held | Decides advisors and rooms. Shown with the display name. |
| Select Time Slot | Available times or a manual time | **Select Available Time** follows your rules. **Custom** lets you enter the time yourself. |
| Filters | Which times you see | E.g. only times with an available room, or only times the customer would see. |
| Choose Meeting Type | How the meeting is held | In-person meetings use a room. Out-of-office meetings add address fields and travel time. |
| Meeting Room | The room for an in-person meeting | The room is reserved together with the meeting. |
| Start address / End address | Travel for an out-of-office meeting | Travel time is calculated once the address is picked from the list. The end address is mandatory. |
| Meeting Title | The meeting's name | Used as the title of the meeting in Salesforce. |
| Description | What the customer wants to talk about | Goes into the meeting's description. |
| Send meeting confirmation to customer participants | Notification to the customer | Stores whether the customer should be notified. Schedule does not send the notification itself; your organisation's own Salesforce setup does. |
| Book Meeting | Reserves the time | Creates the meeting in your calendar and in Salesforce. |


## Troubleshooting

- The **Book Meeting** button is greyed out: Check that you have chosen a meeting type, that there is at least one participant, and that **End address** is filled in for an out-of-office meeting.
- The **Book Meeting** button is greyed out for a moment right after you picked an address: Schedule is fetching the address's position. Wait a second and try again.
- It says **Address not found** under the address: You did not pick from the list. Type part of the address again and click the right suggestion.
- The list of addresses is empty: Type at least three characters. Search for the street address, not a place name such as “Tivoli”.
- It says **An error occurred. Address search is not available at the moment.**: The address service is not responding right now. Try again shortly. If it happens often, contact your super-user.
- The location is shown with an internal name: Your super-user has not set up a display name for that location.
- I can't find the location: Type part of the name you use every day. If the location is not on the list, it is not set up in Schedule.
- No available times: Try **All Available** under **Advisor Selection**, remove filters, or click **Load More Times**. If there are still no times, ask your super-user.
- I can't book from a Contact: That is not possible. Open the customer's Account, Opportunity, Lead or Case instead.

More common questions and errors: see **Schedule – FAQ**.


## Frequently asked questions

**Why do I have to fill in an end address for out-of-office meetings?**
The bank uses the end address in its templates and to calculate your travel time. Without the address the fields are empty, and the travel time does not appear in your calendar.

**Can I book even if the address is not found?**
Yes. The address is saved as text, and you can book. But Schedule calculates no travel time until the address is picked from the list.

**Why can't I search for “Tivoli” any more?**
The address service only knows addresses and street names, not place names. Type the street address instead.

**What happens to my fixed addresses?**
They stay on your profile and are found again every time you open a booking. You don't need to enter them again.

**Why do I see a different name for the location than before?**
Your super-user has set up a display name. The meeting still lands at the same location.

**Who changes the display name of a location?**
Your super-user, under **Meeting setup → Locations** in Schedule.

### See also
- [Address Lookup for Offsite Meetings]({{ site.baseurl }}/bookme/address-lookup/) — technical description of the address search.
- **Schedule – super-user guide: Meeting setup** — locations, display names and meeting types.
- **Schedule – FAQ (typical questions and errors)**.


## Latest update

- 14.09.2026 (v1.0) — First version (booking from Salesforce, location display name, address search and the mandatory end address).


{: .hint }
> ✅ **Done!** You have booked a customer meeting from Salesforce.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 14.09.2026_
