---
layout: default
title: Playbooks User Guide
parent: Playbooks
nav_order: 12
---

# Playbooks User Guide

This guide provides step-by-step instructions for creating, configuring, and managing playbooks in the &Money Management UI.

## Getting Started

### Prerequisites

Before creating playbooks, ensure you have:
- Admin access to the Management UI
- Understanding of your business workflow requirements
- Appropriate permissions for playbook management

### Accessing Playbooks

1. Log in to the Management UI
2. Navigate to the **Admin** section in the left sidebar
3. Select **Playbooks** from the admin menu

You'll see the Playbooks overview page displaying existing playbooks with their names and block counts.

## Creating a Playbook

### Step 1: Open the Creation Modal

Click the **"Create"** button on the Playbooks page to open the creation modal.

![Playbook Creation Modal](../../../assets/images/bookme/playbooks/playbook-create-initial.png)

### Step 2: Configure Basic Information

1. **Enter Playbook Name**: 
   - Use a descriptive name that clearly indicates the playbook's purpose
   - Example: "Customer Meeting Summary Playbook"
   - This field is required

### Step 3: Configure the Trigger Block

Every playbook must start with a Trigger block:

1. **Block Name**: Default is "Trigger block" (can be customized)
2. **Block Type**: Automatically set to "Trigger" (cannot be changed)
3. **Trigger Type**: Select from the available options

### Step 4: Add Additional Blocks

Click **"Add block"** to add more blocks to your playbook:

![Playbook with Multiple Blocks](../../../assets/images/bookme/playbooks/playbook-create-with-blocks.png)

For each new block:

1. **Enter Block Name**: 
   - Use descriptive names (e.g., "Entity Pattern Read Block")
   
2. **Select Block Type**:
   - **AI**: For AI/ML processing
   - **EntityPatternRead**: To fetch data from the CRM system
   - **EntityPatternCreate**: To create data in the CRM system
   - **EntityPatternFilter**: To add filters used in your entity pattern read blocks.
   - **Template**: To fetch a defined template
   - **Output**: To produce results
   - **Note**: Additional block types, File and Input are defined but not yet fully implemented

3. **Configure Block Value**:
   - For AI blocks: Enter the Capability ID
   - For Entity Pattern blocks: Select or enter the Entity Pattern ID
   - Value requirements vary by block type

### Step 5: Configure Block Relations (Advanced)

To add input relations and transformations between blocks:

1. **Select a Configured Block**: 
   - Ensure the block has both type and value configured
   - Click the edit button (pencil icon) on the block

2. **Add Input Relations**:
   - Click **"Add map"**
   - **Select Source Block**: Choose a block that executes before the current block
   - **Specify Source Field**: The output field from the source block
   - **Define Destination Field**: Where to map the data in the current block
   - **Apply Transformation** (optional): Select transformation type if data needs to be modified

3. **Important Notes**:
   - Blocks can only configure their own input relations
   - Source blocks must execute before the current block in the flow
   - Each relation creates a data pipeline from source to destination

### Step 6: Save the Playbook

Once all blocks are configured:
1. Review your configuration
2. Click **"Create playbook"** to save
3. The playbook will be created and appear in the playbooks list

## Block Configuration Details

### Trigger Block Configuration

The Trigger block determines when and how your playbook executes. Currently implemented trigger type:

**PortalMeetings Trigger**:
- Activates when portal meetings are created or updated
- Provides real meeting data:
  - `MeetingId`: Meeting identifier (GUID)
  - `SalesforceId`: Salesforce record ID
  - `Title`: Meeting title
  - `Description`: Meeting description
  - `Type`: Meeting type
  - `BookedBy`: Person who booked the meeting
  - `Room`: Room information object
  - `MeetingOwner`: Primary advisor object
  - `AdditionalAdvisors`: List of additional advisor objects
  - `ExternalAttendees`: List of external attendee objects
  - `Theme`: Meeting theme
  - `ThemeId`: Theme identifier (GUID)
  - `CustomerCategory`: Customer category classification
  - `StartDate`: Meeting start date and time
  - `EndDate`: Meeting end date and time
  - `Cpr`: CPR number (confidential data)
  - `CustomFields`: Key-value pairs of custom fields
- Useful for meeting-related workflows

**Note**: Additional trigger types (TranscriptReady and CustomerOverview) are defined but may not be fully integrated yet.

### AI Block Configuration

AI blocks integrate artificial intelligence capabilities:

1. **Select AI as Block Type**
2. **Enter Capability ID**: 
   - Each capability has a unique identifier
   - Contact your administrator for available capability IDs
3. **Configure Input Relations**:
   - Map data from previous blocks
   - Define variable names for the AI capability

Example Capability IDs:
- Meeting summarization
- Creating customer emails from meeting summaries

New AI operations can quickly be added on demand based on your specific business needs.

### EntityPatternRead Block Configuration

EntityPatternRead blocks retrieve data from Salesforce:

1. **Select EntityPatternRead as Block Type**
2. **Enter Entity Pattern ID**: 
   - Select from available Entity Patterns
   - Each pattern represents a specific Salesforce entity type
3. **Configure Input Relations**:
   - Map search criteria from previous blocks
   - Define which fields to retrieve
4. **Outputs**: Structured Salesforce data that can be used by subsequent blocks

### Output Block Configuration

