---
layout: default
title: Introduction to Playbooks
parent: Playbooks
nav_order: 11
---

# Playbooks

## Introduction

Playbooks are automation workflows in the &Money platform that orchestrate business processes by connecting blocks through a visual editor. They enable automated data processing, integration with AI capabilities, and CRM interactions — all without writing code.

## What are Playbooks?

A playbook is a directed graph of interconnected blocks that defines an automated workflow. Each playbook consists of:

- **Blocks** — individual processing units that perform specific tasks (AI processing, CRM operations, templating, and more)
- **Relations** — connections between blocks that define how data flows through the workflow
- **Transformations** — data manipulation operations applied to data as it moves between blocks

### Key Benefits

- **No-code automation**: Create complex workflows through visual configuration
- **Flexible integration**: Connect AI, CRM, and template services seamlessly
- **Data orchestration**: Transform and route data between systems automatically
- **Trigger-based execution**: Respond to events like portal meetings, cancellations, and transcripts

### Common Use Cases

- **Meeting intelligence** — process meeting data, generate AI summaries, and update CRM records automatically
- **Customer overviews** — gather data from multiple CRM entities, run AI analysis, and produce structured reports
- **Data synchronization** — keep CRM systems up to date with meeting activities and communications

## How Playbooks Work

### Architecture Overview

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Trigger   │────>│   Playbook   │────>│   Result    │
│   Event     │     │   Engine     │     │  (CRM/File) │
└─────────────┘     └──────────────┘     └─────────────┘
                            │
                ┌───────────┼───────────┐
                v           v           v
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │          │ │   CRM    │ │ Template │
        │  AI/ML   │ │ (Entity  │ │  Engine  │
        │          │ │ Patterns)│ │          │
        └──────────┘ └──────────┘ └──────────┘
```

### Execution Process

1. **Trigger activation** — an event (portal meeting booking, transcript ready, API call) initiates the playbook
2. **Sequential processing** — blocks execute in their defined order, top to bottom
3. **Data flow** — data passes between blocks through relations, with transformations applied as configured
4. **Context management** — the execution context maintains state and data throughout the workflow
5. **Result** — the final blocks write to the CRM, generate files, or produce output

## Block Types Reference

Each block type serves a specific purpose in the workflow:

### Trigger

**Purpose**: Initiates playbook execution based on events.
Every playbook must have exactly one trigger block as its first block.

**Available trigger types**:

| Trigger | When it fires | Key data provided |
|---------|---------------|-------------------|
| **PortalMeetings** | A meeting is booked through a portal | Meeting ID, title, dates, advisors, attendees, theme, customer category, custom fields |
| **PortalMeetingCancelled** | A portal meeting is cancelled | Meeting ID and cancellation context |
| **CustomerOverview** | A customer overview is requested | Account ID |
| **TranscriptReady** | A meeting transcript becomes available | Meeting ID, transcript content, event IDs |

Portal-based triggers (PortalMeetings, PortalMeetingCancelled) can be scoped to specific portals — only meetings from selected portals will activate the playbook.

### AI

**Purpose**: Process data using AI capabilities.
Each AI block references a specific capability (e.g., meeting summarization, entity extraction, email generation). You can optionally pin a specific capability version or use the default (latest).

### EntityPatternRead

**Purpose**: Retrieve data from the CRM system.
Select an entity pattern to query (e.g., opportunities, contacts, accounts). Map search criteria from previous blocks to filter the results.

### EntityPatternCreate

**Purpose**: Create new records in the CRM system.
Select the target entity pattern and map field values from upstream blocks.

### EntityPatternUpdate

**Purpose**: Update existing CRM records.
Select the entity pattern and map the fields to update from upstream blocks.

### EntityPatternFilter

**Purpose**: Add filtering conditions for entity pattern operations.
Configure filters with a field name, operator (Equals, NotEquals, GreaterThan, etc.), and value. Supports a `GetDate(days)` function for relative date values — e.g., `GetDate(-30)` computes the date 30 days ago.

### Template

**Purpose**: Generate formatted output using a predefined template.
Select a template and map data from previous blocks into the template's variables. Templates are managed separately under Admin > Templates.

## Data Transformations Reference

Transformations modify data as it flows between blocks. Each relation can have a pipeline of transformations applied in sequence — the output of one transformation feeds into the next.

### Identity

Passes data through unchanged. Use this for direct field-to-field mapping where no transformation is needed.

### Extract

Picks a single value from a nested object using a dot-notation path.

```
Input:  { customer: { name: "John", address: { city: "Copenhagen" } } }
Path:   "customer.address.city"
Output: "Copenhagen"
```

### Project

Keeps only selected fields from an object, discarding everything else.

```
Input:  { name: "John", email: "john@example.com", age: 30, phone: "+45..." }
Paths:  ["name", "email"]
Output: { name: "John", email: "john@example.com" }
```

### Join

Combines array elements into a single text string using a separator.

```
Input:     ["Meeting notes", "Action items", "Follow-up"]
Separator: ", "
Output:    "Meeting notes, Action items, Follow-up"
```

Available separator presets: Comma, Comma (no space), Semicolon, Space, Newline, Pipe — or enter a custom separator.

### Split

Divides a text string into an array using a separator.

```
Input:     "john@example.com, jane@example.com, bob@example.com"
Separator: ", "
Output:    ["john@example.com", "jane@example.com", "bob@example.com"]
```

Options: remove empty entries, trim whitespace from each entry.

### Serialize

Converts an object into a JSON text string.

```
Input:  { name: "John", email: "john@example.com" }
Output: '{"name":"John","email":"john@example.com"}'
```

Options: indented output, camelCase keys, ignore null values.

### Base64Decode

Decodes a Base64-encoded string back to plain text.

```
Input:  "SGVsbG8gV29ybGQ="
Output: "Hello World"
```

## Related Documentation

- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) — step-by-step instructions for creating and managing playbooks
- [Playbooks Integrations]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/) — AI, CRM, and template integration details
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/) — setting up portals that trigger playbooks
