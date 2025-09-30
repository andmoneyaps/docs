---
layout: default
title: Microsoft Entra Integration
nav_order: 6
parent: BookMe
collection: bookme
---

# Microsoft Entra Integration

## Overview

BookMe integrates with Microsoft Entra ID (formerly Azure AD) to provide secure authentication and authorization. This document outlines the key components and configurations of this integration.

## App Registrations

BookMe uses multiple app registrations to handle different aspects of the platform:

### Multi-Tenant App Registrations

These app registrations are designed to work across different customer tenants:

#### BookingPlatform Management UI
- Primary purpose: Handles browser-based login flows
- Capabilities: Requests access tokens for API access
- Use case: User authentication and authorization

#### BookingPlatform Management API
- Exposes API permission scopes
- Defines app roles:
  - Admin
  - Configurator
  - Manager
  - Employee
  - Customer
- Note: Does not support direct login (client credentials flow disabled)

### Single-Tenant App Registrations

These app registrations exist within the BookMe tenant:

#### BookMe API System Integration
- Exposes API permission scopes
- Includes System app role
- Used for system-level integrations

#### Bank-Specific System Integration
For each bank customer:
- Unique client ID and secret
- Supports client credentials OAuth flow
- Automatically receives System app role
- **Important**: Client secrets expire after 2 years and must be renewed

## Token Management

### Multi-Tenant Applications
- Tokens include the customer's Entra Tenant as issuer (iss claim)
- Requires mapping between Entra Tenant ID and BookMe BankId in the organization database
- Supports multiple BankId mappings per tenant
  - Users can select their active bank context in the Management UI

### Single-Tenant Applications
- Uses 'authorized party' (azp claim) for BankId mapping
- Requires configuration in bp_organizations_db database
- ClientId must be registered in the BankClients table

## Security Considerations

### Client Secret Management
- Default expiration: 2 years from creation
- Regular monitoring required
- Plan secret rotation before expiration
- Communicate new secrets to customers in advance

### Administrator Requirements
- Installing app registrations requires:
  - Cloud Application Administrator role, or
  - Application Administrator role

### Permission Management
- Customer tenant administrators can:
  - Map users/groups to app roles
  - Manage enterprise applications
  - Configure access controls

## Best Practices

1. **Tenant Mapping**
   - Always configure proper tenant-to-bank mappings
   - Verify database configurations before deployment

2. **Access Control**
   - Use appropriate app roles for user permissions
   - Regularly review role assignments

3. **Secret Management**
   - Monitor client secret expiration dates
   - Plan rotations well in advance
   - Maintain secure communication channels for secret distribution

4. **Permission Scopes**
   - Request minimal necessary permissions
   - Avoid unnecessary admin consent requirements
   - Use basic Microsoft Graph API scopes when possible

## User Access Configuration

### Assigning App Roles to Users and Groups

Users must be properly configured in Entra ID to access the BookingPlatform Management API. This section describes how to assign the appropriate app roles to users and groups.

#### Configuration Steps

1. **Navigate to Enterprise Applications** in the Azure portal
   - Go to Azure Active Directory > Enterprise applications
   - Search for "BookingPlatform" or use the application ID

2. **Locate the BookingPlatform Mgmt API Application**
   - Find the BookingPlatform Management API app registration
   - Click on the application to open its configuration

3. **Add Users and Groups**
   - Navigate to "Users and groups" in the left menu
   - Click "Add user/group"
   - Select the users or groups that need access to the BookingPlatform API

4. **Assign App Roles**
   - During user/group assignment, select the appropriate app role:
     - **Admin**: Full administrative access to the platform
     - **Configurator**: Access to configuration and setup functions
     - **Manager**: Management-level access with oversight capabilities
     - **Employee**: Standard user access for day-to-day operations
     - **Customer**: Customer-facing access with limited permissions

5. **Verify Access Configuration**
   - Confirm that users can authenticate successfully
   - Test access to ensure proper role-based permissions are applied
   - Validate that users receive appropriate access levels based on their assigned roles

#### App Role Descriptions

| Role | Description | Typical Use Cases |
|------|-------------|-------------------|
| **Admin** | Full platform administration | System administrators, IT staff |
| **Configurator** | Configuration and setup access | Implementation teams, setup specialists |
| **Manager** | Management oversight and reporting | Team leads, department managers |
| **Employee** | Standard operational access | Bank employees, customer service staff |
| **Customer** | Limited customer-facing access | External users, customer portals |

#### Important Considerations

- **Role Assignment**: Choose the most restrictive role that provides necessary access
- **Group Management**: Use security groups to manage access more efficiently, especially for larger organizations
- **Access Validation**: Users must be properly authenticated in their Entra ID session
- **Permission Inheritance**: Role permissions are inherited based on the assigned app role

#### Security Notes

- Only assign roles to users who legitimately need access to the BookingPlatform
- Regularly review role assignments to ensure access remains appropriate
- Monitor authentication logs for any access issues or security concerns
- Follow the principle of least privilege when assigning roles
