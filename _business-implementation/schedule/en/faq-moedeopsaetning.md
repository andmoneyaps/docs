---
layout: "default"
title: "FAQ – Meeting setup"
parent: "English"
grand_parent: "Schedule"
nav_order: 411
lang: "en"
---
# Schedule – FAQ: Meeting setup
_Typical questions, errors and answers · v1.0 · 12.06.2026_

Quick answers to the most common questions and errors in Meeting setup in Schedule. More detailed steps are in the **Schedule – super-user guide: Meeting setup**.


## Booking flows


**Why can internal meetings be booked when the customer sees no available times?**

Because internal meetings (case handling) **skip most rules**: buffers, max. hours per day, customer-type filtering and operating level do not apply internally. A customer-facing rule is therefore blocking the customer's times — for example a daily limit or a buffer.


**What is the difference between advisor-, customer- and portal-booked?**

They use the **same rules engine**. The difference is where you start, and where the context (customer type/topic/location) comes from: the advisor selects it manually, the customer via their link, the portal pre-selects it.


**Do closing days also apply to internal meetings?**

Yes. Closing days are the one exception — they block **all** flows, including internal ones.


**Does ‘max. hours per day’ apply to internal meetings?**

No. The daily limit applies only to the customer-facing flows. Employees can book internally without limit.


## Settings


**Where do I set special rules for one customer type?**

In **Meeting configuration** with **Set up special rules** (per customer type) or specific configurations per meeting topic. They override the default values.


**What is the difference between ‘calendar time’ and ‘working time from booking to meeting’?**

Both are a **minimum notice** before a meeting can be booked. **Calendar time** counts ordinary hours; **working time** counts only working hours (and crosses days).


**‘Preparation time’ — is that a time of day?**

No, it is a **duration** (e.g. 15 min); the employee is blocked before (preparation) and after (follow-up) the meeting.


**What does ‘Offer fixed employee’ do?**

Determines whether the customer is offered their **fixed employee** or **all available** employees in the booking flow.


**What does ‘Show only times the customer sees’ mean?**

In the employee-facing booking, it shows only the times the customer themselves would see — instead of all times.


## Locations and errors


**No employees appear at a location.**

The location's **Name** must match the **SCIM** location **exactly** (case-sensitive). Check the spelling and capitalisation.


**The room selector is missing for a physical meeting.**

Enable **Require an available meeting room** and/or **Add room to the booked meeting** on the location, and check that rooms are synchronised from SCIM.


**No times at all for a customer type/topic.**

A **meeting configuration** is missing for that combination — create a general configuration or a specific one per customer type/topic.


**There is a meeting configuration, but the customer still sees no times.**

The **most specific** configuration wins (topic+customer type beats customer-type-only beats general beats default values) — and there is **no** fall-back to the general one. If the specific configuration is incomplete (e.g. no meeting types or a hard buffer), it yields no times. Check that particular configuration.


**The customer sees fewer times than expected (not zero).**

Something is trimming the list. Check in this order: **max. hours per day** → **buffers** (calendar/working time, time between meetings) → **travel time** → the requirement for an **available room**.


**We renamed a location in M365/SCIM, and booking broke.**

The location's **Name** in Schedule must match SCIM **exactly**. If the M365 name changes, the Schedule name becomes ‘stale’ and no employees are found. Correct the name so it matches again.


**What can a Manager change in Meeting setup?**

Configurator/Admin can do everything; a Manager typically has limited access (including service groups). If you are unsure about a specific tab, contact your administrator.


## Access and roles


**Who can change Meeting setup?**

The **Configurator** or **Admin** role (some parts also **Manager**). Contact your administrator.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
