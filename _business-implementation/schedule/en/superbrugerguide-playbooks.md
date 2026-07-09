---
layout: "default"
title: "Super-user guide – Playbooks"
parent: "English"
grand_parent: "Schedule"
nav_order: 207
lang: "en"
---
# Schedule – super-user guide: Playbooks
_Automated flows from booking to CRM · Admin → Playbooks · v1.0 · 11.06.2026_



{: .note }
> **Note:** The screenshots below show the Danish Management UI; English-interface screenshots are being added.

## Purpose and value

A **Playbook** is an automated flow that connects an event (e.g. a customer's booking via a portal) with a series of actions — typically writing booking data to your CRM, but a Playbook can also fetch and enrich data, run AI and much more. Playbooks are the **going-forward standard** for how portals send booking data to the CRM (they replace the old CRM configuration).

{: .note }
> **Note:** Playbooks are a more **advanced** feature under **Admin**. They are typically set up together with &money — this guide gives you the overview, so you can understand and maintain them.

{: .note }
> **Note:** **What you can do yourself / what &money helps with:** As a super-user you can typically understand the flow, rename, **validate**, run a **dry run**, export a backup and read the **Status**/**Last used**. **Building the flow itself** — blocks, AI, CRM field mapping and the portal connection — you do together with &money.

### Glossary
- **Playbook**: An automated flow: a trigger (event) → data blocks → output (e.g. CRM).
- **Trigger (Starter)**: The event that sets the flow in motion — e.g. ⟦PortalMeetings⟧ (a customer books via a portal).
- **Block**: A step in the flow that does one thing (e.g. reads CRM data, creates a CRM record or runs AI).
- **Relation**: The connection between two blocks — it carries fields forward (⟦Source field⟧ → ⟦Destination field⟧).
- **Transformation**: An adjustment of data along the way (e.g. pull out one value, or join a list into text).


## Audience and prerequisites

- Audience: administrator (role **Admin**) — typically together with &money.
- Your **CRM connection** is set up, and the relevant CRM objects/fields exist.
- The **portal** that will use the playbook exists (or is created), see the **Portals** guide.
- Playbooks are accessed under **Admin → Playbooks**.


## What you get out of it

After this guide you can:

- Understand what a Playbook is, and how it fits together with a portal.
- Create a playbook, choose a trigger and add blocks.
- Connect blocks with relations and transformations.
- Validate, save and link the playbook to a portal — and troubleshoot the most common issues.


## Overview (order)

- Step 1: Create the playbook (name + **trigger**).
- Step 2: Add **blocks** (what the flow should do).
- Step 3: Connect the blocks (**relations** + optional **transformations**).
- Step 4: **Validate** and **save**.
- Step 5: Link the **portal** to the playbook.


## Step-by-step (Management UI)


### Step 1 · Create a playbook

_Why: Start the flow by giving it a name and choosing what should trigger it._

- Go to **Admin** → **Playbooks** → click **Create**.
- Fill in **Name**.
- Choose **Trigger type** — for portals typically **PortalMeetings** (triggered when a customer books via a portal).
- The playbook opens in the visual editor with the **Starter** block at the top.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-playbooks/sched_playbook_opret.png)

*Screenshot 1 (Management UI) — Admin → Playbooks → **Create** — name + trigger (e.g. PortalMeetings)*

{: .hint }
> ✓ **How you know it worked:** The playbook is created and appears in the list with a count of **Blocks**, **Last used** and **Status**.


### Step 2 · Add blocks

_Why: The blocks are the steps the flow carries out — e.g. fetching CRM data and creating a CRM record._

- Click **Add block**.
- Choose a **Block type** (see the ‘Block types’ table below) and a **Value** (the specific resource, e.g. which CRM object or which AI capability), and give the block a **Name**.
- Add the blocks the flow needs. You can **Move up**/**Move down**, **Edit block** and **Remove block**.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-playbooks/sched_playbook_editor.png)

*Screenshot 2 (Management UI) — Playbook editor — blocks on the canvas (Starter → data blocks → CRM)*

{: .important }
> **Remember:** A playbook must have **at least one block** besides the starter — otherwise it cannot be saved (‘You must have at least 1 block in the playbook’).


### Step 3 · Connect the blocks (relations + transformations)

_Why: The relations carry data from one block to the next — and can adjust the data along the way._

- Drag a **relation** from one block to the next.
- On the relation you map a **Source field** (from the previous block) to a **Destination field** (on the next block), e.g. meeting date → a CRM field.
- Optionally add a **Transformation** if the data needs adjusting (see the ‘Transformations’ table).


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-playbooks/sched_playbook_blok.png)

