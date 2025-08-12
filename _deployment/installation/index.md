---
layout: default
title: Installation Guides
nav_order: 3
parent: Platform Deployment
has_children: true
---

# Installation Guides

Choose the installation guide that matches your deployment scenario.

## Installation Options

### [Single-Tenant Installation](single-tenant)
**Best for:**
- Single organizations
- Direct customers
- Proof of concept deployments
- Organizations with one Microsoft Entra ID tenant

**Key Features:**
- Automated configuration
- All resources in one tenant
- Simplified management
- Straightforward deployment process

### [Multi-Tenant Installation](multi-tenant)
**Best for:**
- ISVs and partners
- Managing multiple customers
- Complex organizational structures
- Centralized management scenarios

**Key Features:**
- Customer isolation
- Centralized management
- Scalable architecture
- Comprehensive deployment process

## Before You Install

1. Complete the [Prerequisites Checklist](../prerequisites)
2. Obtain SCIM token from your account manager
3. Ensure you have required permissions
4. Identify your deployment scenario

## Quick Decision Guide

| Question | Single-Tenant | Multi-Tenant |
|----------|--------------|--------------|
| Number of organizations? | One | Multiple |
| Who manages the platform? | Customer IT | Partner/ISV |
| Resource location? | Customer tenant | Split across tenants |
| Management overhead? | Low | Medium |
| Setup complexity? | Simpler | More involved |

## Common Deployment Patterns

### Enterprise Deployment
Single organization with full control → [Single-Tenant](single-tenant)

### Partner Management
ISV managing multiple customers → [Multi-Tenant](multi-tenant)

### Subsidiary Structure
Parent company with divisions → [Multi-Tenant](multi-tenant)

### Trial or POC
Testing the platform → [Single-Tenant](single-tenant)

## Post-Installation

After completing installation:
1. Configure [SCIM Provisioning](../configuration/scim-provisioning)
2. Set up [Teams Integration](../configuration/teams-integration)
3. Enable [Management Portal](../configuration/management-portal)
4. Validate deployment

## Getting Help

- Review [Prerequisites](../prerequisites) first
- Check [Troubleshooting Guide](../reference/troubleshooting)
- Contact your account manager
- Use the support portal for technical issues