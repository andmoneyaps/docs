---
layout: default
title: Introduction to Playbooks
parent: Playbooks
nav_order: 11
---

# Introduction to Playbooks

## What are Playbooks?

Playbooks are automation workflows that run when specific events happen — like a customer booking a meeting or a transcript becoming available. Each playbook is a visual graph of connected **blocks**, where each block performs one task (call an AI model, read CRM data, format a template) and passes its result to the next block.

You build playbooks in a drag-and-drop visual editor. No code is required.

### What you can automate

- **Meeting intelligence** — when a meeting ends, automatically transcribe it, generate an AI summary, and save the summary to the CRM
- **Lead creation** — when a customer books through a portal, automatically create a lead record with the meeting details
- **Customer reports** — gather data from multiple CRM entities, run AI analysis, and produce a formatted report

---

## How a Playbook Works

Every playbook follows the same pattern:

```
Event happens  →  Trigger fires  →  Blocks execute in order  →  Result written
```

1. **An event triggers the playbook** — something happens in the platform (a customer books a meeting, a transcript is ready, a video call ends) and the playbook's trigger block activates
2. **Blocks run in sequence** — each block performs one task and produces output, which becomes available to all blocks that come after it
3. **Data flows through connections** — you connect blocks by drawing relations between them, mapping specific fields from one block to the next. You can apply transformations (extract a nested value, join an array, etc.) as data flows
4. **The result is written** — the final blocks typically write data to the CRM, generate a formatted report, or store processed results

---

## Block Types

Each block in a playbook performs a single task. When you add a block, you choose its **type** (what it does) and its **value** (which specific resource it uses). Here are the seven block types and what they connect to.

### Trigger

Every playbook has exactly one Trigger block at position 1. It determines **when** the playbook runs and **what data** it starts with. You configure the trigger type and — for portal triggers — which portals it responds to. The trigger's output fields become the starting data for the rest of the playbook.

See [Triggers](#triggers) below for the full list of trigger types and the data each one provides.

### Ai

An AI block sends data to an **AI capability** — a configured model + prompt pair that performs a specific task. You select which capability to use from the block's Value dropdown.

**What's behind it:** AI capabilities are configured under the platform's AI settings. Each capability defines a model (e.g., GPT-4), a system prompt, and the input/output field structure. Capabilities can have multiple versions — you can pin a specific version or always use the latest.

**In a playbook:** Earlier blocks provide the input data (e.g., a transcript from the trigger, attendee names from a CRM read). The AI processes it and returns structured output (e.g., a summary, action items, a draft email) that downstream blocks can use.

**Example use cases:** Summarise a meeting transcript, extract action items, draft a customer email, classify a support case.

For integration details, see [AI Integration]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/#ai-integration).

### EntityPatternRead

An EntityPatternRead block fetches records from the CRM using a configured **[entity pattern]({{ site.baseurl }}/bookme/entities-and-entity-patterns/)**.

**What's behind it:** Entity patterns are reusable CRM operation blueprints configured under **Admin > Entities**. Each pattern composes one or more entity definitions (Account, Contact, Event, etc.) into a single operation, with field mappings that translate between abstract field names and CRM-specific names. This means the same playbook works regardless of whether your CRM is Salesforce, Dynamics, or another supported system.

**In a playbook:** You select which entity pattern to use, then connect input relations to provide search criteria (e.g., an email address from the trigger). The block queries the CRM and returns matching records as structured output.

**Example use cases:** Look up a customer by email, fetch open opportunities for an account, retrieve advisor details.

### EntityPatternFilter

An EntityPatternFilter block adds **query conditions** that EntityPatternRead blocks consume.

**What's behind it:** Uses the same [entity pattern system]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) as Read blocks, but instead of executing a query, it defines filter criteria (field, operator, value) that narrow down results.

**In a playbook:** Typically placed before a Read block. The filter's output provides criteria that the Read block uses to narrow its CRM query. This keeps large datasets manageable by filtering early in the flow.

**Example use cases:** Filter by booking ID, date range, status, or customer category.

### EntityPatternCreate

An EntityPatternCreate block creates a **new record** in the CRM.

**What's behind it:** Uses [entity patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) to map playbook data to CRM fields. The pattern defines which entity to create (lead, activity, note, etc.) and how each field maps to the CRM schema.

**In a playbook:** Connect input relations from earlier blocks to provide the field values — meeting details from the trigger, advisor info from a Read block, a summary from an AI block. The block creates the record and returns the new record's ID.

**Example use cases:** Create a lead when a meeting is booked, log an activity after a call, store an AI-generated report.

### EntityPatternUpdate

An EntityPatternUpdate block updates an **existing CRM record**.

**What's behind it:** Same [entity pattern system]({{ site.baseurl }}/bookme/entities-and-entity-patterns/), but targets an existing record by ID rather than creating a new one.

**In a playbook:** You provide the record ID (from a previous Read or Create block) and the fields to update. The block writes the changes back to the CRM.

**Example use cases:** Update a case status, write back an AI-generated summary to a contact record, mark a lead as contacted.

### Template

A Template block formats data into structured text using a predefined **[template]({{ site.baseurl }}/bookme/templates/)**.

**What's behind it:** Templates are managed under **Admin > Templates**. Each template is written in [Liquid syntax](https://shopify.github.io/liquid/) with variable placeholders (e.g., `{% raw %}{{ customerName }}{% endraw %}`, `{% raw %}{{ summary }}{% endraw %}`) that get replaced with actual data at runtime. The editor automatically detects variables and shows them as chips, so you can verify the template before using it in a playbook.

**In a playbook:** Connect input relations to provide values for the template's variables. The block produces formatted text as its output — ready to be stored in the CRM, included in an email, or displayed as a report.

**Example use cases:** Format an AI summary into a customer-facing report, structure meeting details into a CRM note, generate an email body.

For the full template guide, see [Templates]({{ site.baseurl }}/bookme/templates/). For playbook integration details, see [Template Integration]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/#template-integration).

---

## Relations and Transformations

### Relations (connections)

Relations are the lines between blocks on the canvas. Each relation carries one or more **field mappings** — paths that say "take this field from block A and send it to this field on block B."

### Transformations

Transformations modify data as it flows through a relation. For example, you might **Extract** a single value from a nested object, **Join** an array into a comma-separated string, or **Serialize** an object to JSON text.

---

## Triggers

The trigger block determines when the playbook runs and what data it starts with.

| Trigger | When it fires | What data you get |
|---------|---------------|-------------------|
| **PortalMeetings** | A customer books a meeting through a [BookMe portal]({{ site.baseurl }}/bookme/portals/) | Meeting title, dates, advisor info, attendees, theme, customer category, custom fields |
| **PortalMeetingCancelled** | A portal meeting is cancelled | Meeting ID, portal ID, who cancelled, reason |
| **CustomerOverview** | A customer overview is requested | Account ID |
| **TranscriptReady** | A recorded meeting's transcript becomes available | Meeting ID, transcript content, transcript ID |
| **MeetMeetingEnded** | An [&Money Meet]({{ site.baseurl }}/meet/) video meeting ends | Meeting ID and meeting context |

Portal-based triggers (PortalMeetings, PortalMeetingCancelled) can be scoped to specific portals — only meetings from selected portals will activate the playbook.

---

## Next Steps

- **Ready to build?** Follow the [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) for step-by-step instructions
- **Need integration details?** See [Playbooks Integrations]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/) for AI, CRM, and template specifics
