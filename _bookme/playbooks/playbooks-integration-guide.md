---
layout: default
title: Playbooks Integrations
parent: Playbooks
nav_order: 13
---

# Playbooks Integrations

This guide explains how playbook blocks connect to the platform's AI, CRM, and template systems. Each integration follows the same pattern: a block references a configured resource by ID, sends data in, and receives structured results back.

```text
┌──────────────────────────────────────────────────────────┐
│                    PLAYBOOK ENGINE                       │
│                                                          │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐ │
│  │ Trigger │───│  Block  │───│  Block  │───│ Output  │ │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘ │
│       │             │             │              │       │
└───────┼─────────────┼─────────────┼──────────────┼───────┘
        │             │             │              │
    ┌───▼───┐    ┌────▼────┐    ┌───▼────┐    ┌────▼────┐
    │Portal │    │   AI    │    │Entity  │    │Template │
    │Events │    │         │    │Pattern │    │ Engine  │
    └───────┘    └─────────┘    └────────┘    └─────────┘
```

---

## AI Integration

### How Playbooks Use AI

AI blocks send data to a configured **AI capability** for processing — summarization, extraction, classification, email generation, etc. Each AI capability is a model + prompt pair managed under the platform's AI settings.

The flow is:

1. **Capability selection** — each AI block references a specific capability by ID (chosen in the block's **Value** dropdown)
2. **Data input** — relations carry data from earlier blocks into the AI block's input fields
3. **AI processing** — the capability processes the data using its configured model and prompt
4. **Result output** — the AI response becomes the block's output, available to downstream blocks via relations

### Common AI Capabilities

| Capability | What it does |
|-----------|-------------|
| **Meeting summarization** | Generates a concise summary from a meeting transcript |
| **Customer emails** | Drafts customer-facing emails based on meeting summaries or CRM data |
| **Action item extraction** | Identifies next steps and owners from meeting notes |
| **Custom capabilities** | New capabilities can be added on demand for your specific business needs |

### AI Block Configuration

When configuring an AI block in the editor:

1. Set **Block type** to **Ai**
2. Select the AI capability from the **Value** dropdown
3. Optionally select a specific **version** (or leave as default for the latest version)
4. Connect input relations from blocks that provide the data the capability needs (e.g., a transcript from the trigger, attendee names from a CRM read)

The Relation Builder shows which input fields the selected capability expects. Map your source data to these fields using the standard [field mapping workflow]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/#step-7-map-fields-between-blocks).

{: .hint }
AI capabilities can have multiple versions. Pinning a specific version ensures consistent behavior even when a newer version is released. Use **Default** to always run the latest.

---

## Entity Pattern Integration

### How Playbooks Use Entity Patterns

Entity Pattern blocks provide CRM access through a configured **[entity pattern]({{ site.baseurl }}/bookme/entities-and-entity-patterns/)** — a reusable operation blueprint set up under **Admin > Entities**. Each pattern composes one or more entity definitions into a single operation, with field mappings that abstract away CRM-specific details. The same playbook works regardless of which CRM is connected.

For a full explanation of the entity model, see [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/).

### Block Types for CRM Operations

| Block type | Operation | Example use |
|-----------|-----------|-------------|
| **EntityPatternRead** | Fetch records | Look up a customer by email, retrieve opportunity details |
| **EntityPatternFilter** | Add query conditions | Filter by booking ID, date range, or status |
| **EntityPatternCreate** | Create a record | Create a lead, log an activity, store a report |
| **EntityPatternUpdate** | Update a record | Update a case status, write back an AI-generated summary |

### CRM Block Configuration

When configuring an entity pattern block:

1. Set **Block type** to the appropriate type (e.g., EntityPatternRead)
2. Select the entity pattern from the **Value** dropdown
3. Connect input relations to provide search criteria or field values

**Example — reading advisor data from a portal trigger:**

```text
Trigger (PortalMeetings)
  → EntityPatternRead (Advisors)
    Input: Meeting.MeetingOwner.Email → email search parameter
    Output: advisor CRM record (Id, Name, Department, etc.)
```

The Relation Builder dynamically fetches the entity pattern's field structure, so you can browse available input parameters and output fields without guessing.

### Combining Reads and Filters

EntityPatternFilter blocks define query conditions that EntityPatternRead blocks consume. A common pattern:

```text
Trigger → EntityPatternFilter (set filter criteria)
       → EntityPatternRead (fetch filtered results)
```

The filter block's output provides the criteria; the read block uses them to narrow its CRM query.

{: .note }
Each EntityPatternRead block makes a network call to the CRM. Minimize the number of read blocks where possible, and use filters to reduce data volume early in the flow.

---

## Template Integration

### How Playbooks Use Templates

A Template block has a **Kind** setting with two options:

- **Liquid (text)** formats data into structured text using a predefined **template** managed under **Admin > Templates**. Templates contain variables (placeholders) that get replaced with actual data at runtime.
- **PowerPoint (pptx)** builds a presentation from Present slides and fills in their tags. See [PowerPoint Presentations](#powerpoint-presentations) below.

The data for a Template block can come straight from the trigger or from earlier blocks.

Common uses:
- **Customer reports** — format AI analysis results into a readable document
- **Email bodies** — combine meeting details and advisor info into a draft email
- **CRM notes** — structure data before writing it back to a CRM record
- **Customer presentations** — build a PowerPoint deck, and optionally a PDF, with customer details filled in

### Template Block Configuration

When configuring a Template block with Kind **Liquid (text)**:

1. Set **Block type** to **Template**
2. Set **Kind** to **Liquid (text)**
3. Select the template from the **Value** dropdown
4. Connect input relations from the trigger or earlier blocks to provide values for the template's variables

**Example — formatting an AI summary into a report:**

```text
AI block (meeting summary)
  → Template (Customer Report Template)
    Input: summary text, key points, attendee names
    Output: formatted report ready for CRM storage or display
```

The Relation Builder shows which variables the selected template expects. Map your source data to these variables using standard [field mappings]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/#step-7-map-fields-between-blocks).

{: .hint }
Templates are managed separately from playbooks. If you need a new template, create it under **Admin > Templates** first, then select it in your playbook's Template block. For a full guide on creating and managing templates, see [Templates]({{ site.baseurl }}/bookme/templates/).

### PowerPoint Presentations

A playbook can build a PowerPoint presentation from Present slides with a **Template** block with **Kind** set to **PowerPoint (pptx)**. Building the presentation and stopping there is a complete playbook.

If you also need a PDF, add a **Convert** block. It turns a PowerPoint file into a PDF. The file can be the one the Template block just built, or one that is already stored and has a contentRef.

Present slides can contain **[tags]({{ site.baseurl }}/present/tag-mapping/)**, such as `[tag:account_name]`. A tag is a placeholder. The **tag-value** is the real value that is put in the tag's place when the presentation is built.

Neither block passes the file itself. Each produces a **contentRef**, which is a short-lived reference to the stored file. The next block uses the contentRef to read, convert or store the file.

**Build a presentation:**

```text
Trigger
  → Template (Kind: PowerPoint (pptx))
    Input: templates (slides in order), tags (tag-values)
    Output: contentRef (the .pptx)
```

**Build a presentation and a PDF of it:**

```text
Trigger
  → Template (Kind: PowerPoint (pptx))
    Input: templates (slides in order), tags (tag-values)
    Output: contentRef (the .pptx)
  → Convert
    Input: contentRef (the .pptx)
    Output: contentRef (the .pdf)
```

In these examples the Template block's inputs come straight from the trigger. They can also come from earlier blocks. A playbook that builds a presentation can use any trigger. See [Example: the PresentGenerate trigger](#example-the-presentgenerate-trigger) for the simplest case.

#### Configuring a Template block with Kind PowerPoint (pptx)

1. Set **Block type** to **Template**
2. Set **Kind** to **PowerPoint (pptx)**
3. Optionally, add **Template names** to limit which Present templates the block may use. Leave it empty to allow any template. Only templates [uploaded to Present]({{ site.baseurl }}/present/How-to-upload-new-templates/) can be chosen.
4. Connect the inputs, from the trigger or from earlier blocks:
   - **templates** (required) — a list of slides in the order they should appear, each written as `templateName:slideName`. See [How to write a slide](#how-to-write-a-slide).
   - **tags** — the tag-values, as a list where each entry is `{ "name": "<tag>", "values": ["<tag-value>"] }`. Only leave it out, or send an empty list, if the selected slides have no tags.
   - One input per tag is also available if you prefer to connect tag-values one by one. If a tag gets a tag-value both ways, the one from **tags** is used.
5. Connect the **contentRef** output to where the presentation should go: a block that stores the file, the playbook's output, or a Convert block if you also need a PDF

{: .warning }
**Every tag on the selected slides must get a tag-value.** A tag-value may be empty, for example `{ "name": "account_name", "values": [""] }`, and the tag is then replaced with nothing. But the tag must be supplied. If any tag on the selected slides has no tag-value, the presentation is not built and the block fails with an error that names the missing tags.

The block fails, and does not build a partial presentation, when:

- **templates** is missing or empty
- a slide is not written as `templateName:slideName`
- a slide comes from a template that is not in **Template names**
- a tag on the selected slides has no tag-value
- a connected **tags** input has no value at all, or a tag in it has an empty `values` list (use `[""]` for an empty tag-value)

#### How to write a slide

Each entry in **templates** points to one slide as `templateName:slideName`, for example `welcome-deck:cover`.

- **templateName** is the name of the template in Present. These are the same names the **Template names** field offers.
- **slideName** is the name given to the slide in its notes section as `[slide:<slide-name>]`. See [How to set up Master Templates in Present]({{ site.baseurl }}/present/Present-Usage/#how-to-set-up-master-templates-in-present).

Rules:

- The entry is split at the **first** colon. A slide name may contain colons, but a template name may not.
- Spaces around each name are removed. Neither name may be blank.
- Template names must be spelled exactly as in Present, including upper and lower case. If **Template names** is set on the block, the spelling is corrected to match that list.
- The order of the entries is the order of the slides in the presentation.

#### Configuring a Convert block

1. Set **Block type** to **Convert**
2. Connect the **contentRef** of a PowerPoint file to the `contentRef` input. It can come from:
   - a Template block with Kind **PowerPoint (pptx)** that just built the file
   - a PowerPoint file that is already stored and has a contentRef, for example passed in through the trigger
3. Connect the `contentRef` output to the next block

The block produces a new contentRef for the PDF. The original PowerPoint file is not changed. The Convert block has no other settings.

A playbook that only converts an already stored file needs no Template block:

```text
Trigger
    Input: contentRef (a stored .pptx)
  → Convert
    Input: contentRef (the .pptx)
    Output: contentRef (the .pdf)
```

#### Example: the PresentGenerate trigger

A playbook that builds a presentation does not need a special trigger. Any trigger works, as long as the Template block gets its **templates** and tag-values from the trigger or from earlier blocks.

The simplest case is the **PresentGenerate** trigger. It is the trigger used by the generate playbook in the Present playbook bundle. It takes the slides and the tag-values as input, so it can be connected straight to the Template block: `templates` → `templates` and `tags` → `tags`. Its input must have exactly this shape:

```json
{
  "templates": ["welcome-deck:cover", "welcome-deck:agenda"],
  "tags": [
    { "name": "account_name", "values": ["Jane Doe"] }
  ]
}
```

- `templates` must contain at least one slide.
- `tags` must be present. It must have a tag-value for every tag on the selected slides. A tag-value may be empty (`[""]`), but it must be supplied. It can only be an empty list when the selected slides have no tags.
- Any other field is rejected.

Whatever the trigger, building a presentation can take a while. Start the playbook as a job and check its status until it is done. Do not use the synchronous endpoint for this, because it stops after 30 seconds.

{: .note }
The two kinds of the Template block are separate. A Template block with Kind **Liquid (text)** never uses Present. A Template block with Kind **PowerPoint (pptx)** never uses the templates under **Admin > Templates**. The Present Lightning Web Component in Salesforce does not use the Template or Convert block.

---

## Portal Integration

### Portal Events as Triggers

[BookMe portals]({{ site.baseurl }}/bookme/portals/) generate events that trigger playbook execution. Two trigger types respond to portal events:

| Trigger type | When it fires |
|-------------|---------------|
| **PortalMeetings** | A customer books a meeting through a portal |
| **PortalMeetingCancelled** | A portal meeting is cancelled |

### Portal Data Available to Playbooks

When triggered by a portal event, the trigger block provides:

- Meeting ID and metadata (title, dates, type)
- Meeting owner (advisor) information
- External attendees
- Theme and customer category
- Custom fields configured on the portal

Use the Relation Builder on downstream blocks to explore exactly which fields are available — the field structure depends on the portal's configuration and the trigger type selected.

### Portal Scoping

Portal-based triggers can be scoped to specific portals in the trigger block's configuration. If no portals are selected, the playbook responds to events from **all** portals.

---

## Security and Permissions

### Integration Security Model

1. **Service authentication** — each integration uses service accounts with scoped permissions
2. **Data encryption** — all data is encrypted in transit between the playbook engine and integrated services
3. **Scoped access** — entity patterns and AI capabilities enforce their own access controls
4. **Audit logging** — all playbook operations are logged, enabling full tracing and error identification

For details on how CRM data access is secured, see [CRM Integration Security]({{ site.baseurl }}/bookme/onboarding/crm-integration-security/).

---

## Related Documentation

- [Introduction to Playbooks]({{ site.baseurl }}/bookme/playbooks/introduction-to-playbooks/) — concepts, block types, and how playbooks work
- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) — step-by-step instructions for the visual editor
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/) — setting up the portals that trigger playbooks
- [Templates]({{ site.baseurl }}/bookme/templates/) — creating and managing text formatting templates
- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) — the entity model, pattern parts, and how CRM abstraction works
- [CRM Integration Security]({{ site.baseurl }}/bookme/onboarding/crm-integration-security/) — security model for CRM data access
