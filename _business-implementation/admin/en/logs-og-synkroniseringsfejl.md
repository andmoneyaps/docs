---
layout: "default"
title: "Logs & synchronisation errors"
parent: "English"
grand_parent: "Admin"
nav_order: 204
lang: "en"
---
# Admin – Logs & synchronisation errors
_Error catalogue (message → code) · what they mean · what you do · who does what · v1.2 · 12.06.2026_


## Purpose and value

The logs show whether bookings and calendars **synchronise** correctly between Schedule and Microsoft 365 / CRM. When something misbehaves, a Danish **message** is shown in the log (and behind it sits a technical **status code**, CAL-ERR-xx, that you can quote to support). This guide explains the log tabs, **what each message means**, what you do, and — most important in your situation — **who holds the responsibility**.

{: .note }
> **Note:** The logs are **ALARMS** to you (the customer) and your administrator — not a queue that &money or your operating partner monitors on your behalf. An alarm means that **something requires action** — and the action very often lies in your **own Entra / Microsoft 365**. Use the decision tree and the error catalogue below to send the error to the right place.

{: .important }
> **Remember:** **Fill in for your bank (once):** Entra is managed for us by **______** (your own Entra team / your operating partner). Contacts — Entra/IT: **______** · your operating partner (1st-level): **______** · &money: info@andmoney.dk. That turns 'Entra (you/your operating partner)' in the catalogue into **one** name.


## Your role as admin (and what you pass on)

Your job is **not** to make the technical fixes, but to **read and forward**. The technical checks (app permissions, REST API, delegation) are carried out by the **fixer** (your Entra/IT, your operating partner or &money).

- **You can do yourself:** click **Remove synchronisation timeout** on a timeout/connection error (CAL-ERR-13/14).
- **You forward:** always the **error code** · **time** · **employee/room** · **log tab** plus, if useful, the full message.
- **You close:** when the error has been **cleared** (CAL-INFO-18) and a new synchronisation **succeeds**.


## The log tabs — what you actually see

- **Meetings** — creation/update/deletion of meetings in Outlook (status + message per meeting).
- **Employees** — calendar sync per employee: a summary (delta/full, success/error), the latest success and the latest error, and a **Remove synchronisation timeout** button.
- **Rooms** — calendar sync for meeting rooms (same structure as Employees).
- **Present** — log for slide/PDF generation.
- **Audit** — who changed what and when (compliance).
- **Reports** — aggregated data.

Each entry has a **status** (**Information**, **Warning**, **Error** or **Success**), a **message** and a **status code** (CAL-xx). It is the entries with status **Error** (CAL-ERR-xx) that you must act on.


## Decision tree — who should act?

Under your agreed division of responsibility (RACI), **your operating partner** owns the setup and synchronisation in your tenant (they are the operator for you), **your own Entra/IT** owns what only you can control, and **&money** owns the platform. Send the error to the right place:

- **Connection / Graph proxy / sync drift** (CAL-ERR-13/14): **your operating partner** operates the proxy/provisioning and can clear a sync timeout (Graph proxy/SCIM via specialists); for network issues, your IT.
- **Permissions / consent / app setup** (CAL-ERR-06/08/10): whoever handles your **Entra** — **your own Entra team**, if you manage Entra yourselves; otherwise **your operating partner** (via specialists). If a **licence or admin consent** is missing, only the bank itself can grant it.
- **User accounts / mailboxes** (CAL-ERR-09/11): only whoever owns your Microsoft tenant — typically **your own Entra team** (disabled user, wrong UPN, mailbox without REST).
- **Platform / internal error** (CAL-ERR-12/15/16): **&money**.
- As **customer admin** you see the alarm — read the **code** + the **time**, and send it to the right party.


## Error catalogue — look up by the message (or the code)

Look up the **message** you see in the log. All calendar errors begin with 'Kunne ikke synkronisere kalender for rådgiver: …' ("Could not sync calendar for advisor: …") — the table shows the **distinctive part** after the colon. Behind each entry also sits a technical **status code** (CAL-ERR-xx), which you can quote to your operating partner/&money.


