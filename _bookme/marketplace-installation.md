---
layout: default
title: Azure Marketplace Installation
nav_order: 3
parent: BookMe
---

# Azure Marketplace App Offer Installation
# Introduction

Welcome to the comprehensive documentation for our Azure Managed Application Offer, which is accessible and installable via the Azure Marketplace. This document is designed to guide you through the essential aspects of deploying and managing our application offer, whether you are operating within a single tenant or across multiple tenants.

## Purpose

The Azure Managed Application Offer, referred to as the "App Offer," provides a streamlined solution for integrating Azure resources with Microsoft Entra ID resources to enhance your organization's operational efficiency and security management. This document serves as a step-by-step guide for IT administrators and technical personnel tasked with deploying and managing this application within their Azure environment.

## Components

The App Offer comprises two primary components:
- **Azure Part:** This includes the necessary Azure resources such as the Container App (Graph Proxy), environment variables, managed identities, and key vault configurations.
- **Microsoft Entra ID Part:** This optional component facilitates user identity and access management via app registration, service principals, and SCIM provisioning settings.

## Deployment Modes

To cater to diverse organizational needs, the App Offer supports multiple deployment modes:
- **Single Tenant Deployment:** Suitable for organizations where both Azure and Microsoft Entra ID resources are deployed within the same tenant.
- **Multi-Tenant Deployment:** Designed for scenarios where resources are distributed across different tenants, often managed by an administrator overseeing multiple organizational units.

## Audience

This documentation is intended for IT professionals, system administrators, and cloud architects responsible for deploying and maintaining the application. It provides detailed guidance on installation prerequisites, deployment procedures, and post-installation verification steps.

By following this documentation, you will be equipped to seamlessly integrate our Azure Managed Application Offer into your existing infrastructure, leveraging its full potential to optimize your cloud operations.


## App Offer structure
Here is a list of what the App Offer contains by part.
- **Azure part** (required)
    - Container App ([Graph Proxy](../graph-proxy))
        - Environment Variables
    - Key vault
        - Secret: Client secret
    - Managed Identity (optional, only required for single-tenant)
        - API Permissions: `Application.ReadWrite.All` & `Synchronization.ReadWrite.All`
        - Roles: `Teams Communications Administrator` or `Teams Administrator`
- **Microsoft Entra ID part** (optional)
    - App Registration
        - Permission: Calendar Access & Teams Access
    - Service Principal
        - SCIM Provisioning settings

# Installation

## Quick Decision Guide

Before starting, determine your deployment scenario:

| Scenario | Use This Method | Typical For |
|----------|----------------|-------------|
| Same tenant for Azure resources and Microsoft Entra ID | [Single Tenant Installation](#single-tenant-installation) | Direct customers with full control |
| Different tenants or ISV managing multiple customers | [Multi-Tenant Installation](#multi-tenant-installation) | Partners, ISVs, or limited permissions |
| Existing deployment needs update | [Update Procedures](#update-procedures) | Maintenance and upgrades |

## Access the App Offer

Azure Managed Application Offer (**App Offer** for shorthand) is accessed through:
- [Azure Marketplace - &money Financial Meeting Platform](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22andmoneyaps1687867534123.andmoney_azureadmin1%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22ff9d9c27-b409-42b8-808d-bb1455b07a7c%22%7D/searchTelemetryId/29f00a5a-8606-4c7b-b9c1-f770f21c5515)


## Single Tenant Installation

Use this method when Azure resources and Microsoft Entra ID are in the same tenant.

### Prerequisites

{: .information }
> **Required Permissions and Resources**
>
> - **Managed Identity** with:
>   - API Permissions: `Application.ReadWrite.All` & `Synchronization.ReadWrite.All`
>   - Role: `Teams Communications Administrator` or `Teams Administrator`
> - **User performing installation** needs:
>   - `Owner` permission in the target Resource Group
>   - `Global Administrator` or delegated app consent permissions
> - **SCIM Token** from &money (request from your account manager)
> - **Security Group Object ID** containing BookMe users

### Step-by-Step Installation

1. **Open Azure Marketplace**
   - Navigate to [Azure Marketplace - App Offer](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/)
   - Click "Get It Now"

2. **Configure Installation Parameters**
   - **Resource Group**: Select existing or create new
   - **Region**: Choose your preferred Azure region
   - **SCIM Token**: Paste the token provided by &money
   - **Security Group Object ID**: Enter the ID of your prepared security group
   - **Managed Identity**: Select the identity with required permissions

3. **Deploy the Solution**
   - Review configuration
   - Accept terms and conditions
   - Click "Create" to start deployment
   - Wait for deployment completion (typically 10-15 minutes)

4. **Post-Deployment Verification**
   - Check deployment outputs for:
     - Graph Proxy URL
     - App Registration Client ID
     - Service Principal ID
   - Save these values for Management UI configuration

<img src="../../assets/images/single-tenant-installation.png" width="500" alt="Diagram helping visualize the single tenant installation"/>


## Multi-Tenant Installation

Use this method when:
- Managing BookMe across multiple customer tenants
- Customer tenant lacks Azure subscription
- ISV/Partner centrally manages deployments

### Overview

This installation is split into two parts:
1. **Part 1**: Customer tenant setup (Microsoft Entra ID resources)
2. **Part 2**: Partner tenant setup (Azure resources/Graph Proxy)

### Part 1: Customer Tenant Setup

{: .warning }
> **Important**: This part requires coordination with the customer's IT team or Global Administrator access.

#### Step 1: Install App Offer on Customer Tenant

**Performed by**: Customer Global Administrator or Partner with delegated access

1. **Access Azure Marketplace**
   - Customer admin navigates to [Azure Marketplace - App Offer](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/)
   - Select "Get It Now"

2. **Configure for Multi-Tenant**
   - **Enable "Partial Deployment"** checkbox
   - This creates only Microsoft Entra ID resources
   - Enter SCIM token from &money
   - Provide Security Group Object ID

3. **Complete Installation**
   - Deploy and wait for completion
   - **Critical**: Note down the Client ID and Client Secret
   - These will be needed for Part 2

### Part 2: Partner Tenant Setup

**Performed by**: Partner/ISV Administrator

#### Step 2: Deploy Graph Proxy

1. **Install Graph Proxy in Partner Tenant**
   - Use the Azure portal or ARM templates
   - Deploy to partner's Azure subscription
   - Configure with Client ID/Secret from Part 1

2. **Configure Environment Variables**
   ```
   CLIENT_ID=<from-part-1>
   CLIENT_SECRET=<from-part-1>
   TENANT_ID=<customer-tenant-id>
   ENVIRONMENT=<prod|test|dev>
   ```

3. **Note Graph Proxy URL**
   - Will be format: `https://<app-name>.azurewebsites.net`
   - Required for Management UI configuration

The deployment model can be illustrated in the following way:

<img src="../../assets/images/multi-tenant-installation.png" width="500" alt="Diagram helping visualize the single tenant installation"/>

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

The provided script [Enable-SCIM-Provisioning.ps1](../enable-scim-provisioning) performs the following key actions:

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
- Execute PowerShell script [Enable-SCIM-Provisioning.ps1](../enable-scim-provisioning)
- Verify that the following resources are created
  - App Registration for Calendar Access
  - Service Principal for SCIM provisioning


#### 2) Teams Access Policy Script

The provided script [Add-Teams-Access-Policy.ps1](../add-teams-access-policy) performs the following key actions:

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
- Execute PowerShell script [Add-Teams-Access-Policy.ps1](../add-teams-access-policy)
