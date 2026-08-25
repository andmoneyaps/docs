---
layout: "default"
title: "Super-user guide – Service groups"
parent: "English"
grand_parent: "Schedule"
nav_order: 204
lang: "en"
---
# Schedule – super-user guide: Service groups
_Service groups, competence groups and operating level in the Management UI · v1.0 · 11.06.2026_



{: .note }
> **Note:** The screenshots below show the Danish Management UI; English-interface screenshots are being added.

## Purpose and value

A **service group** is a pool of employees who can serve customers across branches. When no slot is available with a local employee, the customer can instead be booked with a qualified employee from a service group. As a super-user you control **when** a service group is activated (activation rules), **what** it offers (service level), **who** it consists of (employees/competence groups) and **in which order** it is offered (operating level).

### Glossary
- **Service group**: A pool of employees that is activated for a booking based on rules and offers a particular service level.
- **Competence group**: A grouping of employees with competences (meeting topics + customer types) — i.e. what they can hold meetings about. Can be added to a service group as a whole.
- **Activation rules**: Conditions (location, customer type, meeting topic) that determine when a service group is activated for a booking.
- **Service level**: What the service group offers: which meeting types and locations the customer can book.
- **Operating level**: The priority order for who the customer is offered (Explicitly chosen → Local adviser → Service group via label).
- **Label**: A marker on a service/competence group, used to prioritise groups in the operating level.
- **Meeting type**: Online, Physical, Phone or Off site.


## Audience and prerequisites

- Audience: super-user/administrator who sets up Schedule.
- Roles: **Service groups** require the **Manager** or **Admin** role; **competence groups** and **operating level** can be accessed by **Configurator** or **Admin**.
- The following have been created in advance: **customer types**, **locations**, **meeting topics** and **employees** (with availability). **Competence groups** are recommended. If any of these are missing, they are created elsewhere in Schedule — contact your administrator if you don't have access.
- The Managed Schedule package is installed (full functionality).

{: .note }
> **Note:** The brand name is **Schedule**; within the system/menu itself you may still encounter the former name (schedule). It is the same product.


## What you get out of it

After this guide you can:

- Create a competence group and a service group.
- Set activation rules and service level, so the right customers are offered the right employees.
- Prioritise service groups in the operating level with labels.
- Understand what each setting means for availability — and troubleshoot the most common problems.


## Overview (order)

- Step 1: Create **competence groups** (recommended — so employee pools are easy to maintain).
- Step 2: Create the **service group** (name, email, labels, employees, max hours).
- Step 3: Set **activation rules** (when the group is activated).
- Step 4: Set **service level** (what the group offers).
- Step 5: Prioritise in the **operating level** (the order the customer is offered).


## How it fits together

- **Competence group** = **what** the employees can do (meeting topics + customer types).
- **Service group** = **who** is offered (members) + **when** (activation rules) + **what** (service level).
- **Operating level** = **in which order** the customer is offered (local employee before service group, etc.).


## Step-by-step (Management UI)


### Step 1 · Create a competence group (recommended)

_Why: Competence groups make it easy to manage what the employees can do — and to add whole pools to a service group._

- Go to **Schedule** → **Competence groups** → click **Create**.
- Fill in **Name**, and optionally add **Labels**.
- Under **Competences**: choose the **Meeting topics** and **Customer types** the employees can hold meetings about.
- Under **Memberships**: add **Employees** (and optionally **Sub-groups** — their employees inherit the group's competences).


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-servicegrupper/sched_kompetencegruppe.png)

*Screenshot 1 (Management UI) — Schedule → Competence groups — create/edit with **Competences** (meeting topics + customer types) and **Employees***

{: .hint }
> ✓ **How you know it worked:** The competence group appears in the list with a count of sub-groups and employees.


### Step 2 · Create the service group

_Why: The service group itself — name, members and optionally a daily time limit._

- Go to **Schedule** → **Service groups** → click **Create**.
- **General:** fill in **Name** and optionally an **Email for the service group** (so internal employees can self-book via the group).
- **Labels:** add labels (used to prioritise the group in the operating level).
- **Employees:** add individual **Employees** and/or **Competence groups** (all employees from the group are linked).
- **Max. hours per day:** optionally choose a limit, otherwise **No override (use default)**.
- Save the service group.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-servicegrupper/sched_servicegruppe_opret.png)

*Screenshot 2 (Management UI) — The **Create service group** dialog — **General**, **Labels**, **Employees** + **Competence groups** and **Max. hours per day***

{: .note }
> **Note:** **Activation rules** and **Service level** can only be set **once the service group has been created** — so save first, then edit (Steps 3–4).


### Step 3 · Set activation rules (when is the group activated?)

_Why: The activation rules determine which bookings the service group comes into play for._

- Open the service group again (edit).
- Under **Activation rules**: choose the **Places** (locations), **Customer types** and/or **Meeting topics** that should activate the group.
- The group is activated when **at least one** of the chosen rules is met (the rules are combined with ‘or’).
- Save.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-servicegrupper/sched_servicegruppe_aktivering.png)

*Screenshot 3 (Management UI) — Service group → **Activation rules** — **Places**, **Customer types** and **Meeting topics***

{: .note }
> **Note:** If you leave **Places** empty, the group can service **all** locations that meet the other rules. Set the rules deliberately, so the group is not activated too broadly.


### Step 4 · Set service level (what does the group offer?)

