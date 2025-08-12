---
layout: default
title: Prerequisites Checklist
nav_order: 2
parent: Platform Deployment
collection: deployment
---

# Prerequisites Checklist

Before deploying the &money Financial Platform, ensure all prerequisites are met for your deployment scenario.

## All Deployments

### Required Permissions

#### Microsoft Entra ID Permissions
- [ ] **Global Administrator** OR the following delegated permissions:
  - [ ] `Application.ReadWrite.All` - To create app registrations ([Why? See App Registration Setup](/docs/deployment/configuration/app-registration-setup))
  - [ ] `Synchronization.ReadWrite.All` - To configure SCIM provisioning ([Learn about SCIM](/docs/deployment/configuration/scim-provisioning#what-is-scim))

#### Microsoft Teams Permissions  
- [ ] **Teams Administrator** OR **Teams Communications Administrator** role
  - Required for creating Teams access policies ([Teams Setup Guide](/docs/deployment/configuration/teams-integration#access-policies))
  - Needed for online meeting management ([Meeting Features](/docs/deployment/configuration/teams-integration#meeting-capabilities))

### Required Information

#### From &money
- [ ] **SCIM Token** - Contact your account manager to obtain ([What is SCIM?](/docs/deployment/configuration/scim-provisioning#overview))
- [ ] **Management UI Credentials** - Provided during onboarding ([Portal Access Guide](/docs/deployment/configuration/management-portal))
- [ ] **Environment Selection** - Test or Production ([Environment Differences](/docs/deployment/overview#environments))

#### From Your Organization
- [ ] **Security Group Object ID** - Microsoft Entra ID group containing platform users
- [ ] **Test Users Identified** - At least 2 users for validation
- [ ] **CRM Information** (if applicable):
  - [ ] Salesforce domain URL ([CRM Integration Setup](/docs/bookme/salesforce-setup))
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
  - [ ] App Offer installation ([Part 1 Process](/docs/deployment/installation/multi-tenant#part-1-customer-setup))
  - [ ] Admin consent approval ([See App Registration Guide](/docs/deployment/configuration/app-registration-setup))
  - [ ] User provisioning configuration ([SCIM Setup](/docs/deployment/configuration/scim-provisioning))
- [ ] **Communication Channel** established with customer IT

### Partner/ISV Tenant
- [ ] **Azure Subscription** in partner tenant ([Multi-Tenant Architecture](/docs/deployment/installation/multi-tenant#architecture))
- [ ] **Container App Environment** quota available
- [ ] **Network Configuration**:
  - [ ] Firewall rules documented ([Network Requirements](#network-requirements))
  - [ ] Required ports accessible
  - [ ] DNS configuration ready

## Network Requirements

### Firewall Rules
- [ ] **Outbound HTTPS (443)** to:
  - [ ] `*.microsoftonline.com` (Authentication traffic)
  - [ ] `*.microsoft.com` (General Microsoft services)
  - [ ] `graph.microsoft.com` (Graph API access)
  - [ ] `*.andmoney.dk` ([SCIM Synchronization](/docs/deployment/configuration/scim-provisioning#network))

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
- [ ] Current Microsoft Entra tenant ID
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

1. **Single-Tenant**: Proceed to [Single-Tenant Installation Guide](/docs/deployment/installation/single-tenant)
2. **Multi-Tenant**: Choose between:
   - [Detailed Multi-Tenant Guide](/docs/deployment/installation/multi-tenant) - For first-time deployments
   - [Quick Start Guide](/docs/deployment/quick-start/multi-tenant-quickstart) - For experienced admins
3. **Questions**: Contact your &money account manager

## Getting Help

If you're missing any prerequisites:

- **Permissions Issues**: Work with your Microsoft Entra ID administrator
- **SCIM Token**: Contact your &money account manager
- **Technical Questions**: Refer to [Technical Reference](/docs/deployment/reference/)
- **Urgent Support**: Use the &money support portal