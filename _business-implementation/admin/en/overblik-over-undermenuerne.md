---
layout: "default"
title: "Overview of the sub-menus"
parent: "English"
grand_parent: "Admin"
nav_order: 201
lang: "en"
---
# Admin – overview of the sub-menus
_What each tab does · what you actually see · the consequence of changes · v1.0 · 12.06.2026_


## Purpose and value

The **Admin** menu holds the technical and organisational settings that make Engage hang together — the connection to your CRM and Microsoft 365, users/licences, and the logs. Several of the tabs are **high-risk**: a wrong change can stop calendar sync or remove users' access. This guide gives you the overview: what each tab does, **what you actually see**, and — most importantly — the **consequence** of changing something.

{: .note }
> **Note:** **Logs are alerts** to you (the customer) and your administrator — not a queue that &money/your operating partner monitors. An alert means something needs action, often in your own Entra/M365. The error catalogue and division of responsibility can be found in **Admin – Logs & sync errors**.

{: .important }
> **Remember:** **Never touch these three on your own in production:** ① **Microsoft → Proxy URL** (stops ALL sync) · ② **User Management → auto-remove licences** (removes access) · ③ **Meeting settings → copy** (overwrites the target). Always agree with IT/your operating partner/&money first.


## Risk overview (all tabs)


| Tab | What it is | Risk | Who changes |
|---|---|---|---|
| Logs | Alerts about, among other things, sync (meetings, employees, rooms, Present). | High — alerts require action. | You (alert) |
| Meetings overview | See all meetings for an employee on a chosen date. | Low — read-only. | You |
| CRM Settings | Connection to Salesforce/Dynamics, limits, licences. | High — wrong = no CRM data. | your operating partner/&money |
| Entities | Definitions and field mapping for CRM objects. | Medium — wrong mapping = data lands in the wrong place. | &money/your operating partner |
| Playbooks | Automated flows from booking to CRM (separate guide). | Medium. | your operating partner/&money |
| Microsoft | Graph proxy URL + Teams meeting settings. | High — wrong proxy = no sync. | your operating partner/IT |
| Meeting settings (copy) | Copy setup from one customer/bank to another. | High — overwrites the target. | your operating partner |
| Templates | Templates for meeting minutes. | Low. | You |
| User Management | Users, rooms, auto-licence management, validate sync. | High — auto-licence can remove access. | You/IT |
| Label management | Labels for organising resources. | Low. | You |
| Operations | Operational/maintenance actions. | Medium–high. | your operating partner/&money |
| Troubleshooter | Diagnostics: meeting sync and availability. | Low — diagnoses. | You |


## The high-risk tabs — what you actually see, and the consequence


**Logs — alerts about sync, etc.**

**What you actually see:** tabs for **Meetings**, **Employees** (calendar sync), **Rooms**, **Present**, **Audit** and **Reports** — with status (Information/Warning/Error/Success) and error codes (**CAL-ERR-xx**). **Consequence:** an error typically means that an employee's availability or a meeting is not being synced. **What you do:** see **Admin – Logs & sync errors** (error catalogue + who-does-what).


**CRM Settings**

