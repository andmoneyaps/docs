---
layout: default
title: Salesforce Connection Setup
nav_order: 10
parent: BookMe
---

# Salesforce Connection Setup

## Overview

This guide describes how to establish a secure connection between BookMe and your Salesforce organization through the Management UI. This automated setup process eliminates the need for manual configuration of authentication providers, named credentials, and remote site settings.

## Prerequisites

- BookMe package version 1.14 or above installed in your Salesforce org
- Administrator access to both Salesforce and the BookMe Management UI
- An integration user account in Salesforce with appropriate permissions

## Connection Setup Process

### Step 1: Configure External Client App in Salesforce

The BookMe package includes an External Client App that enables secure communication between BookMe and Salesforce.

1. **Navigate to External Client App Manager** in Salesforce Setup
2. **Find** `BookMe External Client App` in the list
3. **Click Edit Policies** on the app
4. In the **OAuth Policies** section:
   - Enable **Client Credentials Flow**
   - Add an integration user that will be used for the connection
   - This user should have appropriate permissions to manage BookMe-related objects

![External Client App](../../assets/images/external-client-app.png)

{: .warning }
> **Integration User Requirements**
>
> The selected integration user must have:
> - Access to BookMe objects and fields
> - API access permissions
> - Appropriate profile or permission sets assigned

### Step 2: Configure Salesforce Domain in Management UI

1. **Navigate** to **Admin → CRM → Configuration** in the BookMe Management UI
2. **Enter your Salesforce domain** name in the Salesforce Configuration section
   - Format: Enter only the subdomain (e.g., `yourcompany`)
   - The system automatically formats it as `https://yourcompany.my.salesforce.com`
3. **Click Save** to store the domain configuration

![CRM Configuration](../../assets/images/mgmt-ui-crm-configuration.png)

### Step 3: Test the Backend-to-Salesforce Connection

Before provisioning, verify that BookMe can connect to your Salesforce org:

1. In the **Test CRM Connection** section
2. Click the **Test** button
3. Wait for the connection test to complete
4. A successful test shows a green success message
5. If the test fails, verify:
   - The domain name is correct
   - The External Client App is properly configured
   - The integration user has appropriate permissions

### Step 4: Provision the BookMe Connection

Once the backend connection is verified, provision the connection from Salesforce to BookMe:

1. In the **BookMe Connection** section
2. Click the **Provision BookMe Connection** button
3. The provisioning process will automatically:
   - Create Remote Site Settings in Salesforce
   - Configure Auth Providers
   - Set up Named Credentials
   - Push necessary credentials to your Salesforce org

{: .note }
> If the provision button shows a warning about missing credentials, contact &money support for assistance.

### Step 5: Verify the Named Credential in Salesforce

After provisioning, verify the connection in Salesforce:

1. **Navigate** to **Setup → Named Credentials** in Salesforce
2. **Find** the newly created BookMe named credential
3. **Edit** the named credential
4. **Check** the **Start Authentication Flow on Save** checkbox
5. **Click Save**
6. The authentication should complete successfully

If authentication succeeds, your Salesforce org is now connected to the BookMe backend.

## Connection Status Indicators

The Management UI provides visual status indicators for the connection:

- ✅ **Green checkmark**: Connection successful and active
- ⚠️ **Yellow warning**: Connection pending or requires attention
- ❌ **Red error**: Connection failed (check the error message for details)

## Troubleshooting

### Common Issues

#### "Missing Credentials" Warning
- **Cause**: Backend credentials not configured for your organization
- **Solution**: Contact &money support to provision backend credentials

#### Test Connection Fails
- **Possible Causes**:
  - Incorrect domain name
  - External Client App not configured properly
  - Integration user lacks permissions
- **Solutions**:
  1. Verify the domain name (should not include https:// or .my.salesforce.com)
  2. Check External Client App configuration
  3. Ensure integration user has API access and BookMe permissions

#### Provisioning Fails
- **Possible Causes**:
  - Network connectivity issues
  - Insufficient permissions in Salesforce
  - Existing conflicting configuration
- **Solutions**:
  1. Retry the provisioning process
  2. Check Salesforce logs for detailed error messages
  3. Verify no existing Auth Providers or Named Credentials conflict

#### Named Credential Authentication Fails
- **Cause**: OAuth flow cannot complete
- **Solutions**:
  1. Verify Remote Site Settings were created
  2. Check Auth Provider configuration
  3. Ensure the integration user is active
  4. Try re-provisioning the connection

## Security Considerations

- All connections use OAuth 2.0 with Client Credentials flow
- Credentials are encrypted in transit and at rest
- No passwords are stored or transmitted
- Integration user permissions limit the scope of access
- All communication occurs over HTTPS

## Next Steps

Once the connection is successfully established:
1. [Deploy the iframe LWC component](./salesforce-iframe-lwc-deployment) to enable embedded booking
2. [Configure the component](./salesforce-iframe-lwc) for your specific use cases
3. Set up custom metadata for meeting configurations

## Support

If you encounter issues during setup:
- Check the Salesforce Setup Audit Trail for detailed logs
- Review the Management UI logs for connection errors
- Contact &money support with:
  - Your Salesforce org ID
  - Error messages received
  - Steps attempted