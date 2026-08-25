---
layout: "default"
title: "Getting started"
parent: "English"
grand_parent: "Schedule"
nav_order: 101
lang: "en"
---
# Schedule – getting started
_Overview, booking flows and the setup journey · start here · v1.0 · 12.06.2026_


## Purpose and value

**Schedule** is your booking platform: it governs **when** customers and employees can book meetings, **who** is offered, and **where**. This guide is your **start here** — an overview of the parts, the four booking flows and the order you set them up in, with links to the more detailed guides.

{: .note }
> **Note:** Where Schedule sits: Schedule is the **booking part**. A booking's data is stored in your **CRM** (via Playbook). **Insights** is a separate product (a forecast of availability), and **Present/Assist** are other &money Engage products.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/kom-godt-i-gang/schedule_oversigt.png)

*Screenshot 1 (Management UI) — Schedule in the Management UI — the menu with Meeting setup, Employees, Service groups, Competence groups, Portals and Reporting*


## The four booking flows — the most important distinction

A meeting can come about in four ways. The most important distinction is **internal vs. customer-facing**:

- **Internal meetings (case handling):** an employee books internally — **skips almost all the rules**.
- **Advisor-booked:** an employee books for/with a customer.
- **Customer-booked:** the customer books themselves (e.g. via a direct link).
- **Portal meeting:** the customer books via a portal.

{: .note }
> **Note:** The three **customer-facing** flows (advisor, customer, portal) use the **same rule engine** — the difference is the entry point and where the context comes from. **Rule of thumb: learn the rules once; internal meetings skip them.** The full **booking-flow matrix** can be found in **Schedule – super-user guide: Meeting setup**.


## The Schedule areas — and which guide belongs to each

| Area | What it is | Guide |
|---|---|---|
| Meeting setup | The rules: default values, customer types, meeting topics, locations, meeting configuration, operating level. | Meeting setup |
| Employees | The individual employee's availability (days/times/meeting types/location) + competences. | Employees |
| Service and competence groups | Pools of employees + what they can do; priority via operating level. | Service groups |
| Portals | The customer-facing booking page; sends data to the CRM via Playbook. | Portals |
| Playbooks (under Admin) | Automatic flow: portal booking → CRM (the forward-looking standard). | Playbooks |
| Reporting | Statistics on the meetings actually booked. | Reporting |
| Insights (its own product) | A forecast of future availability; data delivered nightly via Salesforce CRM Analytics. | Insights |

Each area has its own guide: **Schedule – super-user guide: [area]** + an accompanying **FAQ** (Insights, however, is simply called **Insights – super-user guide**). See the full list under 'All Schedule guides' at the bottom.


## The setup journey (cross-cutting order)

Set things up in this order — each part builds on the previous one:

- 1. **Meeting setup** — set the rules (Default values → Customer types → Meeting topics → Locations → Meeting configuration → Operating level).
- 2. **Employees** — make employees bookable (availability) and check their competences.
- 3. **Service and competence groups** — create pools with activation rules + service level, and prioritise them in the operating level.
- 4. **Portals** — build the customer-facing page, and connect it to a **Playbook** (CRM).
- 5. **Follow up** — **Reporting** (meetings actually booked) and **Insights** (a forecast of availability).

{: .note }
> **Note:** The order reflects the dependencies: Default values are the defaults that Meeting configuration overrides; employees/service groups build on the rules; portals build on all of it.


## Roles

- **Manager** — service groups and reporting, among other things.
- **Configurator** — meeting setup, employees, competence/operating level, portals, insights.
- **Admin** — full access, including Playbooks and logs.


## Prerequisites (technical)

- A managed **Schedule** package installed.
- **Entra** roles assigned; employees synchronised (Entra), locations/rooms (SCIM/M365).
- An **M365 calendar** connected (busy times block availability).
- A **CRM connection** (for portals/Playbooks).


## A quick word on the technical terms

### Glossary
- **Schedule**: The technical name for Schedule (in the code/menus you may come across 'schedule').
- **Entra**: Microsoft Entra (formerly Azure AD) — where employees and roles are synchronised from.
- **SCIM / M365**: Synchronisation of locations/rooms and employee calendars from Microsoft 365.
- **Playbook**: An automatic flow that sends a portal booking's data to the CRM.
- **Rule engine**: The shared logic that the customer-facing flows use to find available times.


## First-time checklist

{: .note }
> **Note:** **The quickest route to a test booking:** Default values → one general meeting configuration → one bookable employee with the right competences → test booking. The rest (service groups, portals, Playbook) can come afterwards.

- **Default values** set (opening hours, time zone, closing days, max. hours/day).
- At least one **customer type**, one **meeting topic** and one **location**.
- A **meeting configuration** (at least a general one) for the customer type/topic.
- **Employees** bookable, with working days/times and the right competences.
- Optionally a **service group** + prioritisation in the **operating level**.
- A **portal** (+ Playbook), if customers are to self-book.
- A **test booking** per relevant flow.


## Cross-cutting pitfalls

- **Internal meetings skip the rules:** buffers, the daily limit, priority and customer type do not apply to internal meetings — only closing days and duration.
- **Location name = SCIM:** it must match exactly (case-sensitive), otherwise no employees are shown.
- **A missing meeting configuration** for a customer type/topic → no times.
- **The most specific configuration wins** (topic+customer type → customer type → general → default values).
- **Competences:** an employee without the right competence is not offered in customer-facing flows.

### See also / prerequisites
- **Schedule – super-user guide: Meeting setup** (+ FAQ) — the rules + booking-flow matrix.
- **Schedule – super-user guide: Employees** (+ FAQ) — availability.
- **Schedule – super-user guide: Service groups** (+ FAQ) — pools + operating level.
- **Schedule – super-user guide: Portals** (+ FAQ) — customer-facing page + CRM.
- **Schedule – super-user guide: Playbooks** (+ FAQ) — flow to the CRM.
- **Schedule – super-user guide: Reporting** (+ FAQ) — booking statistics.
- **Insights – super-user guide** (+ FAQ) — a forecast of availability.


## Latest update

- 12.06.2026 (v1.0) — First version (cross-cutting overview).


{: .hint }
> ✅ **Start here** — follow the setup journey, and dive into the individual guide as needed.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
