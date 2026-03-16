---
layout: default
title: Playbooks User Guide
parent: Playbooks
nav_order: 12
---

# Playbooks User Guide

This guide walks you through creating, configuring, and managing playbooks using the visual editor in the &Money Management UI.

## Getting Started

### Prerequisites

- Admin access to the Management UI
- An understanding of the business workflow you want to automate
- Any required resources already configured: AI capabilities, entity patterns, templates, and portals

### Accessing Playbooks

1. Log in to the Management UI
2. Click **Admin** in the left sidebar
3. Select **Playbooks** from the admin menu

The Playbooks page shows all existing playbooks with their names, block counts, and action buttons.

![Playbooks list]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/playbooks-list.png)

From here you can:
- **Create in Graph** — build a new playbook in the visual editor
- **Edit in Graph** — open an existing playbook in the visual editor
- **Export** — download a playbook as JSON for backup or transfer
- **Import** — upload a previously exported playbook
- **Delete** — permanently remove a playbook

---

## The Visual Editor

The visual editor displays your playbook as an interactive graph. Blocks appear as nodes, and data connections appear as edges between them.

![Visual editor overview]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-canvas-overview.png)

### Editor Layout

| Area | Location | What it does |
|------|----------|--------------|
| **Toolbar** | Top | Playbook name, Import, Export, Add block, Validate, and Save |
| **Canvas** | Center | The interactive graph where you build your workflow |
| **Canvas controls** | Bottom-left | Zoom in/out, Fit view, Toggle interactivity, Auto-layout |
| **Minimap** | Bottom-right | Overview of the entire graph for quick navigation |

### Canvas Navigation

| Action | How |
|--------|-----|
| Pan | Click and drag on empty canvas space |
| Zoom | Scroll wheel, or use the +/- buttons |
| Fit view | Click the fit-view button to zoom to show all blocks |
| Auto-layout | Click the auto-layout button to automatically arrange the graph |

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| **Ctrl+S** / **Cmd+S** | Save the playbook |
| **Delete** / **Backspace** | Delete the selected block |

---

## Creating a Playbook from Scratch

### Step 1: Open the Editor

Click **"Create in Graph"** on the Playbooks page. A new editor opens with a single **Trigger** block and suggested next blocks below it.

![New playbook with trigger and suggestions]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-new-playbook.png)

The suggestions show common block types you might add after the trigger — click one to add it directly, or use the **"+ Add block"** button in the toolbar.

### Step 2: Name Your Playbook

Enter a clear, descriptive name in the **Name** field at the top — for example, *"Portal Meeting — Lead Creation"* or *"Customer Overview Report"*.

### Step 3: Configure the Trigger

Click the Trigger block to expand it and reveal the configuration form.

![Trigger block expanded]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-trigger-expanded.png)

1. **Trigger Type** — select the event that starts the playbook:
   - **PortalMeetings** — fires when a meeting is booked through a portal
   - **PortalMeetingCancelled** — fires when a portal meeting is cancelled
   - **CustomerOverview** — fires when a customer overview is requested
   - **TranscriptReady** — fires when a meeting transcript is ready
   - **MeetMeetingEnded** — fires when a Meet video meeting ends
2. **Name** — give the trigger a descriptive name (e.g., *"Portal Meeting Trigger"*)
3. **Portal selection** (PortalMeetings and PortalMeetingCancelled only) — choose which portals this playbook responds to. If none are selected, it responds to all portals.

{: .hint }
The trigger block determines what data is available to the rest of the playbook. A PortalMeetings trigger provides meeting details (title, dates, advisor info, attendees, theme, customer category, custom fields), while a CustomerOverview trigger provides only an account ID. A TranscriptReady trigger provides the transcript content, meeting ID, and transcript ID. Use the Relation Builder to explore exactly which fields are available for each trigger type.

### Step 4: Add Blocks

Build your workflow by adding blocks. Each block performs a specific task:

