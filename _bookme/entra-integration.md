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
- Defines platform app roles used by BookMe (see [Platform Authentication](../general/platform-authentication) for complete role definitions):
  - Admin
  - Configurator
  - Manager
  - Employee
  - Customer
  - CreditEvaluator
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

{: .note}

> **Platform-Level Roles**
>
> The roles used by BookMe are part of the platform-wide authentication system shared across all &money products. For complete role definitions and platform authentication details, see [Platform Authentication](../general/platform-authentication).

Users must be assigned appropriate app roles in Entra ID to access the BookingPlatform Management API. The roles available for BookMe are:

- **Admin**: Full administrative access to the platform. Can access logs (Insights) and perform all configuration tasks. Highest privilege level.
- **Configurator**: Configuration and setup capabilities. Can perform meeting configuration, portal configuration, and manage service/competence groups. All permissions of Manager role plus advanced configuration.
- **Manager**: Management-level access with oversight capabilities. Can access the Management UI and configure service groups and competence groups for their organization.
- **Employee**: Standard user access for day-to-day operations. Used by employees who participate in scheduled activities but do not require configuration or management capabilities.
- **Customer**: Customer-facing access with limited permissions. Used for external customer interactions and self-service capabilities.

For detailed instructions on assigning users and groups to app roles, see the [App Registration Installation](app-registration-installation.md#role-assignment-for-the-management-ui) guide.

### Security Best Practices

- Assign the most restrictive role that provides necessary access
- Use security groups to manage access efficiently
- Regularly review role assignments
- Monitor authentication logs for access issues
