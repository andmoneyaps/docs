---
layout: default
title: Playbooks Integrations
parent: Playbooks
nav_order: 13
---

# Playbooks Integrations

This guide explains how Playbooks integrate with other platform components, particularly focusing on the relationship between Playbooks, AI capabilities, and Entity Patterns.

## Integration Architecture

Playbooks serve as the orchestration layer that connects multiple platform services:

```
┌──────────────────────────────────────────────────────────┐
│                    PLAYBOOK ENGINE                       │
│                                                          │
│  ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   │
│  │ Trigger │───│  Block  │───│  Block  │───│ Output  │   │
│  └─────────┘   └─────────┘   └─────────┘   └─────────┘   │
│       │             │             │              │       │
└───────┼─────────────┼─────────────┼──────────────┼───────┘
        │             │             │              │
    ┌───▼───┐    ┌────▼────┐    ┌───▼────┐    ┌────▼────┐
    │Portal │    │   AI    │    │Entity  │    │Template │
    │Events │    │         │    │Pattern │    │ Engine  │
    └───────┘    └─────────┘    └────────┘    └─────────┘
```

## AI Integration

### What is the AI Platform?

The AI platform provides intelligent processing capabilities to Playbooks. It offers various AI capabilities that can be invoked through AI blocks.

### How Playbooks Use AI

1. **Capability Selection**: Each AI block references a specific capability by ID
2. **Data Input**: Playbooks send structured data to AI capabilities
3. **AI Processing**: The AI processes the data using the specified capability
4. **Result Output**: Processed results are returned to the playbook

### Common AI Capabilities

- **Meeting Summarization**: Generates concise summaries from meeting transcripts
- **Customer Emails**: Generate customer emails based on meeting summaries
- **And more**: New AI capabilities can quickly be added on demand based on your specific business needs.

### AI Block Configuration Example

```yaml
Block Type: AI
Capability ID: meeting-summary-v2
Input Variables:
  transcript: {from: TriggerBlock.meetingTranscript}
  participants: {from: EntityPatternBlock.attendees}
Output Variables:
  summary: {to: TemplateBlock.summaryText}
  keyPoints: {to: OutputBlock.highlights}
```

## Entity Pattern Integration

### What are Entity Patterns?

Entity Patterns are abstraction layers that provide unified access to CRM entities. They enable Playbooks to interact with CRM data without needing system-specific implementations.

### How Playbooks Use Entity Patterns

1. **Pattern Selection**: Choose the appropriate Entity Pattern ID
2. **Operation Type**: Read, Filter, or Create operations
3. **Data Mapping**: Map playbook data to entity fields
4. **CRM Interaction**: Entity Pattern handles the actual CRM communication
5. **Result Processing**: CRM data is returned in a standardized format

### EntityPatternRead Operations

The EntityPatternRead block provides read-only access to CRM data:

- Fetch customer records
- Retrieve meeting summaries
- Get opportunity details
- Access contact information
- Query related entities
- Retrieve multiple records based on criteria

### Entity Pattern Configuration Example

```yaml
Block Type: EntityPatternRead
Entity Pattern ID: customer-360-view
Search Criteria:
  customerId: {from: TriggerBlock.PrimaryAdvisor.Email}
Output Fields:
  - user.Id
  - user.Name
```

## Portal Integration

### Portal Events as Triggers

Portals generate events that can trigger playbook execution:

1. **Meeting Creation**: New meeting scheduled through portal a portal

### Portal Data Available to Playbooks

When triggered by a portal event, playbooks receive:
- Meeting ID and metadata
- Advisor information
- Meeting type and category
- And more

### Portal Trigger Configuration

```yaml
Trigger Type: PortalMeetings
Data Extraction:
  - meeting.meetingId
  - meeting.PrimaryAdvisor
  - meeting.ExternalAttendees
  - meeting.Title
  ...
```

## Security and Permissions

### Integration Security Model

1. **Service Authentication**: Each integration uses service accounts
2. **Data Encryption**: All data encrypted in transit
4. **Audit Logging**: All playbook operations are logged enabling full tracing and error identification.

## Related Documentation

- [Playbooks Overview]({{ site.baseurl }}/bookme/playbooks/introduction-to-playbooks/)
- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/)
- [CRM Integration Security]({{ site.baseurl }}/bookme/crm-integration-security/)
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/)