| Block Type | What it does |
|-----------|--------------|
| **AI** | Process data with an AI capability (summarization, extraction, etc.) |
| **EntityPatternRead** | Fetch records from the CRM |
| **EntityPatternCreate** | Create new records in the CRM |
| **EntityPatternUpdate** | Update existing CRM records |
| **EntityPatternFilter** | Add filter conditions for entity queries |
| **Template** | Format data using a predefined template |

**To add a block:**
1. Click **"+ Add block"** in the toolbar, or click a suggested block below the trigger
2. Click the new block to expand it
3. Select its **Block Type** from the dropdown
4. Select its **Value** — the specific capability, entity pattern, or template to use
5. Give it a descriptive **Name**

Blocks execute in order from top to bottom. The number badge on each block shows its position in the execution order.

### Step 5: Connect Blocks with Relations

Relations define how data flows from one block to the next. When you expand a block, you'll see **Inputs** and **Outputs** sections at the bottom.

![Block with input and output connections]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-block-connections.png)

**To create a connection:**

1. Click the **destination block** (the block that needs data) to expand it
2. Click **"Connect from..."** in the Inputs section
3. Choose the **source block** from the menu — only blocks earlier in the flow are listed
4. A new empty relation appears — configure the **source field** and **destination field**

Each relation has:
- **Source field** — the output field from the source block (where the data comes from)
- **Destination field** — the input field on the destination block (where the data goes)

{: .note }
A block can have multiple input relations from different source blocks. This lets you combine data from several sources into a single block.

### Step 6: Use the Relation Builder to Select Fields

When configuring source or destination fields, you can use the **Relation Builder** — a visual tool for navigating a block's data structure.

1. Click the **field picker icon** next to the source or destination field
2. The Relation Builder modal opens, showing the block's available fields in a tree
3. Click a field to navigate into it. For nested objects, keep clicking to drill deeper.
4. For **array fields**, choose:
   - **First** — selects the first item (adds `[0]` to the path)
   - **All** — selects every item in the array
5. Click **Apply** to set the selected path

The builder generates a dot-notation path automatically. For example, navigating into `Meeting` → `ExternalAttendees` (First) → `Email` produces the path `Meeting.ExternalAttendees[0].Email`.

### Step 7: Add Transformations to Relations

Transformations modify data as it passes through a relation. You can chain multiple transformations — each one receives the output of the previous.

**To add a transformation:**

1. Expand a block and locate an input relation
2. Click the **"+ Add"** button on the relation to add a transformation
3. Select the transformation type

Here are the available types with practical examples:

#### Identity
Passes data through unchanged. This is the default — use it when the source field maps directly to the destination field with no modification needed.

#### Extract
Picks a single value out of a nested object.

**Example:** Your trigger provides a complex meeting object, but the AI block only needs the meeting title.

| | |
|---|---|
| **Source data** | `{ Meeting: { Title: "Q1 Review", Date: "2026-03-15", Room: { Name: "Room A" } } }` |
| **Extract path** | `Meeting.Title` |
| **Result** | `"Q1 Review"` |

#### Project
Keeps only specific fields from an object, dropping everything else.

**Example:** A CRM read returns a full contact record, but you only need the name and email.

| | |
|---|---|
| **Source data** | `{ Name: "Jane Doe", Email: "jane@example.com", Phone: "+45...", Address: "..." }` |
| **Project paths** | `Name, Email` |
| **Result** | `{ Name: "Jane Doe", Email: "jane@example.com" }` |

#### Join
Combines array elements into a single text string using a separator.

**Example:** An entity pattern returns a list of attendee names, and you need them as a single comma-separated string for a template.

| | |
|---|---|
| **Source data** | `["John Smith", "Jane Doe", "Bob Wilson"]` |
| **Separator** | `, ` |
| **Result** | `"John Smith, Jane Doe, Bob Wilson"` |

Separator presets: Comma (`, `), Comma no space (`,`), Semicolon (`; `), Space, Newline, Pipe (` | `), or custom.

#### Split
Divides a text string into an array.

