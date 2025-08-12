---
layout: default
title: Microsoft Entra Integration
nav_order: 4
parent: Configuration
grand_parent: Platform Deployment
collection: deployment
---

# Microsoft Entra Integration

Configure advanced identity and access management features with Microsoft Entra ID (formerly Azure Active Directory).

## Overview

Microsoft Entra ID integration provides:
- **Single Sign-On (SSO)**: Seamless authentication across all platform components
- **Multi-Factor Authentication**: Enhanced security for user access
- **Conditional Access**: Policy-based access control
- **Identity Protection**: Risk-based authentication
- **Managed Identities**: Secure service-to-service authentication

## App Registrations

App registrations are the foundation of the platform's authentication:

### Platform App Registrations
The platform uses two primary app registrations:
1. **SCIM Provisioning App**: Handles user and group synchronization
2. **Calendar/Teams App**: Manages Microsoft 365 integrations

### Why App Registrations?
- **Security Boundary**: Each app has specific, limited permissions
- **Audit Trail**: All access is logged and traceable
- **Consent Management**: Administrators control what the platform can access
- **Token Management**: Secure OAuth 2.0 token flow

## Admin Consent

### What is Admin Consent?
Admin consent allows an administrator to grant permissions on behalf of all users in the organization.

### Required Permissions
The platform requires admin consent for:
- `Calendars.ReadWrite`: Access to calendar data
- `OnlineMeetings.ReadWrite.All`: Create and manage Teams meetings
- `User.Read.All`: Read user profiles for synchronization

### Granting Consent
1. Navigate to Enterprise Applications
2. Select the platform application
3. Click "Permissions"
4. Review requested permissions
5. Click "Grant admin consent"

## Managed Identities

### Overview
Managed identities provide automatic credential management for Azure resources.

### Configuration
The platform uses managed identities for:
- **Key Vault Access**: Retrieve secrets securely
- **Graph API Calls**: Authenticate without storing credentials
- **Storage Access**: Connect to blob storage

### Benefits
- No credential management required
- Automatic key rotation
- Reduced security risk
- Simplified deployment

## Single Sign-On Configuration

### SAML Configuration
For SAML-based SSO:
1. Configure Identity Provider metadata
2. Set up attribute mappings
3. Configure response URLs
4. Test authentication flow

### OAuth 2.0 / OpenID Connect
For modern authentication:
1. Register redirect URIs
2. Configure token settings
3. Set up claims mapping
4. Enable refresh tokens

## Conditional Access Policies

### Recommended Policies

#### Require MFA for Admins
```json
{
  "conditions": {
    "users": ["Admin Role Group"],
    "applications": ["Platform Management Portal"]
  },
  "grant": {
    "requireMfa": true
  }
}
```

#### Trusted Location Access
```json
{
  "conditions": {
    "locations": ["Untrusted"],
    "applications": ["Platform APIs"]
  },
  "grant": {
    "block": true
  }
}
```

## Security Best Practices

### Token Lifetime
- Access tokens: 1 hour (default)
- Refresh tokens: 90 days (recommended)
- Session tokens: 8 hours (configurable)

### Certificate Management
- Use certificate-based authentication for production
- Rotate certificates annually
- Monitor certificate expiration

### Audit and Monitoring
- Enable sign-in logs
- Configure alerts for suspicious activity
- Regular access reviews
- Monitor consent grants

## Troubleshooting

### Common Issues

#### Permission Errors
**Error**: "Insufficient privileges to complete the operation"

**Solution**:
1. Verify admin consent is granted
2. Check user has required licenses
3. Review conditional access policies

#### Token Expiration
**Error**: "Token has expired"

**Solution**:
1. Check token lifetime policies
2. Ensure refresh token is valid
3. Re-authenticate if necessary

#### SSO Failures
**Error**: "Authentication failed"

**Solution**:
1. Verify SSO configuration
2. Check attribute mappings
3. Review SAML response
4. Validate certificates

## Integration with Other Services

### Microsoft Graph
The platform uses Graph API for:
- User profile information
- Calendar operations
- Teams meeting management
- Mail operations (if enabled)

### Azure Services
Integration points include:
- Azure Key Vault for secrets
- Azure Monitor for logging
- Azure Storage for files
- Azure Service Bus for messaging

## Compliance and Governance

### Data Residency
- User data stays in tenant region
- Comply with local regulations
- Configure data boundaries

### Access Reviews
- Quarterly review of permissions
- Remove unnecessary access
- Document access decisions

## Next Steps

- Configure [SCIM Provisioning](/docs/deployment/configuration/scim-provisioning)
- Set up [Teams Integration](/docs/deployment/configuration/teams-integration)
- Review [Security Guidelines](/docs/deployment/reference/security)