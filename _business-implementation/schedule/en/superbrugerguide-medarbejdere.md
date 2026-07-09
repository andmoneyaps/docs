---
layout: "default"
title: "Super-user guide – Employees"
parent: "English"
grand_parent: "Schedule"
nav_order: 206
lang: "en"
---
# Schedule – super-user guide: Employees
_Availability, working hours, meeting types and locations in the Management UI · v1.0 · 11.06.2026_



{: .note }
> **Note:** The screenshots below show the Danish Management UI; English-interface screenshots are being added.

## Purpose and value

On **Employees** you manage the individual employee's **availability**: whether the employee can be booked at all, when (days and times), for which **meeting types** and at which **locations**. This is where you decide which free slots customers get shown — so this screen is the engine behind availability.

### Glossary
- **Employee**: A person who can be booked for customer meetings. Employees are synced in from your Entra (AD) — you set up their availability here.
- **Can be booked**: The main switch: whether the employee can be booked for customer meetings at all. Turned off = never shown.
- **Specific employee**: The employee is only shown if the customer/employee chooses the person specifically by name — not in the general pool.
- **Workdays / Working hours**: The days and the time span within which the employee can be booked. Can be set the same for all days or per day.
- **Meeting types**: Physical, Online, Phone or Offsite — what the employee can be booked for.
- **Location**: The location the employee is available for meetings at (can vary per day).
- **Max hours per day**: A cap on how many hours of customer meetings the employee can be booked for per day.
- **Groups**: Read-only overview of the competency and service groups the employee is part of (these control topics/customer types and pools).


## Audience and prerequisites

- Audience: super-user/administrator (role **Configurator** or **Admin**).
- Employees are **synced from Entra** (AD) and shown in the **Select employee** field — you don't create them here, but you set up their availability.
- The following should already be created: **locations**, **competency groups** (topics + customer types) and possibly **service groups** — together with availability they determine which slots are shown.
- If an employee is missing from the list, it is typically a sync issue — contact your administrator.

{: .note }
> **Note:** The brand name is **Schedule**; in the system/menu you may still encounter the earlier name (bookme). It is the same product.


## What you get out of it

After this guide you can:

- Turn an employee on/off for booking and control whether they can only be chosen specifically.
- Set workdays, working hours, meeting types and location — the same or per day.
- Set a cap for max hours per day.
- Read the employee's groups and troubleshoot why an employee is not shown.


## Overview (order)

- Step 1: **Select employee**.
- Step 2: **Can the employee be booked?** (and possibly only as a specific employee).
- Step 3: **Workdays** and **working hours** (the same or special rules per day).
- Step 4: **Meeting types** and **location** (the same or per day).
- Step 5: **Max hours per day**.
- Step 6: **Save** — and check the employee's **groups**.


## Step-by-step (Management UI)

{: .note }
> **Note:** Changes are saved when you click **Save** at the bottom (confirmation: **Availability updated** = the change is saved). The customer view may take a moment (typically a few minutes) to catch up. If you leave the page with **unsaved changes**, the system warns you.


### Step 1 · Select employee

_Why: Find the employee you want to set up availability for._

- Go to **Schedule** → **Employees** (the **Calendar and availabilities** section).
- Search in **Select employee** by name, initials or email.
- The employee's setup appears below. The page has two tabs: **Availability** (settings) and **Groups** (read-only memberships).


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-medarbejdere/sched_medarb_vaelg.png)

*Screenshot 1 (Management UI) — Schedule → Employees — **Select employee** + the employee's availability*

{: .note }
> **Note:** **Labels** (just below the employee selection) are optional and only used to organise/filter employees — they do not affect booking.


### Step 2 · Can the employee be booked?

_Why: The main switch for whether the employee is part of booking — and whether they can only be chosen specifically._

- Under **Customer meetings**: set **Can the employee be booked for customer meetings** to **Yes** (**No** = the employee is never shown).
- Under **Specific availabilities**: optionally set **Can only be booked as a specific employee** to **Yes** — then the employee is only shown when chosen specifically by name (not in the general pool).
- Set **Can the employee take calls from abroad** (global availability) as needed.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-medarbejdere/sched_medarb_kundemoeder.png)

*Screenshot 2 (Management UI) — **Customer meetings** (Can be booked) + **Specific availabilities** (specific employee only)*

{: .note }
> **Note:** **Can the employee be booked** is the main switch: if it is set to **No**, the employee is not shown, regardless of everything else.


### Step 3 · Workdays and working hours

_Why: Which days and within which time span the employee can be booked._

- Under **Workdays**: choose the days the employee is available (a deselected day = no slots that day).
- Under **Working hours**: set **From** and **To** — this applies by default to all workdays.
- If you want different times per day: enable **Set up special rules**, so each day can have its own time span.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-medarbejdere/sched_medarb_arbejdstid.png)

*Screenshot 3 (Management UI) — **Workdays** + **Working hours** (From/To) with **Set up special rules***

{: .important }
> **Remember:** **Set up special rules** lets you set times (and meeting types/location) **per day** instead of one shared setting. If you turn it on, **fill in each relevant day** — a day you don't fill in gives no slots. If you turn it off again, the shared time span applies.


