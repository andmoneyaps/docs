---
layout: default
title: Phase 3 - Adaptation & Development
description: Technical implementation and customization phase
nav_order: 4
parent: Implementation Guide
---

# Phase 3 - Adaptation & Development

This phase covers the technical implementation and customization of &bookme Scheduler.

## Technical Implementation

### Authentication Setup
- Legacy Auth Provider configuration
- Named Credentials setup
- Salesforce Connected App configuration
- Shared Activities setup

### Data Provider Implementation
- Search Provider implementation
- SLA Utility implementation
- Meeting Configuration setup
- Competence provider configuration

### Custom Metadata Configuration
- Brand Settings setup
- Booking Validation Rules
- Field mapping configuration
- Object relationship definitions

## System Integration

### User Management
- &bookme System User creation
- Permission set assignments
- Integration user setup
- Access control implementation

### Salesforce Integration

#### Record Page Integration
- Opportunity Record Page
  - Standard component embedding
  - Context functionality extension
  - Custom button configuration

- Event Record Page
  - Component integration
  - Workflow customization
  - Field mapping setup

- Account Record Page
  - Component embedding
  - Context integration
  - Custom functionality extension

### Custom Label Configuration
- Terminology alignment
- Translation management
- Label overrides
- Text customization

## Data Configuration

### sObject Field Mapping
- AMB_Config__mdt setup
- AMB_SObject_Config__mdt configuration
- AMB_Config_Relation__mdt mapping
- Field mapping implementation

### Competency Management
- Standard implementation setup
- Custom provider configuration
- Role-based assignments
- Validation rules

### Location Management
- Location hierarchy setup
- Room mapping configuration
- Department structure
- Global/local settings

## Component Configuration

### BookmeCustomerFlow
- Experience site integration
- Parameter configuration
- Event handling setup
- Validation implementation

### BookmeEmployeeFlow
- Record page integration
- Configuration options setup
- Event handling
- Custom functionality

## Testing & Validation

### Integration Testing
- Authentication verification
- Data flow validation
- Permission testing
- Component functionality

### Configuration Testing
- Custom metadata validation
- Field mapping verification
- Location management testing
- Competency assignment validation

### User Acceptance Testing
- Workflow validation
- Interface testing
- Permission verification
- Error handling

## Success Criteria

1. Technical Implementation
   - All integrations functional
   - Data providers implemented
   - Custom metadata configured
   - Security measures verified

2. Component Integration
   - Record pages configured
   - Booking flows operational
   - Event handling validated
   - Custom functionality working

3. Data Configuration
   - Field mappings verified
   - Competency management active
   - Location structure implemented
   - Custom labels configured

4. Testing Completion
   - All test cases passed
   - User acceptance confirmed
   - Performance validated
   - Security verified


# Detailed task description for Phase 3 – Adaptation and development

&bookme - Scheduler offers a wide range of configurations/customizations that ensure the product fits into your sales pipeline. In this section you will find the documentation for the fixes, configurations and customizations &bookme - Scheduler supports in relation to the implementation of the solution in complex organizations.
You will also find guidelines for data quality and data relationships that must be met to get the most out of the solution.

### &bookme Salesforce - Create your own configuration for sObject field mapping
It is possible to override &bookme – Scheduler’s access to standard objects via a no-code solution that can be extended with custom apex for transformations.

The no-code configuration is based on custom metadata types, so it can be easily migrated between systems and allows the creation of a configuration containing an activity object or an activity participant, as well as an Event. Each configuration of an sObject type is done by creating an AMB_SObject_Config_mdt record with the associated AMB_Config_field_Mapping__mdt.

This defines where &bookme – Scheduler can read and write from, and whether the individual field should be read with or without field level security. Each AMB_SObject_config__mdt can be created with or without sharing enabled.

Recommendation - We currently recommend leaving sharing disabled as customers will not normally have CRUD access to the sales pipeline.

![Sales pipeline]({{ site.baseurl }}/assets/images/bookme/implementation-guide/sales-pipeline.png)

*Figure 1- Data model for sObject data access through configuration*

#### **Using amb_config__mdt**
AMB_Config__mdt defines an Id for a given configuration consisting of 2 AMB_SObject_Config__mdt records. This Id can be specified as configId when using the BookmeCustomerFlow and BookmeEmployeeFlow LWC components

#### **Amb_sobject_config__mdt**
AMB_SObject_Config__mdt defines which fields should be read, written and updated on a given Event, Activity Participant or Activity Object record.
It is also possible to define whether CRUD operations on the given sObject type should be performed with or without sharing rules.

