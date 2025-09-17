---
layout: default
title: Deployment Overview
nav_order: 1
parent: Platform Deployment
collection: deployment
---

# Platform Deployment Overview

This guide provides an overview of deploying the &money Financial Platform with its comprehensive suite of capabilities.

## Platform Capabilities

The platform includes:

- **Meeting Management**: Customer meeting scheduling and tracking
- **Microsoft Teams Integration**: Online meetings with transcription
- **Calendar Synchronization**: Full Microsoft 365 calendar access
- **User Management**: Automated provisioning via SCIM
- **CRM Integration**: Salesforce and other platforms
- **Multi-Organization Support**: Manage multiple tenants

## Deployment Models

### Single-Tenant Deployment

Best for organizations that:

- Operate within one Microsoft Entra ID tenant
- Want simplified management
- Prefer automated configuration

### Multi-Tenant Deployment

Designed for:

- ISVs and partners managing multiple customers
- Organizations with complex subsidiary structures
- Scenarios requiring tenant isolation

## High-Level Process

### Phase 1: Preparation

- Review prerequisites
- Obtain required permissions
- Gather necessary information

### Phase 2: Azure Marketplace Installation

- Deploy core platform components
- Configure Microsoft Entra ID resources
- Set up Azure infrastructure

### Phase 3: Configuration

- Enable user provisioning
- Configure Teams integration
- Set up management portal access

### Phase 4: Validation

- Test user synchronization
- Verify meeting capabilities
- Confirm Teams transcription

## Key Components

### Microsoft Entra ID Resources

- **App Registrations**: Platform authentication
- **Service Principals**: API access
- **Enterprise Applications**: User provisioning

### Azure Infrastructure

- **Container Apps**: Microservices hosting
- **Key Vault**: Secure credential storage
- **Managed Identities**: Service authentication

### Integration Points

- **Microsoft Graph API**: Calendar and Teams access
- **SCIM Protocol**: User provisioning
- **CRM APIs**: Customer data synchronization

## Common Scenarios

| Scenario    | Typical Use Case                  | Deployment Model |
| ----------- | --------------------------------- | ---------------- |
| Enterprise  | Single organization, full control | Single-Tenant    |
| Partner/ISV | Multiple customer deployments     | Multi-Tenant     |
| Subsidiary  | Parent company with divisions     | Multi-Tenant     |
| Trial/POC   | Evaluation deployment             | Single-Tenant    |

## Prerequisites Summary

### Required Permissions

- Microsoft Entra ID Global Administrator or delegated permissions
- Teams Administrator for meeting capabilities
- Azure subscription for infrastructure

### Required Information

- SCIM token from &money
- Security group for users
- Target environment (Test/Production)

## Security Considerations

### Data Isolation

- Tenant-level separation
- Encrypted credential storage
- Audit logging enabled

## Getting Help

### Documentation Structure

- **Quick Start**: Rapid deployment guides
- **Installation**: Detailed step-by-step instructions
- **Configuration**: Post-deployment setup
- **Reference**: Technical documentation

### Support Channels

- Account Manager: Initial setup assistance
- Technical Support: Deployment issues
- Documentation: This guide and related docs
- Community: Partner forums

## Next Steps

Based on your scenario:

1. **New Deployment**: Start with [Prerequisites](prerequisites)
2. **Single Organization**: Follow [Single-Tenant Guide](installation/single-tenant)
3. **Multiple Organizations**: See [Multi-Tenant Guide](installation/multi-tenant)
4. **Quick Setup**: Use [Quick Start Guide](quick-start/multi-tenant-quickstart)

---

_This overview covers the complete platform deployment. For product-specific features, see the relevant product documentation._
