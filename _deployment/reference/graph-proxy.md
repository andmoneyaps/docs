---
layout: default
title: Graph Proxy Architecture
nav_order: 1
parent: Technical Reference
grand_parent: Platform Deployment
---

# Graph Proxy Technical Reference

The **Graph-Proxy** is a containerized application that acts as a secure intermediary between the BookMe solution and the Microsoft Graph API.
It is an essential part of the Financial Booking Solutions and is deployed as part of the Azure resources included in the App Offer.

![Graph-Proxy and Key Vault Architecture]({{ site.baseurl }}/assets/images/graph-proxy-keyvault.png)

{: .note }
> For detailed installation instructions, please refer to the [Installation Guide](../installation-marketplace-app-offer).
>

## Deployment Options

There are two deployment options for the Graph-Proxy:

- **Multi-Tenant Installation:** Ideal for environments where multiple tenants share the same deployment.
- **Single-Tenant Installation:** Suitable for dedicated deployments.

In both cases, the Graph-Proxy is deployed into an **Azure Container App** within an **Azure Container App Environment**.
This deployment is automated via the Azure Marketplace App Offer.

## Graph-Proxy Container App

The Graph-Proxy is deployed as a containerized application in an Azure Container App. The container image is hosted at:

{: .note }
> **Maintenance**
>
> The image is maintained by &money and is updated regularly to include the latest security patches and enhancements.
>

## Key Vault Integration

The Graph-Proxy leverages an Azure Key Vault (provisioned via the App Offer) to securely store sensitive information,
such as the client secret used for authenticating with the Microsoft Graph API.

## Environment Variables

The application requires specific environment variables to be configured:

### Mandatory Variables

- **`AzureAD__ClientId`**:  
  The client ID of the Azure AD application used by &money for validation.  
  _This variable is automatically set when selecting an environment in the App Offer._

### Additional Variables for Partial (Multi-Tenant) Deployments

- **`Microsoft365__ClientId`**:  
  The client ID of the Azure AD application used for authenticating with the Microsoft Graph API.
- **`Microsoft365__ClientSecret`**:  
  The client secret used for authenticating with the Microsoft Graph API.

{: .note }
> For multi-tenant deployments, the **Entra Client ID** and **Entra Client Secret** are provided via the App Offer UI.
>

## Provide Access to Calendar Graph API for the Graph-Proxy

The Graph-Proxy requires access to the Calendar Graph API to retrieve and manage calendar data from Microsoft 365. This access is granted via an App Registration in Entra ID with the necessary **Calendar Access** permissions. Depending on your deployment model, please follow the instructions below.

### For Single Tenant Installations

In a single tenant installation, both the Azure and Entra ID components are deployed in the same tenant. During deployment, the App Offer automatically:

- Configures the Graph-Proxy as an Azure Container App.
- Sets up an App Registration with the required **Calendar Access** and **Online Meeting** permission.
- Assigns the necessary roles to the managed identity for accessing Azure resources, such as the Key Vault and container image repository.

This automated setup configures the Graph-Proxy to access the Calendar and Online Meeting Graph API.

### For Multi-Tenant Installations

In multi-tenant installations, only the Azure part (including the Graph-Proxy) is deployed automatically via the App Offer. You must manually configure the Entra ID components to grant Calendar Graph API access. Follow these steps:

1. **Configure Entra ID Resources First**

   - Sign in with a user account that has the following permissions:
     - `Application.ReadWrite.All`
     - `Synchronization.ReadWrite.All`
   - Execute the PowerShell script [Enable-SCIM-Provisioning.ps1](powershell-scripts#enable-scim-provisioningps1) to deploy the Entra ID components.
   - Once the script completes, note the generated **ClientID** and **ClientSecret** for the App Registration configured with **Calendar Access** and **Online Meeting** permissions.

2. **Configure Teams access policy**
    - Sign in with a user account that has one of the two Teams admin roles `Teams Communications Administrator` or `Teams Administrator`.
    - Execute the PowerShell script [Add-Teams-Access-Policy.ps1](../configuration/teams-access-policy) to create a Teams access policy for the above generated App Registration. This step is necessary to allow the Graph-Proxy to manage online meetings in Microsoft Teams.

3. **Deploy the Azure Part**

   - Install the App Offer using the **Partial Deployment** option to set up the Graph-Proxy and related Azure resources.
   - Configure the Graph-Proxy with the **ClientID** and **ClientSecret** obtained from the Entra ID configuration. These values are provided as environment variables to the Graph-Proxy container:
     - `Microsoft365__ClientId`
     - `Microsoft365__ClientSecret`

4. **Verify Calendar and Online Meeting API Access**
   - Ensure that the App Registration in Entra ID has the correct **Calendar and Online Meeting Access** permission.
   - Test the Graph-Proxy by entering and testing the Graph-Proxy url in the Management UI. Under the 'Admin' → 'Microsoft'-tab in the Management UI.

The above steps are explained in greater detail in the [Installation Guide](../installation-marketplace-app-offer).

### How to set up the Graph API URL in the Management UI

In order to manually set the Graph API URL to allow for a proxy connection, the "Admin/Microsoft" page allows for this. An input field is given, where a user can insert one's Graph API URL.

Two services are then provided:

- **Test connection**
  Allows for the user to be able to verify that the given API URL's firewall allows for incoming requests. This service will either return: "_Connection to Microsoft Graph API created_", indicating a successful connection, or: "_Error connecting to Microsoft Graph API_": indicating that the given API URL does not allow incoming requests.
- **Save**
  Allows the user to submit the given URL to the database. This button will be disabled, if the posted URL matches the existing URL.

![Management UI Graph Test]({{ site.baseurl }}/assets/images/management-ui-graph-test.png)

{: .note }
>  Be sure to follow the [Installation Marketplace App Offer](../installation-marketplace-app-offer) guide carefully to ensure all required resources are correctly configured, especially in multi-tenant deployments where Entra ID resources must be set up manually.

This documentation provides an overview of the Graph-Proxy, its deployment options,
integration with Azure Key Vault, and required configuration. For further details or assistance,
please consult the accompanying [Installation Guide](../installation-marketplace-app-offer) or contact our support team.
