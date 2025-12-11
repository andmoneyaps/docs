---
layout: default
title: Template Labels
nav_order: 5
parent: Present
collection: present
---

# Template Labels

Labels help organize templates into categories, making it easier for advisors to find relevant slides.

## Adding Labels to Templates

Administrators can add labels to templates through the Template Management interface.

1. Navigate to the Template Management tab
2. Select a template
3. Add one or more labels (e.g., "Investment", "Mortgage", "Private Banking")
4. Save changes

> **Tip:** Labels are free-form text. Use consistent naming conventions across your organization.

## Filtering Templates by Labels

When creating a presentation, advisors can filter templates using the label filter:

1. Open the **Filters** accordion in the FastSlides component
2. Select one or more labels from the dropdown
3. Only templates matching **all** selected labels will be shown

> **Note:** Selecting multiple labels narrows the results (AND logic). A template must have all selected labels to appear.

## Preselected Labels

Labels can be preselected based on context (e.g., meeting type or customer segment) by configuring the `preselectedLabels` property in the Present wrapper component.

## Best Practices

- Use clear, consistent label names
- Avoid overly specific labels that only apply to one template
- Consider labels for: customer segments, product categories, seasonal campaigns, meeting types
