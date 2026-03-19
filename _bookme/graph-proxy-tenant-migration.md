---
layout: default
title: Graph Proxy Tenant Migration
nav_order: 7
parent: BookMe
---

# Graph Proxy Tenant Migration Guide

This guide walks you through migrating your &money Graph Proxies (BookMe Graph Proxy) from one Azure tenant to another. The Graph Proxies are deployed as Azure Container Apps via the Azure Marketplace and act as a secure proxy between Microsoft Graph API and &money's systems.

Each Graph Proxy deployment creates a Managed Application containing a [Container App (Graph-Proxy)]({{ site.baseurl }}/bookme/graph-proxy/), a Key Vault (storing secrets), and a User-Assigned Managed Identity.

{: .note }
> This guide assumes you are using a **Partial Deployment** (multi-tenant) setup. For more details on deployment modes, see the [Marketplace Installation Guide]({{ site.baseurl }}/bookme/marketplace-installation/).

---

## Prerequisites

- Access to the **old Azure tenant** (to gather existing configuration)
- Access to the **new Azure tenant** with:
  - An active Azure subscription
  - Permissions to deploy Azure Marketplace offers

---

## Step 1: Inventory your existing Graph Proxies

Create an overview of all Graph Proxies currently deployed in your old tenant.

1. Go to the [Azure Portal](https://portal.azure.com)
2. Search for **Managed Applications** in the top search bar
3. List all managed applications of type **andmoney graph proxy**
4. For each application, note down:
   - **Application Name** — the name you gave the managed application
   - **Resource Group** — the resource group it was deployed into
   - **Managed Resource Group** — the auto-created resource group (prefixed with `mrg-andmoney_azure-`)
   - **Region** — the Azure region it is deployed in

{: .hint }
> If you have many proxies, use a spreadsheet to track all values across deployments.

---

## Step 2: Gather configuration from each existing Graph Proxy

For each Graph Proxy identified in Step 1, you need to collect the configuration values that were used during the original deployment. These will be reused when creating the new proxies.

### 2.1 Find the Container App and Key Vault

1. Open the **Managed Resource Group** for the Graph Proxy (the `mrg-andmoney_azure-...` resource group)
2. Inside you will find:
   - A **Container App** (named `app-graph-proxy`)
   - A **Key Vault**
   - A **User-Assigned Managed Identity**

### 2.2 Collect values from the Key Vault

The Key Vault stores the following secrets. Navigate to the Key Vault → **Secrets** and retrieve:

| Secret name | Description |
|---|---|
| `entraClientId` | The Application (client) ID of the Entra app registration |
| `entraClientSecret` | The client secret for the Entra app registration |
| `scimSecretToken` | The SCIM provisioning token |

{: .note }
> You need the **Key Vault Secrets User** role or equivalent to view secret values.

### 2.3 Collect values from the Container App

Navigate to the Container App → **Containers** → **Environment variables** to find:

| Environment variable | Description |
|---|---|
| `Microsoft365__TenantId` | The Entra Tenant ID |
| `AzureAD__ClientId` | The Azure AD Client ID used by the proxy |

### 2.4 Record all values

For each Graph Proxy, fill out a row like this:

```
Application Name:     ____________________
Region:               ____________________
Entra Client ID:      ____________________ (from Key Vault secret: entraClientId)
Entra Client Secret:  ____________________ (from Key Vault secret: entraClientSecret)
Entra Tenant ID:      ____________________ (from Container App env: Microsoft365__TenantId)
Environment:          prod
SCIM Token:           ____________________ (from Key Vault secret: scimSecretToken)
```

{: .important }
> All Entra values (Client ID, Client Secret, Tenant ID) and the SCIM Token are reused as-is from the old deployment. You do not need to create new app registrations.

---

## Step 3: Prepare the new tenant

Before deploying the new Graph Proxies in the new tenant:

1. Ensure the subscription has permissions to deploy **Azure Marketplace offers**
2. Create or select **Resource Groups** for the new deployments

---

## Step 4: Deploy new Graph Proxies via the Marketplace

For each Graph Proxy from your inventory, deploy a new instance in the new tenant.

Install the App Offer from the [Azure Marketplace](https://portal.azure.com/#view/Microsoft_Azure_Marketplace/GalleryItemDetailsBladeNopdl/id/andmoneyaps1687867534123.andmoney_azure/selectionMode~/false/resourceGroupId//resourceGroupLocation//dontDiscardJourney~/false/selectedMenuId/home/launchingContext~/%7B%22galleryItemId%22%3A%22andmoneyaps1687867534123.andmoney_azureadmin1%22%2C%22source%22%3A%5B%22GalleryFeaturedMenuItemPart%22%2C%22VirtualizedTileDetails%22%5D%2C%22menuItemId%22%3A%22home%22%2C%22subMenuItemId%22%3A%22Search%20results%22%2C%22telemetryId%22%3A%22ff9d9c27-b409-42b8-808d-bb1455b07a7c%22%7D/searchTelemetryId/29f00a5a-8606-4c7b-b9c1-f770f21c5515) and follow the steps below.

### Basics tab

**Project details:**
- **Subscription** — select the appropriate subscription in the new tenant
- **Resource group** — select or create a resource group

**Instance details:**
- **Region** — use the same region as the original deployment (or choose a preferred region)
- **Partial Deployment of Azure Resources** — **check this box** (this is critical — it tells the deployment to reuse existing app registrations rather than creating new ones)
- **Entra Client ID** — enter the Client ID from Step 2
- **Entra Client Secret** — enter the Client Secret from Step 2
- **Entra Tenant ID** — enter the Tenant ID from Step 2
- **Environment** — select `prod`
- **SCIM Token** — enter the SCIM token from Step 2 (must be 32 alphanumeric characters)

### Attribute Generation tab

- Review the auto-generated attributes
- Check the acknowledgment checkbox to confirm

### Review + create

- Review all settings and click **Create** to deploy

Repeat for each Graph Proxy in your inventory.

---

## Step 5: Verify the new deployments

After all Graph Proxies have been deployed in the new tenant:

1. Go to **Managed Applications** in the new tenant and verify all expected applications are listed
2. For each deployment, open the **Managed Resource Group** and check:
   - The **Container App** (`app-graph-proxy`) is running and healthy
   - The **Key Vault** contains the correct secrets (`entraClientId`, `entraClientSecret`, `scimSecretToken`)
   - Container App logs show successful startup (check **Log stream** in the Container App)
3. Test the Graph-Proxy connection via the Management UI under **Admin** → **Microsoft** (see [Graph Proxy documentation]({{ site.baseurl }}/bookme/graph-proxy/#how-to-set-up-the-graph-api-url-in-the-management-ui))
4. Notify &money that the migration is complete so they can verify connectivity and update any routing on their end

---

## Step 6: Decommission old Graph Proxies

Once the new Graph Proxies are verified and operational:

1. Coordinate with &money to confirm traffic is flowing through the new proxies
2. In the old tenant, navigate to **Managed Applications**
3. Delete each old Graph Proxy managed application (this will also clean up the managed resource group containing the Container App, Key Vault, and Managed Identity)

{: .warning }
> Do not delete the old Graph Proxies until you have confirmed the new ones are fully operational and &money has completed the switchover.

---

## Troubleshooting

| Issue | Resolution |
|---|---|
| Cannot retrieve secrets from Key Vault | Ensure you have the **Key Vault Secrets User** role on the Key Vault. The Key Vault is inside the managed resource group. |
| SCIM Token validation error | The SCIM token must be exactly 32 alphanumeric characters. Verify the value is correct. |
| Container App fails to start | Check the container logs for errors. Verify all secrets in the Key Vault are correctly populated. |
| Managed Identity permissions error | Ensure the User-Assigned Managed Identity has the required permissions. It needs **Key Vault Secrets User** and **ACR Pull** roles. |
| Marketplace offer not available | Ensure your subscription has permissions to deploy Marketplace offers and that the offer is available in your region. |

---

## Need help?

Contact &money support if you encounter any issues during the migration.
