---
layout: "default"
title: "Super-user guide – Reporting"
parent: "English"
grand_parent: "Schedule"
nav_order: 202
lang: "en"
---
# Schedule – super-user guide: Reporting
_Booking statistics and distributions in the Management UI · v1.0 · 11.06.2026_


## Purpose and value

**Reporting** gives you a quick overview of your booking activity: how many meetings have been booked, **how** they are booked (by employees, by customers or via portals), and how they break down by **customer type**, **meeting type** and **meeting subject**. It is a **read-only overview** — you use it to follow developments and make decisions about, for example, portals and resources.

### Glossary
- **Booked meetings**: The total number of booked meetings in the selected period (counts meetings, not unique customers).
- **Booking source**: Where the meeting was booked: ⟦Employee⟧, ⟦Customer⟧ (direct) or via a named ⟦portal⟧.
- **Share**: An individual source's/category's percentage of the total number of meetings.
- **Distribution**: How the meetings break down — across weeks, customer types, meeting types and meeting subjects.
- **Period**: The time window for the report — the last 2, 7, 14, 30, 60 or 90 days.
- **Customer type**: A filter that limits the view to a single customer type (or All).

{: .note }
> **Note:** This is the built-in overview in Schedule. **Detailed meeting data** is also delivered to you via **Salesforce CRM analytics**, where you can carry out deeper analyses of the individual meetings.


## Audience and prerequisites

- Audience: **Manager** or **Admin** — the report shows the whole organisation's booking data.
- There must be **booked meetings** in the system for the report to show data.
- **Customer types**, **meeting subjects** and **portals** must be created/named to appear with a name (otherwise, for example, 'Portal' or 'None').
- The report is **read-only**: no editing, and there is no export or custom date range.

{: .note }
> **Note:** The brand name is **Schedule**; in the system/menu you may still come across the previous name (schedule). It is the same product.


## What you get out of it

After this guide you can:

- Choose a period and customer type and read off the total number of meetings.
- See how the meetings break down by booking source (employee/customer/portal).
- Read the distributions across weeks, customer type, meeting type and meeting subject.
- Understand the typical 'gotchas' (e.g. rounding) and troubleshoot an empty report.


## How to read the report


### Step 1 · Choose a period and customer type

_Why: The filters at the top control which meetings the report shows._

- Go to **Schedule** → **Reporting**.
- Choose a **Period** (2, 7, 14, 30, 60 or 90 days — the default is 30).
- Optionally choose a **Customer type** (**All** by default). The whole report updates automatically.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-rapportering/sched_rapport_oversigt.png)

*Screenshot 1 (Management UI) — Schedule → Reporting — filters (**Period**, **Customer type**) + **Booked meetings** and the distribution table*


### Step 2 · Read off the summary (booking sources)

_Why: The large number is the total number of meetings; the table shows where they were booked._

- Read off **Booked meetings** (the total for the period).
- In the table you see, per source: **Count** and **Share** — **Meetings booked by employees**, **Meetings booked by customers** and **Booked via [portal name]**.
- A source only appears if it has at least one meeting in the period.

**Example:** Booked meetings = 142 → Employees 90 (63 %), Customers 40 (28 %), Portal 1 12 (8 %). Note: 63 + 28 + 8 = 99 % due to rounding — this is expected.


### Step 3 · Read 'Distribution of meetings' (over time)

_Why: The bar chart shows the number of meetings per week, split by booking source._

- Each bar is one **week**; the colours within the bar are the individual sources (employee/customer/portals).
- Click a source in the **legend** to highlight just that source's contribution.
- Weeks without meetings are not shown as a bar.


### Step 4 · Read the distributions (customer type, meeting type, meeting subject)

_Why: The other charts show how the meetings break down._

- **Distribution of customer type** (pie chart): the three largest customer types are shown individually, and the rest are grouped as **Other** (meetings without a customer type are shown as a **white segment without a label**, separate from 'Other').
- **Distribution of meeting type** (Physical/Online/Phone and more) and **Distribution of meeting subjects** (horizontal bars) show the most-booked types/subjects.
- Very small shares (below about 1 %) are not shown in the type/subject charts.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-rapportering/sched_rapport_fordeling_typer.png)

*Screenshot 2 (Management UI) — **Distribution of meeting type** + **Distribution of meeting subjects***

{: .hint }
> ✓ **How you know it worked:** You now have an overview of the counts, sources and distributions for the selected period.


## What do the fields and figures mean?


| Field / figure | What it shows | Good to know |
|---|---|---|
| Period | The time window (last N days) | Rolling window; default 30 days. No custom date range. |
| Customer type | Filter on customer type | Affects only the view — not the calculation of the total. |
| Booked meetings | Total number of meetings in the period | Counts meetings (time slots), not unique customers. |
| Count | Number of meetings per source | Whole number. |
| Share | The source's percentage of the total | Rounded to whole percent — so the sum may become 99 % or 101 %. |
| Meetings booked by employees | Meetings booked by employees | E.g. via the Management UI/calendar. |
| Meetings booked by customers | Meetings booked directly by customers | Outside a named portal. |
| Booked meetings - other | Other booking sources | Meetings that are not employee, customer or a named portal. |
| Booked via [portal] | Meetings booked via a portal | One row per portal; without a name, 'Portal' is shown. |
| Distribution of customer type | Pie chart | Top 3 + 'Other'. Uncategorised meetings = white segment without a label. |


## Good to know

- **Rounding:** the percentages are rounded to whole numbers, so the parts may sum to 99 % or 101 % — this is expected.
- **Counts meetings, not customers:** a figure is the number of booked meetings, not the number of unique customers.
- **The customer-type filter** only changes the view; the total figure still covers all customer types.
- **Small shares are hidden:** meeting types/subjects below about 1 % are not shown in the charts.
- **Real time:** the figures reflect bookings on an ongoing basis (typically within seconds/minutes).
- **Rolling window:** the period is the last N days up to today.
- **Cancelled/moved:** if a meeting is cancelled or moved, the figure can change.
- **Same data for everyone:** all Managers/Admins see the whole organisation's figures — so two users see the same figures.


## How you can use the figures

- A large share of **Meetings booked by employees** vs. **portals** → consider promoting self-service via a portal.
- A large **Other** share in the customer-type distribution → customer types may be missing, or meetings are being created without a customer type.
- The most-booked **meeting subjects**/**meeting types** → use this to prioritise skills, rooms and staffing.


## Troubleshooting

- The report is empty: there are no meetings in the period, or the customer-type filter excludes everything → choose a longer **Period** (e.g. 90 days) and **Customer type = All**.
- The figures don't quite add up: this is due to **rounding** of percentages — the parts may sum to 99/101 %.
- A portal appears as 'Portal' (without a name): give the portal a name under **Schedule → Portals**.
- The customer-type filter is empty: no customer types have been created yet → create them under **Meeting setup → Customer types**.
- You can't see **Reporting** in the menu: your role is not **Manager** or **Admin** → contact your administrator.
- 'Couldn't load data': refresh the page (F5); if it continues, contact support.


## Latest update

- 11.06.2026 (v1.0) — First version (Reporting).


{: .hint }
> ✅ **Done!** You can now read and use the booking statistics in Reporting.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
