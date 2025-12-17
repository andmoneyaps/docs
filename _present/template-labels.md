---
layout: default
title: Template Labels
nav_order: 5
parent: Present
collection: present
---

# Template Labels

Labels allow you to organize templates into categories, making it easier for advisors to find the most relevant slides for their meetings.

## What are Labels?

Labels are free-form text tags assigned to templates that act as filters. When a label is selected, only templates with that label are shown.

**Example labels:**
- Customer segments: "Private Banking", "Retail", "Business"
- Product categories: "Investment", "Mortgage", "Pension"
- Campaigns: "Q4 Campaign", "Summer Offer"

{: .note }
> Labels are case-sensitive and matched exactly. Use consistent naming conventions across your organization.

## Adding Labels to Templates

Administrators can add labels to templates through the Management UI.

1. Navigate to the Present -> Setup -> Templates tab
2. Select a template
3. Add one or more labels
4. Save changes

## Filtering Templates by Labels

When creating a presentation, advisors can filter templates using the label dropdown in the **Filters** accordion. Selecting a label shows only templates that have that label assigned.

## Best Practices

- Use clear, consistent label names
- Avoid overly specific labels that only apply to one template
- Consider labels for: customer segments, product categories, seasonal campaigns, meeting types

---

# Salesforce Package Integration

The Present Salesforce package supports preselecting a label, allowing you to automatically filter templates based on context before the advisor opens the component.

## Preselecting a Label

Configure the `preselectedLabel` property in your wrapper component's config object:

```javascript
import { LightningElement, api, track } from "lwc";

export default class PresentWrapper extends LightningElement {
  @api recordId;

  @track
  config = {
    agenda: "",
    preselectedLabel: "Private Banking" // Pre-filter templates by this label
  };
}
```

```html
<template>
  <andmoney-fast-slides
    record-id={recordId}
    config={config}>
  </andmoney-fast-slides>
</template>
```

When `preselectedLabel` is set, the FastSlides component will load with only matching templates visible. The advisor can still change or clear the filter.

## Config Object Properties

| Property | Type | Description |
|----------|------|-------------|
| `agenda` | `string` | Predefined agenda text |
| `preselectedLabel` | `string` | Label to pre-filter templates |

Both properties are optional. If `preselectedLabel` is empty, all templates are shown.
