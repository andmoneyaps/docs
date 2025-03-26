---
layout: default
title: Master Template Creation
nav_order: 2
parent: Present
---

# Master Template Creation

> **Important**: Before setting up master templates and using Present
>
> Clarify who the stakeholders are for the following:
> 1. Who maintains the master slides in your business (sales, product managers, marketing)
> 2. The content of the master slides
> 3. The design of the content (Fonts, Images, CVI, etc.)

## Prerequisites

Make sure that:
- The newest Present Package is installed in your org
- Valid licenses are assigned to relevant users

## Setting Up Master Templates in Present

### 1. Create PowerPoint Presentation

Create a PowerPoint presentation (a .pptx file) with relevant slides.

#### Slide Categories
Before you start, it is recommended that you divide your slides into different sections:
- Master slides (e.g., Frontpage, agenda, ending slides)
- Addon-slides (e.g., based on the season)
- Pricing slides
- Other categories as needed

> **Note**: How templates work in Present
>
> When generating presentations in Present the users can choose from all Master Templates.
> This means that it does not matter whether you have one Master Template with everything or divide it into multiple templates with different purposes.

### 2. Name Your Slides

Each slide in the PowerPoint can be given a name in the notes section of the slide with the following syntax:
`[slide:<slide-name>]`

- `<slide-name>` must be _lowercase_ and _without spaces_

> **Warning**: Slide name is a **must** to correctly report the usage of the different slides

![Slide name in notes section](../assets/images/slide_name.png)

### 3. Set Up Sections

Set up sections for the Master Slides (e.g., introduction, about the customer, about the bank, investing, etc.)

This can be done using the sections in PowerPoint:

![Section names](../assets/images/section_names.png)

Here the agenda slide is in the section 'Agenda'.

To make subsections you can use the following syntax: `<sectionname> -- <subsectionname>`. As an example in the image above, slide number 3 is in the section 'Sektionsnavn' and has a subsection called 'undersektion'.

> **Note**: Why divide slides into sections and subsections?
>
> This is useful to categorize slides for different purposes. As an example for a section about investing, subsections could include 'bonds', 'shares', 'taxation', 'dividends' etc.

### 4. Insert Salesforce Data Tags

Insert 'tags' where you want Salesforce data to automatically insert data in the presentation.

To insert tags use the following syntax: `[tag:<name-of-tag>]`

- `<name-of-tag>` must be _lowercase_ and _without spaces_

> **Tip**: Information on how the **tags** are mapped to Salesforce data can be found in the [Tag Mapping Guide](tag-mapping).

### 5. Insert Image Tags

To replace images use the following tag in the image name: `[image:<image_name>]`

![Replace images](../assets/images/image_tags.png)

### 6. Charts Support

Charts are not (yet) supported in the current version of Present.

> **Note**: While you can include charts in the templates, the data cannot be changed.

> **Warning**: Charts included in templates CAN NOT reference external worksheet data.
> All worksheet data must be included in the PowerPoint file (PPTX)

![Charts in presentations](../assets/images/charts.png)

## Template Management

> **Warning**: Deletion of Master Templates is not supported in Present v1.10
>
> Since all template metadata is stored in Salesforce this is (at the moment) used to report usage statistics to your CRM Analytics (If this is enabled in your org).
> Because of this Present v1.10 does not support (yet) deletion of Master Templates. This will be available in future releases.
> 
> In order to upload a new version of a Master Template you **MUST** upload a new template with the same file name. This will overwrite the existing Master Template.
