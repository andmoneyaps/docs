---
layout: "default"
title: "Super-user guide"
parent: "English"
grand_parent: "Insights"
nav_order: 201
lang: "en"
---
# Insights – super-user guide
_Setting up datasets for employee availability · data delivered nightly · v1.0 · 11.06.2026_


## Purpose and value

**Insights** builds a dataset about your employees' availability for a period ahead (typically around 60 days): **when** are there available times, and **why** are there not (e.g. outside working hours, busy, or not qualified). In the Management UI you **set up** the datasets — the data itself is **delivered to you every night** via **Salesforce CRM analytics**, where you analyse it yourselves.

{: .note }
> **Note:** There is **no** result or analysis screen in the Management UI for you. In the Management UI you create and maintain the **setups**; the detailed analysis takes place in **Salesforce CRM analytics**, where the data is delivered each night.

### Glossary
- **Insight setting**: A dataset you define (customer type + meeting topic + meeting configuration) that forms the basis for the analysis.
- **Data run**: Insights generates data automatically (nightly). ⟦Latest data⟧ shows when it last happened.
- **Usecase**: Whether the dataset should contain ⟦all⟧ times with a reason (Full dataset) or ⟦only available⟧ ones (Only available meetings).
- **Reason**: Why a time is not available (e.g. Outside working hours, Busy, Not qualified) — or Available.
- **Meeting configuration**: The rules (opening hours, duration, buffers, meeting types, etc.) that the simulation works with.


## Audience and prerequisites

- Audience: **Configurator** or **Admin**.
- Schedule must be set up: **customer types**, **meeting topics**, **meeting configuration**, **employees** (with competences + calendar) and **locations** — Insights builds on top of these data.
- Data is generated **automatically (nightly)** per setting and **delivered to you via Salesforce CRM analytics**.
- A new setting only delivers data after the first nightly run.

{: .note }
> **Note:** Insights is accessed from the menu under **Insights → Settings**.


## What you get out of it

After this guide you can:

- Create an insight setting (customer type, meeting topic, meeting configuration, usecase).
- Understand when and how data is generated and delivered.
- Understand what the dataset contains (dimensions and 'reasons').
- Troubleshoot the typical problems.


## Create an insight setting


### Step 1 · Start a new setting and choose the dataset

_Why: The setting determines which scenario the analysis simulates._

- Go to **Insights** → **Settings** → click **Create new**.
- Under **Settings**: choose **Customer type**, **Meeting topic** and **Time zone** (default Europe/Copenhagen).
- Note the tooltip: in the dataset, employees' **competence group** membership is not included in the availability calculation if you choose to ignore competence groups.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/insights/en/superbrugerguide/insights_opret.png)

*Screenshot 1 (Management UI) — Insights → Settings → **Create insight setting** — Name, Customer type, Time zone, Usecase and Meeting configurations*


### Step 2 · Name the setting and set the meeting configuration

_Why: The meeting configuration governs the rules that the simulation works with._

- Give the setting a **Name**.
- Under **Meeting configurations**: choose an existing configuration or set up a new one — **Opening time**, **Closing time**, **Meeting duration**, **Time between meetings**, the buffers (**Working time/Calendar time from booking to meeting**, optionally **excl. weekend**), **Max meeting time per day** and **Meeting types**.


### Step 3 · Choose the usecase and options

_Why: The usecase determines what the dataset contains._

- Choose **Usecase**: **Full dataset** (all times with a reason) or **Only available meetings** (only the available ones).
- Optionally set **Ignore competence groups** (use it when you want to see the **raw capacity** regardless of competences) and **Include 'Can only be booked specifically' employees** (when you also want specialist employees included).

{: .note }
> **Note:** **Full dataset** is best when you want to understand **why** times are not available (reasons). **Only available meetings** focuses on the actual available capacity.


### Step 4 · Create — and wait for the data run

_Why: The setting is saved and runs automatically._

- Click **Create insight setting** (confirmation: **Insight setting created**).
- The setting appears in the list with **Name**, **Customer type** and **Latest data**.
- Data is generated nightly — a setting created today only delivers data after the **next** nightly run (typically tomorrow).


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/insights/en/superbrugerguide/insights_opsaetning.png)

*Screenshot 2 (Management UI) — Insights → Settings — the list with **Name**, **Customer type** and **Latest data***

