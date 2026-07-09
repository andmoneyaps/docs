---
layout: "default"
title: "User management (deep-dive)"
parent: "English"
grand_parent: "Admin"
nav_order: 202
lang: "en"
---
# Admin – User Management (deep-dive)
_Users, rooms & automatic license management · what you actually see · the consequences of changes · v1.0 · 12.06.2026_


## Purpose and value

**User Management** covers employees (**Users**), meeting rooms (**Rooms**) and — most important and most risky — **automatic license management**. Here, licenses and access can be assigned or **removed automatically** across **all** employees, and users can come both from **Entra/SCIM** and be created **manually**.

{: .important }
> **Remember:** **Auto-remove licenses** removes the license/access **automatically** when an employee is deleted — with no extra warning in the delete dialog itself. Test the auto rules on **a few users** first, and run **Validate users** before you enable auto-license.


## Who changes what (and the risk)


| Area | Who | Risk |
|---|---|---|
| Users / Rooms (create/edit) | You / IT | Low–medium. |
| Edit a SCIM user | You (carefully) | Medium — may be overwritten at the next SCIM sync. |
| Auto-license: master toggle | You / &money | High — applies to all new employees. |
| Auto-assign | You | High — everyone gets the license/permission. |
| Auto-remove | You | High — removed on deletion, no extra warning. |
| Auto-Discover Mappings | You | Low — names only, non-destructive. |
| Reset to Default | You | High — deletes all auto configuration, cannot be undone. |
| Validate users | You | — diagnostics (email match). |


## What you actually see


**Users**

**What you actually see:** a table with **Name**, **Initials**, **Email**, **SCIM** (does the user come from Entra?), **Rights**, **Groups**, **Licenses** and **Labels**. You can **Create**, edit, and use the bottom actions: **Edit rights/groups/licenses** and **Delete/Restore user(s)**.


**Rooms**

**What you actually see:** **Name**, **Location**, **Can be booked**, **SCIM** and **Labels** — create/edit/delete in the same way as users.


**SCIM versus manually created users**

**What you actually see:** if you edit a **SCIM user**, a **red warning** appears together with a confirmation: 'Correct this information only if you are absolutely sure what you're doing!'. **Consequence:** manual changes to a SCIM user may be **overwritten** at the next Entra sync. Manually created users are **not** synced by SCIM. **If a duplicate arises** (the same person manually and via SCIM), keep the **SCIM** user and remove the manual one.


**Automatic license management**

**What you actually see:** a master toggle **Enable Auto License Management** and three sections — **Package Licenses**, **Permission Sets** and **Permission Set Groups** — each with **Auto Assign** and **Auto Remove**. In addition, **Auto-Discover Mappings** (puts readable names on license IDs) and **Reset to Default**.

- **Auto Assign** = all employees automatically receive the chosen license/permission.
- **Auto Remove** = the license/permission is removed when an employee is **deleted** from the system.
- **Auto-Discover Mappings** is **non-destructive** — it touches only names, not actual assignments.
- **Reset to Default** deletes **all** auto configuration (requires confirmation, **cannot be undone**) — but does not touch licenses that have already been assigned.


## Consequences of the dangerous actions


| Action | Consequence | Warning in UI? |
|---|---|---|
| Auto-assign turned ON | Everyone (current + new) gets the license/permission | No |
| Auto-remove ON + delete employee | License/access removed in CRM on deletion | NO — no extra warning on deletion |
| Edit a SCIM user | The change may be overwritten at the next sync | Yes — red warning + confirm |
| Reset to Default | All auto configuration deleted (not already-assigned ones) | Yes — confirm, cannot be undone |
| Auto-Discover Mappings | Readable names on license IDs only | Non-destructive |


## Before you change anything

- **Run Validate users FIRST:** there must be a one-to-one email match — duplicates/missing entries make auto-license fail. (See CRM Setup.)
- **Test auto-assign/-remove on a few users** before you enable it for everyone.
- **Remember auto-remove** is triggered on deletion **with no extra warning** — be sure before you delete an employee.
- **Only edit SCIM users** if you know what you are doing — otherwise handle them in Entra.
- **Reset to Default** cannot be undone; export/note your configuration first.

### See also / prerequisites
- **Admin – CRM Setup (deep-dive)** — Validate users + the license basis itself.
- **Admin – Logs & synchronisation errors** — sync errors + division of responsibility.
- **Admin – overview of the submenus** — all tabs in brief.


## Latest update

- 12.06.2026 (v1.0) — First version (User Management deep-dive).


{: .important }
> **Remember** — Auto-remove removes on deletion with no extra warning; validate users first; SCIM can overwrite manual corrections.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
