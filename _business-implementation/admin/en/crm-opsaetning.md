---
layout: "default"
title: "CRM setup (deep-dive)"
parent: "English"
grand_parent: "Admin"
nav_order: 203
lang: "en"
---
# Admin – CRM Settings (deep-dive)
_The connection to your CRM · what you actually see · the consequences of changes · v1.0 · 12.06.2026_


## Purpose and value

**CRM Settings** connects Engage to your CRM (**Salesforce** or **Dynamics 365**). It is the backbone that ensures booking data — meetings, customer types, meeting topics — ends up in the right place in your CRM. The area is split into three pages: **CRM Configuration** (connection + provisioning), **Limits** (usage in Salesforce) and **Auto-license** — plus **Validate users**. Most of the actions here are **rare setup steps**, not day-to-day operations.

{: .note }
> **Note:** **The domain name can often only be changed by &money/the service desk.** If you see the text ‘contact the service desk for assistance’, that is deliberate — it is a high-risk value. Contact &money rather than trying to work around it.


## Who changes what (and the risk)


| Action | Who | Risk |
|---|---|---|
| Domain name / Environment URL | &money / service desk | High — wrong = no CRM data. |
| Test connection / Test CRM | You | None — read-only test. |
| Create (provision Schedule) | You / your operating partner | Low — idempotent, safe to re-run. |
| Push (customer types/meeting topics) | You / your operating partner | Low–medium — synchronises configuration. |
| Push EngageMe components (deploy) | your operating partner / &money | High — OVERWRITES the Salesforce component. |
| Limits | You (monitor) | — read/monitor usage. |
| Validate users | You | — diagnostics (e-mail match). |


## What you actually see


**CRM Configuration**

**What you actually see:** the **Domain name** field (Salesforce: **https://___.my.salesforce.com**) or **Environment URL** (Dynamics); **Test connection**; **Create** (provision the Schedule connection); possibly **Test Present connection**; **&money EngageMe components** with the **Push** button (+ a note: ‘Pushing overwrites the same Salesforce component’); **Push** of customer types/meeting topics; and **Test CRM**.

- **Create** is **idempotent** (an ‘upsert’) — it can safely be run again without breaking anything; it simply creates/updates the connection.
- **Push EngageMe components** (deploy), by contrast, is **invasive**: it **overwrites** the existing component in Salesforce. Confirm the **component type** (Standard vs. Standalone) before you push.
- **Domain name** is validated on format — an incorrect format gives the error ‘Malformed URL’, and you cannot save.


**Limits**

**What you actually see:** a table of your Salesforce limits (**Limit name**, **Status**, **Used**, **Maximum**, **Remaining**, **Usage**). Status is colour-coded:


| Status | Usage | What it means |
|---|---|---|
| Healthy | 0–69 % | Normal — no action. |
| Warning | 70–89 % | Keep an eye on it — consider clean-up/more capacity. Act HERE. |
| Critical | 90 %+ | Close to the ceiling — at 100 % Salesforce rejects further calls, and CRM writes (meetings/data) can stop. |


**Auto-license**

**What you actually see:** setup of which licenses and permissions employees automatically receive (or lose). This is **high-risk** and has its own guide — see **Admin – User Management (deep-dive)**, where auto-assign/auto-remove, permission sets and **Reset to Standard** are described.


**Validate users**

**What you actually see:** three lists that compare Schedule users with the CRM: **Duplicated** (matches more than one e-mail in the CRM), **Missing** (does not exist in the CRM) and **Valid** (clean one-to-one match). **Consequence:** there must be a **one-to-one** match before sync and auto-license work reliably. Duplicates and missing entries must be cleaned up in the CRM/Schedule.


## The consequence of a wrong value


| If … | Then … | Shown as |
|---|---|---|
| Wrong domain/URL (but valid format) | Test fails; provisioning + sync to CRM fails | ‘Error in the integration to the CRM’ |
| Malformed domain/URL | Cannot be saved | ‘Malformed URL’ (red) |
| Push EngageMe components onto an existing one | The existing component is overwritten | ‘Pushing overwrites …’ |
| A limit hits Critical (90 %+) | CRM writes near stop at 100 % | Status Critical (red) |


## Before you change anything

- **Domain name/URL:** leave it to &money/the service desk — it is a high-risk value, and wrong = no CRM data.
- **Test afterwards:** use **Test connection**/**Test CRM** after any change, and make a **test booking**.
- **Create can be re-run** (idempotent) — but **Push/deploy** OVERWRITES; confirm the component type and target.
- **Monitor Limits:** act on **Warning** (70 %+), not only when Critical.
- **Validate users** must be one-to-one before you switch on auto-license (otherwise the assignment fails).

### See also / prerequisites
- **Admin – User Management (deep-dive)** — auto-license + Validate users in detail.
- **Admin – Microsoft (deep-dive)** — calendar sync (Graph proxy).
- **Admin – Logs & sync errors** — error catalogue + division of responsibility.
- **Admin – overview of the sub-menus** — all tabs in brief.


## Latest update

- 12.06.2026 (v1.0) — First version (CRM Settings deep-dive).


{: .important }
> ⚠️ **Remember** — Domain name = &money; Create can be re-run; Push/deploy overwrites; always test afterwards.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