### Step 4 · Meeting types and location

_Why: What the employee can be booked for — and where._

- Under **Meeting types**: choose **Physical**, **Online**, **Phone** and/or **Offsite** (only selected types are offered).
- Under **Location**: choose the location(s) the employee is available at (empty = the employee's default location).
- Both can be set the same for all days or per day via **Set up special rules**.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-medarbejdere/sched_medarb_modetyper_lokation.png)

*Screenshot 4 (Management UI) — **Meeting types** (Physical/Online/Phone/Offsite) + **Location***

{: .note }
> **Note:** Defaults you inherit: empty **Location** = the employee's **default location** from the profile; **No override (use default)** under Max hours = the organisation default set under **Meeting setup → Default values**.


### Step 5 · Max hours per day

_Why: An optional cap on how many hours of customer meetings the employee can be booked for per day._

- Under **Max hours per day**: choose a cap, or keep **No override (use default)**.
- Once the cap is reached for a day, no further slots are shown that day.

{: .note }
> **Note:** **Max hours per day** only applies to **customer meetings** — internal meetings do not count. If the employee is in a service group, the highest limit applies.


### Step 6 · Save and check groups

_Why: Save the setup, and read the employee's groups._

- Click **Save** — you get the confirmation **Availability updated**.
- Click the **Groups** tab (at the top) — here you see (read-only) the employee's **Competency groups** (direct and inherited) and **Service groups**.
- If a competency/service group is missing, the employee is added on the group itself (not here).


![Screenshot 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-medarbejdere/sched_medarb_grupper.png)

*Screenshot 5 (Management UI) — **Groups** — read-only overview of Competency groups (direct/inherited) and Service groups*

{: .hint }
> ✓ **How you know it worked:** Availability is saved, and the employee's groups look right.

**Example:** Make an employee bookable **Monday–Thursday 09:00–15:00** for **Physical** + **Online** at **Aarhus branch**, max **4 hours/day**: Step 2 Can be booked = Yes; Step 3 choose Mon–Thu + working hours 09:00–15:00; Step 4 meeting types Physical+Online, location Aarhus branch; Step 5 max 4 hours; Step 6 Save.


## What do the fields mean?


| Field | What it controls | Meaning (★ = affects availability) |
|---|---|---|
| Can the employee be booked | Main switch | ★ No = the employee is never shown. Yes = included (depends on the rest). |
| Can only be booked as a specific employee | Visibility | ★ Yes = only shown when chosen specifically by name, not in the general pool. |
| Can take calls from abroad | Global availability | Whether the employee can be included in cross-border bookings. |
| Workdays | Days | ★ Only selected days give slots. A deselected day = no slots. |
| Working hours (From/To) | Time span | ★ Only slots within the window are shown. Can be set per day. |
| Meeting types | Channel | ★ Only selected types (Physical/Online/Phone/Offsite) are offered. |
| Location | Place | ★ The employee is only shown for bookings at the selected location(s). |
| Max hours per day | Daily cap | ★ Once the cap is reached, no further slots are shown that day (customer meetings only). |
| Set up special rules | Per-day control | Turn on to set different times/meeting types/location per day. |
| Groups (Competency/Service) | Topics/customer types/pools | Read-only here. Controls which topics/customer types the employee can take, and which pools they are part of. |


## What determines the shown slots?

A slot is only shown when **all** conditions are met for the employee:

- **Can be booked** = Yes, and (if relevant) the employee is not set to specific-only.
- The day is a **workday**, and the time falls within the **working hours**.
- The requested **meeting type** and **location** are selected for the employee (that day).
- **Max hours per day** is not reached.
- The employee is qualified via a **competency group** (topic + customer type) — and possibly activated via a **service group**.
- The employee's **calendar** (Outlook) is free at that time.


## Troubleshooting


**The employee is not shown in availability**

Check in this order (most common first):

- **Can the employee be booked** is set to **No** → set it to **Yes**.
- The employee's **Outlook calendar** is busy (all-day/tentative appointments can also block) → check the calendar.
- The requested **meeting type** or **location** is not selected for the day (e.g. only Online, but the customer wants Physical) → add them.
- The employee is set to **specific only** → only shown when chosen specifically by name.
- No **competency group** matches the topic/customer type → add to the right group.
- The booking requires a **service group** (e.g. remote/national pool), and the employee is not part of an activated group → add/activate the group.
- **Workday** not selected, or the time falls outside the **working hours** → adjust the days/times.
- **Max hours per day** is reached (can leave afternoons empty) → wait for a new day or raise the cap.
- **Special rules per day**: a day is missing a meeting type/location/time → fill in the day.


**Changes don't take effect**

- Remember to click **Save** (confirmation: **Availability updated**).
- If you use **special rules per day**, check that you edited the right day.
- Changes can take a moment to take effect in booking — try a new search/refresh.


**The employee is missing from the list**

Employees come from **Entra** (sync). If a person is missing, it is a sync/access issue — contact your administrator.


## Latest update

- 11.06.2026 (v1.0) — First version (employee availability).


{: .hint }
> ✅ **Done!** The employee's availability is set up and saved.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
