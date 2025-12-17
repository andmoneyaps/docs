---
layout: default
title: Release Notes
nav_order: 1
parent: Present
collection: present
---

# Release Notes—Present

## Version 1.31

**Release Date:** December 2025

This release introduces template labeling and filtering capabilities.

### New Features

**Template Labels and Filtering**

You can now organize templates using labels and filter them when creating presentations.

- **Add labels to templates** — Categorize templates with custom labels (e.g., "Investment", "Mortgage", "Private Banking")
- **Filter by label** — Advisors can filter available templates by selecting a label from the dropdown
- **Preselect label** — Configure a preselected label in your wrapper component to automatically filter templates based on context

See [Template Labels](template-labels.md) for details.

### Installation

> **Subscriber Package Version ID:** `TODO`
>
> **Installation URL:**
> `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=TODO`
>
> **Note:** Replace `[YOUR_DOMAIN]` with your organization's Salesforce domain.

---

## Version 1.29

**Release Date:** November 4, 2025

This release focuses on resolving critical bugs to improve system stability and user experience.

### Bug Fixes

**Slide Deck Permission Set Corrections**

Resolved an issue where the `Can_generate_slide_deck` PermissionSet lacked necessary permissions, causing Salesforce record IDs to display instead of customer types when choosing slides.

- **Impact:** Users with the affected PermissionSet experienced incorrect data display when generating presentations
- **Resolution:** Updated the `Can_generate_slide_deck` PermissionSet to include all required field-level security and apex code permissions

**Template Update Status Tracking**

Fixed a defect where template operations (new uploads or reordering) incorrectly flagged all templates as "Updated" rather than only the modified ones.

- **Impact:** Made it difficult for administrators to identify which templates had actually changed
- **Resolution:** Implemented an auxiliary tracking object to accurately monitor template modifications

### Installation

> **Subscriber Package Version ID:** `04tP7000002BUG9IAO`
>
> **Installation URL:**
> `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000002BUG9IAO`
>
> **Note:** Replace `[YOUR_DOMAIN]` with your organization's Salesforce domain.

---

## Present - Version 1.27
This version of Present includes several releases of new features and bug fixes.

### Release Date - 2025-10-21
This release includes the following updates:

**Interactive slides**
Allow the admin to create even more nice-looking slides, which gives the feeling of interactivity at the meeting.

Note: Active links don't work in Salesforce preview feature!

**Editing slides**
This feature allows admins to create slides where the user can edit the content with **free text** and thereby gives the users an option to create their own personal slide for the meeting.

Note: Active links dont work in Salesforce preview feature!

**Active links**
Users of Present can now click at active links in the presentation, and come back to the presentation when presenting in PowerPoint.

Note: Active links dont work in Salesforce preview feature!

**Tag modifiers**
Allows admins to transform the data from Salesforce fields before inserting them into the customer presentations. This gives control over text formatting without changing the source data in Salesforce, and creates new opportunities for the usage of tags.

### Release Date - 2025-05-06
This release includes the following updates:

> **Subscriber Package Version Id**: `04tP7000001U8dtIAC`
>
> **Install link**:
> - `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000001U8dtIAC`.
>
> Remember to use your org's URL instead of [YOUR_DOMAIN].

**General bugfixes** — Fixes a bug with agenda tag, so it correctly adds bullet points.

**Changes** - Removed validation rule that disallowed inactive templates to be activated again (in case a template was falsely deactivated)


## Present - Version 1.24
This version of Present delivers important quality-of-life enhancements that improve consistency,
usability, and clarity across the application.

### Release Date - 2025-03-01
This release includes the following updates:

> **Subscriber Package Version Id**: `04tP7000001HSSLIA4`
>
> **Install link**:
> - `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000001HSSLIA4`.
>
> Remember to use your org's URL instead of [YOUR_DOMAIN].

**General bugfixes** — This release includes several bug fixes to improve the overall stability and performance of the application.

### Improvements {id="improvements_2"}
**Enhanced Error Messages and Permission checks**