#### **Amb_config_relation__mdt**
AMB_Config_Relation__mdt makes it possible to define a many-to-many relationship between an AMB_Config__mdt and an AMB_SObject_Config__mdt record. This makes it possible to create few AMB_SObject_Config__mdt records (e.g. one per record type) and reuse these across multiple configurations. An example here could be to create one record for CRUD operations on an Event and reuse this in configurations on Opportunity and Lead respectively.

#### **Creating amb_config_field_mapping__mdt**
AMB_Config_field_mapping__mdt contains a source to target field mapping between an AMBBookMeetingDTO object and a field on the given AMB_SObject_Config__mdt record. Each mapping can be done directly if the type of source and target respectively is compatible, or via a converter function that can map from Source to Target. The Apex function can also be used to aggregate data. Util_Class_Name__c must implement Salesforce's Callable interface, which allows dynamic field access on Records. Util_Method_Name__c is a function that takes two inputs, a callable dto (AMBBookMeetingDTO) and a sourceName (string).


### Deployment of the solution

In order for the solution to be deployed, certain data requirements must be met.

#### **Account data requirements**
- AMB_Location__c
   Must be populated with an AD location that matches advisors and premises exposed through Azure SCIM
- AMB_Customer_Category__c
   Must point to a Customer category from AMB_Taxonomy__c, synchronized from the &Money-Management configuration

#### **User data requirements**
- Advisor Email
   The advisor's email field must match their AD email exposed via Azure SCIM to the &bookme – Scheduler backend

#### **Competence data requirements**
- AMBAdvisorCompetence__c must contain a many-to-many mapping between AMB_Taxonomy__c objects and advisor User Id


## Location matching between Entra and Salesforce

In &bookme - Scheduler, 3 different location concepts are used.

| Customer location  | Advisor location  | Meeting room location  |


When booking a meeting for a given customer through Bookme – Scheduler, the **customer's location** determines the availability of advisors and meeting rooms in the booking process.

The **customer's location** is retrieved by default via the customer's Salesforce account. An example of such a string could be "Finans Allé 1-3".
When the flow then displays available advisors under "department" or "global", these advisors are filtered down to advisors who either have the same location as the customer, or are marked as global advisors.

The **advisor's location** is given to &bookme - Scheduler through Azure SCIM. If this location exactly matches the text string displayed as the **customer's location**, the advisor will be able to appear under "department" in the advisor flow.

The **meeting room location** is given to &bookme - Scheduler through Azure SCIM, and just like the **advisor's location**, this is given via Azure SCIM. The list of meeting rooms in the advisor flow will therefore always be filtered down to meeting rooms whose location matches the customer's location.

This means that if the **customer's location** is "Finans Allé 1-3", only exact syllables in the advisor and meeting room location match.


| Location  | Mathes the customer's location  |
|------------|-------|
| Finans Allé 1-3 | Yes ✅|
| Finans allé 1-3 |No ❌|
| Finans Allé 1 | No ❌|
| Finans Allé 3 | No ❌|
| Finans Allé1-3 | No ❌|

## Using custom labels
In the booking components we use "custom labels", which means that you can overwrite the default values ​​set for the text fields on various screens in the booking flow.
Here you must use translations, by creating a translation in the language used in the org, for the custom label you want to overwrite.
You should not go in and change the default values ​​for booking custom labels directly, as these will be reset with each upgrade/installation of the package.

## Documentation for naive competency management

As a starting point, &bookme – Scheduler uses the Andmoney__AMBAdvisorCompetence__c object to manage competencies for all employees in the solution.
However, the management can also be implemented programmatically by implementing a Competence provider, so that the solution no longer looks up the individual advisor's competencies in an object, but instead calculates them on-the-fly.
Some customers today have a solution where, via the user's job title, they have a standard group of meeting topics and customer groups that they return instead of looking them up in our object.

If you do not want to differentiate at all by customer categories or meeting types, competency retrieval can be turned off by short-circuiting the solution so that all advisors can advise in all customer groups and meeting topics.
A less aggressive version would be, for example, to calculate the right customer categories, and then turn off meeting competencies by giving all competencies in the APEX class.

## Exhibition of booking flows
The booking solution consists of 3 LWC components for customer-facing booking and advisor-facing booking and advisor-facing opportunity management, respectively.

| BookmeCustomerFlow  |  BookmeEmployeeFlow | AMBMoveMeetingEventAction |
|------------|------------|------------|
|LWC component that can be embedded in an experience site for customer-facing booking. This component is exposed in the Experience builder | LWC-komponent der kan indlejres i Account, Case og Opportunity record pages til rådgivervendt booking. Denne komponent er exposed i Page builderen. |Salesforce Flow Enabled LWC-komponent til brug i quick actions til at flytte events mellem account og opportunities |

