---
layout: default
title: "What Are Entity Definitions?"
nav_order: 1
parent: "_entity_definitions"
---

# What Are Entity Definitions? A Deep Dive

In the world of complex software integrations involving Customer Relationship Management (CRM) systems, a shared understanding of data is paramount. At the heart of our system's ability to communicate fluently with Salesforce lies a powerful concept: the **Entity Definition**.

Think of an Entity Definition as a detailed blueprint or a comprehensive dictionary for your data. It doesn't hold the customer data itself. Instead, it holds _metadata_—data about data. It meticulously describes the structure, rules, and technical names of a data object (like a "Lead," "Contact," or "Account") as it exists in Salesforce. By creating this blueprint, we enable our platform to interact with Salesforce in a standardized, predictable, and reliable way.

This document provides a thorough exploration of the Entity Definition model, its components, how it manages relationships and data validation, and the business value it delivers.

---

### The Business Value: From Code to Configuration

The traditional approach to integrations is characterized by brittle, hardcoded solutions. This creates technical debt, slows innovation, and puts the integrity of critical business data at risk. Our entity-driven model redefines this relationship, transforming a slow and costly development process into an agile and efficient configuration task. This delivers:

- **Business Agility:** Radically accelerate the pace of business innovation.
- **Operational Efficiency:** Slash the total cost of ownership and eliminate integration chaos.
- **Data Governance:** Ensure data quality and consistency proactively.
- **Scalability:** Build a platform for sustainable, long-term growth.

---

### **The Anatomy of an Entity Definition**

An `EntityDefinition` is the foundational model that maps an internal concept to a concrete object in Salesforce. Each definition is composed of several key properties that, together, create a complete and unambiguous picture of a data entity.

#### **Core Properties: The Identity and Scope**

- **`Name` (User-Friendly Name):** This is a simple, human-readable name for the definition (e.g., "Salesforce Lead Definition"). It serves as a convenient label for administrators, making it easier to identify and manage definitions in a list.

- **`Type` (The Technical Salesforce Object Name):** This is arguably the most critical property of the `EntityDefinition`. The `Type` is the _actual technical name_ of the object in the Salesforce API. For instance, this could be "Lead", "Account", "Opportunity", or a custom object like "Financial_Product\_\_c". This property forms the direct, unbreakable link between our abstract definition and the concrete object in Salesforce.

- **`Fields` (The Schema Definition):** An `EntityDefinition` is not complete without knowing what data fields it contains. This property holds a collection of `FieldDefinition` objects, which together define the entity's schema. Each `FieldDefinition` describes a single piece of information, like an email address, a company name, or a contract value. This collection is detailed in the next section.

---

### **Understanding Field Definitions: The Building Blocks**

If an `EntityDefinition` is the blueprint for a house, then `FieldDefinition`s are the detailed specifications for each room, window, and door. They describe the individual data points that make up the whole entity.

#### **The `FieldDefinition` Model**

- **`Name` (Internal Field Name):** Similar to the parent `EntityDefinition`'s `Name`, this is a user-friendly handle for the field within our system (e.g., "Primary Email Address").

- **`FieldType` (The Primitive Data Type):** This property specifies the fundamental data type of the field, such as `String`, `Int`, `Double`, `Boolean`, or `DateTime`. This is crucial for maintaining data integrity. Assigning the correct `FieldType` ensures that data is serialized (converted for transmission) and deserialized (converted back) correctly. It's like ensuring you use the right kind of fuel for an engine; putting text into a number field can cause both our system and the target CRM to fail.

- **`MappedName` (The Technical CRM Field Name):** Just as `Type` maps to the CRM object, `MappedName` maps to a specific field's technical API name within that object (e.g., "AnnualRevenue", "NumberOfEmployees"). This is the final piece of the "address" required for API interactions, telling the CRM exactly which box to put the data in.

- **`Required` (Mandatory Field Flag):** A simple `Boolean` flag that indicates whether this field is mandatory. If `Required` is true, our system will perform checks to ensure that this field has a value before attempting to process the data, preventing incomplete records from being sent to the CRM.

- **`ReadOnly` (Write-Protected Field Flag):** This `Boolean` flag signals that the field's value is managed exclusively by the external CRM and cannot be written to or modified by our system. Common examples include "CreatedDate" or "LastModifiedById" fields, which the CRM populates automatically. By marking these fields as `ReadOnly`, we prevent accidental and erroneous write attempts.

---

### **How Relationships Are Modeled: The `EntityPatternDefinition`**

In any real-world scenario, data objects are rarely isolated; they are interconnected. A "Contact" belongs to an "Account." An "Opportunity" is linked to a "Contact." To model these crucial business relationships, our system uses a higher-level composite model called an **`EntityPatternDefinition`**.

Think of an `EntityPatternDefinition` as a recipe for a complex procedure. It groups multiple `EntityDefinition` objects together to describe a multi-entity structure. Within this pattern, each `EntityDefinition` is referred to as a `PatternPartDefinition`.

The real power of this model lies in its ability to define **`FieldRequirements`**. These are rules that establish dependencies and links between the different parts of the pattern. For example, a `FieldRequirement` could declare that a Contact's `accountId` must be equal to an Account's `id`.

This allows the system to perform intelligent lookups, validate data consistency across related objects, and ensure that when it creates a new Contact, it is correctly associated with the intended Account in Salesforce.

---

### **Data Validation**

Ensuring data quality is critical. Our system validates data against the rules in the `EntityDefinition` before sending it to Salesforce. This includes checking for mandatory fields and verifying data types. Salesforce performs the final validation, ensuring all data conforms to its specific business rules.

---

### **Lifecycle Management**

Entity Definitions are managed through a standard lifecycle. They can be created, reviewed, updated, and deleted as needed through the administrative interface.

By understanding these core concepts, you can better appreciate how Entity Definitions provide the robust, flexible, and reliable foundation for our platform's powerful integration capabilities.
