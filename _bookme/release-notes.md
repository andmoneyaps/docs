---
layout: default
title: Release Notes
nav_order: 10
parent: BookMe
---

# Release Notes—BookMe

## Release 1.14.0 (05-02-2025)

### New features and improvements
Here is what's new in release 1.14.0 of &bookme.

> **Note**:
> - **Managed Package Version ID**: `04tP7000001BqkHIAS`
> - **Install link**: `https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP7000001BqkHIAS`
> - Remember to use your org's URL instead of https://login.salesforce.com.

- **Advisor Flow Redesigned to Use Salesforce Standard Components**
  - The advisor flow has been re-engineered to fully leverage Salesforce's standard components, ensuring a more consistent and native user experience across the platform.
  - By relying on standard Lightning web components, the advisor flow now benefits from built‐in accessibility, error handling, and responsive design—features that reduce development overhead and enhance end-user reliability.

### New for developers
- **Integration of an External Client App in the Package**
  - The package now includes an External Client App – a next-generation solution that improves on the limitations of traditional Connected Apps.
  - Unlike Connected Apps, External Client Apps are designed to work seamlessly with second-generation managed packages (2GP). This integration allows the app to be packaged and distributed to subscriber orgs with greater ease, ensuring that OAuth credentials and integration settings remain isolated and manageable.

## Release 1.13.0 (22-05-2024)

> **Note**:
> - **Managed Package Version ID**: `04tP7000000K6SfIAK`
> - **Install link**: `https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP7000000K6SfIAK`
> - Remember to use your org's URL instead of https://login.salesforce.com.

### New for developers

- **Opening the Teams-link in &bookme customer-flow now emits a "startmeeting" event**
    - The event is emitted when the user clicks the Teams link in the booking flow.
    - The event can be listened to in the parent component of the booking flow e.g. a wrapper component.
- **Better Lead support**
    - Meetings booked via a Lead now support multiple contacts.
    - Only the first contact is added as an event-relation, and all are added to `AMB_Meeting_Contact__c` which is referenced in `AMB_Event_Detail__c`.

### New features and improvements
- **Caching data in the booking flow**
    - When going back and forth in the booking flow, the data is now cached, so the user doesn't have to re-enter data.
    - Reserved meeting timeslot will now be released when navigating back to meeting timeslot selection.
- **Travel time for meetings with start- and end-address**
    - When selecting the 'ude af huset'/offsite meeting type, it is now possible to choose a start and end address. These addresses are used to calculate the travel time to and from the meeting.
    - The travel time is added as an extra time slot in the employee's calendar.
    - The address search uses DAWA (Danmarks Adressers Web API) to find addresses.
- **Meeting room selection before date/time**
    - It is now possible to choose (optional) a meeting room before you select the meeting date/time.
- **Meeting forwarding creates/updates participant object**
    - Forwarding meetings created via &bookme will now create/update the custom meeting participant object in Salesforce.
    - `AMB_Meeting_Participant` is now populated with forwarded invitees with a status; Accepted, Tentative, Declined.
    - Contact &bookme-support to activate this feature.

> **Important**: Permission Requirements
>
> - The integration user must have the "API Enabled" permission to sync attendees to Salesforce.
>   - [Salesforce documentation](https://help.salesforce.com/s/articleView?id=sf.branded_apps_commun_api_permset.htm&type=5)
> - It needs access to the following objects:
>   - `Event` (READ), `EventRelation` (READ/WRITE)
>   - `Email` and `Id` on `Contact` and `User` (READ)
>   - `AMB_Event_Detail__c` (READ) and `AMB_Meeting_Contact__c` (READ/WRITE)

### Fixed
- Issue where it was not possible to override a specific meeting configuration
- Issue where the Allowed Options for Employees did not in some cases respect Service Group assignments
- Issue with Location Configurations that caused the meetings without a room to not show physical meetings
- `AMBAdvisorCompetencesDTO` is now a Callable class
    - The `AMBAdvisorCompetencesDTO` class was previously a private class in the managed package which made it impossible to use outside the &bookme-package.

### Breaking changes
No breaking changes in this release.

[View older releases](https://github.com/andmoney/bookme/releases)
