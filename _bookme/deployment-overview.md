---
layout: default
title: Deployment Overview
nav_order: 1
parent: BookMe
---

# BookMe Deployment Overview

This guide provides instructions for deploying the BookMe platform through the Azure Marketplace App Offer.

## Deployment Options

The BookMe platform supports two deployment models:

### Single-Tenant Deployment

Best for organizations where all resources are deployed within the same Azure tenant. This option provides the simplest setup with automated configuration.

### Multi-Tenant Deployment

Designed for ISVs and partners managing multiple customer installations. This allows centralized management while maintaining customer data isolation.

## Prerequisites

### For Customer Organizations

Before beginning deployment, ensure you have:

- [ ] **Administrator Access**: Global Administrator role or delegated admin consent permissions
- [ ] **Teams Administration**: Teams Administrator or Teams Communications Administrator role
- [ ] **SCIM Token**: Provided by your &money account manager
- [ ] **User Security Group**: Microsoft Entra ID security group containing BookMe users (note the Object ID)

### For Partners/ISVs

If deploying on behalf of customers:

- [ ] **Azure Subscription**: Active subscription in your partner tenant
- [ ] **Customer Coordination**: Access to customer's admin for consent steps
- [ ] **Management UI Access**: Credentials provided by &money

## Installation Process

### Step 1: Azure Marketplace Installation

1. Navigate to the Azure Marketplace and search for "&money Financial Meeting Platform"
2. Click "Get It Now" to begin installation
3. Select your deployment type:
   - **Full Installation**: For single-tenant deployments
   - **Partial Installation**: For multi-tenant deployments (Part 1)

### Step 2: Configure App Registrations

During installation, the following will be automatically created in your tenant:

- **SCIM Application**: Handles user and room synchronization
- **Calendar Integration**: Manages calendar access and Teams meetings

Required permissions will be configured automatically:

- Calendar access for meeting management
- Teams access for online meeting creation
- User synchronization capabilities

### Step 3: User Provisioning

1. Assign users to the SCIM application from your security group
2. Configure provisioning settings with the provided SCIM token
3. Start provisioning to sync users and rooms

### Step 4: Validation

After installation completes:

1. Verify app registrations are created in Microsoft Entra ID
2. Confirm service principals have correct permissions
3. Test user provisioning is working
4. Book a test meeting to validate end-to-end functionality

## Multi-Tenant Specific Steps

For multi-tenant deployments, additional coordination is required:

### Customer Tenant (Part 1)

1. Customer admin installs the App Offer with "Partial Installation" option
2. App registrations and service principals are created
3. Customer provides Client ID and Secret to partner

### Partner Tenant (Part 2)

1. Partner deploys Azure resources in their subscription
2. Configures connection using customer's Client ID and Secret
3. Establishes secure communication channel

### Final Configuration

1. Partner configures Management UI with connection details
2. Customer adds users to provisioning groups
3. Joint validation of the complete setup

## Common Deployment Scenarios

| Scenario            | Typical Use Case                       |
| ------------------- | -------------------------------------- |
| Single Organization | Direct customer with full admin access |
| Multi-Tenant        | ISV managing multiple customers        |
| Limited Permissions | Customer with restricted admin rights  |

## Post-Deployment

After successful deployment:

1. **User Training**: Schedule training sessions for administrators
2. **CRM Integration**: Configure Salesforce integration if applicable
3. **Monitoring**: Set up monitoring and alerting preferences
4. **Support**: Contact your account manager for any issues

## Troubleshooting

### Common Issues

| Issue                     | Resolution                                         |
| ------------------------- | -------------------------------------------------- |
| Provisioning not starting | Verify SCIM token and security group configuration |
| Missing permissions       | Ensure Teams Administrator role is assigned        |
| Users not syncing         | Check security group membership and licenses       |

### Getting Help

- **Documentation**: Review detailed guides linked below
- **Support**: Contact your &money account manager
- **Emergency**: Use the support portal for critical issues

## Next Steps

- [Detailed Installation Guide](marketplace-installation)
- [SCIM Configuration](scim-provisioning-setup)
- [User Management](enable-scim-provisioning)
- [CRM Integration Setup](salesforce-setup)
