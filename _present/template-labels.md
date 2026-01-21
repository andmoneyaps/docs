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

{: .important }
> The label filter dropdown only appears in the UI once you have added at least one label to your templates in the Management UI. If you don't see the filter, ensure labels have been configured first. If you later decide filtering is not needed, you can hide it using the `hideLabelFilter` config option.

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
| `preselectedLabel` | `string` | Label to pre-filter templates on load |
| `labelWhitelist` | `string[]` | Only show these labels in the filter dropdown |
| `hideLabelFilter` | `boolean` | Hide the label filter completely |

All properties are optional.

### Label Whitelist

Use `labelWhitelist` to restrict which labels are available in the filter dropdown. Only labels in the whitelist (that also exist in the backend) will be shown.

```javascript
config = {
  labelWhitelist: ["Private Banking", "Retail"]  // Only these labels available
};
```

This is useful when you want to limit the filter options to labels relevant for a specific use-case or customer segment.

### Hiding the Label Filter

Use `hideLabelFilter` to completely hide the label filter from the UI. This is useful for banks or use-cases where label filtering is not relevant.

```javascript
config = {
  hideLabelFilter: true  // Filter UI is hidden, all templates shown
};
```

{: .note }
> When `hideLabelFilter` is `true`, any `preselectedLabel` value will be ignored.

### Validation

The component validates the `preselectedLabel` to ensure it:
1. Exists in the available labels from the backend
2. Is included in the `labelWhitelist` (if configured)
3. Is not used when `hideLabelFilter` is `true`

If validation fails, the preselected label is ignored and a warning is logged to the console.
