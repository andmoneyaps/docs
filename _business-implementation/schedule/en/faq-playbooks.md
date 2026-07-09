---
layout: "default"
title: "FAQ – Playbooks"
parent: "English"
grand_parent: "Schedule"
nav_order: 413
lang: "en"
---
# Schedule – FAQ: Playbooks
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors with Playbooks in Schedule. More detailed steps are in the **Schedule – super-user guide: Playbooks**.


## Playbooks


**What is a Playbook?**

An automated flow: a **trigger** (an event, e.g. a customer's portal booking) → **blocks** (steps) → output (typically a record in the CRM). Playbooks are the way forward — the standard for how portals send booking data to the CRM.


**Where do I create and manage Playbooks?**

Under **Admin → Playbooks**. They are typically set up together with &money, as this is a more advanced feature.


**What is a trigger?**

The event that starts the flow. For portals this is typically **PortalMeetings** (a customer books via a portal). There is also, for example, **PortalMeetingCancelled** (a cancellation).


**What is a block?**

A step that does one thing — for example **Read CRM data**, **Create CRM record**, **Update CRM data**, **Filter results** or **Run AI**. A playbook must have at least one block in addition to the trigger.


**What is a relation and a transformation?**

A **relation** connects two blocks and passes data on by mapping **Source field** → **Destination field**. A **transformation** adjusts data along the way (e.g. Extract = pull out a single value; Join = combine a list into text).


**I can't save the playbook.**

Most commonly: ‘You must have at least 1 block in the playbook’ — add at least one block in addition to the trigger. Otherwise: click **Validate** and fix all the flagged errors (missing fields, invalid relations) before saving.


**Data isn't landing in the CRM.**

Check that there is a **Create CRM record**/**Update CRM data** block that is connected, that the fields are mapped (Source field → Destination field), and that the portal uses **Playbook** as its CRM strategy.


**How do I link the playbook to a portal?**

On the portal: set **CRM creation strategy** = **Playbook**. Choosing the specific playbook currently happens together with &money — the portal's playbook picker still shows ‘No playbooks available’ and will open soon.


**Do Playbooks replace the old CRM configuration?**

Yes. Playbooks are the way forward and the standard; the old **CRM configuration (standard)** is being phased out and is used only by a few customers during a transition period.


**Can I reuse a playbook?**

Yes — you can **Export**/**Import** a playbook as JSON, and the same playbook can be used on several portals.


**How do I tell that a booking ran the playbook?**

In the playbook list, **Status** (Active/Disabled) and **Last used** show when it last ran. To test, you can use a **Dry run** in the editor. If you suspect a failed run: check **Admin → Logs** or contact &money.


**I can't see Playbooks under Admin.**

Your role is probably not **Admin**, or the CRM connection isn't set up yet. Contact your administrator/&money.


**What should a cancellation playbook (PortalMeetingCancelled) do?**

Typically **update** or **delete** the CRM record that the original booking created, so the CRM is kept up to date. Usually set up together with &money.


**How do I avoid duplicates in the CRM?**

Use **Read CRM data** + **Filter results** to find an existing record before you create a new one (‘find before create’) — or use **Update CRM data** instead of **Create CRM record**.


## Access and roles


**Who can set up Playbooks?**

The **Admin** role — and typically together with &money. Contact your administrator/&money if you lack access or need help.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
