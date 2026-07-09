---
layout: "default"
title: "FAQ – Reporting"
parent: "English"
grand_parent: "Schedule"
nav_order: 415
lang: "en"
---
# Schedule – FAQ: Reporting
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors with Reporting in Schedule. More detailed guidance is in the **Schedule – super-user guide: Reporting**.


## Reporting


**Who can see Reporting?**

The **Manager** or **Admin** role. The report shows booking data for the whole organisation (it is not filtered per department/location).


**Can I get more detailed meeting data than this overview?**

Yes. In addition to the Reporting overview, **detailed meeting data** is delivered to you via **Salesforce CRM analytics**, where you can analyse individual meetings in depth.


**The report is empty — why?**

There are no booked meetings in the selected period, or the customer-type filter excludes everything. Choose a longer **Period** (e.g. 90 days) and **Customer type = All**, and check that there are bookings in the system.


**Why do the percentages add up to 99 % or 101 %?**

The shares are rounded to whole percentages. The parts can therefore add up to 99 or 101 % — this is expected and not an error.


**Do the numbers count meetings or customers?**

Meetings. **Booked meetings** is the number of booked meetings (time slots) — not the number of unique customers.


**Does the customer-type filter affect the total figure?**

No — the customer-type filter only changes what is shown. The total **Booked meetings** still covers all customer types.


**A portal is shown as ‘Portal’ with no name — why?**

The portal is missing a name. Give it a name under **Schedule → Portals**, and the name will then appear in the report.


**Why is a meeting type or meeting topic missing from the chart?**

Very small shares (below about 1 % of all meetings) are not shown in the type/topic charts, so the chart stays clear and readable.


**Can I export the report or choose a free date range?**

No. The report is read-only, and you choose from fixed periods (2/7/14/30/60/90 days). There is no export or free date range.


**How often are the figures updated?**

Continuously (real time) — new bookings are typically reflected within seconds to minutes.


**What is the white part in the pie chart?**

Meetings with no customer type (uncategorised). They are shown as a white part with no label.


**I can't see Reporting in the menu.**

Your role is probably not **Manager** or **Admin**. Contact your administrator to get the right access.


**The number changed / a meeting disappeared from the report.**

The report counts the booked meetings in the period. If a meeting is cancelled or moved, the number can change. The period is also a rolling window (the last N days), so older meetings drop out over time.


**The source figures don't add up to ‘Booked meetings’.**

This can happen because very small sources/categories (or sources with 0 in the period) are not shown as their own row, and because of rounding. The total **Booked meetings** is always the total.


**Which 30 days exactly is it?**

The last 30 days up to today (a rolling window). Change the **Period** for a different window (2/7/14/30/60/90 days).


**My colleague sees different figures than me.**

They shouldn't — all Managers/Admins see the whole organisation's data. Small differences are typically because you are looking at different times (real time) or different filters (Period/Customer type).


**What is in ‘Other’ in the pie chart?**

The customer types that fall outside the three largest, combined into one part. The white part with no label is meetings **without** a customer type (uncategorised) — separate from ‘Other’. Neither of them can be clicked for details.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
