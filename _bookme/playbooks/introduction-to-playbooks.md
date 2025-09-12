---
layout: default
title: Introduction to Playbooks
parent: Playbooks
nav_order: 11
---

# Playbooks

## Introduction

Playbooks are powerful automation workflows in the andMoney platform that orchestrate complex business processes by connecting various system components through a visual block-based configuration system. They enable automated data processing, integration with AI capabilities, and seamless CRM interactions without requiring code development.

## What are Playbooks?

Playbooks are directed graphs of interconnected blocks that define automated workflows. Each playbook consists of:

- **Blocks**: Individual processing units that perform specific tasks (AI processing, CRM operations and more)
- **Relations**: Connections between blocks that define how data flows through the workflow
- **Transformations**: Data manipulation operations that modify data as it flows between blocks

### Key Benefits

- **No-Code Automation**: Create complex workflows through visual configuration without programming
- **Flexible Integration**: Connect various services (AI, CRM, Templates) seamlessly
- **Data Orchestration**: Transform and route data between different systems automatically
- **Trigger-Based Execution**: Respond to events like portal meetings and M365 transcripts and more triggers in the future

### Common Use Cases

Playbooks excel in scenarios requiring automated business process orchestration:

- **Meeting Intelligence**: Automatically process meeting data, generate AI summaries, and update CRM records
- **Data Synchronization**: Keep CRM systems synchronized with meeting activities and communications
- **Multi-Step Workflows**: Automate complex business processes that span multiple systems

## How Playbooks Work

### Architecture Overview

Playbooks integrate seamlessly with the andMoney platform ecosystem:

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Trigger   │────▶│   Playbook   │────▶│   Output    │
│   Event     │     │   Executor   │     │  (Results)  │
└─────────────┘     └──────────────┘     └─────────────┘
                            │
                ┌───────────┼───────────┐
                ▼           ▼           ▼
        ┌──────────┐ ┌──────────┐ ┌──────────┐
        │          │ │   CRM    │ │ Template │
        │  AI/ML   │ │ (Entity  │ │  Engine  │
        │          │ │ Patterns)│ │          │
        └──────────┘ └──────────┘ └──────────┘
```

### Execution Process

1. **Trigger Activation**: An event (Portal meeting, transcript ready event, API call) initiates the playbook
2. **Sequential Processing**: Blocks execute in their defined order
3. **Data Flow**: Data passes between blocks through relations, with transformations applied as configured
4. **Context Management**: The execution context maintains state and data throughout the workflow
5. **Result Generation**: Then final result can either be updating data in the CRM system, using output blocks produce final results or something else.

## Block Types Reference

Each block type serves a specific purpose in the workflow automation:

### Trigger Block
**Purpose**: Initiates playbook execution based on events  
**Required**: Every playbook must have exactly one trigger block  
**Configuration**:
- **Trigger Type**: Select the event source (PortalMeetings, etc.)
- **Conditions**: Optional filters to control when execution occurs

**Available Triggers**:
- **PortalMeetings**: Activated when Portal meetings are created or updated
- **CustomerOverview**: Triggered when a request to generate a customer overview is made
- **TranscriptReady**: Fires when meeting transcripts become available

### AI Block
**Purpose**: Leverages AI capabilities for intelligent data processing  
**Configuration**:
- **Capability ID**: Unique identifier for the AI function to execute
- **Input Mapping**: Maps incoming data to AI capability inputs

**Common Capabilities**:
- Meeting summarization and analysis
- Entity extraction from text
- Sentiment and intent analysis
- Document intelligence and classification

### EntityPatternRead Block
**Purpose**: Retrieves data from CRM systems  
**Configuration**:
- **Entity Pattern ID**: Identifies the CRM entity configuration
- **Query Parameters**: Filters and search criteria

**Output**: Structured CRM data in JSON format

### EntityPatternCreate Block
**Purpose**: Creates new records in CRM systems  
**Configuration**:
- **Entity Pattern ID**: Target entity type
- **Field Mappings**: Maps playbook data to CRM fields

### EntityPatternFilter Block
**Purpose**: Filters and transforms CRM data  
**Configuration**:
- **Field**: The field to filter on
- **Operator**: Comparison operator (=, !=, >, <, In, NotIn etc.)
- **Value**: The value to compare against. A `GetDate(days)` is available to compute date time values. I.e. `GetDate(-30)` inserts the current date minus thirty days into the value field. This is usefull for limiting the data collected from an entity pattern read block.

### Template Block
**Purpose**: Generates documents using templates  
**Configuration**:
- **Template ID**: Reference to document template
- **Data Bindings**: Maps data to template variables

### Input Block
**Purpose**: Accepts external data into the playbook  
**Configuration**:
- **Input Schema**: Defines expected data structure
- **Validation Rules**: Data validation requirements

### File Block
**Purpose**: Handles file operations and storage  
**Configuration**:
- **Operation Type**: Read, write, or transform files
- **File Format**: Supported formats and encoding

### Output Block
**Purpose**: Defines the playbook's final output  
**Configuration**:
- **Output Format**: Structure of returned data
- **Delivery Method**: How results are delivered (API response, webhook, etc.)

## Configuring Data Flow

### Understanding Relations

Relations define how data flows between blocks in your playbook. They create a directed data pipeline where each block receives input from previous blocks and produces output for subsequent blocks.

**Key Concepts**:
- **Input Relations**: Each block configures what data it receives from other blocks
- **Source Block**: The block providing the data (must execute before the destination)
- **Source Field**: The specific data field or path from the source block's output
- **Destination Field**: Where the data maps in the receiving block's input structure
- **Transformations**: Optional data modifications applied during the transfer

### Using the Relation Builder

The Relation Builder is a visual tool that simplifies creating data connections between blocks:

#### Step 1: Access the Relation Builder
1. Select a block that has both type and value configured
2. Click the edit button (pencil icon) on the block
3. Click "Add Input Relation" to open the builder

#### Step 2: Navigate Data Structure
The Relation Builder presents the source block's output structure as a navigable tree:
- Click through nested objects to explore the data structure
- Select "First" to get the first array element or "All" to process all elements
- The builder automatically generates the correct dot-notation path

#### Step 3: Configure the Mapping
- **Source Block**: Select from blocks that execute before the current block
- **Source Field**: Use the builder to navigate and select the exact field
- **Destination Field**: Choose where to map the data
- **Transformation**: Optionally apply a transformation (see below)

#### Step 4: Apply and Test
- Data will flow automatically during playbook execution
- Multiple relations can be added to combine data from different sources

### Data Transformations

Transformations modify data as it flows between blocks, enabling powerful data manipulation without code:

#### Identity Transformation
**Purpose**: Pass data through without modification  
**Use Case**: Direct field-to-field mapping  
**Example**: Copy `meeting.id` directly to `crm.meetingId`

#### Project Transformation
**Purpose**: Select specific fields from complex objects  
**Configuration**: List of field paths to extract  
**Example**: From a customer object with 50 fields, extract only `name`, `email`, and `phone`  
**Result**: Creates a new object with only the selected fields

#### Extract Transformation
**Purpose**: Extract a single value from a nested structure  
**Configuration**: Dot-notation path to the target value  
**Example**: Extract `response.data.customer.id` from an API response  
**Result**: Returns the specific value rather than the entire object

#### Join Transformation
**Purpose**: Combine data from multiple sources  
**Configuration**: 
- Join keys to match records
- Merge strategy (left, right, inner, outer)
**Example**: Combine customer data from CRM with meeting data from calendar  
**Result**: Unified object with data from both sources

#### Split Transformation
**Purpose**: Divide data into multiple outputs  
**Configuration**: 
- Split criteria (delimiter, pattern, or field)
- Output format
**Example**: Split a comma-separated list of emails into individual records  
**Result**: Array of separate data items

## Example: Meeting Intelligence Playbook

Here's a practical example of how a meeting intelligence playbook processes data:

### Workflow Design
```
1. Trigger Block (PortalMeetings)
   Output: {meetingId, startTime, endTime, title, primaryAdvisor.Email}
   ↓
