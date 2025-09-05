---
layout: default
title: Playbooks Integration Guide
parent: BookMe
nav_order: 13
---

# Playbooks Integration Guide

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
    ┌───▼───┐   ┌────▼────┐   ┌───▼────┐   ┌────▼────┐
    │Portal │   │   AI    │   │Entity  │   │Template │
    │Events │   │         │   │Pattern │   │ Engine  │
    └───────┘   └─────────┘   └────────┘   └─────────┘
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
- **Action Item Extraction**: Identifies and extracts action items from text
- **Sentiment Analysis**: Analyzes emotional tone of customer interactions
- **Entity Recognition**: Identifies people, companies, and other entities
- **Classification**: Categorizes content based on predefined criteria
- **Language Translation**: Translates content between languages

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

Entity Patterns are abstraction layers that provide unified access to CRM entities across different systems (Salesforce, Dynamics 365, etc.). They enable Playbooks to interact with CRM data without needing system-specific implementations.

### How Playbooks Use Entity Patterns

1. **Pattern Selection**: Choose the appropriate Entity Pattern ID
2. **Operation Type**: Read, Filter, or Create operations
3. **Data Mapping**: Map playbook data to entity fields
4. **CRM Interaction**: Entity Pattern handles the actual CRM communication
5. **Result Processing**: CRM data is returned in a standardized format

### EntityPatternRead Operations

The EntityPatternRead block provides read-only access to CRM data:

- Fetch customer records
- Retrieve meeting histories
- Get opportunity details
- Access contact information
- Query related entities
- Retrieve multiple records based on criteria

### Entity Pattern Configuration Example

```yaml
Block Type: EntityPatternRead
Entity Pattern ID: customer-360-view
Search Criteria:
  customerId: {from: TriggerBlock.customerId}
Output Fields:
  - customer.name
  - customer.segment
  - customer.recentMeetings
  - customer.opportunities
```

## Portal Integration

### Portal Events as Triggers

Portals generate events that can trigger playbook execution:

1. **Meeting Creation**: New meeting scheduled through portal
2. **Meeting Update**: Meeting details modified
3. **Meeting Completion**: Meeting marked as complete
4. **Participant Changes**: Attendee list modified

### Portal Data Available to Playbooks

When triggered by a portal event, playbooks receive:
- Meeting ID and metadata
- Participant information
- Meeting type and category
- Associated customer IDs
- Meeting agenda and notes
- Recording and transcript links

### Portal Trigger Configuration

```yaml
Trigger Type: Portal
Event Type: meeting.created
Filter Criteria:
  meetingType: "customer-review"
  hasTranscript: true
Data Extraction:
  - meeting.id
  - meeting.customerId
  - meeting.participants
  - meeting.transcriptUrl
```

## Data Flow Between Components

### Example: Meeting Summary Workflow

```
1. Portal Trigger
   └─ Provides: meetingId, customerId, transcriptUrl
   
2. EntityPatternRead (Customer Data)
   ├─ Input: customerId
   └─ Output: customerName, segment, history
   
3. AI (Generate Summary)
   ├─ Input: transcript, customerData
   └─ Output: summary, actionItems, sentiment
   
4. Output
   ├─ Input: summary, customerData, actionItems
   └─ Returns: summary, actionItems, customerInfo
```

## Transformation Pipeline

### How Transformations Work

Transformations modify data as it flows between integration points:

1. **Data Reception**: Block receives data from integration
2. **Transformation Application**: Configured transformations are applied
3. **Data Output**: Transformed data is passed to next block

### Transformation Use Cases

#### AI Data Preparation
```javascript
// Extract relevant fields for AI processing
Transform: Project
Input: {customer: {id: "123", name: "Acme", revenue: 1000000}}
Fields: ["customer.name", "customer.revenue"]
Output: {name: "Acme", revenue: 1000000}
```

#### Entity Pattern Field Mapping
```javascript
// Map playbook fields to CRM fields
Transform: Join
Input1: {meetingId: "456"}
Input2: {summary: "Discussion about Q4 targets"}
Output: {Meeting__c: "456", Notes__c: "Discussion about Q4 targets"}
```

#### Template Data Formatting
```javascript
// Format data for template consumption
Transform: Extract
Input: {results: {summary: {text: "Key points discussed..."}}}
Path: "results.summary.text"
Output: "Key points discussed..."
```

## Security and Permissions

### Integration Security Model

1. **Service Authentication**: Each integration uses service accounts
2. **Data Encryption**: All data encrypted in transit
3. **Permission Inheritance**: Playbooks respect user permissions
4. **Audit Logging**: All operations are logged

### Permission Requirements

#### AI Access
- Valid AI API credentials
- Capability access permissions
- Rate limit allocation

#### Entity Pattern Access
- CRM system credentials
- Entity-level permissions
- Field-level security

#### Portal Access
- Portal API access
- Event subscription permissions
- Data access rights

## Related Documentation

- [Playbooks Overview](playbooks.md)
- [Playbooks User Guide](playbooks-user-guide.md)
- [CRM Integration Security](crm-integration-security.md)
- [Portal Configuration](portals.md)