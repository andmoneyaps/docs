---
layout: default
title: Phase 2 - Clarifications & Staging
description: Technical and business clarifications phase
nav_order: 2
parent: Implementation Guide
---

# Phase 2 - Clarifications & Staging

This phase ensures all technical and business requirements are clarified before development begins.

## Technical Clarifications

### Entra Integration Setup
- SCIM integration task division
- Enterprise Application registration
- User provisioning workflow
- Access management configuration

### Integration User Configuration
- Permission scope definition
- Access level documentation
- User role assignment
- Security protocol establishment

### Azure DMZ Security Proxy
- Technical documentation handover
- Container deployment specifications
  - TEST environment setup
  - PROD environment setup
- Container configuration requirements
- Security protocol implementation

### Sandbox Environment
- Development resource access
- Package installation verification
- Integration testing setup
- UAT environment preparation

## Business Clarifications

### General Settings
- Branch operating hours configuration
- Meeting booking time constraints
- Daily meeting capacity limits
- System-wide defaults

### Meeting Configuration

#### Types and Categories
- Online meeting setup
- Physical meeting requirements
- Phone meeting configuration
- Other meeting type specifications
- Meeting type prioritization rules

#### Time Management
- Meeting duration by theme
- Pre/post processing time allocation
- Booking window restrictions
- Time gap requirements
- Buffer time configuration

### Location Management

#### Physical Locations
- Location mapping strategy
- Room booking system integration
- Creation/deletion procedures
- Room identification standards
- Location status management

#### Employee Assignment
- Department mapping
- Location-based assignments
- Global vs. local advisor setup
- Resource allocation rules

### Employee Configuration
- System access assignments
- Unique identifier management
- Alias name configuration
- Onboarding/offboarding procedures

## Management UI Configuration

### Initial Setup
- Default value configuration
- Meeting taxonomy creation
- Customer category setup
- Meeting configuration completion
- Room usage parameter definition

### Validation
- Configuration testing
- User access verification
- Integration point validation
- Workflow testing

## Success Criteria

1. Technical Setup
   - All integrations configured
   - Security measures implemented
   - Access controls established
   - Test environment operational

2. Business Configuration
   - Meeting types defined
   - Location mapping completed
   - Employee setup finalized
   - Workflows documented

3. Documentation
   - Technical specifications complete
   - Configuration guides created
   - User procedures documented
   - Support processes established

---
layout: default
title: Phase 2 - Technical Setup Guide
description: Technical and business clarifications phase
nav_order: 3
parent: Implementation Guide
---


# Detailed task description for Phase 2 – Clarifications & staging (technical clarifications)

This guide covers the technical setup requirements and steps for deploying &bookme Scheduler.

## Entra and Azure Configuration

### Pre-deployment

### Enterprise Applications for Calendar Access

Before deploying graph-proxy, create an Enterprise Application with:
- `Calendars.ReadWrite` role
- `Calendars.Read` role
- Admin consent granted

![Enterprise Applications for Calendar Access]({{ site.baseurl }}/assets/images/bookme/implementation-guide/Enterprise-Applications-for-Calendar-Access.png)


### Integration User Setup

1. Create an integration user with restricted access:
   - Rooms: AvailabilityOnly
   - Users: Author

2. Grant permissions using PowerShell commands:

```powershell
# For Rooms:
Add-MailboxFolderPermission -Identity <Room@Organisation.onmicrosoft.com>:\Calendar -User IntegrationUser@Organisation.onmicrosoft.com -AccessRights AvailabilityOnly

# For Advisors:
Add-MailboxFolderPermission -Identity User@Organisation.onmicrosoft.com:\Calendar -User IntegrationUser@Organisation.onmicrosoft.com -AccessRights Author
```

This will display the full command without cutting off any part of the string.

![Enterprise Applications for Calendar Access]({{ site.baseurl }}/assets/images/bookme/implementation-guide/graph-explorer.png)


**Note**: Integration User requires a Microsoft 365 E5 Developer license.

![Enterprise Applications for Calendar Access]({{ site.baseurl }}/assets/images/bookme/implementation-guide/m365e5-license.png)

### User provisioning through SCIM protocol integration for Microsoft Entra

User provisioning in &bookme takes place through SCIM endpoints that can be connected directly to Microsoft Entra (formerly Active Directory), and ensures that user provisioning in &bookme can take place via already existing Entra groups.