_Why: The service level controls which meeting types and locations slots are shown for._

- Still editing: under **Service level** choose **Meeting types** (Online, Physical, Phone, Off site).
- Choose **Locations** — the meeting places the customer can choose for **physical** meetings.
- Save.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-servicegrupper/sched_servicegruppe_serviceniveau.png)

*Screenshot 4 (Management UI) — Service group → **Service level** — **Meeting types** and **Locations***

{: .hint }
> ✓ **How you know it worked:** The service group appears in the list with an employee count and is now ready to take part in bookings.

{: .note }
> **Note:** Under **Service level** you must actively **choose at least one meeting type** the service group can handle. If you choose **Physical**, you must also add **locations** — otherwise no physical slots are shown. An empty service level gives no slots.


### Step 5 · Prioritise in the operating level

_Why: The operating level determines the order the customer is offered employees in — e.g. local employee before service group._

- Go to **Schedule** → **Meeting setup** → **Service level**. The section itself is called **Operating level** (same screen).
- Add/adjust priority levels with **Add operating level** and the **arrows** (top = highest priority).
- Per level: choose **Type** (**Explicitly chosen**, **Local adviser** or **Service group**), write a **Description**, and choose a **Label** (only for type Service group). **Choose the same label you gave the service group in Step 2** — that is the link between the service group and its priority.
- Save.


![Screenshot 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-servicegrupper/sched_betjeningsniveau.png)

*Screenshot 5 (Management UI) — **Operating level** — priority levels with **Type**, **Description** and **Label** + arrows for order*

{: .note }
> **Note:** **Explicitly chosen** and **Local adviser** can each appear only once; **Service group** can appear several times (each with its own label) — so you can create primary, secondary, etc. service groups.


### Step 6 · Test that it works

_Why: Confirm that the service group is actually offered before you rely on it in production._

- Make a **test booking** as a customer of the customer type/location/meeting topic that matches the activation rules.
- Confirm that available slots from the service group are shown (and in the correct priority).
- If no slots are shown, check the activation rules, service level (meeting types + locations) and the members' availability.

{: .hint }
> ✓ **How you know it worked:** The customer is offered slots from the service group as expected — then the setup is complete.

**Example — Service group “Bolig Vest”:** activation rules = customer type **Private** + location **Aarhus** + meeting topic **Home loan**; service level = meeting types **Online** + **Physical** and locations **Aarhus**; label **sekundaer**; in the operating level the label **sekundaer** sits below **Local adviser**.


## What do the fields mean? — Service group


| Field | What it controls | Meaning (★ = affects availability) |
|---|---|---|
| Name | Display name | Shown in admin and to the customer. Use a meaningful name. |
| Email for the service group | Internal self-booking | Employees can book meetings via the group at this email. Optional. |
| Labels | Prioritisation | ★ Used in the operating level to rank the group (primary/secondary). |
| Employees | Member pool | ★ The employees (direct + via competence groups) who can be offered. |
| Competence groups | Member pool (as a whole) | ★ All employees from the group are linked to the service group. |
| Max. hours per day | Daily time limit | ★ Limits how much time the members can be booked per day. Empty = default; several groups = highest limit; an individual limit wins. |


## What do the fields mean? — Activation rules and service level


| Field | What it controls | Meaning (★ = affects availability) |
|---|---|---|
| Activation: Places | When (location) | ★ The group is activated for these locations. Empty = all locations (that meet the other rules). |
| Activation: Customer types | When (customer type) | ★ The group is activated for these customer types. Empty = all customer types. |
| Activation: Meeting topics | When (topic) | ★ The group is activated for these meeting topics. Empty = all meeting topics. |
| Service level: Meeting types | What (channel) | ★ Which meeting types the group offers: Online (video meeting), Physical (in person — requires locations), Phone (phone meeting), Off site (meeting outside your locations). |
| Service level: Locations | What (physical place) | ★ Meeting places the customer can choose for physical meetings. |

{: .important }
> **Remember:** The activation rules are combined with ‘or’: the group is activated when **at least one** rule is met. If you want to be precise, set all three deliberately.


## What do the fields mean? — Operating level


| Field | What it controls | Meaning |
|---|---|---|
| Type: Explicitly chosen | The customer chose the employee themselves | Highest relevance — only once. |
| Type: Local adviser | Employee at the customer's own location | Typically high priority — only once. |
| Type: Service group | Employees from a service group | Can appear several times (one per label) for primary/secondary. |
| Description | Explanation of the level | Internal text, so you can recognise the level. |
| Label | Which service groups the level applies to | ★ Only for type Service group: matches service groups with this label. |
| Arrows (order) | Priority | ★ Top = highest priority; the system takes the first match from the top down. |


## Troubleshooting

- The service group is never activated: check the **activation rules** (customer type/location/meeting topic), and that the members have **availability/working hours** on the matching days.
- Employees are missing from the selection list: check that they are synchronised and can be **booked** (see Availability).
- The customer only gets local employees: adjust the **operating level** so the service group's label is prioritised.
- Max hours don't take effect: an individual limit on the employee wins over the service group's.
- Activation rules/service level cannot be set: the service group must be **created first** — save and then edit.
- A label doesn't work in the operating level: make sure at least one service group has the chosen label.


## Latest update

- 11.06.2026 (v1.0) — First version (service groups + competence groups + operating level).


{: .hint }
> ✅ **Done!** The service group is ready for bookings.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