### Advanced configuration of BookmeCustomerFlow

Configurations on BookmeCustomerFlow are done via the public attribute Config, which allows you to provide a complex configuration object to the solution. Below are the options in the object

| Mutual | Configuration           | Description |
|--------|------------------------|-------------|
| No     | advisorOptionWhitelist | Allows you to specify a whitelist of advisor options that are added as a filter on the backend configuration. This makes it possible to ensure that the customer is never offered a specific advisor option even if the customer is eligible for it in the Mgmt UI.<br>**Possible filter values:**<br>- PrimaryAdvisor<br>- OtherAdvisors |
| No     | meetingTypeWhitelist   | Allows you to specify a whitelist of meeting types that are added as a filter on the backend configuration. This makes it possible to ensure that the customer is never offered a specific meeting type even if the customer is entitled to it in the Mgmt UI.<br>**Possible filter values:**<br>- Physical<br>- Online<br>- Telephone<br>- OffSite |
| Yes    | customflow | Property is used to control which custom flow is desired. This can have these valid values: <br> **withtheme**: Used to start the booking flow with a pre-selected theme. <br> - **update**: Used to go directly to the “reschedule” page in the experience flow for an existing meeting, or start an “edit” flow in the record-page flow for an existing meeting <br> - **cancel**: Used to go directly to the “cancel meeting” page for an existing meeting |
| Yes | meetingId | The ID of the meeting in &bookme - Scheduler with which you want to start an "update" or "cancel" flow |
| Yes | subthemeid | The subtheme ID of the theme you want to start a flow with a preselected theme with |
| Yes | disableprogressbar | Hides the progress bar at the top of the flow |
| Yes | disablecustomermeetings | Hides the meeting overview at the start of the flow |
| Yes | removeclosebutton | Hides the option to press the "Close meeting booking" button on the confirm page |
| No | contactId | Required: contactId of the customer initiating the meeting booking |
| Yes | accountId | Required: AccountId for the account the customer is associated with |

### Advanced configuration on BookmeEmployeeFlow

| Mutual | Configuration           | Description |
|--------|------------------------|-------------|
| No | disableheaders | Hides header and back button in the flow |
| No | disablecustommeetingtitle | Removes the feature to manually set/edit meeting title. |
| No | meetingtitle | Start BookmeEmployeeFlow with a predefined meeting title |
| No | disableadditionalcontacts | Hides the ability to add meeting contacts |
| Yes | customflow | Property is used to control which custom flow is desired.This can have these valid values: <br> - **withtheme**: Used to start the booking flow with a pre-selected theme. <br>- **update**: Used to go directly to the “reschedule” page in the experience flow for an existing meeting, or start an “edit” flow in the record-page flow for an existing meeting <br>- **cancel**: Used to go directly to the “cancel meeting” page for an existing meeting |
| Yes | meetingid |  The ID of the meeting in &bookme - Scheduler with which you want to start an "update" or "cancel" flow |
| Yes | subthemeid |  The subtheme ID of the theme you want to start a flow with a preselected theme with |
| Yes | disableprogressbar |  Hides the progress bar at the top of the flow |
| Yes | **disablecustomermeetings** |  **Hides the meeting overview at the start of the flow** |
| Yes | removeclosebutton |  Hides the option to press the "Close meeting booking" button on the confirm page |

#### **Advanced configuration of AMBMoveMeetingEventAction**

|--------|------------------------|
| EventId | Salesforce event ID of event to be moved |
| brand | Styling to be used |
| disablerelationtoaccount | Remove the ability to relate the event directly to an account |

#### **LWC Events**

|--------|------------------------|
| logerror | This event is executed every time an error occurs in the booking flow |
| back | Executed when the "back" button is pressed in a custom flow |
| close | Executed when the "Close meeting booking" button is pressed |
| meetingbooked | Executed when a meeting has been booked or updated |
| meetingcanceled | Executed when a meeting has been canceled |

## &Bookme – setup requirements and points to consider

Requirements for setup:
- Salesforce permission sets MUST be set correctly for Advisor both in terms of the account and in terms of booking
- Advisor's user email in Salesforce MUST match the advisor's email as specified via the bank's Entra
- Advisors, rooms and customers are matched together based on their location string. A match requires that the location string is 100% identical - otherwise rooms, advisors and customers cannot be linked together.
- Also always check the 'Manage availability' overview in the management UI - Red 'crosses' indicate problems that MUST be fixed