**What you actually see:** **Salesforce** (Domain name) or **Dynamics 365** (Environment URL); **Test connection**/**Test Schedule integration**; **Create** (provision the integration); **Limits** (status Healthy/Warning/**Critical**); **Licences** and **Permission set**; **Validate users**. **Consequence:** a wrong domain/URL or missing provisioning = **no booking data in the CRM**; if you hit a **Critical** limit, CRM writes can stop. **Create** (provision) can safely be repeated (idempotent) — it is **Push/deploy** of components that overwrites. **Do:** test the connection after a change; keep an eye on the limits. See **Admin – CRM Settings (deep-dive)**.


**Microsoft (Graph API + Teams)**

**What you actually see:** **Proxy URL** to Microsoft Graph + **Test connection**; **Teams - meeting settings** (allow recording/transcription, auto-recording, meeting template ID). **Consequence:** a wrong or unreachable **Proxy URL** means that **calendar sync cannot connect** (gives error CAL-ERR-14 for all employees). **Do:** only touch the proxy URL by agreement with your IT/your operating partner; **Test connection** afterwards. See **Admin – Microsoft (deep-dive)**.


**User Management**

**What you actually see:** **Users** and **Rooms** (create/edit, labels); **Automatic licence management** (auto-assign/auto-remove licences, permission sets and permission groups) with **Auto-Discover Mappings** and **Reset to Default**. **Consequence:** **Auto-remove** can **remove licences/access** from employees automatically; manually created users can collide with those coming in via SCIM (if a duplicate appears, keep the **SCIM** user and remove the manual one). **Do:** be careful with the auto-licence rules; test on a few users first. See **Admin – User Management (deep-dive)**.


**Meeting settings (copy)**

**What you actually see:** **Copy meeting settings** from one source to one target — you choose what is copied (**Default values**, **Customer types**, **Meeting topics**, **Meeting configurations**). **Consequence:** the copy **overwrites** the target's setup, and 'default settings must be set up manually'. **Do:** confirm source and target carefully; use it mainly for new setups, not on a customer in production.


**Entities**

**What you actually see:** definitions and field mapping for the CRM objects that booking data is written to. **Consequence:** a wrong mapping means data lands in the wrong fields (or not at all). **Do:** only change together with &money/your operating partner; test a booking afterwards.


## The lower-risk tabs

- **Meetings overview** — look up which meetings an employee has on a given date (read-only).
- **Templates** — create/edit templates for meeting minutes.
- **Label management** — labels for organising and filtering resources (portals, users, etc.).
- **Operations** — operational/maintenance actions (can be intrusive). **Do not run actions here without a your operating partner/&money case** — the risk depends entirely on the individual action.
- **Troubleshooter** — diagnostic tools (meeting sync and availability) for finding out why a slot/sync is playing up.
- **Playbooks** — automated flows from portal booking to CRM (see **Schedule – super-user guide: Playbooks**).


## Symptom → which tab (quick triage)

If an employee calls with a symptom, start here — and always check **Logs** first.


| Symptom | Likely tab | First |
|---|---|---|
| No availability / calendar not syncing for everyone | Microsoft (Proxy URL) — CAL-ERR-14 | Logs → Employees |
| Booking not landing in the CRM | CRM Settings / Entities | Test connection + Logs |
| Employee has lost licence/access | User Management (auto-remove licences) | Check auto-licence rules |
| Online meeting without Teams link | Microsoft (Teams) + the user's licence | Logs → Meetings |
| Meeting booked on top of an appointment / double booking | Calendar sync delayed | Logs → Employees |
| A single slot/sync playing up for one user | Troubleshooter (diagnostics) | Run diagnostics |


## Before you change anything in Admin

- **Understand the consequence first:** Admin changes often affect **all** employees/meetings, not just one.
- **Note the old value first:** write down, for example, the Proxy URL or CRM domain before you change a high-risk setting — so you can set it back.
- **High-risk = agree with IT/your operating partner/&money:** Microsoft (proxy), Entities, auto-licence and copy-setup should not be changed alone in production.
- **Test afterwards:** use **Test connection** (CRM/Microsoft) and make a **test booking** when something in the sync chain has been touched.
- **The logs are your receipt:** check **Logs** after a change to see that sync is still running.

### See also / prerequisites
- **Admin – Logs & sync errors** — error catalogue (CAL-ERR-xx) + division of responsibility (RACI).
- **Admin – CRM Settings / Microsoft / User Management (deep-dives)** — the three high-risk tabs in detail.
- **Schedule – super-user guide: Playbooks** — flows to the CRM.
- **Schedule – super-user guide: Meeting settings** — the meeting rules themselves (the copy function copies these).
- **Schedule – getting started** — cross-cutting overview.


## Latest update

- 12.06.2026 (v1.1) — Who-changes column, symptom→tab triage, rollback note, top-3 'do not touch alone', Operations/CRM/SCIM clarified (persona feedback).
- 12.06.2026 (v1.0) — First version (Admin overview).


{: .warning }
> **Warning:** Admin changes have broad effects; understand the consequence, and test afterwards.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