| Message in the log (after '… rådgiver:') | Code | Meaning, consequence & what you do | Owner |
|---|---|---|---|
| Adgang nægtet for bruger. Kunne være en manglende tilladelse ("Access denied for user. Could be a missing permission") | CAL-ERR-06 | The calendar does not synchronise → missing/wrong times. Check that the app registration has Calendars.ReadWrite + a calendar licence. | Entra (you/your operating partner) |
| For mange forsøg ("Too many retries") | CAL-ERR-07 | Sync abandoned after repeated errors. Find the FIRST underlying 06/14 in the log, and route by that. | Follow 06/14 |
| Kunne ikke læse begivenhed. Kunne være en manglende tilladelse. ("Could not read event. Could be a missing permission.") | CAL-ERR-08 | Event could not be read. Check the permission on the calendar; run a full synchronisation. | Entra (you/your operating partner) |
| Ugyldig bruger ("Invalid user") | CAL-ERR-09 | The account does not exist / is disabled. Check that the user is active and that the UPN matches what Schedule knows. | Your Entra |
| Delegeret kalenderadgang nægtet. ("Delegated calendar access denied.") | CAL-ERR-10 | Check the app permission + admin consent; check the mailbox's delegation rules. | Entra (you/your operating partner) |
| Postkassen er ikke aktiveret til REST API ("The mailbox has not been enabled for REST API") | CAL-ERR-11 | Older mailbox setup. Enable REST API on the user's Exchange mailbox. | Your Entra |
| Adgangstoken er ugyldig. Prøv igen med en ny ("The access token is invalid. Retry to use a new one") | CAL-ERR-12 | Token expired/invalid. Run a new synchronisation (the token is renewed). Persists? Check the app credentials. | &money |
| Synkroniseringen fik timeout. Kunne være relateret til netværksproblemer eller gamle tilbagevendende begivenheder ("The sync timed out. Could be related to network issues or old recurring events") | CAL-ERR-13 | Check network/M365 status; use 'Remove synchronisation timeout'; possibly a calendar clean-up. | your operating partner |
| Kunne ikke oprette forbindelse til Graph API ("Could not connect to the Graph API") | CAL-ERR-14 | Typically hits ALL employees. Check that the Graph proxy is running + that the Proxy URL is correct (Admin → Microsoft); check the firewall. | your operating partner |
| Ukendt fejl ("Unknown Error") | CAL-ERR-15 | Unexpected error from Graph. Contact &money with the code and the time. | &money |
| (no 'rådgiver:' prefix) Kunne ikke opdatere delta link for rådgiveren ("Could not update the delta link for the advisor") | CAL-ERR-16 | Internal sync state. Run a full synchronisation. Persists? &money investigates. | &money |

{: .note }
> **Note:** **Not all codes are errors** — the code families: **CAL-FS** (01–03) = full synchronisation running/completed; **CAL-DS** (01–02) = delta synchronisation; **CAL-TS** (22–25) = time slots created/updated/deleted; **CAL-INFO-17** = time slots deleted during full sync; **CAL-INFO-18** = 'Synkroniseringsfejl ryddet for rådgiver' ("Sync error cleared for advisor") (the error is gone); **CAL-INFO-19/20** = new/all employees queued. Only **CAL-INFO-21** ('Fejl ved hentning af synkroniseringsindstillinger for bank' — "Error while getting sync settings for bank") is genuinely an error — owned by &money.


## What the typical errors look like in the log (recognise them)

- CAL-ERR-06: 'Kunne ikke synkronisere kalender for rådgiver: Adgang nægtet for bruger. Kunne være en manglende tilladelse'.
- CAL-ERR-09: '…: Ugyldig bruger'.
- CAL-ERR-11: '…: Postkassen er ikke aktiveret til REST API'.
- CAL-ERR-13: '…: Synkroniseringen fik timeout. Kunne være relateret til netværksproblemer eller gamle tilbagevendende begivenheder'.
- CAL-ERR-14: '…: Kunne ikke oprette forbindelse til Graph API'.


## How you act on a sync error

- Open **Logs → Employees** (or Rooms), and select the affected employee.
- Read the **code** and the latest **error** message; look the code up in the catalogue.
- If it is a **timeout/connection** error, you can click **Remove synchronisation timeout** to force a new sync.
- If it is **identity/permission**, send the code + time + employee to your **Entra/IT**.
- If the error persists after action, escalate to **your operating partner** (operations) or **&money** (platform) with the code.
- Finally: confirm that the error has been **cleared** (CAL-INFO-18) and that a new **synchronisation succeeds** (CAL-FS/DS) before closing the case.


## Most frequent support tickets in practice

Patterns from your actual support tickets (anonymised). Use them as a shortcut to 'what do I check — and who owns it'.