#### **Points of attention**
- &bookme - Scheduler synchronizes calendars up to n days into the future (default 60 days). This means that a meeting booked further into the future than n days will only take into account free time for other meetings booked through &bookme
- Repeated meetings and meetings over several days (e.g. vacation) that were booked before &bookme synchronization was enabled are currently not synchronized
- Past meetings cannot be edited via &bookme - Scheduler
- Advisors may only be created in one environment at a time (i.e. an advisor cannot be in both the test and production environments)
- If a search for an advisor returns too many results, you must use an email alias to find the advisor, i.e. <initials>@....
- If other advisors are invited to the meeting, you can only see their acceptance of the invitation in Outlook
- If meeting creation in Salesforce fails, the meeting is not canceled in Backend/m365

#### **Support tickets**
- Describe the process in as much detail as possible so that we can recreate the experience (including what the expected result was)
- For troubleshooting in Salesforce, we often need to enable the debug log and then send the log to &bookme's service desk.
- In case of errors on booked meetings, it is important to include the meeting's bookingId for troubleshooting in the &bookme -Scheduler solution

### Extraordinary calendar availability
This feature is used if an advisor wants to be available outside of the availability configured in the Management UI.
To use the feature, the advisor must book the &bookme - Scheduler Integration User in their outlook calendar (the user that the bank has set up for the MS365 integration service - e.g. the bank's IT department has the details of this user).
This signals to &bookme - Scheduler that the advisor is available outside of normal availability, but only for online and telephone meetings.

![Extraordinary calendar availability]({{ site.baseurl }}/assets/images/bookme/implementation-guide/calendar-availability.png)

### Offer of advisor for given configuration
This section provides an overview of when appointments are scheduled for an advisor in different scenarios.

#### **BookmeCustomerFlow**
In BookmeCustomerFlow you can choose between ‘My Advisor’ and ‘Other Advisors’. The location sent when asking about available appointments is the one configured on the Account.

*Offer as primary advisor*

| Location | My advisor | + Others |
|--------|------------------------|-------------|
| SCIM match     | ✅ | ✅ |
| Schedule match | s   | ✅ |
| No match | 	Physical ❌ <br>  ✅ | Physical ❌ <br> ✅  |

The primary advisor will be the advisor who is set as Account Owner for the customer's Account.

**Example of how to read the table:**
The table shows when the primary advisor's times will be displayed.
- If the Account location matches the advisor's SCIM location, times for the primary advisor will be displayed under 'My Advisor' and 'Other Advisors'.
- If the Account location matches the location configured in the advisor's schedule for that weekday, times for the primary advisor will be displayed under 'My Advisor' and 'Other Advisors'.
- If the Account location does not match the primary advisor's SCIM or Schedule location, only online and phone times will be displayed.

*Tender as a local advisor*

| Location | My advisor | + Others |
|--------|------------------------|-------------|
| SCIM match     | ❌ | ✅ |
| Schedule match | ❌	| ✅ |
| No match       | ❌ | ❌ |

A local advisor will be an advisor who is NOT the Account Owner, but has the same SCIM/Schedule location as the one configured on the Account.

*Tender as a global advisor*

| Location | My advisor | + Others |
|--------|------------------------|-------------|
| SCIM match     | ❌ | Physical ❌ <br> ✅ |
| Schedule match | ❌	| Physical ❌ <br> ✅ |
| No match       | ❌ | Physical ❌ <br> ✅ |

A global advisor is an advisor who is configured as Global in the Booking Management UI. Appointments are displayed for these advisors even if their SCIM/Schedule location is different from the Account location.

### BookmeEmployeeFlow 
In BookmeEmployeeFlow you can search for times for either specific advisors, local advisors or all available advisors (Local and Global).

The tables below show when times are posted for the different scenarios.


*Specific advisor*

| Location | My advisor | + Others | + Global |
|--------|------------------------|-------------|-------------|
| SCIM match     | ✅ | ✅ | ✅ |
| Schedule match | ✅	| ✅ | ✅ |
| No match       | ✅ | Physical ❌ <br> ✅ | Physical ❌ <br> ✅ |

*Local advisor*

| Location | My advisor | + Others | + Global |
|--------|------------------------|-------------|-------------|
| SCIM match     | ❌ | ✅ | ✅ |
| Schedule match | ❌	| ✅ | ✅ |
| No match       | ❌ | ❌ | ❌ |

*Global advisor*

| Location | My advisor | + Others | + Global |
|--------|------------------------|-------------|-------------|
| SCIM match     | ❌ | ❌ | Physical ❌ <br> ✅ |
| Schedule match | ❌	| ❌ | Physical ❌ <br> ✅ |
| No match       | ❌ | ❌ | Physical ❌ <br> ✅ |