---
layout: default
title: Prerequisites Checklist
nav_order: 2
parent: BookMe
---

# Prerequisites Checklist

Before deploying BookMe, ensure all prerequisites are met for your deployment scenario.

## All Deployments

### Required Permissions

#### Microsoft Entra ID Permissions
- [ ] **Global Administrator** OR the following delegated permissions:
  - [ ] `Application.ReadWrite.All` - To create app registrations
  - [ ] `Synchronization.ReadWrite.All` - To configure SCIM provisioning

#### Microsoft Teams Permissions  
- [ ] **Teams Administrator** OR **Teams Communications Administrator** role
  - Required for creating Teams access policies
  - Needed for online meeting management

### Required Information

#### From &money
- [ ] **SCIM Token** - Contact your account manager to obtain
- [ ] **Management UI Credentials** - Provided during onboarding
- [ ] **Environment Selection** - Test or Production

#### From Your Organization
- [ ] **Security Group Object ID** - Azure AD group containing BookMe users
- [ ] **Test Users Identified** - At least 2 users for validation
- [ ] **CRM Information** (if applicable):
  - [ ] Salesforce domain URL
  - [ ] Salesforce administrator access

## Single-Tenant Specific

### Azure Resources
- [ ] **Azure Subscription** - Active subscription in your tenant
- [ ] **Resource Group** - Existing or permission to create new
- [ ] **Azure Services Quota**:
  - [ ] Container Apps service available
  - [ ] Key Vault service available
  - [ ] Sufficient compute quota

### Managed Identity
- [ ] **Managed Identity** created with:
  - [ ] Graph API permissions configured
  - [ ] Key Vault access policies set
  - [ ] Assigned to appropriate resources

## Multi-Tenant Specific

### Customer Tenant
- [ ] **Customer Administrator** available for:
  - [ ] App Offer installation (Part 1)
  - [ ] Admin consent approval
  - [ ] User provisioning configuration
- [ ] **Communication Channel** established with customer IT

### Partner/ISV Tenant
- [ ] **Azure Subscription** in partner tenant
- [ ] **Container App Environment** quota available
- [ ] **Network Configuration**:
  - [ ] Firewall rules documented
  - [ ] Required ports accessible
  - [ ] DNS configuration ready

## Network Requirements

### Firewall Rules
- [ ] **Outbound HTTPS (443)** to:
  - [ ] `*.microsoftonline.com`
  - [ ] `*.microsoft.com`
  - [ ] `graph.microsoft.com`
  - [ ] `*.andmoney.dk` (for SCIM)

### Browser Requirements
- [ ] Modern browser (Edge, Chrome, Firefox, Safari)
- [ ] JavaScript enabled
- [ ] Cookies enabled for authentication

## Validation Requirements

### Test Scenarios Ready
- [ ] **Test Meeting Room** identified
- [ ] **Test Advisor Account** prepared
- [ ] **Test Customer Account** available
- [ ] **Test Meeting Booking** scenario defined

## Documentation to Have Ready

### Technical Documentation
- [ ] Current Azure AD tenant ID
- [ ] Azure subscription ID
- [ ] Security group Object IDs
- [ ] Network configuration details

### Process Documentation
- [ ] Escalation contacts identified
- [ ] Change management process defined
- [ ] Rollback plan prepared

## Pre-Deployment Checklist

### Communication
- [ ] Stakeholders notified of deployment schedule
- [ ] Maintenance window scheduled (if required)
- [ ] Support team briefed on changes

### Backup and Recovery
- [ ] Current configuration documented
- [ ] Rollback procedure documented
- [ ] Recovery time objective (RTO) defined

## Next Steps

Once all prerequisites are confirmed:

1. **Single-Tenant**: Proceed to [Azure Marketplace Installation](marketplace-installation)
2. **Multi-Tenant**: Review [Multi-Tenant Quick Start](multi-tenant-quickstart)
3. **Questions**: Contact your &money account manager

## Getting Help

If you're missing any prerequisites:

- **Permissions Issues**: Work with your Azure AD administrator
- **SCIM Token**: Contact your &money account manager
- **Technical Questions**: Refer to deployment documentation
- **Urgent Support**: Use the &money support portal