*Screenshot 3 (Management UI) — Block configuration — **Block type**, **Value** and field mapping (Source field → Destination field)*


### Step 4 · Validate and save

_Why: Check the flow for errors before you save._

- Click **Dry run** to test the flow with sample data, without writing to the CRM.
- Click **Validate** — fix any flagged errors (missing fields, invalid relations).
- Click **Save** (you can also use Ctrl/Cmd+S). Confirmation: **Playbook created** / **Playbook updated**.
- You can **Export**/**Import** a playbook as JSON to reuse it.

{: .hint }
> ✓ **How you know it worked:** The playbook is validated and saved — ready to be linked to a portal.


### Step 5 · Link the portal to the playbook

_Why: Finally, the portal needs to use the playbook to send data to the CRM._

- Open the portal (**Schedule → Portals**).
- Set **CRM Creation Strategy** = **Playbook**.
- Choosing the specific playbook is currently done together with &money — the portal's Playbook selector still shows ‘No playbooks available’ and opens soon.

{: .hint }
> ✓ **How you know it worked:** The portal now sends booking data to the CRM via the playbook.

**Example (like the demo playbook ‘Portal meeting’):** Trigger **PortalMeetings** → **Read CRM data** (find the customer, advisor and topic) → **Filter results** → **Create CRM record** (the meeting itself), optionally **Format with template**. Each arrow is a relation that maps fields forward.


## Confirm that the playbook runs

On the playbook list you see whether a playbook is **Active** or **Deactivated** (**Status**), and when it last ran (**Last used**). To test a flow the editor has **Dry run**. If you suspect a failed run, you can check **Admin → Logs** — or contact &money.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-playbooks/sched_playbooks_liste.png)

*Screenshot 4 (Management UI) — Admin → Playbooks — the list with **Status** (Active/Deactivated) and **Last used***


## Block types


| Block (add action) | What it does |
|---|---|
| Starter (trigger) | The start event that sets the flow in motion (e.g. a portal booking). |
| Run AI | Process data with an AI capability — e.g. insights, summaries or decisions. |
| Format with template | Structure data into a consistent, readable format. |
| Read CRM data | Fetch records from the CRM for use further in the flow. |
| Filter results | Narrow down CRM records by setting conditions. |
| Create CRM record | Create a new record in the CRM from data in the flow. |
| Update CRM data | Update an existing CRM record with data from the flow. |
| Generate file / Switch / etc. | Generate a file, control the flow with rules, or deliver/dispatch data. |

{: .note }
> **Note:** The common CRM/AI blocks (Read CRM data, Create/Update CRM record, Filter results, Run AI, Format with template) cover the vast majority of portal flows. **Switch**, **Generate file** and advanced transformations (Serialize/Base64Decode) are for more complex flows — typically together with &money.


## Transformations


| Transformation | What it does |
|---|---|
| Identity | Passes data through unchanged. |
| Extract | Picks one value via a path (e.g. Meeting.Title). |
| Project | Keeps only selected fields. |
| Join | Joins a list into a single text (e.g. A, B, C). |
| Split | Splits a text into a list. |
| Serialize | Converts to JSON text. |
| Base64Decode | Decodes Base64 into plain text. |


## Triggers (events)

- **PortalMeetings** — a customer books a meeting via a portal (the usual one for portals).
- **PortalMeetingCancelled** — a portal booking is cancelled.
- Others exist (e.g. customer overview, transcription ready, meeting finished) for other flows.


## Troubleshooting

- ‘You must have at least 1 block in the playbook’: add at least one block besides the starter.
- ‘Cannot save … validation errors’: click **Validate**, and fix all flagged errors (missing fields, invalid relations) before you save.
- The transformation doesn't work: the types have to match (e.g. **Join** requires a list as input). Validation catches mismatches.
- Data doesn't land in the CRM: check that a **Create/Update entity** block is connected, that the fields are mapped (Source field → Destination field), and that the portal uses **Playbook** as its strategy.
- I can't choose the playbook on the portal: the portal's Playbook selector opens soon — the link is currently done together with &money.
- I can't see **Playbooks** under Admin: your role is not **Admin**, or the CRM connection is not set up → contact your administrator/&money.
- ‘The block has no value’ / a required CRM field is empty at **Create CRM record**: because a source field is missing or not mapped → add/fix the mapping (Source field → Destination field).
- **Import** of JSON is rejected: because the JSON is invalid or from another version → export a fresh JSON, or contact &money.


## Latest update

- 11.06.2026 (v1.0) — First version (Playbooks).


{: .hint }
> ✅ **Done!** The playbook is built, validated, saved and linked to the portal.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
