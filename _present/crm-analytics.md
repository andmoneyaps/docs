---
layout: default
title: CRM Analytics
nav_order: 15
parent: Present
collection: present
---

# Present CRM Analytics

## Overview

Present CRM Analytics provides business intelligence dashboards and datasets for analyzing presentation usage patterns within Salesforce CRM Analytics (formerly Wave Analytics/Einstein Analytics).

The analytics assets are maintained in the [`engageme-salesforce-crm-analytics`](https://dev.azure.com/andmoney/Engage%20Me/_git/engageme-salesforce-crm-analytics) repository and deployed to customer Salesforce orgs as part of the `andmoney` managed package.

## Repository Structure

```
engageme-salesforce-crm-analytics/
├── am-analytics/main/default/wave/
│   ├── SlidesGenerated.wdpr          # Base slides dataset
│   ├── AllSlideData.wdpr             # Extended slides dataset with user info
│   └── Present_Dashboard.wdash       # Present analytics dashboard
├── sfdx-project.json                 # Salesforce DX configuration
└── config/project-scratch-def.json   # Scratch org definition
```

## Datasets

### SlidesGenerated

The base dataset that combines slide definitions with their usage in generated presentations.

**Source Objects:**

| Object | Purpose |
|--------|---------|
| `andmoney__Slide__c` | Individual slide definitions |
| `andmoney__Template_Section__c` | Template sections containing slides |
| `andmoney__Template__c` | Master templates |
| `andmoney__Generated_slide__c` | Slides used in generated presentations |

**Data Flow:**

```
Slide → Template Section → Template → Generated Slide (OUTER JOIN)
```

The OUTER JOIN to `Generated_slide__c` ensures slides that have never been used are still included in the dataset, enabling "least used slides" analysis.

**Key Fields:**

- Slide name and external ID
- Template section name
- Template name and customer type
- Subsection information
- Image URLs
- Generated slide deck reference

---

### GeneratedSlidesDataset (AllSlideData)

An extended dataset that adds user information and taxonomy data for comprehensive analytics.

**Additional Source Objects:**

| Object | Purpose |
|--------|---------|
| `andmoney__Generated_Slide_Deck__c` | Generated presentation decks |
| `andmoney__AMB_Taxonomy__c` | Customer type taxonomy |
| `User` | Salesforce users who created presentations |

**Data Flow:**

```
Generated Slide → Slide → Template Section → Template → Generated Slide Deck → Taxonomy
                                                                            ↓
                                                           Generated Slide Deck → User
```

**Key Fields (in addition to SlidesGenerated):**

- User name (who created the presentation)
- Customer type from taxonomy
- PDF and PPTX content version IDs
- Agenda information

## Dashboard

### Present Dashboard

A comprehensive dashboard for analyzing presentation creation and slide usage.

**Metrics:**

| Widget | Description | Data Source |
|--------|-------------|-------------|
| Total PPTX Presentations | Count of unique PowerPoint presentations generated | `andmoney__Generated_Slide_Deck__c` |
| Average Slides per Presentation | Mean number of slides included in generated decks | GeneratedSlidesDataset |
| Presentations per Day | Bar chart showing daily presentation creation volume | Direct report |
| Presentations per User | Horizontal bar chart of presentations by creator | GeneratedSlidesDataset |
| Slides per Section/Subsection | Distribution of slide usage across template structure | GeneratedSlidesDataset |
| Most Used Slides | Top 10 slides by usage frequency | SlidesGenerated |
| Least Used Slides | Bottom 10 slides by usage frequency | SlidesGenerated |

**SAQL Queries:**

The dashboard uses SAQL (Salesforce Analytics Query Language) for complex analytics. Example query for most used slides:

```sql
q = load "SlidesGenerated";
q = foreach q generate
    'andmoney__1.Name' as 'Template Navn',
    'Name' as 'Slide Navn',
    'andmoney__Subsection_Name__c' as 'Undersektion Navn',
    'andmoney__.Name' as 'Sektionsnavn',
    'final.andmoney__Generated_Slide_Deck__c' as 'GeneratedSlideId',
    count() as 'Antal Slides';
q = group q by ('Template Navn', 'Slide Navn', 'Sektionsnavn', 'Undersektion Navn');
q = foreach q generate
    'Template Navn', 'Slide Navn', 'Sektionsnavn', 'Undersektion Navn',
    sum('Count') as 'Antal Slides';
q = order q by 'Antal Slides' desc;
q = limit q 10;
```

## Deployment

### Prerequisites

- Salesforce CLI (sf/sfdx) installed
- CRM Analytics enabled in the target org
- `andmoney` namespace configured

### Deploying to an Org

```bash
# Authenticate to your org
sf org login web -a MyOrg

# Deploy the analytics assets
sf project deploy start --source-dir am-analytics -o MyOrg
```

### Scratch Org Development

The repository includes a scratch org definition with CRM Analytics features enabled:

```json
{
  "orgName": "andmoney analytics scratch",
  "edition": "Developer",
  "features": ["EnableSetPasswordInApi", "SharedActivities", "DevelopmentWave"],
  "settings": {
    "lightningExperienceSettings": { "enableS1DesktopEnabled": true },
    "mobileSettings": { "enableS1EncryptedStoragePref2": false }
  }
}
```

Create a scratch org with:

```bash
sf org create scratch -f config/project-scratch-def.json -a analytics-scratch -d 7
sf project deploy start --source-dir am-analytics -o analytics-scratch
```

{: .note }
> **CRM Analytics Licensing**
>
> CRM Analytics requires specific licensing in Salesforce. Scratch orgs created with the `DevelopmentWave` feature include CRM Analytics capabilities for development and testing purposes.

## Understanding the File Formats

### Dataset Recipes (.wdpr)

Dataset recipes define how data is extracted, transformed, and loaded into CRM Analytics datasets. They use a JSON format specifying:

- **nodes**: Data transformation steps (load, join, save)
- **parameters**: Configuration for each node (fields, join types, keys)
- **ui**: Visual layout for the recipe editor

**Join Types Used:**

| Type | Purpose |
|------|---------|
| `LOOKUP` | Left join - keeps all left records, matches right |
| `OUTER` | Full outer join - keeps all records from both sides |

### Dashboard Definitions (.wdash)

Dashboard files define the layout, widgets, and queries for CRM Analytics dashboards:

- **gridLayouts**: Page structure and widget positioning
- **steps**: Data queries (SAQL, SOQL, or aggregateflex)
- **widgets**: Visual components (charts, numbers, tables)

## Business Value

Present CRM Analytics enables organizations to:

1. **Optimize Template Content**: Identify which slides are most/least used to improve template effectiveness
2. **Track User Adoption**: Monitor presentation creation across the team
3. **Analyze Usage Patterns**: Understand which sections and subsections are most valuable
4. **Measure ROI**: Track presentation volume over time

## Related Documentation

- [Template Creation Guide](../Present-Usage) - How to create master templates with slides
- [Tag Mapping](../tag-mapping) - Configuring data tags in templates
