---
layout: "default"
title: "Microsoft (Graph + Teams) (deep-dive)"
parent: "English"
grand_parent: "Admin"
nav_order: 205
lang: "en"
---
# Admin – Microsoft (Graph API + Teams) (deep-dive)
_Calendar sync + Teams meetings · what you actually see · the consequences of changes · v1.0 · 12.06.2026_


## Purpose and value

The **Microsoft** tab controls two things: the connection to **Microsoft Graph** via a **Proxy URL** — the backbone of **all calendar sync** — and the default settings for the **Teams meetings** that Schedule creates automatically. The Graph connection ensures that meetings are created, updated, read and deleted in employees' calendars.

{: .important }
> **Remember:** **The Proxy URL is the single most important setting in the whole of Admin.** A wrong or unreachable value stops **ALL** calendar sync for **every** employee at once. Only touch it in agreement with your IT/your operating partner — and click **Test connection** BEFORE you save.


## Who changes what (and the risk)


| Setting | Who | Risk |
|---|---|---|
| Proxy URL (Graph) | your operating partner / IT (by agreement) | CRITICAL — stops all calendar sync. |
| Test connection | You | None — advisory test. |
| Teams: recording / transcription / auto-record | You | Medium — applies to ALL new meetings. |
| Teams meeting template ID | You / IT | Medium — overrides the three toggles; requires Teams Premium. |


## What you actually see


**Microsoft Graph API (Proxy URL)**

**What you actually see:** a single field — **Proxy URL** — a **Test connection** button and **Save**. The test hits the proxy's **/healthz** and shows either a green ‘Connection to Microsoft Graph API created’ or a red ‘Error connecting to Microsoft Graph API …’ (with a status code).

- **Important:** the test is only **advisory** — you CAN save a URL that fails the test. There is **no confirmation** and **no undo**.
- **/healthz** only tests that the proxy **responds** — not that permissions/scopes are in place. A green test is therefore not a guarantee that sync works.
- **Consequence:** a wrong/unreachable URL = no employee is synchronised, and new meetings are not created in Teams/Exchange.

{: .note }
> **Note:** The error appears in Logs as ‘Kunne ikke synkronisere kalender for rådgiver: Kunne ikke oprette forbindelse til Graph API’ (English: ‘Could not sync calendar for advisor: Could not connect to the Graph API’) — in the Logs guide this is **CAL-ERR-14**. If it hits ALL employees at once, the cause is almost always the proxy/platform — not the individual.


**Teams – meeting settings**

**What you actually see:** three on/off settings + a field for a template ID. They apply to **all** Teams meetings that Schedule creates going forward (not existing ones):


| Setting | What it does | Note |
|---|---|---|
| Allow recording | Participants can record the meeting | Recordings land in Teams/SharePoint. |
| Allow transcription | Turns on auto-transcription | Microsoft does NOT support Danish yet — keep it OFF, otherwise it fails silently. |
| Start recording automatically | Records from the start of the meeting | Applies to all new meetings. |
| Teams meeting template ID | Uses a fixed Teams template | Overrides the three above; requires Teams Premium; created in Teams Admin Center. |

**Consequence:** if a **template ID** is set, the three toggles have **no effect** — the template decides everything. If **transcription** is turned on for Danish, transcription is attempted but fails (Danish not supported).


## Related log errors

- **CAL-ERR-14** — ‘Could not connect to the Graph API’ (proxy down/wrong).
- **Delegated calendar access denied** — a permissions/delegation problem (not the proxy).
- **Access denied** / **invalid access token** / **timeout** — see the error catalogue in the Logs guide.


## Before you change anything

- **Note down the old Proxy URL** before you change it — so you can put it back.
- **Test connection BEFORE Save** — but remember: a green test = the proxy responds, not that sync works.
- **Is it hitting everyone at once?** Suspect the Proxy URL/platform, not the individual employee.
- **Leave transcription off** until Danish is supported.
- **Template ID:** remember that it overrides the three toggles — remove it if you want to control things via them.


## Latest update

- 12.06.2026 (v1.0) — First version (Microsoft deep-dive).


{: .warning }
> **Warning:** The Proxy URL stops ALL sync on failure; test before Save; Danish transcription = off.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
