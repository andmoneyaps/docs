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

Template blocks format data into structured text using a predefined **template** managed under **Admin > Templates**. Templates contain variables (placeholders) that get replaced with actual data at runtime.

Common uses:
- **Customer reports** — format AI analysis results into a readable document
- **Email bodies** — combine meeting details and advisor info into a draft email
- **CRM notes** — structure data before writing it back to a CRM record

### Template Block Configuration

When configuring a Template block:

1. Set **Block type** to **Template**
2. Select the template from the **Value** dropdown
3. Connect input relations to provide values for the template's variables

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

For details on how CRM data access is secured, see [CRM Integration Security]({{ site.baseurl }}/bookme/crm-integration-security/).

---

## Related Documentation

- [Introduction to Playbooks]({{ site.baseurl }}/bookme/playbooks/introduction-to-playbooks/) — concepts, block types, and how playbooks work
- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) — step-by-step instructions for the visual editor
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/) — setting up the portals that trigger playbooks
- [Templates]({{ site.baseurl }}/bookme/templates/) — creating and managing text formatting templates
- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) — the entity model, pattern parts, and how CRM abstraction works
- [Setup Entity Pattern Mappers]({{ site.baseurl }}/embeddable-ui/setup-entity-pattern-mappers/) — operational guide for setting up mappers in a new bank
- [CRM Integration Security]({{ site.baseurl }}/bookme/crm-integration-security/) — security model for CRM data access
