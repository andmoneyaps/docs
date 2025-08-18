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

**Note:** If the Enterprise Application doesn't exist yet, see the [App Registration Setup](app-registration-setup) guide to create it first.

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

1. Create security groups for each role
2. Assign groups to roles
3. Manage membership via groups

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

## Multi-Tenant Configuration

For partners managing multiple customers:

### Customer Isolation

Each customer appears as separate organization:

1. Top navigation shows organization selector
2. Switch between organizations without re-authentication
3. Permissions apply per organization

## Troubleshooting

### Cannot Access Portal

**Issue**: "Access Denied" error

**Solutions**:

1. Verify user is assigned to application
2. Check role assignment is complete
3. Clear browser cache/cookies
4. Check for any tenant-specific access policies

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

- Configure [App Registration Setup](app-registration-setup) for role assignments
- Set up [monitoring and alerts](../reference/monitoring)
- Review [security guidelines](../reference/security)
- Plan administrator training
