---
layout: "default"
title: "FAQ – Employees"
parent: "English"
grand_parent: "Schedule"
nav_order: 412
lang: "en"
---
# Schedule – FAQ: Employees
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors with employee availability in Schedule. More detailed steps are in the **Schedule – super-user guide: Employees**.


## Availability


**“Can be booked” is set to Yes, but there are still no time slots.**

Work through the diagnosis in this order (most common first): 1) is the **Outlook calendar** busy at that time? 2) is a **meeting type**/**location** not selected for the day (e.g. only Online, but the customer wants In-person)? 3) is the employee set to **specific employee only**? 4) does no **competence group** match the topic/customer type? 5) does the booking require a **service group** the employee isn't part of? 6) is it outside the **workday/hours**? 7) has the **max. hours per day** been reached?


**How do I know whether it's the Outlook calendar that's blocking?**

If the configuration looks right but exactly one time slot is missing, it's typically a busy time in the employee's **Outlook calendar**. Note that all-day events and “tentative” appointments can also block time slots.
{: .note }


**The employee is in the right competence group but still doesn't show up.**

Then it's often **service-group gating**: if the booking requires a service group (e.g. a remote/national pool), the employee must be part of a group that is **activated** for that customer type/topic/location. Check the service group's activation rules and members.


**I turned on “Set up special rules”, and now one day is empty.**

With special rules you set time slots/meeting types/location **per day** — a day you haven't filled in gives no time slots. Fill in the day, or turn off special rules to use the shared time slot again.


**What happens if I leave Location blank?**

Then the employee's **default location** from the profile is used. If you want a different location (or several), you select them explicitly.


**What does “Can the employee take calls from abroad” mean?**

That's global availability — turn it on if the employee may take part in cross-border bookings.


**What does “Can the employee be booked for customer meetings” do?**

That's the main switch. If it's set to **No**, the employee is excluded entirely from all booking — regardless of every other setting.


**What does “Can only be booked as a specific employee” mean?**

If it's set to **Yes**, the employee doesn't show up in the general pool of available time slots — only if the customer or an employee selects the person specifically by name.


**How do I set different time slots on different days?**

Turn on **Set up special rules** under Working hours (and optionally Meeting types/Location). Then each individual day can have its own time slot, its own meeting types and its own location.


**My changes don't take effect.**

Remember to click **Save** — when you see the confirmation “Availability updated”, the change is saved. The customer view can take **a few minutes** to catch up; try a new search/refresh. If you're using per-day special rules, check that you've edited the right day.
{: .important }


**What is “Max. hours per day”, and why isn't it working?**

A cap on how many hours of customer meetings the employee can be booked for per day. It applies only to **customer meetings** — internal meetings don't count. If the employee is in a service group, the **highest** limit applies. If it isn't set, the default value is used.


## Employees & groups


**Where do the employees come from, and why is one missing?**

Employees are synced in from your **Entra** (AD). If a person is missing from **Select employee**, it's a sync/access issue — contact your administrator.


**Can I deactivate an employee?**

There's no separate “inactive” button. Set **Can the employee be booked** to **No** — then the employee isn't included in booking.


**How do I add an employee to a competence or service group?**

That's done on the **group** itself (Competence groups/Service groups). On the employee, **Groups** is only a read-only overview.


**What do “direct” and “inherited” competence group mean?**

Direct = the employee is added to the group directly. Inherited = the employee is included via a subgroup and also takes on the parent group's competences.


## Access and roles


**Who can set up employee availability?**

The **Configurator** or **Admin** role in the Management UI. Contact your administrator if you don't have access.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