| Pattern (what the customer reports) | Likely cause | Check / who |
|---|---|---|
| Online meeting created without a Teams link | Teams/M365 meeting creation failed (policy/licence/template) | Hits ONE user → licence/policy (your Entra); hits MANY/systemic → template/back-office (&money/your operating partner). Check Admin → Microsoft → Teams. |
| 'Kunne ikke oprette forbindelse til Graph API' — many/all advisors | CAL-ERR-14 — Graph proxy down/wrong | Graph proxy + Proxy URL (Admin → Microsoft) → your operating partner. If it hits all banks, it is platform → &money. |
| Meeting booked even though the advisor is off / not available | Calendar sync delayed or rule setup | Calendar sync (Logs → Employees) + meeting configuration/working hours. Persists → &money. |
| Double booking / meeting booked on top of another appointment | Calendar sync delayed — the new busy status has not arrived yet | Check calendar sync (Logs → Employees); if it hits many, it is often sync/platform → &money. |
| 'Max hours per day' fails | Limit calculation | Default values + employee/service-group limit. Persists → &money. |
| Advisor does not get meetings in the calendar / meeting is not moved in Outlook | M365 write fails | Permissions/connection (CAL-ERR-06/14). M365 → your Entra / your operating partner. |
| Internal meetings do not work | Setup or platform | Meeting configuration (internal). Persists → &money. |
| Meeting rooms not synced / booked on top of each other | Room sync (SCIM/M365) | Logs → Rooms + location name (SCIM match) → your operating partner / your Entra. |
| User cannot be seen/edited under Employees | Provisioning (SCIM) | SCIM provisioning → your operating partner / your Entra (user active/UPN). |

{: .note }
> **Note:** **Teams link** and **Graph proxy connection** are the two most frequent themes in practice. When an error hits **many/all** advisors at once, it is almost always a **common** cause (proxy/platform) — not the individual employee.


## Division of responsibility (RACI)

Based on your agreed RACI (&money ↔ your operating partner, v2). **Guiding principle:** &money owns the **infrastructure/platform**; your operating partner owns the **setup** — even when it runs inside &money's infrastructure. Two phases: **Hypercare** (right after a change, where &money leans in) and **Operation** (day-to-day running).


| Party | Owns (core) | With respect to sync errors |
|---|---|---|
| your operating partner (operator for you) | Setup in your tenant: Graph proxy, Entra app, SCIM provisioning, M365 access, data quality; 1st-level support; synchronisation + sync alarms. (Entra/Graph proxy/SCIM: your operating partner draws on specialists in their parent organisation.) | A/R — drives most sync errors; clears the timeout; escalates. |
| Your own Entra/IT | What only you can control in your Microsoft tenant: user accounts (active/UPN), licences, admin consent, mailboxes. Several customers handle Entra entirely themselves. | Acts on CAL-ERR-09/11 + grants consent/licence for 06/10. |
| &money | Platform/hosting, sync orchestration, backend, token, error definitions, managed playbooks/AI; 2nd-level support. | CAL-ERR-12/15/16; consulted on the rest. |
| Customer admin | Sees the alarm, reads the code, grants access/info, forwards. | First responder on the alarm itself. |

{: .note }
> **Note:** Your RACI marks **A6 (synchronisation + sync alarms)** as a point to be finalised between **your operating partner, &money and the bank's Entra expert** — precisely 'who acts on which error type'. The error catalogue above is a concrete first proposal. **Until A6 is settled:** default **your operating partner 1st-level → &money 2nd-level**, so no case stalls.

{: .note }
> **Note:** **Important in practice:** your operating partner does not itself hold **Entra/Graph proxy/SCIM** competencies — they draw on **specialists in their parent organisation**, or else the customer handles **Entra themselves** (this applies to several of the larger banks). So 'who fixes the Entra error' depends on your setup: if you manage Entra yourselves, it is **your own Entra team**.


## Troubleshooting tools (Admin → Troubleshooter)

- **Meeting Sync Troubleshooter** — investigate why a particular meeting has not synchronised.
- **Availability Troubleshooter** — investigate why an employee is not showing available times.

### See also / prerequisites
- **Admin – overview of the sub-menus** — what the other Admin tabs do.
- **Schedule – super-user guide: Employees** — availability (calendar sync originates here).
- **Schedule – super-user guide: Meeting setup** — the meeting rules.


## Latest update

- 12.06.2026 (v1.2) — Error catalogue reversed: the VERBATIM Danish log message is now the primary lookup key, the status code (CAL-ERR-xx, from the backend's statusCode) is the secondary reference. Strings verified against the code (translateSyncMessage.ts). ⟦⟧ markers cleared in table cells.
- 12.06.2026 (v1.1) — Persona uplift: 'Your role as admin' (YOU vs fixer) + handoff template, contact/setup box, A6 default (your operating partner 1st → &money 2nd), close-the-loop, double-booking row.
- 12.06.2026 (v1.0) — First version: error catalogue + division of responsibility (your RACI, &money ↔ your operating partner v2) + most frequent support tickets (anonymised from your Atlassian/AMFM).


{: .important }
> 📣 **Remember** — a log alarm means that something requires action, often in your own Entra/M365.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.2 · 12.06.2026_