To make use of SCIM provisioning, the following must be done:
1. Transfer SCIM Token from &money
2. Create an Enterprise application in Microsoft Entra
3. Configure Tenant URL endpoints
4. Create SCIM attribute mapping
5. Test
6. Set up monitoring
7. Add users and rooms for provisioning


SCIM Provisioning can take place on 2 specific resource types:
• Employees
• Rooms

### Create enterprise application registrations

Two **Enterprise Application Registrations** are required for each Environment to set up provisioning, one for Advisors and one for Rooms.  
To set up the Enterprise Application Registrations:  
-	Go to the [Microsoft Entra portal](https://entra.microsoft.com) --> Applications --> Enterprise Applications --> Create Your Own Application 
The name has no effect other than for discoverability. We recommend the following naming schema for visibility. This allows for your system admins to distinguish between environments and resource provisioning types:  
-	`andmoney-bookme-{environment}-{resource}`
The Enterprise Application Registration should be a non-gallery app. 

![Enterprise Application Registrations]({{ site.baseurl }}/assets/images/bookme/implementation-guide/microsoft-enterprise-application.png)

3. **Configure Tenant URLs** based on environment:

To configure the enterprise application SCIM provisioning select your enterprise application for either **Advisors** or **Rooms** and go to:  
- Provisioning --> Edit Provisioning --> Admin Credentials 
Here you should set up the appropriate &Money **Tenant URL** provisioning endpoint depending on environment and resource provisioning type along with their associated secret token(s):  


| Environment\Resource  | Tenant URL: Advisors  | Tenant URL: Rooms  |
|------------|--------------|-----------|
| Test | https://api.test-env.booking.andmoney.dk/advisors/scim | https://api.test-env.booking.andmoney.dk/rooms/scim |
| Production | https://api.booking.andmoney.dk/advisors/scim | https://api.booking.andmoney.dk/rooms/scim |

The “Secret Token” is provided by &Money.  

4. **Configure Attribute Mappings**
To configure the Enterprise Application Attribute Mappings, select your Enterprise Application for either Advisors or Rooms and go to:  
-	Provisioning --> Edit Provisioning --> Mappings --> Provision Azure Active Directory Users 
The adjust the attribute mappings according to the following tables depending on the resource type: 


For Advisors:

| Customappsso Attribute | Microsoft Entra ID Attribute |
|------------------------|----------------------------|
| active | Switch([IsSoftDeleted], , "False", "True", "True", "False") |
| userName | userPrincipalName |
| displayName | displayName |
| name.given | givenName |
| name.family | family |
| addresses[type eq "work"].formatted | physicalDeliveryOfficeName |

![Attribute mappings Advisors]({{ site.baseurl }}/assets/images/bookme/implementation-guide/attr-mappings.png)

For Rooms:

| Customappsso Attribute | Microsoft Entra ID Attribute |
|------------------------|----------------------------|
| active | Switch([IsSoftDeleted], , "False", "True", "True", "False") |
| userName | userPrincipalName |
| displayName | displayName |
| addresses[type eq "work"].formatted | physicalDeliveryOfficeName |

![Attribute mappings Rooms]({{ site.baseurl }}/assets/images/bookme/implementation-guide/attr-mappings-rooms.png)



### Verification & Testing 
When an Enterprise Application Registration has been configured it is possible to test it against the &Money solutions systems. This can be done at the following levels:  
1.	Tenant URL configuration validity:  
   -	Use the “Test Connection” button when editing the provision 
   -	Go to Enterprise Application --> Provisioning --> Edit Provisioning --> Admin Credentials --> Test Connection 
2.	Provision on-demand: 
   -	Use on-demand provisioning for a subset of users before rolling it out broadly. 
   -	Go to Enterprise Application --> Provisioning --> Provision on demand 


### Monitoring 
To Monitor that the SCIM provisioning is working as intended continuously it is possible to configure an email address to notify when failure occurs. To do this:  
-	Go to Enterprise Application --> Provisioning --> Settings --> Enable Send Email  
This will need to be configured for each Enterprise Application Registration that needs to be monitored. 
More Advanced monitoring scenarios can be achieved by integrating the Enterprise Application Registrations with Azure Log Analytics.  

![Monitoring]({{ site.baseurl }}/assets/images/bookme/implementation-guide/monitoring.png)


### Assign Users & Rooms for Provisioning 
Now that provisioning is configured, assign the Advisors and Rooms to their respective Enterprise Application Registrations. 


### Continuously Updating Integration User 
You should consider how to keep the integration user up to date with permissions. This can occur when: 
-	A new employee is being onboarded. 
-	An existing employee is removed from the solution.  
 
Here is a suggestion on some commands that can add the permissions, this can be run in a script automatically executing it. 
The integration user must be a licensed exchange online should have the following permissions: 
1.	Room Calendar: AvailabilityOnly  
   -	AvailabilityOnly is required to inspect the availability of Rooms. 
   -	Example: Add-MailboxFolderPermission -Identity Room@Organisation.onmicrosoft.com:\Calendar -User IntegrationUser@Organisation.onmicrosoft.com -AccessRights AvailabilityOnly 
2.	User Calendar: Author  
   -	Author is required since we need to impersonate the User as the owner of meetings. 
   -	Example: Add-MailboxFolderPermission -Identity User@Organisation.onmicrosoft.com:\Calendar -User IntegrationUser@Organisation.onmicrosoft.com -AccessRights Author 

To execute the commands above, you must be in powershell and have the ExchangeOnline Module installed. This can be done via the [PowerShell Gallery](https://www.powershellgallery.com/packages/ExchangeOnlineManagement/3.4.0) (Opens in new window or tab)  
To authenticate, run the command Connect-ExchangeOnline -UserPrincipalName <YOUR USERNAME> 
Please note that the calendar folder can be localized for some users. If this is the case, the names can be reset using the following command: 
```powershell
Get-Mailbox -Identity <IDENTITY> | Set-MailboxRegionalConfiguration -LocalizeDefaultFolderName:$true -Language "en-US" 
```

#### **Common issues during setup **
Missing the required permissions on the integration user, please make sure to double check those are set. 
Nested AD groups with users in it assigned to the SCIM provisioning will not work for example: AD Group --> AD Group --> Users. However, it will work with just one AD Group, and it is our recommended way to set up the SCIM provisioning. 



### Deployment

When deploying a graph proxy in AD, it is recommended to use a **container app** resource in Azure, as it is the most cost-effective and minimal compared to just running a container image with some environment variables.

The Graph proxy is deployed through our public container registry, where the latest image can be downloaded from the resource below:

***externalmoneybookingplatform.azurecr.io/graph-proxy:latest***

Once the container app resource is created, it must be configured with the following secrets. It is recommended that they are stored in a keyvault and referenced in this way:

![Graph Proxy Secrets]({{ site.baseurl }}/assets/images/bookme/implementation-guide/graph-proxy-secrets.png)


#### **Graph Proxy Container Setup**
For correct configuration of the container app, it is important that the following environment variables are defined:

| Variable | Description |
|----------|-------------|
| Microsoft365__TenantId | Your Azure AD tenant ID |
| Microsoft365__ClientId | Client ID for graph-proxy app registration |
| Microsoft365__ClientSecret | Client secret for graph-proxy app registration |
| Microsoft365__Username | Integration user username |
| Microsoft365__Password | Integration user password |
| AzureAD__ClientId | &money app registration ClientId (Test: efb54ece-1070-4539-8c97-abdef4296af9, Prod: EB25D79C-0BD1-4A8E-BFFB-A0FF49A14B9F) |
| ReverseProxyStr | Stringified YARP Config for GraphApi Endpoints |

### Employee access to &bookme Management UI through SSO and Enterprise Applications

&bookme Scheduler can be configured via the solution's Management UI, which is a standalone portal for setting up business rules. Access to this is provided through SSO and role management via Entra Enterprise applications.

Access to test and production is provided through the links below, which create the relevant Enterprise applications and enable roles to be added to specific employees
Replace the placeholder “TENANT_ID_FOR_BANK” with the correct Entra tenant ID for the Entra organization.
Enterprise applications for testing:

Test Environment:
- API: `https://login.microsoftonline.com/TENANT_ID_FOR_BANK/adminconsent?client_id=6b7bb15f-9fa3-4fea-9291-032de7636d3a`
- UI: `https://login.microsoftonline.com/TENANT_ID_FOR_BANK/adminconsent?client_id=aedd9e1c-0361-4902-bd41-a7610498f2de`

Production Environment:
- API: `https://login.microsoftonline.com/TENANT_ID_FOR_BANK/adminconsent?client_id=cb38e3dc-61cd-4955-b973-b650406fa335`
- UI: `https://login.microsoftonline.com/TENANT_ID_FOR_BANK/adminconsent?client_id=4b7e5091-3eec-4750-a1f7-3d4e91da89ad`

This provides access to the following roles for the respective environment:
-	AMB_configurationAccess – Users assigned this role are allowed access to the configuration section of the &Money web portal: `Management UI`. 
-	AMB_managementAccess – Users assigned this role are allowed access to the management section of the &Money web portal: `Management UI`. 

Below is an example where an employee has been assigned both roles for the test environment:

![Test environment roles]({{ site.baseurl }}/assets/images/bookme/implementation-guide/test-env-roles.png)

**We recommend that internal processes or automation be created to grant permissions to new employees for the integration user.**

## Salesforce Package Installation
&bookme – Scheduler is a solution that is delivered via Salesforce AppExchange packages and can be easily installed.
The &bookme - Scheduler package consists of a project package and a dependency on an internal &money package. Dependencies must currently be installed before the primary project package, according to AppExchange guidelines.
Deployment is thus divided into 2 steps:
1. Installation of the &money Component package
2. Installation of the &bookme project package.

The creation of the integration user has the following requirements:

| Field | Value |
|------------------------|----------------------------|
| License | Salesforce |
| usPermission set assignments | Booking platform – integration  |

Depending on the security setup in the environment, it may be required that &money's backend IP is whitelisted in the integration user's profile (See provided data sheet).
### Create auth. Provider
Create an auth. provider for outgoing calls to &bookme – Scheduler backend.

| Field | Value |
|------------------------|----------------------------|
| License | Salesforce |
| usPermission set assignments | Booking platform – integration  |
| Name | 	AMBAuthProvider |
| URL suffix |	BookingAuthProvider |
| Client Id | See the data sheet provided. |
| Client Secret |	See the data sheet provided. |
| Execute Registration |	Insert the integration user created in the section “Creating an integration user in the deployment environment” |
| Include Consumer Secret in API Responses |	False |

![Auth provider]({{ site.baseurl }}/assets/images/bookme/implementation-guide/auth-prov.png)

### Verify booking platform client credential metadata 
Check that a custom metadata record has now been created in “Booking Platform Client Credentials”.

| Field | Value |
|------------------------|----------------------------|
| Name | AMBBookingAuth  |
| Client Id  | See the data sheet provided  |
| Client Secret  | See the data sheet provided |
| URL |	See the data sheet provided |

![Booking platform client credential]({{ site.baseurl }}/assets/images/bookme/implementation-guide/bp-client-cred.png)

### Create named credentials
Create a set of named credentials for the &money booking backend

| Field | Value |
|------------------------|----------------------------|
| URL | See the data sheet provided  |
| Name  | BookingEngine  |
| Identity Type  | Named Principal |
| Authentication provider |	AMBBookingAuth |
| Scope |	API1 |
| Start Authentication Flow on Save |	True |
| Generate Authorization Header |	True |

![Named credentials]({{ site.baseurl }}/assets/images/bookme/implementation-guide/named-creds.png)

### Salesforce connected app to event integration 
1. Create a Connected App in Salesforce Orgen with Oauth flow (see Connected app guide.pdf)
2. Preauthorize Booking platform – Integration permission set
3. Save Consumer Key and Consumer Secret and transfer them to &money together with the integration username
4. Add &money backend IP range to “Trusted IP Range for OAuth Web Server Flow”

In order for &money to call in via this connected app, it may be necessary to add the &money backend IP range to Network Access/profile
1. Go to Security -> Network Access
2. Add &money backend IP range to Trusted IP Ranges (See provided data sheet)

#### **Allow users to relate multiple contacts to tasks and events**
In order for advisors to be able to book customer meetings with multiple participants in the future, it is important that Shared activities is enabled on the environment. This can be done via activity settings.
1. Go to “Feature Settings -> Sales -> Activity Settings”
2. Enable “Allow Users to Relate Multiple Contacts to Tasks and Events”

Note - this feature can **not** be disabled once enabled.