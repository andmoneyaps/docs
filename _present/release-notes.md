---
layout: default
title: Release Notes
nav_order: 1
parent: Present
collection: present
---

# Release Notes—Present

## Present - Version 1.27
This version of present includes a few bug fixes

### Release Date - 2025-05-06
This release includes the following updates:

> **Subscriber Package Version Id**: `04tP7000001U8dtIAC`
>
> **Install link**:
> - `https://[YOUR_DOMAIN].lightning.force.com/packagingSetupUI/ipLanding.app?apvId=04tP7000001U8dtIAC`.
>
> Remember to use your org's URL instead of [YOUR_DOMAIN].

**General bugfixes** — Fixes a bug with agenda tag, so it correctly adds bullet points

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
