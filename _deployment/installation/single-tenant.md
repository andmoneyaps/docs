---
layout: default
title: Single-Tenant Installation
nav_order: 1
parent: Installation Guides
grand_parent: Platform Deployment
---

# Single-Tenant Installation Guide

This guide provides step-by-step instructions for deploying the &money Financial Platform in a single-tenant environment where all resources are deployed within the same Microsoft Entra ID tenant.

## Overview

Single-tenant deployment is the simplest installation method, ideal for organizations that:

- Have full administrative control over their tenant
- Want all resources in one location
- Prefer automated configuration

## Before You Begin

Ensure you have completed the [Prerequisites Checklist](prerequisites). Key requirements:

- Global Administrator or appropriate delegated permissions
- Azure subscription in your tenant
- SCIM token from &money
- Security group with platform users

## Installation Steps

### Step 1: Access Azure Marketplace

1. Sign in to the [Azure Portal](https://portal.azure.com) with Global Administrator privileges
2. Navigate to **Create a resource** → **See all**
3. Search for **"&money Financial Meeting Platform"**
4. Click **Create** to begin the installation

### Step 2: Configure Basic Settings

#### Subscription and Resource Group

1. **Subscription**: Select your Azure subscription
2. **Resource Group**:
   - Create new: Enter a descriptive name (e.g., `rg-bookme-prod`)
   - Use existing: Select from dropdown
3. **Region**: Choose your preferred Azure region

#### Application Configuration

1. **Application Name**: Enter a unique name for your deployment
2. **Environment**: Select either:
   - **Test** - For testing and validation
   - **Production** - For live deployment

### Step 3: Configure SCIM Settings

1. **SCIM Token**: Paste the token provided by your &money account manager
2. **Security Group Object ID**:
   - Navigate to Microsoft Entra ID → Groups
   - Find your platform users group
   - Copy the Object ID
3. **Enable SCIM Provisioning**: Check this box

### Step 4: Configure Managed Identity

1. **Use Managed Identity**: Select **Yes** for automated configuration
2. **Managed Identity Name**: Accept default or enter custom name
3. The managed identity will be automatically configured with:
   - Required Graph API permissions
   - Key Vault access
   - Teams administration capabilities

### Step 5: Review and Create

1. Review all configuration settings
2. Check the **Terms and Conditions** box
3. Click **Create** to begin deployment

### Step 6: Monitor Deployment

1. Navigate to your Resource Group
2. Click on **Deployments** in the left menu
3. Monitor the deployment status
4. Wait for status to show **Succeeded**

## Post-Installation Configuration

### Verify Resources Created

Confirm the following resources appear in your resource group:

| Resource Type             | Resource Name      | Purpose                |
| ------------------------- | ------------------ | ---------------------- |
| Container App             | bookme-proxy-[env] | Graph Proxy service    |
| Key Vault                 | kv-bookme-[env]    | Stores secrets         |
| Container App Environment | cae-bookme-[env]   | Container environment  |
| Managed Identity          | mi-bookme-[env]    | Service authentication |

### Verify App Registrations

1. Navigate to **Microsoft Entra ID** → **App registrations**
2. Confirm these applications exist:
   - **platform SCIM Provisioning** - For user synchronization
   - **platform Calendar Integration** - For calendar and Teams access

### Configure User Provisioning

1. Go to **Microsoft Entra ID** → **Enterprise applications**
2. Find **platform SCIM Provisioning**
3. Click **Provisioning** in the left menu
4. Set **Provisioning Mode** to **Automatic**
5. Under **Mappings**:
   - Enable **Provision Microsoft Entra ID Users**
   - Enable **Provision Microsoft Entra ID Groups**
6. Click **Save**
7. Click **Start provisioning**

### Access Management UI

1. Navigate to the Management UI:
   - Test: `https://management.test.bookme.andmoney.dk`
   - Production: `https://management.bookme.andmoney.dk`
2. Sign in with your Microsoft Entra ID credentials
3. Verify you can access the administration panel

## Validation Steps

### Test User Synchronization

1. Add a test user to your security group
2. Wait for synchronization to complete
3. Check Management UI → Users to confirm user appears

### Test Meeting Booking

1. In Management UI, navigate to **Meetings**
2. Click **Book Meeting**
3. Select:
   - Test advisor
   - Test room
   - Date and time
4. Confirm meeting appears in:
   - Management UI
   - Advisor's calendar
   - Teams (if online meeting)

### Verify Graph Proxy Connection

1. In Management UI, go to **Settings** → **Integrations**
2. Click **Test Microsoft Connection**
3. Verify status shows **Connected**

## Troubleshooting

### Deployment Fails

**Issue**: Deployment status shows Failed

**Solutions**:

1. Check deployment error messages in Azure Portal
2. Verify all prerequisites are met
3. Ensure sufficient Azure quota
4. Contact support if errors persist

### Users Not Syncing

**Issue**: Users don't appear in Management UI

**Solutions**:

1. Verify SCIM provisioning is started
2. Check users are in the security group
3. Review provisioning logs for errors
4. Ensure SCIM token is valid

### Cannot Access Management UI

**Issue**: Access denied or login fails

**Solutions**:

1. Verify user has appropriate role assigned
2. Check app registration permissions
3. Clear browser cache and cookies
4. Try incognito/private browsing mode

## Next Steps

- [Configure SCIM Provisioning](scim-provisioning-setup) for advanced settings
- [Management UI Setup]({{ site.baseurl }}/deployment/configuration/app-registration-setup) for role assignments
- [Microsoft 365 Integration]({{ site.baseurl }}/deployment/configuration/microsoft-365-integration) for additional configuration

## Support

For assistance:

- **Documentation**: Review related guides
- **Account Manager**: Contact your &money representative
- **Support Portal**: Submit tickets for technical issues