**Example:** A field contains comma-separated email addresses that you need to process individually.

| | |
|---|---|
| **Source data** | `"john@example.com, jane@example.com"` |
| **Separator** | `, ` |
| **Result** | `["john@example.com", "jane@example.com"]` |

#### Serialize
Converts an object to a JSON text string.

**Example:** You need to pass structured data as a text input to an AI capability.

| | |
|---|---|
| **Source data** | `{ Name: "Jane", Role: "Advisor" }` |
| **Result** | `'{"name":"Jane","role":"Advisor"}'` |

#### Base64Decode
Decodes Base64-encoded text back to a readable string.

| | |
|---|---|
| **Source data** | `"SGVsbG8gV29ybGQ="` |
| **Result** | `"Hello World"` |

{: .important }
Transformations have compatibility rules. Extract and Project require an **object** as input. Join works on **arrays**. Split and Base64Decode work on **text**. The editor shows warnings if you chain incompatible transformations.

### Step 8: Validate

Click **"Validate"** in the toolbar to check your playbook for issues.

![Validation results]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-validation.png)

The validator checks for:
- Missing required fields (block type, block value, name)
- Invalid or incomplete relations
- Configuration errors

After validation:
- **Green badges** — the block passed validation
- **Red badges** with an error count — issues that must be fixed
- **Edge styling** — problematic connections are highlighted

{: .warning }
All validation errors must be fixed before you can save. The Save button automatically runs validation and will not proceed if there are errors.

### Step 9: Save

Click **"Save"** (or press **Ctrl+S** / **Cmd+S**). For new playbooks, the button reads **"Create Playbook"**.

The editor stays open after saving, so you can continue editing.

---

## Real-World Example: Portal Meeting Lead Creation

This example walks through building a playbook that automatically creates a CRM lead record when a meeting is booked through a portal.

### The workflow

```
Portal meeting booked
  → Trigger (PortalMeetings)
  → EntityPatternFilter (filter by booking ID)
  → EntityPatternRead (fetch advisor data)
  → EntityPatternCreate (create lead in CRM)
```

### Step-by-step

1. **Create a new playbook** and name it *"Portal Meeting — Lead Creation"*

2. **Configure the trigger:**
   - Trigger Type: **PortalMeetings**
   - Name: *"Portal Meeting Trigger"*
   - Select the portal(s) this should apply to

3. **Add an EntityPatternFilter block:**
   - Name: *"Filter by Booking ID"*
   - Value: Configure with Field: `BookingId`, Operator: `Equals`, Value: `placeholder`
   - This filter will be used by the read block to find the right record

4. **Add an EntityPatternRead block:**
   - Name: *"Read Advisor"*
   - Value: Select the advisor entity pattern
   - Add an input relation **from the Trigger block**:
     - Source field: use the Relation Builder to navigate to `Meeting.MeetingOwner.Email`
     - Destination field: the email search parameter
   - This fetches the advisor's CRM record using the email from the trigger data

5. **Add an EntityPatternCreate block:**
   - Name: *"Create Lead"*
   - Value: Select the lead entity pattern
   - Add input relations from both the **Trigger** and **Read Advisor** blocks:
     - Map meeting title, dates, and attendee info from the trigger
     - Map the advisor's CRM ID from the read block

6. **Validate and save**

### How the portal connection works

When a customer books a meeting through a BookMe portal:

1. The portal fires a **PortalMeetings** event containing all meeting details
2. The playbook engine matches the event to playbooks whose trigger type is `PortalMeetings` and whose portal selection includes that portal
3. The trigger block receives the meeting data and makes it available as output fields
4. Downstream blocks pull the data they need via relations — for example, extracting `Meeting.MeetingOwner.Email` to look up the advisor in the CRM
5. The playbook executes blocks in order, with each block able to use data from any previous block

{: .hint }
The data available from a portal trigger depends on the portal's configuration. Use the Relation Builder to explore exactly which fields are available — it dynamically fetches the field structure from the server based on your trigger type and selected portals.

