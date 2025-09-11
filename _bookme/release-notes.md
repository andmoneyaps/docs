---
layout: default
title: Release Notes
nav_order: 13
parent: BookMe
---

# Release Notes—BookMe

## Release 1.16.0 (22-05-2025)

### 1.16.0 — New features and improvements
Here is what's new in release 1.16.0 of &bookme.
> **Managed Package Version ID**: `04tP7000001XAWHIA4`.
>
> **Install link**:
> - `https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP7000001XAWHIA4`.
>
> Remember to use your org's URL instead of https://login.salesforce.com.

- **Advisor Flow - fixed search "advisor as the meeting owner"**
  - It is now possible to search for an advisor as the meeting owner and capture the click event the first time a user clicks

###  1.16.0 — New for developers
- **Changed event for click**
  - Updated the event handler on `BookingSearchInput` to use `onmousedown` instead of `onclick`, as the `onclick` event was not firing after hovering over an advisor for more than one second.

## Release 1.15.0 (10-02-2025)

### 1.15.0 — New features and improvements
Here is what's new in release 1.15.0 of &bookme.
> **Managed Package Version ID**: `04tP7000001CxtNIAS`.
>
> **Install link**:
> - `https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP7000001CxtNIAS`.
>
> Remember to use your org's URL instead of https://login.salesforce.com.

- **Advisor Flow Redesigned to Use Salesforce Standard Components**
  - The advisor flow has been re-engineered to fully leverage Salesforce’s standard components, ensuring a more consistent and native user experience across the platform.
  - By relying on standard Lightning web components, the advisor flow now benefits from built‐in accessibility, error handling, and responsive design—features that reduce development overhead and enhance end-user reliability.

###  1.15.0 — New for developers
- **Integration of an External Client App in the Package**
  - The package now includes an External Client App – a next-generation solution that improves on the limitations of
    traditional Connected Apps.
  - Unlike Connected Apps, External Client Apps are designed to work with second-generation managed packages (2GP).
    This integration allows the app to be packaged and distributed to subscriber orgs with greater ease, ensuring that OAuth credentials and integration settings remain isolated and manageable.

## Release 1.13.0 (22-05-2024)
Here is what's new in release 1.13.0 of &bookme.

> **Managed Package Version ID**: `04tP7000000K6SfIAK`.
>
> **Install link**:
> - `https://login.salesforce.com/packaging/installPackage.apexp?p0=04tP7000000K6SfIAK`.
>
> Remember to use your org's URL instead of https://login.salesforce.com.

### 1.13.0 — New for developers

- **Opening the Teams-link in &bookme customer-flow now emits a "startmeeting" event.**
    - The event is emitted when the user clicks the Teams link in the booking flow.
    - The event can be listened to in the parent component of the booking flow e.g. a wrapper component.
- **Better Lead support.**
    - Meetings booked via a Lead now support multiple contacts.
    - Only the first contact is added as an event-relation, and all are added to `AMB_Meeting_Contact__c` which is referenced in `AMB_Event_Detail__c`.

### 1.13.0 — New features and improvements
- **Caching data in the booking flow.**
    - When going back and forth in the booking flow, the data is now cached, so the user doesn't have to re-enter data.
    - Reserved meeting timeslot will now be released when navigating back to meeting timeslot selection.
- **Travel time for meetings with start- and end-address.**
    - When selecting the 'ude af huset'/offsite meeting type, it is now possible to choose a start and end address. These addresses are used to calculate the travel time to and from the meeting.
    - The travel time is added as an extra time slot in the employee's calendar.
    - The address search uses DAWA (Danmarks Adressers Web API) to find addresses.
- **It is now possible to choose (optional) a meeting room before you select the meeting date/time.**
- **Forwarding meetings created via &bookme will now create/update the custom meeting participant object in Salesforce.**
    - `AMB_Meeting_Participant` is now populated with forwarded invitees with a status; Accepted, Tentative, Declined.
    - Contact &bookme-support to activate this feature.

