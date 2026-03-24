---
layout: default
title: Deploying Iframe LWC to Salesforce
nav_order: 10.1
parent: BookMe
---

# Deploying the Iframe LWC Component to Salesforce

## What is the Iframe LWC Component?

The &money EngageMe iframe Lightning Web Component (LWC) is a powerful integration tool that embeds BookMe's meeting booking functionality directly within Salesforce Lightning pages. For a complete overview of embeddable components and their capabilities, see the [Embeddable UI Documentation]({{ site.baseurl }}/embeddable-ui/).

This component enables users to:

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
2. **Established Salesforce org connection**: The connection between BookMe and Salesforce must be provisioned and tested successfully
3. **Administrator Access**: You need appropriate permissions in both the Management UI and Salesforce
4. **User Access Configuration**: Bank employees who will use the iframe must have proper access configured. See [Embeddable UI Access Requirements]({{ site.baseurl }}/embeddable-ui/#access-requirements) for an overview

## Deployment Process

### Step 1: Setup Salesforce Connection

Before deploying the component, you must establish a secure connection between BookMe and your Salesforce organization. Follow the comprehensive instructions in the [Salesforce Connection Setup]({{ site.baseurl }}/bookme/salesforce-connection-setup/) guide which covers:
- Configuring the External Client App in Salesforce
- Setting up the Salesforce domain in the Management UI
- Testing and provisioning the connection
- Verifying the authentication flow

Once your connection is successfully established and tested, proceed to deploy the component.

### Step 2: Deploy the Portal Component

1. Navigate to Admin → CRM → Configuration in the Management UI
2. Locate the **&money EngageMe Components** section
3. Click the **"Deploy Portal"** button
4. The deployment process will:
   - Package the iframe LWC component
   - Authenticate with your Salesforce org using the provisioned connection
   - Deploy the component to Salesforce
   - Poll for deployment status

### Step 3: Verify Deployment

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
- Supports all configuration options documented in the [Iframe LWC Configuration guide]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/)

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


## Component Variants

The &money Portal component exists in two variants. The variant is selected in the Management UI under **Admin → CRM → Configuration** when deploying the component.

| Variant | When to use | Behavior |
|---------|-------------|----------|
| **With managed package** | The bank has the BookMe managed package installed. The managed package handles customer bookings via its own LWC components. | The Portal iframe handles internal meetings and the meeting overview. Customer bookings are handled by the managed package. The "Book Meeting" button switches from the iframe to the managed package's LWC. `disablecustomermeetings` is hardcoded to `true`. |
| **Standalone** | The bank does **not** have the managed package. All booking is done through the Portal iframe. | The Portal iframe handles both internal meetings and customer bookings. The landing page shows both buttons, and employees stay within the iframe for both flows. `disablecustomermeetings` is configurable via `configOverride`. |

{: .note }
> In the **managed package variant**, `disablecustomermeetings` is always forced to `true` and cannot be overridden via `configOverride`. In the **standalone variant**, it defaults to `false` and can be set via `configOverride`.

## Related Documentation

- [Salesforce Connection Setup]({{ site.baseurl }}/bookme/salesforce-connection-setup/) - Detailed guide for establishing the BookMe-Salesforce connection
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) - Configuration options for the deployed iframe component
- [Salesforce BookMe Integration Setup]({{ site.baseurl }}/bookme/salesforce-setup/) - Complete Salesforce package installation and metadata configuration
- [CRM Integration Security]({{ site.baseurl }}/bookme/crm-integration-security/) - Security architecture and considerations
