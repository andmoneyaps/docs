---
layout: "default"
title: "FAQ"
parent: "English"
grand_parent: "Insights"
nav_order: 402
lang: "en"
---
# Insights – FAQ
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors in Insights. More detailed steps are in the **Insights – super-user guide**.


## Insights


**What is Insights, and what do I use it for?**

Insights simulates and analyses employee availability some time ahead (typically ~60 days): when slots are available, and why slots are not. You use it to understand capacity and bottlenecks.


**What is the difference between Insights and Reporting?**

**Insights** is a **forecast/simulation** of future availability. **Reporting** shows **actual** booked meetings in the past. The two complement each other.


**Where do I see the results / the data?**

The data is delivered to you **every night** via **Salesforce CRM analytics**, where you build your own dashboards and analyses. There is **no** results/analysis screen in the Management UI — here you only create the settings themselves.


**Where do I create a setting?**

Under **Insights → Settings → Create new**. Choose the customer type, meeting topic, time zone, meeting configuration and usecase.


**When is the data delivered?**

Data is generated and delivered **nightly** per setting (to Salesforce CRM analytics). A new setting only delivers data after its first run — see **Latest data** in the list.


**What is the difference between ‘Full dataset’ and ‘Only available meetings’?**

**Full dataset** contains every time slot with a **reason** (including the busy ones) — good for understanding why. **Only available meetings** shows only the free slots — good for seeing real capacity.


**Why is an employee missing from the dataset?**

Usually because the employee does not have the right **competence** (meeting topic/customer type) for the setting, or cannot be booked. Check Schedule → Employees. You can also set **Ignore competence groups** in the setting.


**What does ‘Ignore competence groups’ do?**

Then the employees' competence-group membership is not included in the calculation — all employees are included regardless of competences. Use it when you want to see the raw capacity.


**Is Insights connected to Salesforce CRM analytics?**

Yes. Insights data can be passed on to **Salesforce CRM analytics**, where you can carry out deeper, business-wide analyses.


**I created a setting today and still haven't received any data.**

Data is generated and delivered **nightly**. A setting created today only delivers data after the next nightly run (typically tomorrow). Check **Latest data** in the list.


**‘Latest data’ is old / the data is not updating.**

The nightly run may have failed. Contact your administrator, who can check **Admin → Logs** for errors in the Insights run.


**‘Error creating insight setting’.**

A required field is missing (customer type, meeting topic, time zone, meeting types) or a time/duration is invalid. Check all fields and try again.


**The numbers look wrong / don't match the actual bookings.**

Insights is a **simulation** of future availability — not actual meetings. For actual, booked meetings you use **Reporting**.


**In the dataset, almost everything has the same reason (e.g. Busy or Unqualified) — what do I do?**

This points to a Schedule setup: **Busy** → Outlook calendar; **Unqualified** → competences; **Outside workday** → working days/hours; **Unbookable** → ‘Can the employee be booked’. Fix it in Schedule → Employees.


**Can I edit or delete a setting?**

Yes — use the icons in the list (view, open, delete). Changes are reflected at the next nightly run.


## Access and roles


**Who can use Insights?**

The **Configurator** or **Admin** role. Contact your administrator if you are missing access.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
