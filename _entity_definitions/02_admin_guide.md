---
layout: default
title: "Admin Guide"
nav_order: 2
parent: "_entity_definitions"
---

# Administrator's Guide to Managing Entity Definitions

This guide provides a comprehensive walkthrough of the Entity Definition management interface. As an administrator, this dashboard is your primary tool for creating, managing, and testing the data mappings that bridge your internal system with external CRMs. A thorough understanding of this interface is crucial for ensuring data integrity and enabling powerful, context-aware features throughout the platform. We will cover everything from the main dashboard to the detailed steps of creating and testing a definition, as well as understanding the various feedback mechanisms the system provides.

## Accessing the Dashboard: Your Central Hub

The journey begins at the main "Entity Definitions" dashboard. Think of this as your command center. It provides a clear, at-a-glance overview of all the definitions currently configured in the system. The layout is intentionally clean and structured, presenting the most critical information in a simple table format to help you quickly assess the state of your configurations.

The dashboard table is organized into the following columns:

- **Name:** This column displays the unique, user-defined name for each entity definition, such as "Standard Lead," "Enterprise Contact," or "Salesforce Account." This is the primary identifier you will use internally to recognize a specific mapping configuration.
- **CRM Type:** This shows the specific CRM object that the entity definition is mapped to. For example, you might see "Lead," "Account," or "Contact" here, corresponding directly to the object types available in your connected Salesforce instance. This tells you precisely what kind of CRM record this definition is designed to interact with.
- **Fields:** This column provides a simple numerical count of the individual fields that have been mapped within that definition. A "Lead" definition might have 5 fields mapped, while a more complex "Account" definition might have 15. This number gives you a quick sense of the complexity and granularity of a given definition.

### Key Actions on the Dashboard

At the top of the page, a prominent **"Create"** button serves as the entry point for configuring a new entity definition.

For each existing definition listed in the table, a set of icons on the right-hand side of the row allows you to perform specific actions:

- **Test:** This action allows you to validate a definition against a real CRM record.
- **Edit:** This action opens the configuration modal to modify an existing definition.
- **Delete:** This action allows you to permanently remove a definition.

It is important to note that, in its current iteration, the main dashboard view does not include built-in sorting, filtering, or search functionality. You will need to visually scan the list to locate the definition you wish to manage.

## Creating Your First Entity Definition: A Guided Journey

Creating a new entity definition is a guided, multi-step process that takes place within a focused, full-screen modal. This approach minimizes distractions and walks you through the configuration logically, from initial setup to detailed field mapping.

To begin, click the **"Create"** button on the main dashboard. The creation modal will appear, presenting you with the first set of required information.

### Step 1: Initial Entity Setup

The first part of the form establishes the high-level identity of your new data mapping.

- **Name:** This is a required text field where you will enter a unique and descriptive name for your definition. The system provides real-time validation feedback; if you attempt to proceed without filling this in, the field will be highlighted to prompt you for input.
- **Type:** This required autocomplete dropdown is where you select the primary Salesforce object you wish to map (e.g., Lead, Contact, Account). This field is dynamic. When you first click on it, the system initiates an API call to Salesforce to fetch the complete list of available object types. During this brief fetch, a loading spinner will be displayed, indicating that the system is working. Once the list is retrieved, you can either scroll through the options or begin typing to filter the list and find the object you need. The selection you make here is critical, as it dictates the fields that will be available for mapping in the next step.

### Step 2: The Field Mapping Experience

Once you have defined the name and type of your entity, you can begin the core task of mapping individual fields. An **"Add Field"** button allows you to create a new mapping row. Each row represents a single piece of data you want to define.

For each field you add, you must configure the following:

- **Field Name:** A text input for the internal name of the field. This is the handle you will use within our system to refer to this piece of data.
- **Mapped Name:** This is the most critical part of the mapping process. This autocomplete dropdown allows you to select the specific field from the Salesforce object you chose as your main "Type." The options in this dropdown are _dynamically populated_. After you select a main "Type" (e.g., "Lead"), a background API call fetches the complete schema for that object from Salesforce. A loading indicator is shown while this happens. Once populated, you can search and select the precise Salesforce field (e.g., `FirstName`, `Company`, `Email`) that you want to link to your internal "Field Name."
- **Field Type:** A standard dropdown to select the data type for the field, which defaults to "String."
- **Configuration:** Two checkboxes provide further control over the field's behavior:
  - **Required:** Check this box if this field must contain a value.
  - **ReadOnly:** Check this box if the field's value can only be read from the CRM and not written to.

### An Important Behavioral Note: Handling Type Changes

The system has a crucial built-in safety measure related to field mapping. If you have already mapped several fields and then decide to change the main entity **"Type"** (for instance, switching from "Lead" to "Contact"), all of your existing "Mapped Name" selections will be automatically cleared. This is intentional. Because the available fields are entirely dependent on the selected object type, changing the type invalidates the previous mappings. This behavior forces you to re-map each field to a new, valid field from the schema of the newly selected object type, thereby preventing data corruption and saving errors down the line.

Finally, the **"Create"** button at the bottom of the modal will remain disabled until the form is valid, meaning all required fields (like "Name" and "Type") have been filled out.

## Managing Existing Definitions

Once you have one or more definitions saved, you can manage them from the main dashboard.

### Editing a Definition

To modify an existing definition, simply click the **"Edit"** icon for the corresponding row. This will launch the same full-screen modal used for creation, but pre-populated with all the saved details of that definition. You can change the name, adjust field mappings, add new fields, or remove existing ones. All the same validation rules and dynamic behaviors, including the clearing of mapped fields if the main "Type" is changed, apply when editing.

### Deleting a Definition

To remove a definition, click the **"Delete"** icon. To prevent accidental data loss, the system will immediately present a confirmation modal, asking you to verify that you truly want to delete the definition. This two-step process ensures that you do not inadvertently remove a configuration that may be in active use.

### Testing a Definition

The "Test" functionality is a powerful tool for verifying that your mapping is working as expected.

1.  From the dashboard, click the **"Test"** icon on the row of the definition you want to validate.
2.  A new modal will appear, containing a single text field labeled **"Entity ID."**
3.  Here, you must input a valid CRM Record ID for an object of the correct type. For example, if you are testing a "Contact" definition, you must provide the actual ID of a record from your Salesforce "Contacts" table.
4.  After entering the ID, click the **"Test"** button inside the modal. The system will then use your entity definition to query the CRM for that specific record.
5.  The results are displayed _within the same modal_. They appear in a clean, key-value table format. The "Key" column will show the internal "Field Name" you defined, and the "Value" column will show the corresponding data retrieved from the CRM for that record, presented as a raw JSON string.

## Understanding Feedback and Error Messages

The system provides several forms of feedback to keep you informed.

- **Client-Side Form Validation:** As you create or edit a definition, the form provides immediate feedback. If you miss a required field, it will be highlighted in red, and a helpful message will appear. The "Create/Update" button remains disabled until these issues are resolved.
- **API/CRM-Side Error Handling:** If an error occurs while trying to save a definition (for example, a problem connecting to the CRM), a generic toast-style notification will appear on the screen to inform you that the action failed.
- **Test Functionality Feedback:** During a test, if the lookup fails for any reason (e.g., an invalid ID was provided, or there was a CRM connectivity issue), a distinct alert box will appear _within the test modal_ to clearly indicate the error.
