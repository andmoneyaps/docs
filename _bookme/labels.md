---
layout: default
title: Labels
nav_order: 10
parent: BookMe
---

# Labels

---

## Overview

Labels are flexible metadata tags that help you organize, categorize, and filter entities across the BookMe platform. By assigning labels to Service Groups, Competence Groups, Portals, and Present Templates, you can create a consistent organizational structure that makes it easier to manage and discover resources.

---

## Key Benefits

- **Organization**: Group related entities together using consistent naming conventions
- **Discovery**: Quickly find entities by searching or filtering by labels
- **Visual Identification**: Assign colors to labels for easy visual recognition in tables and lists
- **Cross-Platform Consistency**: Use the same labels across different entity types (Service Groups, Portals, etc.)
- **Flexible Categorization**: Create any labeling scheme that fits your organization's needs

---

## Entities That Support Labels

Labels can be assigned to the following entity types:

| Entity Type | Location in Management UI |
|-------------|---------------------------|
| **Service Groups** | BookMe → Service Groups |
| **Competence Groups** | BookMe → Competence Groups |
| **Portals** | BookMe → Portals |
| **Present Templates** | Present → Templates |

---

## Label Management (Admin)

### Accessing Label Management

1. Navigate to **Admin** in the Management UI
2. Select **Label Management** → **Labels**

The Label Management page provides a central view of all labels used across your organization.

### Label Overview

The label overview table displays the following information:

| Column | Description |
|--------|-------------|
| **Label Name** | The name of the label as it appears when assigned to entities |
| **Color** | Visual indicator showing the label's assigned color |
| **Description** | Optional description explaining the label's purpose |
| **Services** | Number of times the label is currently assigned across all entities |
| **Status** | Indicates whether the label is currently in use |
| **Actions** | Edit or delete the label|

### Filtering and Searching

- **Search**: Use the search field to find labels by name. The search supports fuzzy matching, helping you find labels even with partial or slightly misspelled names.
- **Active Filter**: Filter the list to show:
  - **All**: Display all labels
  - **Active**: Only show labels currently assigned to at least one entity
  - **Inactive**: Only show labels not currently assigned to any entity

---

## Creating Labels

Labels can be created in two ways:

### Method 1: Pre-create in Label Management (Recommended)

Pre-creating labels in the Label Management admin panel is recommended when you want to:
- Establish a consistent naming convention before labels are used
- Assign colors and descriptions upfront
- Maintain control over your organization's label taxonomy

**Steps:**

1. Go to **Admin** → **Label Management** → **Labels**
2. Click **Create**
3. Fill in the label details:
   - **Label Name** (required): The name of your label
     - Maximum 255 characters
     - Must be unique within your organization
     - Case-insensitive (e.g., "Priority:High" and "priority:high" are considered the same)
   - **Color** (optional): Choose a color for visual identification
     - Use the color picker or enter a hex color code (e.g., `#FF5733`)
     - Default color is gray (#808080) if not specified
   - **Description** (optional): Add a description to explain the label's purpose
     - Maximum 500 characters
4. Click **Create** to save the label

### Method 2: Create While Assigning

Labels can also be created on-the-fly when assigning them to an entity:

1. Open the entity you want to label (e.g., a Service Group)
2. In the Labels section, type a new label name
3. Press **Enter** or click the "Create" option that appears
4. The label is automatically created and assigned to the entity

> Labels created this way will have the default gray color and no description. You can later edit them in the Label Management admin panel to add colors and descriptions.

---

## Editing Labels

To edit a label's metadata:

1. Go to **Admin** → **Label Management** → **Labels**
2. Find the label you want to edit
3. Click the **Edit** button (pencil icon)
4. Update the label details:
   - **Color**: Change the visual color
   - **Description**: Update or add a description
5. Click **Save Changes**

> The label name cannot be changed after creation. If you need to rename a label, create a new label with the desired name and reassign entities to it.

---

## Deleting Labels

Labels can only be deleted when they are not assigned to any entities.

**Steps:**

1. Go to **Admin** → **Label Management** → **Labels**
2. Find the label you want to delete
3. Verify the label is inactive (Services = ❌)
4. Click the **Delete** button (trash icon)
5. Confirm the deletion

> The delete button is disabled for active labels. You must first remove the label from all entities before it can be deleted.

---

## Assigning Labels to Entities

### Service Groups

1. Go to **BookMe** → **Service Groups**
2. Click on a Service Group to edit, or create a new one
3. Scroll to the **Labels** section
4. Use the label selector to add labels:
   - Type to search for existing labels
   - Select from the dropdown or press Enter to add
   - Click "Load More" to see additional labels
5. To remove a label, click the delete icon next to it
6. Click **Save** to apply the changes

### Competence Groups

1. Go to **BookMe** → **Competence Groups**
2. Click on a Competence Group to edit, or create a new one
3. In the edit modal, locate the **Labels** section
4. Add or remove labels using the label selector
5. Click **Save** to apply the changes

### Portals

1. Go to **BookMe** → **Portals**
2. Click on a Portal to edit, or create a new one
3. Scroll to the **Labels** section in the form
4. Add or remove labels using the label selector
5. Click **Save** to apply the changes

### Present Templates

1. Go to **Present** → **Templates**
2. Click on a template row to open the edit modal
3. Add or remove labels using the label selector
4. Click **Save** to apply the changes

---

## Label Display

Labels appear throughout the Management UI in a consistent format:

- **In Tables**: Labels are displayed as colored chips/badges
  - Each chip shows the label name
  - The background color matches the label's assigned color
  - Text color automatically adjusts for readability (light or dark based on background)

- **In Edit Forms**: Labels appear in a list with delete buttons for easy removal

---

## Best Practices

### Naming Conventions

Consider using a consistent naming structure for your labels:

| Pattern | Example | Use Case |
|---------|---------|----------|
| **Category:Value** | `Region:APAC`, `Priority:High` | Grouping by category |
| **Prefix-Name** | `dept-finance`, `team-sales` | Department or team identification |
| **Single Word** | `urgent`, `archived`, `vip` | Simple status or attribute labels |

### Recommended Label Categories

Common label categories that work well for organizing booking-related entities:

- **Region/Location**: `Region:APAC`, `Region:EMEA`, `Location:Copenhagen`
- **Priority/Tier**: `Priority:High`, `Tier:Premium`, `VIP`
- **Department**: `Dept:Private`, `Dept:Business`, `Dept:Agriculture`
- **Status**: `Active`, `Pilot`, `Legacy`
- **Customer Segment**: `Segment:Retail`, `Segment:Corporate`

### Color Guidelines

- Use consistent colors for related labels (e.g., all priority labels in shades of red/orange)
- Choose colors with good contrast for readability
- Document your color scheme for organizational consistency

---

## Searching and Filtering by Labels

### In Tables

Most entity tables display a **Labels** column showing all assigned labels. You can visually identify entities by their label colors.

### Using the API

When using the Public API, you can filter entities by labels. For example, Service Groups can be filtered by their assigned labels to find specific groups matching your criteria.

---

## Important Notes

- Labels are scoped to your organization and are not shared with other organizations
- Changes to label metadata (color, description) are reflected immediately across all entities
- The search functionality uses fuzzy matching, making it easier to find labels even with partial names or minor typos
