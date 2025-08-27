---
layout: default
title: Deploying Iframe LWC to Salesforce
nav_order: 9
parent: BookMe
---

# Deploying the Iframe LWC Component to Salesforce

## What is the Iframe LWC Component?

The &money EngageMe iframe Lightning Web Component (LWC) is a powerful integration tool that embeds BookMe's meeting booking functionality directly within Salesforce Lightning pages. This component enables users to:

- **Schedule meetings** without leaving Salesforce
- **View and manage appointments** in context with customer records
- **Automate meeting workflows** integrated with Salesforce data
- **Provide self-service booking** to customers through customer portals
- **Customize the booking experience** with configurable themes and workflows

The component acts as a seamless bridge between Salesforce CRM data and BookMe's scheduling platform, allowing organizations to leverage their existing customer data while providing advanced booking capabilities.

## Overview

The BookMe Management UI provides a streamlined deployment feature that allows administrators to automatically push this iframe Lightning Web Component directly to their connected Salesforce organization. This eliminates the need for manual deployment through Salesforce CLI or other developer tools.

## Prerequisites

Before deploying the iframe component, ensure you have:

1. **Configured Salesforce Domain**: Your Salesforce organization's domain must be properly configured in the Management UI
2. **Established BookMe Connection**: The connection between BookMe and Salesforce must be provisioned and tested successfully
3. **Administrator Access**: You need appropriate permissions in both the Management UI and Salesforce

## Deployment Process

### Step 1: Access CRM Configuration

Navigate to the CRM Configuration page in the Management UI:
- Path: `/admin/crm/configuration`
- Menu: Admin → CRM → Configuration

### Step 2: Configure Salesforce Domain

1. In the **Salesforce Configuration** section, enter your Salesforce domain
   - Format: `yourcompany` (without the full URL)
   - The system will automatically format it as: `https://yourcompany.my.salesforce.com`
2. Save the configuration using the save bar

### Step 3: Provision BookMe Connection

1. In the **BookMe Connection** section, click the **"Provision BookMe Connection"** button
2. Wait for the provisioning process to complete
3. A status indicator will show:
   - ✅ **Green checkmark**: Connection successful
   - ⚠️ **Yellow warning**: Connection pending or requires attention
   - ❌ **Red error**: Connection failed (check error message for details)

### Step 4: Deploy the Portal Component

1. Locate the **&money EngageMe Components** section
2. Click the **"Deploy Portal"** button
3. The deployment process will:
   - Package the iframe LWC component
   - Authenticate with your Salesforce org using the provisioned connection
   - Deploy the component to Salesforce
   - Poll for deployment status (up to 30 seconds)

### Step 5: Verify Deployment

After successful deployment, you should receive a success notification: `"Portal deployed successfully"`

To verify in Salesforce:
1. Log into your Salesforce organization
2. Navigate to Setup → Lightning Components
3. Look for the deployed Portal component
4. The component will be available for use on Lightning pages

## Component Structure

The deployed component includes:

### Portal Component (c-portal)
The main iframe container component that:
- Accepts configuration through the `configOverride` API property
- Handles postMessage communication with the embedded iframe
- Dynamically adjusts height based on content
- Supports all configuration options documented in the [Iframe LWC Configuration guide](./salesforce-iframe-lwc.md)

### Deployment Contents
- Lightning Web Component bundle
- Component metadata configuration
- Security permissions
- Event handlers for iframe communication

## Using the Deployed Component

Once deployed, the component can be used in two ways:

### 1. Direct Usage
Add the Portal component directly to Lightning pages:

```xml
<c-portal 
    src="https://your-booking-platform.com"
    record-id={recordId}
    object-api-name={objectApiName}>
</c-portal>
```

### 2. Creating Custom Wrappers
Create wrapper components with preset configurations:

```javascript
// customBookingWrapper.js
import { LightningElement, api } from 'lwc';

export default class CustomBookingWrapper extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    get portalConfig() {
        return {
            recordid: this.recordId,
            meetingtitle: 'Customer Meeting',
            disableheaders: true,
            customflow: 'withtheme'
        };
    }
}
```

```html
<!-- customBookingWrapper.html -->
<template>
    <c-portal 
        src="https://booking.platform.com"
        record-id={recordId}
        object-api-name={objectApiName}
        config-override={portalConfig}>
    </c-portal>
</template>
```

## Technical Details

### Deployment API Flow

1. **Initiate Deployment**: The Management UI calls `crmIntegrationDeployPortal()` endpoint
2. **Status Polling**: If deployment returns "Pending" status, the system polls `crmIntegrationGetPortalDeploymentStatus()` every 2 seconds
3. **Timeout Handling**: Deployment times out after 30 seconds if still pending
4. **Result Processing**: Returns success or failure status with appropriate messaging

### Connection Requirements

The deployment uses the provisioned CRM connection which:
- Establishes OAuth authentication with Salesforce
- Validates API access permissions
- Ensures metadata deployment capabilities
- Verifies org compatibility

## Troubleshooting

### Common Issues and Solutions

#### Deployment Button Disabled
- **Cause**: Deployment already in progress
- **Solution**: Wait for current deployment to complete

#### "Deployment timed out" Error
- **Cause**: Salesforce deployment taking longer than 30 seconds
- **Solution**: 
  1. Check Salesforce Setup → Deployment Status
  2. Verify network connectivity
  3. Try deployment again after a few minutes

#### "Portal deployment failed" Error
- **Possible Causes**:
  - Invalid Salesforce credentials
  - Insufficient permissions in Salesforce
  - Network connectivity issues
  - Salesforce org restrictions
- **Solutions**:
  1. Test the CRM connection using the "Test Connection" button
  2. Re-provision the BookMe connection
  3. Verify user has deployment permissions in Salesforce
  4. Check Salesforce Setup → Deploy → Deployment Settings

#### Component Not Visible in Salesforce
- **Cause**: Component deployed but not added to page layouts
- **Solution**: 
  1. Go to Lightning App Builder
  2. Edit the relevant page
  3. Find "Portal" or "EngageMe" component in the component palette
  4. Drag and drop to desired location
  5. Configure component properties
  6. Save and activate the page

### Testing the Connection

Before deployment, always test the connection:
1. Click **"Test CRM Connection"** button in the Test CRM Connection section
2. Success message confirms API access
3. Error messages indicate specific connection issues

## Security Considerations

- The deployment process uses secure OAuth authentication
- No credentials are stored in the browser or exposed to client-side code
- All communication happens over HTTPS
- The deployed component runs in Salesforce's secure Lightning container

## Best Practices

1. **Test First**: Always test the CRM connection before attempting deployment
2. **Single Deployment**: The component only needs to be deployed once per Salesforce org
3. **Version Management**: Future updates will automatically handle versioning
4. **Configuration Over Customization**: Use the `configOverride` API rather than modifying the deployed component
5. **Monitor Deployment**: Check Salesforce deployment status if the process takes longer than expected

## Related Documentation

- [Salesforce Iframe LWC Configuration](./salesforce-iframe-lwc.md) - Detailed configuration options for the iframe component
- [Salesforce BookMe Integration Setup](./salesforce-setup.md) - Complete Salesforce integration guide
- [CRM Integration Security](./crm-integration-security.md) - Security architecture and considerations