---

## Real-World Example: Customer Overview with AI

This example shows a more complex playbook that gathers CRM data, runs AI analysis, and produces a formatted report.

### The workflow

```
Customer overview requested
  → Trigger (CustomerOverview)
  → EntityPatternRead (fetch opportunities)
  → EntityPatternRead (fetch interactions)
  → EntityPatternRead (fetch cases)
  → AI (analyze and summarize)
  → Template (format report)
  → EntityPatternCreate (store report)
```

![Complex playbook]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/editor-complex-playbook.png)

### Key patterns in this playbook

**Multiple parallel reads:** Several EntityPatternRead blocks all pull from the trigger's account ID but query different CRM entities (opportunities, interactions, cases). They all receive data from the same trigger block.

**AI processing:** The AI block receives data from multiple read blocks. Its input relations use **Project** transformations to select only the fields the AI capability needs, keeping the payload focused.

**Template formatting:** The Template block takes the AI output and structures it into a human-readable format using a predefined template.

**Final storage:** An EntityPatternCreate block saves the finished report back to the CRM, linking it to the customer's account.

---

## Editing an Existing Playbook

1. From the Playbooks list, click **"Edit in Graph"** on the playbook
2. The editor loads all blocks and connections onto the canvas
3. Click any block to expand and modify it
4. Add, remove, or reconnect blocks as needed
5. Click **Save** when finished

{: .note }
If you have unsaved changes and try to leave the editor, you'll be asked whether to save, discard, or cancel.

---

## Managing Blocks

### Reordering Blocks

Blocks execute in the order shown (top to bottom). To change execution order:

1. Click a block to select it
2. Use the **up/down arrow buttons** next to the block's order number

{: .warning }
The Trigger block must always remain at position 1 and cannot be moved.

### Deleting Blocks

1. Click a block to select it
2. Click the **delete icon** on the block header, then confirm with **"Delete?"**

Or select a block and press **Delete** / **Backspace**.

When a block is deleted, all its relations (incoming and outgoing) are automatically cleaned up.

---

## Import and Export

### Exporting

1. Open a playbook in the editor
2. Click the **Export** button (down-arrow icon) in the toolbar
3. Copy the JSON or download it

Exports are fully portable — they include all block configurations, relations, transformations, and resource definitions (templates, entity patterns). You can use exports to transfer playbooks between environments or as backups.

### Importing

1. Click the **Import** button (up-arrow icon) in the toolbar
2. Paste the exported JSON
3. Click **Import**

**In create mode** (new playbook): The import replaces the current canvas entirely.

**In edit mode** (existing playbook): Imported blocks are appended after existing blocks. Their internal connections are cleared — reconnect them to the existing flow using the relation tools.

{: .note }
Import automatically handles resource provisioning. If the imported playbook references templates, entity patterns, or AI capabilities that don't exist in the target environment, the import endpoint creates them based on the embedded resource definitions.

---

## AI Block: Capability Versions

AI capabilities can have multiple versions. When configuring an AI block:

- **Default** — uses the latest version (recommended for most cases)
- **Specific version** — pin a particular version to ensure consistent behavior even when a newer version is released

The version selector appears after you choose an AI capability that has multiple versions available.

---

## End-to-End Tutorial: Building a Playbook Step by Step

This walkthrough creates a simple "Portal Meeting — Lead Creation" playbook from scratch, demonstrating every major feature of the visual editor along the way.

### 1. Open the Editor

From the Playbooks list, click **"Create in Graph"**.

![Playbooks list]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-playbooks-list.png)

A new editor opens with a toolbar at the top, a single Trigger block on the canvas, and suggested next blocks below it.

![New playbook canvas]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-new-canvas.png)

The toolbar provides quick access to all editor actions:

![Editor toolbar]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-toolbar.png)

### 2. Name and Configure the Trigger

Enter a name for the playbook in the **Name** field — for example, *"Portal Meeting — Lead Creation"*.

