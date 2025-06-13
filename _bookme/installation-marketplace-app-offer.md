---
layout: default
title: Marketplace Installation
nav_order: 4
parent: BookMe
---

# Installation Marketplace App Offer
# Introduction

Welcome to the comprehensive documentation for our Azure Managed Application Offer, which is accessible and installable via the Azure Marketplace. This document is designed to guide you through the essential aspects of deploying and managing our application offer, whether you are operating within a single tenant or across multiple tenants.

## Purpose

The Azure Managed Application Offer, referred to as the "App Offer," provides a streamlined solution for integrating Azure resources with Entra ID resources to enhance your organization's operational efficiency and security management. This document serves as a step-by-step guide for IT administrators and technical personnel tasked with deploying and managing this application within their Azure environment.

## Components

The App Offer comprises two primary components:
- **Azure Part:** This includes the necessary Azure resources such as the Container App (Graph-Proxy), environment variables, managed identities, and key vault configurations.
- **Entra ID Part:** This optional component facilitates user identity and access management via app registration, service principals, and SCIM provisioning settings.

## Deployment Modes

To cater to diverse organizational needs, the App Offer supports multiple deployment modes:
- **Single Tenant Deployment:** Suitable for organizations where both Azure and Entra ID resources are deployed within the same tenant.
- **Multi-Tenant Deployment:** Designed for scenarios where resources are distributed across different tenants, often managed by an administrator overseeing multiple organizational units.

## Audience

This documentation is intended for IT professionals, system administrators, and cloud architects responsible for deploying and maintaining the application. It provides detailed guidance on installation prerequisites, deployment procedures, and post-installation verification steps.

By following this documentation, you will be equipped to seamlessly integrate our Azure Managed Application Offer into your existing infrastructure, leveraging its full potential to optimize your cloud operations.


## App Offer structure
Here is a list of what the App Offer contains by part.
- **Azure part** (required)
    - Container App ([Graph-Proxy](Graph-Proxy.md))
        - Environment Variables
    - Key vault
        - Secret: Client secret
    - Managed Identity (optional, only required for single-tenant)
        - API Permissions: `Application.ReadWrite.All` & `Synchronization.ReadWrite.All`
        - Roles: `Teams Communications Administrator` or `Teams Administrator`
- **Entra ID part** (optional)
    - App Registration
        - Permission: Calendar Access & Teams Access
    - Service Principal
        - SCIM Provisioning settings

# Installation

- Azure Managed Application Offer (**App Offer** for shorthand) is accessed and installed through the [Azure Marketplace - App Offer](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22andmoneyaps1687867534123.andmoney_azureadmin1%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22ff9d9c27-b409-42b8-808d-bb1455b07a7c%22%7D/searchTelemetryId/29f00a5a-8606-4c7b-b9c1-f770f21c5515).


## Single Tenant Installation
A single tenant installation is needed when the Azure part and Entra ID part should be deployed together on a single tenant.

{: .information }
> **Requirements**
>
> - A managed Identity with the following permissions: `Application.ReadWrite.All` & `Synchronization.ReadWrite.All` as well as the role of `Teams Communications Administrator` or `Teams Administrator`.
> - The user installing the App Offer needs the `Owner` permission in the Resource Group

**App Offer:**
- Can be installed from here [Azure Marketplace - App Offer](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22andmoneyaps1687867534123.andmoney_azureadmin1%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22ff9d9c27-b409-42b8-808d-bb1455b07a7c%22%7D/searchTelemetryId/29f00a5a-8606-4c7b-b9c1-f770f21c5515)
- SCIM Token: Obtain your SCIM token from the &money system. This token is used to authenticate SCIM requests.
- Security Group: Specify a security group Object ID from your Entra setup to which the Teams Access Policy will be applied. The security group should contain the users that will be using the BookMe solution. The Teams access policy will allow the BookMe solution to access and modify Teams meetings for the users in this group.
- Select a Managed Identity with the proper permissions.
- Press Deploy in the App Offer

<img src="{{ site.baseurl }}/assets/images/single-tenant-installation.png" width="500" alt="Diagram helping visualize the single tenant installation"/>


## Multi-Tenant Installation
A multi-tenant installation is needed when the two following conditions are met:
- The BookMe solution will be maintained over multiple tenants by an administrator,
- and where one or more tenants do not have subscriptions to install the App Offer through Marketplace. 

Using this installation means that the Entra ID resources need to be created by executing additional PowerShell scripts.

**App Offer:**
- Can be installed from here [Azure Marketplace - App Offer](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22andmoneyaps1687867534123.andmoney_azureadmin1%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22ff9d9c27-b409-42b8-808d-bb1455b07a7c%22%7D/searchTelemetryId/29f00a5a-8606-4c7b-b9c1-f770f21c5515)
- Enable the "Partial Deployment"-option.
    - A partial deployment will only deploy the Azure part, meaning that the Entra ID-part of the installation needs to be installed using PowerShell scripts.