Output blocks define what the playbook returns:

1. **Select Output as Block Type**
2. **Configure What to Output**:
   - Select data from previous blocks
   - Define the output structure
3. **Map Input Relations**:
   - Connect results from AI or EntityPattern blocks
   - Format the final output

## Working with Relations and Transformations

### Understanding Relations

Relations define data flow between blocks. **Critical concept**: Each block can only configure its own input relations - blocks cannot push data to other blocks, they can only pull data from previous blocks.

- **Input Relations**: Data received by a block from previous blocks
- **Source Block ID**: The block providing the data (must execute before current block)
- **Source Field**: The specific output field from the source block
- **Destination Field**: Where to map the data in the current block

### Adding Input Relations

To add an input relation to a block:

1. **Ensure Block is Configured**: 
   - Block must have both type and value set
   - Only then will the edit button be enabled

2. **Open Block Editor**:
   - Click the edit (pencil) icon on the block
   - This opens the relation configuration panel

3. **Add Input Relation**:
   - Click "Add map"
   - Configure the following fields:
   ```
   Source Block ID: [Select from dropdown of previous blocks]
   Source Field: customer.id (the output field from source block)
   Destination Field: customerId (where to map in current block)
   Transformation: [Optional - Identity, Project, Extract, Join, or Split]
   ```

4. **Save the Configuration**:
   - Click Save to apply the relation
   - The block will now receive data from the source block

![Playbook with Multiple input relations](../../../assets/images/bookme/playbooks/relation-builder-configured-relation.png)

### Visual Guide: Using the Relation Builder

The Relation Builder provides an intuitive interface for creating input relations between blocks.

#### Opening the Relation Builder

1. **Prerequisites**:
   - Block must have both type and value configured
   - Example: AI block with Capability ID set

2. **Access the Builder**:
   - Click the edit (pencil) icon on the block
   - Click "Add map" button
   - Select source block
   - Click the icon in the input field for Source field or destination field to open
   - The Relation Builder modal opens

#### Relation Builder Interface

The Relation Builder modal contains:

**Top Section - Breadcrumb Navigation**:
- Shows your current path: `Home > customer > contacts`
- Click any breadcrumb to navigate back
- Helps track your location in nested structures

**Middle Section - Field Selection**:
- **Field Dropdown**: Shows available fields at current level
  - Examples: `customer`, `meeting`, `transcript`
- **Selection Type** (for arrays): 
  - "First" - Select first item only (`contacts[0]`)
  - "All" - Select all items (`contacts`)

**Bottom Section - Actions**:
- **Cancel**: Close without saving
- **Save**: Apply the relation (enabled when path is complete)

![Playbook relation builder for input](../../../assets/images/bookme/playbooks/relation-builder-complete-path.png)

#### Example: Creating a Complex Relation

**Scenario**: Connect customer contact email to AI block

1. **Open Relation Builder** on AI block
2. **Navigate the structure**:
   ```
   Step 1: Select "customer" from root fields
   Step 2: Select "contacts" (array field appears)
   Step 3: Choose "First" for selection type
   Step 4: Select "email" from contact fields
   ```
3. **Generated Path**: `customer.contacts[0].email`
4. **Configure Mapping**:
   - Source Block: EntityPatternRead
   - Source Field: (path from builder)
   - Destination Field: contactEmail
5. **Click Save** to apply the relation

### Configuring Transformations

Transformations modify data as it flows between blocks:

**Identity Transformation** (Default):
- Passes data unchanged
- Direct field mapping

**Project Transformation**:
- Extracts specific fields
- Example: Extract `name` and `email` from customer object
  ```
  Input: {customer: {name: "John", email: "john@example.com", age: 30}}
  Project: ["customer.name", "customer.email"]
  Output: {name: "John", email: "john@example.com"}
  ```

**Extract Transformation**:
- Gets single value from complex structure
- Example: Extract customer ID from nested object
  ```
  Input: {data: {customer: {id: "123"}}}
  Extract: "data.customer.id"
  Output: "123"
  ```

**Join Transformation**:
- Combines data from multiple sources
- Example: Merge customer and meeting data
  ```
  Input1: {customerId: "123", name: "John"}
  Input2: {meetingId: "456", date: "2024-01-15"}
  Output: {customerId: "123", name: "John", meetingId: "456", date: "2024-01-15"}
  ```

**Split Transformation**:
- Divides data into separate outputs
- Example: Split comma-separated values
  ```
  Input: "value1,value2,value3"
  Split: ","
  Output: ["value1", "value2", "value3"]
  ```

## Managing Existing Playbooks

### Viewing Playbooks

The Playbooks page displays:
- **Name**: Playbook identifier
- **Blocks**: Number of blocks in the playbook
- **Actions**: Edit and delete options

### Editing Playbooks

To edit an existing playbook:
1. Click the edit icon (pencil) in the actions column
2. Modify the configuration as needed
3. Save changes

### Deleting Playbooks

To delete a playbook:
1. Click the delete icon (trash can) in the actions column
2. Confirm the deletion
3. Note: Deletion cannot be undone

## Best Practices

### Planning Your Playbook

Before creating a playbook:
1. **Define the Goal**: What should the playbook accomplish?
2. **Identify Data Sources**: What information is needed?
3. **Map the Workflow**: List the steps in sequence
4. **Determine Outputs**: What results are expected?