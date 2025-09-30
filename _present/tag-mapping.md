---
layout: default
title: Tag Mapping
nav_order: 6
parent: Present
collection: present
---

# Tag Mapping
Tag mapping is useful for mapping data from Salesforce objects to the tags that are used throughout the uploaded templates.
It is possible to map fields and nested fields from Account, Contact, and Event to the tags in templates.

## Tag Mapping
To start mapping between tags and SObject fields, go to the Management UI and select the Tags tab.
This will lead you to the following page:

![Tag Mapping Overview](../../assets/images/present/tags_mapping_overview.png)

1. Click Create and choose a tag to be configured. From this input, any tag used in one of the uploaded templates can be selected.
![Tag configuration](../../assets/images/present/tag_configuration_step1.png)

2. Select Object type. This can be Account, Contact, and Event, or from the built-in custom SObject (Specific).
![Tag configuration2](../../assets/images/present/tag_configuration_step2.png)

3. Select Object field for the chosen Object type.
![Tag configuration3](../../assets/images/present/tag_configuration_step3.png)

4. If the field is a reference type, you can select a nested field from the reference object.

5. Click the 'Create' button.

> In the example above, the tag "dine_jeres" is mapped to `Event → Account → andmoney__AMB_Taxonomy__c → Name`.

If the tag mapping is successfully created, it will now be shown in the list of tag mappings.
The list also shows which master templates the tags are used within.

A single tag can be used across multiple different templates.

> **How does tag mapping work**
>
> When a slide deck is created on a Salesforce Event, Present will look up the tags that are used in the selected slides, and find the relevant tag mappings.
>
> Each tag in the respective slides is then replaced with the value of the tag mapping's SObject field.
> The values are looked up directly on the Event from which the slide deck is created, and on the Account and Contacts that are related to the Event.
>
> Any tag that has not been mapped to an SObject field, can be populated by the user through input fields, before the creation of the slide deck.

## Unmapped Tags

### Handling Unmapped Tags in the Validation Modal

When generating a slide deck, the existing validation modal will also include input fields for any unmapped tags found in your selected slides. These appear as empty fields alongside the pre-populated mapped tag values.

**What you'll see:**
- Mapped tags appear with their Salesforce data pre-filled for validation
- Unmapped tags appear as empty input fields ready for your custom text
- You can edit both mapped and unmapped tag values before generating the presentation

### When to Use Unmapped Tags

Unmapped tags are ideal for content that:
- Changes per meeting and isn't stored in Salesforce
- Requires contextual input specific to each presentation
- Varies too frequently to warrant creating Salesforce fields

**Example:** While `[tag:account_name]` shows pre-filled data from Salesforce, an unmapped tag like `[tag:meeting_focus]` will appear as an empty field where you can enter "Investment Portfolio Review".

> **Tag mapping maps Salesforce fields 'as-is'**
>
> In Present v1.10 the tag-mapping maps the Salesforce SObject fields 'as-is', meaning the raw data.
>
> **With some exceptions**:
> - Dates are transformed based on your locale and language in User Settings. For example, `Event.enddate` will be in DK date format: `dd.MM.yyyy`
> - If a field is a lookup (an `Id`) for example `Account.OwnerId` the sObject is queried and the `.Name` property is used. In case of the `Account.OwnerId` this will return the Name of the Account Owner.

## Tag Modifiers (New Feature)

Present now supports **tag modifiers** that allow you to transform the data from Salesforce fields before inserting them into your presentations. This gives you control over text formatting without changing the source data in Salesforce.

### How to Use Tag Modifiers

Tag modifiers use the following syntax in your PowerPoint templates:

```
[tag:<tag-name>:<modifier>]
```

For example:
- `[tag:company_name:uppercase]` - Converts company name to UPPERCASE
- `[tag:contact_name:capitalize]` - Capitalizes the first letter of the contact name
- `[tag:description:trim]` - Removes extra whitespace from the description

### Available Modifiers

| Modifier | Description | Example Input | Example Output |
|----------|-------------|---------------|----------------|
| `capitalize` | Capitalizes the first letter only | `john doe` | `John doe` |
| `uppercase` | Converts all text to uppercase | `Hello World` | `HELLO WORLD` |
| `lowercase` | Converts all text to lowercase | `Hello World` | `hello world` |
| `title` | Capitalizes the first letter of each word | `hello world` | `Hello World` |
| `trim` | Removes leading and trailing whitespace | `  hello world  ` | `hello world` |

### Combining Modifiers

You can chain multiple modifiers together by separating them with additional colons:

```
[tag:company_name:trim:uppercase]
```

This will first trim whitespace, then convert to uppercase.

{: .important }
> **Modifier Processing Order**
>
> When using multiple modifiers, they are processed from left to right in the order you specify them.

### Practical Examples

**Example 1: Formatting Names**
- Template: `Welcome [tag:contact_name:capitalize]!`
- Salesforce data: `john doe`
- Result: `Welcome John doe!`

**Example 2: Company Branding**
- Template: `Presented by [tag:company_name:uppercase]`
- Salesforce data: `Acme Corp`
- Result: `Presented by ACME CORP`

**Example 3: Clean Input Data**
- Template: `Topic: [tag:meeting_subject:trim:title]`
- Salesforce data: `  quarterly review  `
- Result: `Topic: Quarterly Review`

### Backward Compatibility

{: .note }
> **Existing templates continue to work**
>
> All existing templates without modifiers will continue to work exactly as before. Tag modifiers are an optional enhancement that you can add when needed.