2. EntityPatternRead Block (Fetch Advisor data Data)
   Input: primaryAdvisor.Email from Trigger
   Output: {UserId}
   ↓
3. EntityPatternCreate Block (Create CRM entities)
   Input: {userId, meetingId, startTime, endTime, title}
```

## Platform Integration

### AI Service Integration
The AI service provides advanced intelligence capabilities:
- **Capability Management**: Each AI function has a unique ID for precise control
- **Input/Output Contracts**: Strongly-typed interfaces ensure data compatibility
- **Supported Operations**: 
  - Meeting transcription and summarization
  - More capabilities can be created quickly upon request

### CRM Integration (Entity Patterns)
Entity Patterns provide a unified interface to CRM systems:
- **Operations**: Create, Read, for any entity pattern
- **Query Capabilities**: 
  - Complex filters with multiple conditions
  - Relationship traversal and joins
- **Data Mapping**: Automatic field mapping between systems

### Meeting Platform Integration
Seamless integration with the BookMe meeting platform:
- **Event Types**: 
  - Portal ceeting creation 
  - Customer overview triggered
  - Transcript availability
- **Processing Modes**: 
  - On-demand: Manual triggering via API will be available in future versions

### Template Engine Integration
Document generation through the template system:
- **Template Examples**: Meeting summaries, reports, follow-up emails
- **Format Support**: The templates are added in Management UI under "admin/templates"

## Best Practices

### Design Guidelines

#### Start Simple, Iterate
- Begin with basic workflows and add complexity incrementally
- Test each addition before proceeding
- Use the preview feature to validate data flow

#### Modular Architecture
- Create standard patterns for common operations

#### Performance Optimization
- Minimize the number of CRM queries to increase performance
- Use filters early in the workflow to reduce data volume

## Related Documentation

- [Entity Patterns Overview]({{ site.baseurl }}/bookme/crm-integration-security/) - CRM integration details
- [Portal Configuration]({{ site.baseurl }}/bookme/portals/) - Meeting platform setup
- [Meeting Management]({{ site.baseurl }}/bookme/implementation-guide/) - Meeting workflow automation
- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) - Step-by-step usage instructions
- [API Documentation]({{ site.baseurl }}/api/bookme/) - Complete API reference