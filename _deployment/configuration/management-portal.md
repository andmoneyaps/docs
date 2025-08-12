---
layout: default
title: Management Portal Access
nav_order: 3
parent: Configuration
grand_parent: Platform Deployment
---

# Management Portal Access Configuration

Set up administrative access and roles for the platform management interface.

## Overview

The Management Portal provides:

- **Platform Administration**: Configure system settings
- **User Management**: View and manage synchronized users
- **Meeting Oversight**: Monitor and manage meetings
- **Integration Control**: Configure external integrations
- **Audit Capabilities**: Track platform usage and changes

## Access Levels

### Role Hierarchy

| Role             | Capabilities                             | Typical Users        |
| ---------------- | ---------------------------------------- | -------------------- |
| **Admin**        | Full platform control, all features      | IT administrators    |
| **Configurator** | Configuration without audit access       | System configurators |
| **Manager**      | User and meeting management              | Team managers        |
| **Employee**     | Standard user access, limited management | Bank employees       |
| **Customer**     | Basic access, view own information       | End customers        |

## Configuration Steps

### Step 1: Access Enterprise Application

1. Sign in to [Azure Portal](https://portal.azure.com)
2. Navigate to **Microsoft Entra ID** → **Enterprise applications**
3. Search for **"BookingPlatform Mgmt API"**
4. Click to open application settings

**Note:** If the Enterprise Application doesn't exist yet, see the [Management UI Access Setup](../../bookme/app-registration-installation) guide to create it first.

### Step 2: Assign User Roles

#### Individual Users

1. Click **Users and groups** in left menu
2. Click **Add user/group**
3. Select user and choose role:
   - Admin
   - Configurator
   - Manager
   - Employee
   - Customer
4. Click **Assign**

#### Group Assignment

For easier management:

1. Create security groups:
   - `Platform-Admins`
   - `Platform-Configurators`
   - `Platform-Managers`
2. Assign groups to roles
3. Manage membership via groups

### Step 3: Configure Application Settings

1. In Enterprise Application settings
2. Go to **Properties**
3. Configure:
   - **Assignment required**: Yes (recommended)
   - **Visible to users**: Yes
   - **User assignment required**: Yes

### Step 4: Set Up Conditional Access

For enhanced security:

1. Go to **Conditional Access**
2. Create new policy:
   ```
   Name: Platform Management Access
   Users: Platform administrators
   Cloud apps: Platform Management API
   Conditions:
   - Locations: Trusted locations only
   - Device state: Compliant devices
   Grant:
   - Require MFA
   - Require compliant device
   ```

## Portal URLs

### Production Environment

- Management Portal: `https://management.andmoney.dk`

### Test Environment

- Management Portal: `https://management.test-env.andmoney.dk`

## First-Time Access

### Initial Login

1. Navigate to portal URL
2. Click **Sign in with Microsoft**
3. Authenticate with Entra ID
4. Accept permissions prompt
5. Complete MFA if required

### Profile Setup

On first login:

1. Verify contact information
2. Set notification preferences
3. Configure time zone
4. Review assigned permissions

## Multi-Tenant Configuration

For partners managing multiple customers:

### Customer Isolation

Each customer appears as separate organization:

1. Top navigation shows organization selector
2. Switch between organizations without re-authentication
3. Permissions apply per organization

### Delegation Setup

1. In customer's tenant:
   - Grant partner organization access
   - Assign delegated admin privileges
2. In partner's portal:
   - Add customer configuration
   - Map customer to organization

## Troubleshooting

### Cannot Access Portal

**Issue**: "Access Denied" error

**Solutions**:

1. Verify user is assigned to application
2. Check role assignment is complete
3. Confirm no conditional access blocking
4. Clear browser cache/cookies

### Role Not Applied

**Issue**: Missing expected permissions

**Solutions**:

1. Sign out and sign back in
2. Wait for changes to propagate
3. Check group membership if using groups
4. Verify no conflicting assignments

### SSO Issues

**Issue**: Redirect loops or authentication failures

**Solutions**:

1. Verify Enterprise Application is configured correctly
2. Check user has proper role assignment
3. Clear browser cache and cookies
4. Verify tenant ID is correct

## Next Steps

- Configure [Microsoft Entra Integration](entra-integration) for advanced features
- Set up [monitoring and alerts](../reference/monitoring)
- Review [security guidelines](../reference/security)
- Plan administrator training