The deployment model can be illustrated in the following way:

<img src="{{ site.baseurl }}/assets/images/multi-tenant-installation.png" width="500" alt="Diagram helping visualize the single tenant installation"/>

### Prerequisites

- **Entra Tenant:** You must have an active Microsoft Entra (Azure AD) tenant.
- **Permissions:** Ensure your account has one of the following roles in Entra:
    - Global Administrator
    - Application Administrator
    - Cloud Application Administrator
- **Teams Permissions:** as well as one of the following Teams roles:
    - Teams Communications Administrator
    - Teams Administrator
- **SCIM Token:** Obtain your SCIM token from the &money system. This token is used to authenticate SCIM requests.
- **PowerShell Modules:** The script requires the following modules:
    - `Microsoft.Graph.Applications`
    - `Microsoft.Graph.Authentication`
    - `MicrosoftTeams`

The script checks for these modules and installs/imports them if necessary.
- **Environment Details:** Know which environment you are targeting (e.g., `dev`, `test`, or `prod`) as the SCIM endpoints differ by environment.

### Overview of the Powershell scrips. 
The following PowerShell scripts are provided to facilitate the setup of SCIM provisioning and Teams access policies for the BookMe solution. They must be executed in the specified order as the output from the first script should be used in the next script.

#### 1) SCIM Provisioning Script

The provided script [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/bookme/enable-scim-provisioning) performs the following key actions:

1. **Module Check and Import:**  
   It checks if the required Microsoft Graph modules are installed. 
   If not, it installs and imports them.

2. **App Registration Creation:**  
   The `New-AppRegistration` function creates a new app registration in Entra with a specified display name and required permissions. It also generates a client secret.

3. **SCIM Service Principal Setup:**  
   The `Add-ScimServicePrincipal` function instantiates a service principal using a SCIM application template. It waits for propagation, creates a synchronization job, configures the SCIM parameters (such as the BaseAddress and SecretToken), and then starts the synchronization job.

4. **Provisioning Execution:**  
   The main function, `Enable-SCIM-Provisioning`, sets the environment-specific SCIM endpoints, connects to Microsoft Graph with the necessary scopes, creates the app registration, and then creates two SCIM service principals (one for each endpoint).

The script is parameterized so that you can specify:
- **ApplicationName** (e.g., "BookMe - SCIM integration")
- **TenantId** (your Entra tenant ID)
- **Environment** (dev, test, or prod)
- **ScimToken** (your secret token from &money)

{: .warning }
> Before you run the script make sure you are logged in either via the `Connect-MgGraph` cmdlet or by using the Azure CLI.
> 
> `Connect-MgGraph -Scopes "Application.ReadWrite.All,Synchronization.ReadWrite.All" -TenantId $TenantId -NoWelcome`
>
> `az login --tenant $TenantId`

**Executing the script:**
- Sign in using a user with the following permissions:
    - `Application.ReadWrite.All`
    - `Synchronization.ReadWrite.All`
- Execute PowerShell script [Enable-SCIM-Provisioning.ps1]({{ site.baseurl }}/bookme/enable-scim-provisioning)
- Verify that the following resources are created
  - App Registration for Calendar Access
  - Service Principal for SCIM provisioning


#### 2) Teams Access Policy Script

The provided script [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/bookme/add-teams-access-policy) performs the following key actions:

1. **Module Check and Import:**  
   It checks if the Microsoft Teams module is installed. If not, it installs and imports it.
2. **Connect to Microsoft Teams:**  
   It connects to Microsoft Teams.
3. **Create Application Access Policy:**  
   It creates a new application access policy for the BookMe solution using the specified app registration ID and environment.
4. **Grant Access Policy to Security Group:**  
   It grants the created access policy to a specified security group. The security group should contain the users that will be using the BookMe solution. The Teams access policy will allow the BookMe solution to access and modify Teams meetings for the users in this group.

The script is parameterized so that you can specify:
- **AppRegistrationId** (the ID of the application registration created in the previous step (Enable-SCIM-Provisioning.ps1). This can be found in the output of the previous script as the "Client ID")
- **SecurityGroupId** (the Object ID of the security group to which the policy should be applied)
- **Environment** (dev, test, or prod - use the same environment as used in the previous script)
- **TenantId** (your Entra tenant ID)
- **ConnectionType** (Optional parameter specifying whether to connect using a managed identity or user interactive sign-in, default is "User". No need to specify this parameter when running the script as the default value is correct.)

{: .warning }
> Before you run the script make sure you have one of the following Teams roles:
> 
> -`Teams Communications Administrator` (lower privilege role)
> - or `Teams Administrator` (highest privilege role)
>
> One of the two roles is required to create the Teams access policy.
 
**Executing the script:**
- Ensure that the requirements are met, including the Teams role.
- Execute PowerShell script [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/bookme/add-teams-access-policy)
