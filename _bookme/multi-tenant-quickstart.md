---
layout: default
title: Multi-Tenant Quick Start
nav_order: 5
parent: BookMe
---

# Multi-Tenant Quick Start

A rapid deployment guide for experienced administrators deploying BookMe across multiple customer tenants.

## 30-Minute Deployment Process

### Pre-Flight Checklist ✓

**Customer Ready:**
- [ ] Global Admin available
- [ ] SCIM token obtained
- [ ] Security group created
- [ ] Users identified

**Partner Ready:**
- [ ] Azure subscription active
- [ ] Management UI access confirmed
- [ ] Communication channel open

## Phase 1: Customer Setup (10 minutes)

**Customer Admin Actions:**

```bash
1. Azure Portal → Create Resource → "&money Financial Meeting Platform"
2. Select: "Partial Deployment (Multi-Tenant Part 1)"
3. Enter: SCIM Token + Security Group Object ID
4. Deploy → Copy: Client ID, Client Secret, Tenant ID
5. Share credentials with partner (secure channel)
```

## Phase 2: Partner Setup (10 minutes)

**Partner Admin Actions:**

```bash
1. Azure Portal → Create Resource → "&money Financial Meeting Platform"  
2. Select: "Partner Infrastructure (Part 2)"
3. Enter: Customer's Client ID + Secret
4. Deploy → Copy: Graph Proxy URL
5. Document: Container App URL for configuration
```

## Phase 3: Configuration (10 minutes)

### In Management UI

```bash
1. Settings → Customers → Add Customer
2. Enter:
   - Customer Name: [Customer]
   - Tenant ID: [From Part 1]
   - Graph Proxy URL: [From Part 2]
3. Save → Test Connection → ✓ Success
```

### In Customer Tenant

```bash
1. Enterprise Applications → BookMe SCIM
2. Users and Groups → Add → Select Users
3. Provisioning → Automatic → Start
4. Wait 5 minutes → Verify sync
```

## Validation Checklist

**Quick Tests:**
- [ ] Management UI: Users visible
- [ ] Test meeting: Successfully created
- [ ] Calendar sync: Confirmed working
- [ ] Teams integration: Meeting appears

## Common Issues & Quick Fixes

| Issue | Fix (< 2 min) |
|-------|--------------|
| Users not syncing | Restart provisioning in customer tenant |
| Connection failed | Verify Client ID/Secret are correct |
| Access denied | Check admin consent was granted |
| Graph Proxy timeout | Check firewall allows HTTPS to *.microsoftonline.com |

## Command Reference

### PowerShell - Quick Customer Setup
```powershell
# If UI is unavailable
.\Enable-SCIM-Provisioning.ps1 `
  -TenantId "[CUSTOMER_TENANT]" `
  -ScimToken "[TOKEN]" `
  -Environment "Production"
```

### Azure CLI - Quick Validation
```bash
# Test Graph Proxy
curl -X GET https://[YOUR-PROXY].azurecontainerapps.io/health

# Check provisioning
az ad app list --display-name "BookMe" --query "[].appId"
```

## Scaling to Multiple Customers

**Efficient Multi-Customer Workflow:**

1. **Batch Part 1**: Have all customers complete Part 1 simultaneously
2. **Single Part 2**: Deploy partner infrastructure once
3. **Bulk Configure**: Add all customers to Management UI
4. **Parallel Validation**: Test all connections together

**Time Estimate per Additional Customer:** 5-10 minutes

## Emergency Contacts

- **Critical Issues**: [Partner Support Hotline]
- **SCIM Tokens**: &money Account Manager
- **Azure Issues**: Azure Support Portal

## Next Steps

**For detailed instructions**, see:
- [Full Multi-Tenant Installation Guide](multi-tenant-installation)
- [SCIM Configuration Details](scim-provisioning-setup)
- [Troubleshooting Guide](deployment-overview#troubleshooting)

---

*This quick start assumes familiarity with Azure and Microsoft Entra ID administration.*