---
layout: default
title: Platform Authentication
nav_order: 4
parent: General
collection: general
---

# Platform Authentication & Roles

## Overview

The &money platform uses Microsoft Entra ID (formerly Azure AD) for authentication and role-based access control (RBAC). This authentication system is shared across all &money products, providing a unified security model for user permissions and access management.

Authentication is handled through Azure AD app registrations that integrate with customer tenants, enabling user provisioning, secure single sign-on (SSO) and role-based authorization across the platform.

Note that during onboarding to the platform, 3 distinct Azure AD Enterprise Applications are created in the customer's tenant to manage provisioning and role assignments. These are described in detail later in this document.

## Platform Roles

The platform defines several roles that grant different levels of access and capabilities across &money products. Users are assigned to these roles through one of the Enterprise Applications' role assignments in their organization's tenant.

### Role Definitions

| Role                | Description                                                                                                                                                                                       | Used By          |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| **Admin**           | Full administrative access to all platform features and settings. Can access logs (Insights) and perform all configuration tasks. Highest privilege level.                                        | BookMe           |
| **Configurator**    | Configuration and setup capabilities. Can perform meeting configuration, portal configuration, and manage service/competence groups. All permissions of Manager role plus advanced configuration. | BookMe           |
| **Manager**         | Management-level access with oversight capabilities. Can access the Management UI and configure service groups and competence groups for their organization.                                      | BookMe           |
| **Employee**        | Standard user access for day-to-day operations. Used by employees who participate in scheduled activities but do not require configuration or management capabilities.                            | BookMe           |
| **Customer**        | Customer-facing access with limited permissions. Used for external customer interactions and self-service capabilities.                                                                           | BookMe           |
| **CreditEvaluator** | Role for credit assessment personnel with full evaluation capabilities. Provides access to evaluate and process credit applications.                                                              | Kreditbeslutning |

### Role Hierarchy

Roles are generally hierarchical in nature, where higher-level roles include the permissions of lower-level roles:

**BookMe Product Roles (hierarchical):**

- Admin (highest) → includes all Configurator permissions
- Configurator → includes all Manager permissions
- Manager → includes relevant operational permissions
- Employee, Customer (operational roles)

**Kreditbeslutning Product Roles:**

- CreditEvaluator (specialized role for credit assessment)

{: .note}

> Users can be assigned to multiple roles, but they will effectively have the permissions of the highest privilege role assigned to them. There is typically no benefit to assigning multiple roles to a single user for the same product.

## Enterprise Applications

The &money platform uses three distinct Entra Enterprise Applications to handle different aspects of provisioning and access control. Each serves a specific purpose in the authentication and user management workflow.

### 1. Role Assignment Enterprise App (Management API)

This application manages role-based access control (RBAC) for the platform but does not perform any provisioning operations. All users that access any of the &money platforms Web UIs must be assigned roles through this Enterprise Application.

There is an instance of this application for each environment (Test and Production), and role assignments must be configured separately for each environment. It is the recommentaion of &money that users are assigned to roles using security groups rather than individual user assignments to simplify management and ensure scalability as the number of users grows.

Once onboarding is complete, the following IDs can use used to identify the Role Assignment Enterprise Applications in the customer's tenant:

- **Test Environment**: f100d6c7-bbee-405b-9231-7e1c05c4b944
- **Production Environment**: 642f0f04-31f9-4641-a1cb-793f31496bd3

### 2. User Provisioning Enterprise App

This application handles the provisioning of users (previously referred to as Advisors) into the &money platform. This is done using the SCIM (System for Cross-domain Identity Management) protocol to synchronize user data from your Microsoft 365 environment to the platform.

This application is used to sync two types of users:

- Users that should have avaiable timeslots for booking in BookMe
- Users of systems that require extra information such as Kreditbeslutning which needs a users EmployeeNumber attribute.

Due to the high overlap on users that are provisioned and users that are assigned roles, it is common to use security groups for both provisioning and role assignment to simplify management.

Note that there are two cases where users are not both provisioned and assigned roles:

- Users that only need to be provisioned to be available for booking, but do not need access to the BookMe Management UI (these users will not be assigned any roles)
- Users that only need access to the BookMe Management UI, to assist with configuration and management tasks, but do not need to be provisioned as booking resources (these users will not be provisioned)

### 3. Room Provisioning Enterprise App

This application is dedicated to provisioning meeting rooms into the &money platform. Like the User Provisioning app, it uses the SCIM protocol to synchronize room data from your Microsoft 365 environment to the platform. It is a separate application to isolate room/resource provisioning from user provisioning, to support mapping of different attributes, and to allow for distinct configuration settings.

This application is only needed for organizations that use BookMe's room/resource booking features.

### Setup and Configuration

Detailed setup instructions for both the User Provisioning and Room Provisioning Enterprise Applications can be found in the section on BookMe SCIM Provisioning. This includes steps for registering the applications, configuring permissions, and setting up the SCIM synchronization process.

## Support

For assistance with:

- Registering redirect URIs
- Obtaining production access
- Role assignment issues
- Authentication troubleshooting

Contact the &money Service Desk.