To help with faster troubleshooting and provide better guidance,
error messages now offer more detailed insights and clear instructions.
Additionally,
we have improved permission checks to ensure that users have the necessary access to perform specific actions.

### Bug fixes {id="bug-fixes_2"}
**Tag Name Case Sensitivity**

A fix has been applied to ensure that tag comparisons are case-insensitive.
This update prevents inconsistencies related to tag case sensitivity.

### Technical details {id="technical-details_2"}
new Version — The application has been updated to version 1.24.

## Present - Version 1.23
This version of Present delivers important quality-of-life enhancements that improve consistency,
usability, and clarity across the application.

### Release Date - 2025-02-03
This release includes the following updates:

> **Subscriber Package Version Id**: `04tP7000000vNSwIAM`
>
> **Install link**:
> - `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000000vNSwIAM`.
>
> Remember to use your org's URL instead of [YOUR_DOMAIN].

**Tag Name Handling** — Tag names are now normalized by converting them to lowercase before comparison,
ensuring consistent behavior and preventing case-related issues.

**Enhanced Error Messaging** — Error messages have been improved to offer clearer,
more actionable feedback for troubleshooting.

**UI Enhancements and Additional Labels** —
New labels and subtle UI adjustments have been introduced to boost the overall user experience.

### New features {id="new-features_1"}
**UI Enhancements and Additional Labels**

We have implemented additional labels and refined UI elements to improve navigation and clarity within the application. These adjustments make it easier for users to locate features and understand interface elements.

### Improvements {id="improvements_1"}
**Enhanced Error Messages**

To assist in faster troubleshooting and provide better guidance, error messages now offer more detailed insights and clear instructions.

### Bug fixes {id="bug-fixes_1"}
**Tag Name Case Sensitivity**

A fix has been applied to ensure that tag comparisons are case-insensitive.
This update prevents inconsistencies related to tag case sensitivity.

### Technical details {id="technical-details_1"}
Version bump — The application has been updated to version 1.23.

## Present - Version 1.21

This version of Present introduces crucial quality-of-life features.

### Release Date - 2024-11-15

This release includes the following updates:
* **Present Validation Tool**—Validate your templates before uploading them in Present. The new tool helps you identify any issues with your templates before they are uploaded to Present
* **Deactivation of old templates**—We now support deactivation/archiving of templates in Present. This will keep your templates' metadata when deactivating templates used in reporting
* **Tag mapping now supports custom and nested sObjects**—Map custom and/or nested objects in Salesforce to tags in your templates
* **Translations**—We have added translations for the Present app in English, Norwegian and Swedish

### New features

- **Present Validation Tool**

The Present Test Tool allows you to test and validate your templates before uploading them in Present.
This tool helps you to identify any issues with your templates before they are uploaded to Present. It can report on missing data in chart, incorrect tags, and more. It allows template authors to get info, warnings or errors on the slides they create.


<img alt="Validate Button" src="../../assets/images/present/validate_button.png" width="600"/>
<img alt="validate Template" src="../../assets/images/present/validate_template.png" width="600"/>
<img alt="Validation Results" src="../../assets/images/present/validation_results.png" width="600"/>


- **Deactivation of old templates**

We now support deactivation/archiving of templates in Present. This will keep your templates' metadata when deactivating templates used in reporting. This feature allows you to deactivate templates, but keep the metadata of a template but no longer want to use.

<img alt="Deactivate template" src="../../assets/images/present/deactivate.png" width="300"/>


- **Tag mapping now supports custom and nested sObjects**

This feature allows you to map fields from custom and nested objects in Salesforce to tags in your templates.

<img alt="Extended Tag Mapping" src="../../assets/images/present/tag_mapping_extended.png" width="600"/>


### Improvements

- **Translations**

We have added translations for the Present app in English, Norwegian and Swedish.

### Bug fixes

- **Stability fixes**

  We have fixed issues where the app would crash when uploading a template with a large number of slides.

### Technical details
- Subscriber Package Version Id: `04tP7000000vNSwIAM`
- Install link: `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000000vNSwIAM`

---