{: .hint }
> ✓ **How you know it worked:** The setting is created and appears in the list — and data is delivered at the next nightly run.


## How data is delivered and used

Once the setting has run (nightly), the **dataset is delivered to you via Salesforce CRM analytics**. There you build your own dashboards, analyses and reports on the data — e.g. available capacity per weekday, or which **reasons** most often block times.

- The dataset contains, per employee and time: **weekday**, **time of day**, **location**, **meeting type**, **start date** and duration.
- Each time has a **reason**: either **Available** or why it is not available (see the table below).
- **Latest data** in the list shows when data was last generated and delivered.

{: .note }
> **Note:** The detailed analysis (filters, groupings, charts) takes place in **Salesforce CRM analytics** — not in the Management UI.


## Reasons in the dataset

Each time in the dataset has a **reason** — it is either available, or the reason explains why it is not available:


| Reason | Meaning |
|---|---|
| Available | The time is available. |
| Reserved/Booked | Already taken by a meeting. |
| Busy | Busy in the calendar (external appointment). |
| Bank closed | Closed day. |
| Outside working hours | Outside the employee's working hours. |
| Within working hours | Within working hours (but possibly blocked by another reason). |
| Max meetings per day | The day's cap on meeting time has been reached. |
| Meeting type unavailable | The requested meeting type is not offered. |
| Weekday unavailable | The employee does not work that day. |
| Not qualified | The employee does not have the competence (topic/customer type). |
| Cannot be booked | The employee cannot be booked for customer meetings. |
| Working elsewhere | The employee is at another location. |
| Working time buffer / Calendar time buffer | Too close to now — buffer from booking to meeting. |
| Time between meetings | Blocked by the break between meetings. |
| None / Unknown | No reason, or unknown reason. |

{: .note }
> **Note:** **How to fix the most common reasons (in Schedule):** **Busy** → the employee's Outlook calendar; **Not qualified** → competences (Schedule → Employees/Competence groups); **Outside working hours**/**Weekday unavailable** → working days/hours; **Cannot be booked** → the setting 'Can the employee be booked'.


## What do the fields mean? — Settings


| Field | What it controls |
|---|---|
| Customer type + Meeting topic | Which scenario is simulated (which employees/configuration applies). |
| Time zone | How times are expressed in the data. |
| Opening time / Closing time | The window the simulation treats as possible. |
| Meeting duration / Time between meetings | Meeting length and break between meetings. |
| Working time / Calendar time from booking to meeting | Buffer (notice) from booking until the meeting can be held. |
| Max meeting time per day | Cap on meeting time per day per employee. |
| Meeting types | Which meeting types (Online/Physical/Phone/Offsite) are included. |
| Usecase | Full dataset (all times with a reason) or Only available meetings. |
| Ignore competence groups | Whether competence group membership is left out of the calculation. |


## Good to know

- **Nightly run + delivery:** data is generated automatically and delivered to Salesforce CRM analytics; a new setting only delivers data after the first run (see **Latest data**).
- **Simulation into the future:** Insights predicts availability for a period ahead (typically ~60 days).
- **Competences matter:** an employee without the right competence (topic/customer type) counts as **Not qualified** — unless you have chosen to ignore competence groups.
- **Edit/delete:** you can view, edit or delete a setting via the icons in the list.


## Troubleshooting

- 'Error creating insight setting': a required field is missing (customer type, meeting topic, time zone, meeting types) or an invalid time/duration → check the fields.
- The dataset has not arrived / is missing in Salesforce: check **Latest data** — if it is empty or old, the nightly run may have failed → contact your administrator (Admin → Logs) or support.
- An employee is missing from the dataset: the employee does not have the right **competence** (topic/customer type) for the setting, or cannot be booked → check Schedule → Employees.
- The numbers don't match actual bookings: Insights is a **simulation** of future availability — for actual, booked meetings use **Reporting**.

### See also / prerequisites
- **Insights – FAQ** — typical questions, errors and answers.
- **Schedule – super-user guide: Employees** — availability and competences that Insights builds on.
- **Schedule – super-user guide: Reporting** — booking statistics (actual meetings).


## Latest update

- 11.06.2026 (v1.0) — First version (insight setting + nightly data delivery).


{: .hint }
> ✅ **Done!** Your insight setting is created — data is delivered at the next nightly run.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
