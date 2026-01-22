---
layout: default
title: Advisor Priority Rules
nav_order: 11
parent: BookMe
collection: bookme
---

# Advisor Priority Rules

---

## Overview

Advisor Priority Rules allow banks to configure how advisors are selected when multiple advisors are available for the same time slot. When a customer books a meeting, the system uses these rules to determine which advisor to assign from the pool of available advisors.

---

## Key Benefits

- **Load Balancing**: Distribute meetings across advisors based on business priorities
- **Business Rule Enforcement**: Ensure local advisors are prioritized over regional or national advisors
- **Customized Routing**: Create tiered service groups to route customers to the most appropriate advisors
- **Flexible Configuration**: Adjust priorities without requiring IT assistance

---

## Understanding Priority Types

The system supports three types of advisor priorities:

| Type | Description |
|------|-------------|
| **Explicitly selected** | Advisors explicitly requested by the customer (e.g., customer selected a specific advisor when booking) |
| **Local advisor** | Local branch advisors who are qualified for the meeting theme |
| **Service group** | Advisors assigned via service group membership |

---

## Default Behavior

When no custom configuration exists, the system applies a default priority order:

| Priority | Type | Description |
|----------|------|-------------|
| 1 (Highest) | Explicitly selected | Customer-selected advisors are always prioritized first |
| 2 | Local advisor | Local branch advisors are considered next |
| 3 (Lowest) | Service group | Advisors from service groups are used as fallback |

This default ensures sensible out-of-the-box behavior where customers are matched with their preferred or local advisors when possible.

---

## Configuring Priority Rules in Management UI

### Accessing the Configuration

1. Navigate to **BookMe** → **Meeting Setup** → **Operating Level** in the Management UI
2. The Operating Level page displays your current priority configuration

**Required Role:** Configurator or Admin

### Viewing Current Configuration

The configuration displays as a list of priority levels. Each level shows:
- **Type**: The advisor type (Explicitly selected, Local advisor, or Service group)
- **Description**: A text description explaining the priority level's purpose
- **Label**: For Service group types, the label used to filter which service groups apply

Priority levels are ordered from highest (top) to lowest (bottom).

### Adding a New Priority Level

1. Click the **Add operating level** button at the bottom of the list
2. Select the **Type** from the dropdown:
   - **Explicitly selected** - Only available if not already used
   - **Local advisor** - Only available if not already used
   - **Service group** - Can be added multiple times
3. Enter a **Description** explaining this priority level
4. For Service group type, select a **Label** to filter which service groups apply
5. Click **Save** in the save bar

### Reordering Priority Levels

Use the arrow buttons next to each priority level to change its position:
- Click the **up arrow** to move a level higher in priority
- Click the **down arrow** to move a level lower in priority

Changes take effect after saving.

### Removing a Priority Level

1. Click the **delete button** (trash icon) next to the priority level you want to remove
2. Click **Save** in the save bar to confirm the changes

---

## Using Service Group Labels

Labels enable you to create tiered service groups, allowing fine-grained control over advisor routing.

### How Labels Work

- **Without a label**: All service groups for the bank are included at that priority level
- **With a label**: Only service groups that have a matching label are included

### Creating Tiered Service Groups

To create a tiered system:

1. First, create labels in **Admin** → **Label Management** → **Labels**
   - Example: Create labels named "prio-1" and "prio-2"

2. Assign labels to your service groups in **BookMe** → **Service Groups**
   - Assign "prio-1" to your high-priority service groups
   - Assign "prio-2" to your standard service groups

3. Configure priority rules in **BookMe** → **Meeting Setup** → **Operating Level**
   - Add a Service group level with label "prio-1" at a higher priority
   - Add a Service group level with label "prio-2" at a lower priority

---

## Example Configurations

### Standard Configuration (Default Behavior)

This configuration prioritizes customer preferences, then local advisors, then any service group advisor.

| Priority | Type | Label | Description |
|----------|------|-------|-------------|
| 1 | Explicitly selected | - | Customer-selected advisors |
| 2 | Local advisor | - | Local branch advisors |
| 3 | Service group | (none) | All service group advisors |

### Tiered Service Groups

This configuration creates multiple tiers of service groups for more granular routing.

| Priority | Type | Label | Description |
|----------|------|-------|-------------|
| 1 | Explicitly selected | - | Customer-selected advisors |
| 2 | Local advisor | - | Local branch advisors |
| 3 | Service group | prio-1 | Primary service group advisors |
| 4 | Service group | prio-2 | Secondary service group advisors |
| 5 | Service group | (none) | All remaining service group advisors |

### Prioritizing Specialized Advisors

Use this pattern when certain service groups contain specialized advisors who should be considered first.

| Priority | Type | Label | Description |
|----------|------|-------|-------------|
| 1 | Explicitly selected | - | Customer-selected advisors |
| 2 | Service group | specialists | Specialized advisors for this meeting type |
| 3 | Local advisor | - | Local branch advisors |
| 4 | Service group | (none) | General service group advisors |

---

## Validation Rules

The following rules are enforced when saving a configuration:

| Rule | Description |
|------|-------------|
| At least one level required | The configuration must have at least one priority level |
| Single Explicitly selected | Only one priority level can have the "Explicitly selected" type |
| Single Local advisor | Only one priority level can have the "Local advisor" type |
| Label required for Service group | When the type is "Service group", a label must be selected |

---

## Impact on Booking

When a customer searches for available time slots:

1. The system identifies all advisors who are available at each time slot
2. For each time slot with multiple available advisors, the priority rules determine which advisor is selected
3. The system evaluates advisors starting from priority 1 (highest)
4. The first advisor found at any priority level is assigned to the time slot
5. If no advisors match the higher priority levels, the system falls back to lower priority levels

This ensures customers see time slots assigned to the most appropriate advisor based on your business rules.
