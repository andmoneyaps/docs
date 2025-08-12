---
layout: default
title: Multi-Tenant Installation
nav_order: 2
parent: Installation Guides
grand_parent: Platform Deployment
---

# Multi-Tenant Installation Guide

This guide provides detailed instructions for ISVs and partners deploying the &money Financial Platform across multiple customer tenants.

## Overview

Multi-tenant deployment allows partners to:
- Manage multiple customer installations from a central location
- Deploy resources across different tenants
- Maintain customer isolation while centralizing management

## Architecture

The multi-tenant deployment splits resources between:
- **Customer Tenant**: Microsoft Entra ID resources (app registrations, users)
- **Partner Tenant**: Azure infrastructure (Graph Proxy, Key Vault)

## Before You Begin

Review the [Prerequisites Checklist](prerequisites) for both:
- Customer tenant requirements
- Partner tenant requirements

## Part 1: Customer Tenant Setup

### Who Performs This
Customer's Global Administrator or Partner with delegated admin consent

### Step 1: Initiate App Offer Installation

1. Customer admin signs in to [Azure Portal](https://portal.azure.com)
2. Navigate to **Create a resource**
3. Search for **"&money Financial Meeting Platform"**
4. Select **Create**

### Step 2: Configure for Partial Deployment

1. **Deployment Type**: Select **Partial (Multi-Tenant Part 1)**
2. **SCIM Token**: Enter token from &money
3. **Security Group Object ID**: 
   - Customer provides Object ID of their the platform users group
4. **Skip Azure Resources**: Check this option
5. Click **Create**

### Step 3: Collect Output Information

After deployment completes, document:
- **Client ID** (Application ID)
- **Client Secret** 
- **Tenant ID**
- **SCIM Endpoint URL**

**Important**: Securely share these values with the partner administrator

### Step 4: Grant Admin Consent

1. Navigate to **Microsoft Entra ID** → **Enterprise applications**
2. Find the newly created applications:
   - the platform SCIM Provisioning
   - the platform Calendar Integration
3. Click each application and select **Permissions**
4. Click **Grant admin consent**

## Part 2: Partner Tenant Setup

### Who Performs This
Partner/ISV Administrator

### Step 1: Deploy Azure Resources

1. Partner admin signs in to [Azure Portal](https://portal.azure.com)
2. Navigate to **Create a resource**
3. Search for **"&money Financial Meeting Platform"**
4. Select **Create**

### Step 2: Configure for Partner Deployment

1. **Deployment Type**: Select **Partner Infrastructure (Multi-Tenant Part 2)**
2. **Resource Group**: Create new or select existing
3. **Region**: Choose appropriate Azure region
4. **Number of Customers**: Estimate for scaling

### Step 3: Configure Customer Connection

Enter the information from Part 1:
1. **Customer Tenant ID**
2. **Customer Client ID**
3. **Customer Client Secret**
4. **Customer Name**: For identification

### Step 4: Complete Deployment

1. Review configuration
2. Accept terms and conditions
3. Click **Create**
4. Wait for deployment to complete

### Step 5: Retrieve Graph Proxy URL

After deployment:
1. Go to your Resource Group
2. Find the Container App resource
3. Copy the **Application URL**
4. Format: `https://[app-name].azurecontainerapps.io`

## Part 3: Final Configuration

### Configure Management UI

1. Access Management UI with partner credentials
2. Navigate to **Settings** → **Customers**
3. Click **Add Customer**
4. Enter:
   - Customer Name
   - Customer Tenant ID
   - Graph Proxy URL
   - SCIM Configuration

### Enable User Provisioning

Working with customer admin:

1. Customer navigates to **Microsoft Entra ID** → **Enterprise applications**
2. Select **the platform SCIM Provisioning**
3. Go to **Users and groups**
4. Click **Add user/group**
5. Select users from the security group
6. Click **Assign**

### Start Synchronization

1. In customer's tenant:
   - Go to **Provisioning** settings
   - Set to **Automatic**
   - Click **Start provisioning**
2. In partner's Management UI:
   - Navigate to customer configuration
   - Click **Activate Sync**
   - Monitor synchronization status

## Validation

### Test Connection

1. In Management UI → Customer Settings
2. Click **Test Connection**
3. Verify:
   - Graph Proxy: Connected
   - SCIM Endpoint: Reachable
   - Authentication: Valid

### Verify User Sync

1. Check Management UI → Users
2. Confirm customer users appear
3. Verify user attributes are correct

### Test Meeting Booking

1. Create test meeting as customer user
2. Verify meeting appears in:
   - Customer's calendar
   - Management UI
   - Teams (if applicable)

## Managing Multiple Customers

### Adding Additional Customers

Repeat the process for each customer:
1. Customer completes Part 1
2. Partner adds configuration in Management UI
3. No need to redeploy Azure resources

### Customer Isolation

Each customer's data is isolated through:
- Separate Client ID/Secret pairs
- Tenant-specific authentication
- Segregated data storage
- Independent SCIM channels

### Monitoring

Monitor all customers from Management UI:
- **Dashboard**: Overview of all customers
- **Sync Status**: Per-customer synchronization health
- **Audit Logs**: Detailed activity tracking

## Troubleshooting

### Customer Cannot Complete Part 1

**Issue**: Missing permissions or resources

**Solution**:
1. Ensure Global Administrator role
2. Verify Azure subscription (can be trial)
3. Use PowerShell scripts if UI fails

### Graph Proxy Connection Fails

**Issue**: Cannot connect to customer tenant

**Solution**:
1. Verify Client ID and Secret are correct
2. Check admin consent was granted
3. Confirm network connectivity
4. Review firewall rules

### Users Not Syncing

**Issue**: SCIM provisioning not working

**Solution**:
1. Verify SCIM token is valid
2. Check provisioning is started
3. Review provisioning logs
4. Confirm users are in security group

## Best Practices

### Security
- Store Client Secrets securely
- Rotate secrets regularly
- Use managed identities where possible
- Enable audit logging

### Scalability
- Plan Container App scaling
- Monitor resource utilization
- Set up alerts for issues
- Regular performance reviews

### Customer Communication
- Document customer-specific configurations
- Maintain deployment runbooks
- Schedule regular sync validations
- Establish support channels

## Next Steps

- Review [SCIM Configuration](scim-provisioning-setup) for advanced settings
- Configure [Microsoft Entra Integration](entra-integration)
- Set up monitoring and alerts

## Support

- **Partner Support**: Contact your partner account manager
- **Technical Issues**: Use the partner support portal
- **Customer Issues**: Follow escalation procedures