> **IMPORTANT**
>
> - The integration user must have the "API Enabled" permission to sync attendees to Salesforce.
    >   - [Salesforce documentation](https://help.salesforce.com/s/articleView?id=sf.branded_apps_commun_api_permset.htm&type=5)
> - It needs access to the following objects:
    >    - `Event` (READ), `EventRelation` (READ/WRITE),
>    - `Email` and `Id` on `Contact` and `User` (READ),
>    - `AMB_Event_Detail__c` (READ) and `AMB_Meeting_Contact__c` (READ/WRITE)
>

### Fixed
- **Issue where it was not possible to override a specific meeting configuration.**
- **Issue where the Allowed Options for Employees did not in some cases respect Service Group assignments.**
- **Issue with Location Configurations that caused the meetings without a room to not show physical meetings.**
- **`AMBAdvisorCompetencesDTO` is now a Callable class.**
    - The `AMBAdvisorCompetencesDTO` class was previously a private class in the managed package which made it impossible to use outside the &bookme-package.

### Breaking changes

No breaking changes in this release.

## Release 1.12.0 (27-02-2024)
- Breaking change:
    - The current LWC flows for advisor booking and customer booking have been replaced/renamed.
    - The new names are `bookmeEmployeeFlow` and `bookmeCustomerFlow`
    - These function the same way as the old components but have a new interface, which includes the old public properties, wrapped in an object called `config`
- Bug fixes:
    - Exception logging is now correctly logged in AMB_Log__c
- Preparations for managed package release, so the package can be distributed on AppExchange.
    - A lot of internal refactoring and rework has been done to the code base.
    - Interfaces available for custom implementation after the transition is now implementing the callable interface (https://developer.salesforce.com/docs/atlas.en-us.apexref.meta/apexref/apex_interface_System_Callable.htm)
- Standard implementations of providers have been removed from the package
    - The functionality from our standard implementations of providers have been moved elsewhere
    - There is fallback to any custom implementation of the provider interfaces, so custom providers are still supported.
    - It is recommended to start using the AMB_Config setup that was introduced in v.1.10, which is further documented in the bookme onboarding/implementation guide.
    - However, to continue using custom provider implementations, go to the `AMB_Booking_Platform_DI_Implementations__mdt` custom metadata object and create a record with `DeveloperName` set to `CRUD_Provider_Implementation` and `Apex_Class_Name__c` set to `AMBFallbackCRUDProvider` (Remove this record again once the new Config setup is to be used).
- New search apex interface is now available
    - The search methods are now configurable by creating a custom class that implements the `Callable` interface, and implements the two actions `findContacts` and `getCloseContacts` in the `call` method.
    - `findcontacts` is called whenever Contacts are searched in the bookme flow.
    - `getCloseContacts` is called when default contacts are added to a meeting, during the bookme flow.
    - To configure this, go to the `AMB_Booking_Platform_DI_Implementations__mdt` custom metadata object and create a record with `DeveloperName` set to `Search_Provider_Implementation` and `Apex_Class_Name__c` set to `{YOUR_CLASS_NAME}`.
- New configuration based override function of meeting title, location pretty is now available
    - New way to configure custom meeting titles and pretty printed location for bookme.
    - Can be done by creating a class the implements the Callable interface.
    - Go to the custom metadata object `AMB_Meeting_Configuration__mdt` and create a record with the `Callable_Class_Name__c` set to your class name, and the `Callable_Action_Name__c` set to the correct action name in the `call` method.
    - The `Map<String,Object>` arg of the `call` method will contain a dto that can be cast to a `Callable` object.
    - Use this dto to get the initial meeting title or initial location by calling `dto.call('meetingTitle', new Map<string,Object>());` for meeting title, and `dto.call('location', new Map<string,Object>());` for location.
    - The actions should return a `String`.
- New feature: Competence groups
    - These are setup in the Management UI.
    - Advisors can now be grouped into service or competence groups.
    - Advisor skills/competences (themes and customer categories) can be assigned to a competence group. This will work in addition to skills/competences that are currently setup and fetched from salesforce.
- New feature: Service groups
    - These are setup in the Management UI.
    - Allows grouping of advisors (or competence groups).
    - Defines a service trigger and a service level.
    - The service trigger defines what conditions (Customer categories, themes, locations) must be met for the group to be active.
    - The service level defines what Locations and meeting types the service group advisors can be booked.
- New feature: Closing days
    - Add closing days for your organization in the Management UI.
    - Closing days will make any advisor unavailable for booking on the specific days.
-  Added translations for bookme customLabels for numerous languages (The used language will depend on the specific user's language setting in the organization).

## Release 1.11.3 (17-11-2023)
- If an AMB_Config__mdt record has been specified and is used for the booking of a meeting, It's Id is now stored on AMB_Event_Detail__c on the ConfigIdUsed__c field, and the config of the stored Id is fetched and reused whenever a meeting is edited/rebooked, instead of using the configuration of the configId set on the flow component.
- Fixed duplicate 'Specific Advisor' option that appeared in some situations.

## Release 1.11.2 (24-10-2023)
- Bug fix:
    - Fixed a bug where edit meeting would fail on a meeting that was booked directly on an account.
- New feature flags
    - `disableshowavailabletimesascustomerfilter` (boolean, defaults to false) can be set to true on the `ambBookingFlowAdvisor` to remove the checkbox to enable an advisor to see available timeslots from the customers point of view.
    - `configoverride` is an object that can be set to override the different advisor options that can be selected between. To control this, set the `configoverride` prop on `ambBookingFlowAdvisor` to an object where the prop `advisorOptionWhitelist` is defined. `advisorOptionWhitelist` should be defined as an array containing values from this collection `('SpecificAdvisors' | 'LocalAdvisors' | 'AllAdvisors')`. The values in the array, are the advisor values to be whitelisted.
- Existing flag reminders:
    - `disablecreaterecordcheckbox`can be set to true on `ambBookingFlowAdvisor` to remove the checkbox on the booking page, that controls whether a Lead or an Opportunity is created as a relation to the meeting. If this feature is removed, the meeting is always booked directly on the record of the booking flow.
    - `removeclosebutton`can be set to true to removed the button to close meeting booking on the last screen of the booking flow.
- Added initial english translations for custom labels used in booking

##Release 1.11.0 (03-04-2023)
- Added a new custom object `AMB_Log__c` used for logging different events occurring in the booking flow.
    - Additionally added more custom exceptions and exception handling, allowing errors that occur during the booking flow to be logged.
    - A new custom setting has been added `AMB Log Level Setting`, which can be configured to enable different debug levels, as well as configure how long the logs are kept in the org.
    - To start the clean up job for logs, execute the function `AMBLogCleanupScheduler.scheduleCleanupJob()` in anonymous apex for the org. This job will delete old AMB_Log__c based on what is configured in the custom setting `AMB Log Level Setting`.
    - Read more about how to use AMB_Log__c and the log utils in the deployment guide.
- The option to get available timeslots for 'Other Advisors' in the customer flow will now also look for timeslots for the primary advisor if possible.
- Added initial checks for correct configuration of Account and correct permission set on the start of a booking flow.
- Added an error boundary to the flow which enables it to show an error screen on critical errors.
    - Added new custom exception types in relation to this
- New feature added: Location for each advisor can now be configured per weekday in the Management UI in the advisor's schedule.

##Release 1.10 (06-03-2023)
- Added configurations to support booking meetings on Leads
    - The booking solution can now be setup with the use of configurations instead of overriding the various Providers
    - New custom metadata types AMB_Config__Mdt, AMB_SObject_Config__Mdt, AMB_Config_Relation__Mdt, AMB_Config_Field_Mapping__Mdt
    - Using records of these types together can create a configuration to be used for booking.
    - The SOBject_Config__mdt together with AMB_Config_Field_Mappings__mdt, defines how a specific Sobject is created, read, updated and deleted
    - AMB_Config__Mdt must have relations (AMB_Config_Relation__Mdt) between itself and an AMB_SObject_Config__Mdt, and must relate to a configuration for an activity (Event) and either an activity object or participant (eg. Opportunity or Lead).
    - Each AMB_Config_Field_Mapping__mdt defines which value is assigned to which field on the SObject creation/update.
    - The usage of the configurations is further described in detail in the deployment guide.
- Dependency Injection Metadata for standard providers no longer needs to be explicitly specified. Instead, &bookme will default to the standard implementations if no dependency injection provider is specified.
- Added infinite scroll to planner screen
    - Available times can be fetched through a "Hent flere tider" button, shown at the bottom of the page
- Added a rule that, when activated, disables the "book meeting" button until either a Contact or an external participant is added to the meeting
    - The rule is activated by creating a new metadata record of the type `AMB_Booking_Validation_Rule__mdt` with the rule name `RequireParticipantForBooking`
- The select input options for meeting rooms is now sorted alphabetically
- Added further filtering for advisor users when matching a user id with an advisor email
    - Now only searches through Users that are not portal users, don't have a Contact attached and are active Users.
- Improved the spinner overlay so it now blurs the background and is contained within the booking component

##Release 1.9.2 (23-01-2023)
- Support for allowing the customer booking flow component to start a custom flow with a sub theme ID that is not configured to be exposed to customers (Configured in the management UI).
- Added support for providing a record id (Only opportunity at the moment) which the meeting will be booked on. If no id is provided, an Opportunity is created, just as before.
- Added a custom metadata object `AMB_Booking_Validation_Rule__mdt` which contains various booking validation rules that can be enabled throughout the flow.
    - Currently only supports one rule `RequireContactForBooking` which, when enabled, requires that an actual Contact is participating when creating the meeting in the advisor flow.
    - To enable this rule, a record of the custom metadata object `AMB_Booking_Validation_Rule__mdt` must be created in the org with the rule `RequireContactForBooking`.
    - The custom metadata object supports that new validation rules can be added when needed
        - This is done by the developers of the package

##Release 1.9.1 (07-12-2022)
- Fixes an issue with the use of `update` custom flow where it would redirect back to the planner screen upon successful meeting edit.
- Names of contacts added to a meeting are now correctly formatted without a '-' at the end if they don't have a relation.
- Filters on the advisor planner screen now always default to unselected when editing a meeting.
- Update to the `AMBCloseContactTuple` DTO used in `getDefaultContacts` in the `AMBBookingController`, and in `getCloseContactRelations` in the `AMBAccountProvider`.
    - Added a new field `isSelected` which controls if the contact is selected to participate in the meeting.
    - The booking page will now use this field to select which contacts in participate in the meeting instead of selecting the first in the list.
    - If the `isSelected` field is not used for any of the contacts in the DTO, the first contact in the list is selected as default, just as before this change.
- Layout improvements to the contacts information/selection list in the advisor-flow.
    - To get the complete layout improvements, changes from the component library are required (PR !4448), which will be in an upcoming release of the component library package.


##Release 1.9.0 (31-10-2022)
- Removed packaged metadata for the DI Provider implementation records of the object type `AMB_Booking_Platform_DI_Implementations__mdt.object-meta`
    - By removing these from the package, they will no longer be overridden on each package install/upgrade, but will instead have to be created just once.
    - An apex class has been added `AMBDIProviderMetadataDeployment` with the method `upsertMetadataRecords()`, which deploys all the missing records, but won't override any of the existing records
        - An apex script should be created, which executes this method after install/upgrade of the booking-package.
        - The `Apex_Class_Name__c` field on the metadata records can then be edited to match the class names of your implementations of the providers, and will no longer be overridden on package upgrades.
- Upgraded SF REST API version of booking-package to 56.0
- Fixed an issue where reservation would fail when selecting a timeslot provided outside of the "only show timeslots available to customers" filter in the advisorflow.
- Expanded selection of opportunities in the "Move Event" quick action flow component to also include opportunities with expired `closeDate` which are still marked as `open`

##Release 1.8.1 (18-10-2022)
- Removed references to old booking components from component library which now exist in the booking-project instead.

##Release 1.8.0 (10-10-2022)
- Changed options in the "meeting duration" dropdown to 15 min intervals - both in the advisorflow and in the management UI.
- Added support for custom meeting title in the advisor flow
    - The feature can be disable through the flag `disablecustommeetingtitle` which can be set on the component `c-amb-booking-flow-advisor`.
    - An initial meeting title can be provided to the flow through the property `meetingtitle` on the component `c-amb-booking-flow-advisor`
    - If the feature is disabled, or if it's enabled and no meeting title is entered, it will default to using the AMBCustomizedStringProvider to set a meeting title.
- Fixed a caching issue related to getting the list of meetings after an update
- Fixed an issue with updating meetings where multiple advisors are added.
- Fixed an issue where updating a meeting resulted in duplicated pre- and postprocessing events.
- Fixed an issue where the overridden location would not be used in reservation of a timeslot
- Error events are now emitted when an error occurs during the bookingflow
    - To handle these events, listen for events of the type `onlogerror` emitted throughout the booking components
- Added support for PermissionSetGroup when checking if a user has the advisor PermissionSet (`AMBSecurityUtils.isAdvisor`)


## Release 1.7.1 (26-09-2022)
- Fixed an issue where meeting rooms were not being booked on meetings, even when they were configured to be required

## Release 1.7.0 (19-09-2022)
- New input in advisor flow: Ability to search and select other locations than the customer's default, when looking for available time slots
- New filter in advisor flow: When selected, shows available time slots as if it was the customer.
    - Replaces the "ignore minimum time from booking to meeting" filter
    - When the filter is unchecked, more available timeslots are shown, as the configuration `ignore minimum time from booking to meeting` is ignored, and the advisor's/advisors' availability is extended to the opening and closing times set in the bank configuration `Banken's åbningstider`.

## Release 1.6.0 (02-09-2022)
- New filter added for advisorflow, making it possible to ignore the "minimum time from booking to meeting" configuration.
- Fixed an issue where reservation of a timeslot would give an error when clicking the icon on the button.
- Added parent/child relationship between taxonomy objects (AMB_Taxonomy__c)


## Release 1.5.0 (11-07-2022)
- New LWC 'ambMoveMeetingEventAction' to use in quick action flow for Event object. The quick action flow can be used to move the 'WhatId' relation of an Event to another record. This can either be the related Account or an Opportunity of the related Account.
    - The component has 3 handles: 'eventId' which is the id of the current event, 'brand' which is the branding to use, 'disablerelationtoaccount' which is a flag that can be set to disable the option to move the event to the related Account

## Release 1.4.0 (24-06-2022)
- Feature: Meetings can now be created directly on an account. A new checkbox has been added to the BookingPage for advisors, to select if a new opportunity should be created, or if the meeting should be created directly on the account. This feature can be turned off with the feature flag 'disablecreateopportunitycheckbox' on the ambBookingFlowAdvisor component
- Interface for createCustomerMeeting on ActivityProvider updated: opportunityId changed to whatId, since meetings can now be booked on accounts as well
- Comments on booked meetings are no longer sent to the booking backend. These are now fetched from event detail on a meeting
- Fixed a bug where meeting type choice would reset when writing a comment during 'Edit meeting' flow
- Fixed issue with email validation for contact participants and external participants. Emails that are invalid are now removed.
- Removed descriptive texts for meetingtypes and advisortypes on ambBookingPlanner in customerflow
- New flag 'disableheaders' on the ambBookingFlowAdvisor component for disable/removing headers (+ backbuttons) throughout the advisor booking flow
- Fixed bug where defaultRecordTypeId would use Opportunity record type instead of Event record type

## Release 1.3.0 (27-05-2022)
- Components only related to the bookingplatform (mainly the screens of the flow) have been moved from the shared component library to the booking-project. These components have been renamed to fit the booking-project naming and the old version of these components in the component library will be deprecated
- If a room has been booked for a meeting, it's name will now be displayed on the confirmation screen, and will be stored in AMB_Event_Detail__c in salesforce
- Added where clause to EventRelation query to avoid fetching too many entries on edit meeting
- Added customerflow property override for advisor types and meeting types

## Release 1.2.0 (12-05-2022)
- New "Planner" screen in customer flow (Select input instead of filters)
- New "Booking" screen in customer flow (Contact email input and more information about meeting etc.)
- Improvements to responsiveness of some of the components used throughout the booking flow

## Release 1.1.0 (29-04-2022)
- Added custom flows to the booking components
    - bookingRecordPageFlow and bookingExperienceFlow can be initiated with custom flows
    - Initiate custom flows by wrapping the recordPage and experience flow components and providing them with necessary properties

## Release 1.0.0 (28-04-2022)
- Added spinners to various AuraEnabled callouts (getMeeting, cancel, reschedule, book, etc..)
- Improvements to test utils
    - Improved advisorProvisioning
    - Fixed user provisioning in MeetingController test that provisioned 2 users separately