Then click the Trigger block to select it. When selected, the block expands to show its name, description, and a header with controls: **order arrows** (to move the block up or down), a **pencil icon** (to enter edit mode), and a **delete icon** (for non-trigger blocks).

Click the **pencil icon** to enter edit mode. The block now shows a configuration form:

![Trigger configuration]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-trigger-config.png)

Configure the trigger:
- **Block type** — already set to *Trigger* (cannot be changed)
- **Trigger type** — select *PortalMeetings* from the dropdown
- **Name** — enter *"Portal Meeting Trigger"*
- **Choose portals** — optionally select which portals this playbook responds to

Click the **green checkmark** to confirm your changes and exit edit mode.

### 3. Add an EntityPatternRead Block

Click **"+ Add block"** in the toolbar. A new empty block appears below the trigger.

Click the new block to select it — the editor automatically enters edit mode for new blocks. Configure it:

1. Set **Block type** to *EntityPatternRead*
2. Select a **Value** — this is the entity pattern to query (e.g., *"Advisors"*)
3. Enter a **Name** — e.g., *"Read Advisor"*

### 4. Connect Blocks

With the Read Advisor block still open, click **"Connect from..."** in the Inputs section. A menu lists all blocks earlier in the flow — select **"Portal Meeting Trigger"**.

A new input relation appears, and a connection edge is drawn between the blocks on the canvas:

![Connected blocks]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-block-connected.png)

The dashed red edge with a *"Click to configure"* label indicates an incomplete relation — you still need to map which fields flow between the blocks.

### 5. Build the Complete Flow

Continue adding blocks to complete the workflow. In this example, add an **EntityPatternCreate** block named *"Create Lead"* and connect it to both the Trigger and the Read Advisor blocks.

After clicking **Auto-layout** (bottom-left controls), the editor arranges the graph automatically:

![Flow overview]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-flow-overview.png)

Each block shows its type, name, and current validation status. The number badge indicates execution order.

### 6. Validate

Click **"Validate"** in the toolbar. The editor checks every block and relation for issues:

![Validation results]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-validation.png)

- **Red badges** with error counts appear on blocks that have issues
- **Red-bordered blocks** need attention before saving
- **Green badges** appear on blocks that pass validation

Fix any errors by entering edit mode on the flagged blocks, completing missing fields, and configuring relation mappings. Then validate again until all blocks show green.

### 7. Save

Once validation passes, click **"Create Playbook"** (or **"Save"** when editing an existing playbook). The editor stays open so you can continue making changes.

### What a Complete Playbook Looks Like

Here is a real-world customer overview playbook with 21 blocks — multiple CRM reads, AI processing, template formatting, and final storage:

![Complex playbook]({{ site.baseurl }}/assets/images/bookme/playbooks/editor/tut-complex-playbook.png)

This demonstrates how playbooks scale to handle complex workflows while remaining visually navigable through the graph editor.

---

## Tips and Best Practices

### Planning

- **Define the goal first** — what should the playbook accomplish?
- **Identify data sources** — what CRM entities, AI capabilities, and templates are needed?
- **Sketch the flow** — map out which blocks connect to which before building

### Building

- **Name blocks clearly** — *"Read Advisor by Email"* is better than *"EntityPatternRead 1"*
- **Start simple** — get a minimal flow working, then add complexity
- **Validate often** — run validation after adding blocks or relations to catch issues early
- **Use auto-layout** — keeps the graph readable as it grows

### Performance

- **Minimize CRM queries** — each EntityPatternRead is a network call; combine where possible
- **Use filters** — EntityPatternFilter blocks reduce the data volume early in the flow
- **Keep transformation pipelines short** — only transform data that actually needs modification

---

## Related Documentation

- [Introduction to Playbooks]({{ site.baseurl }}/bookme/playbooks/introduction-to-playbooks/) — concepts, block types, and transformation reference
- [Playbooks Integrations]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/) — AI, CRM, and template integration details
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/) — setting up the portals that trigger playbooks
