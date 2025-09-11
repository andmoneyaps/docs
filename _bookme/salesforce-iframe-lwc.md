---
layout: default
title: Salesforce Iframe LWC Configuration
nav_order: 10.2
parent: BookMe
---

# Salesforce Iframe LWC Component - configOverride API Documentation

## Overview
The `configOverride` is an `@api` decorated object property in the Iframe Lightning Web Component that allows parent components to customize the behavior and appearance of the embedded iframe booking solution. This powerful configuration mechanism enables you to control various aspects of the meeting booking flow without modifying the base component.

## How to Use configOverride

### Creating a Wrapper Component
To utilize the `configOverride` functionality, you need to create a wrapper component that uses the Portal component:

```javascript
// Example: customPortalWrapper.js
import { LightningElement } from 'lwc';

export default class CustomPortalWrapper extends LightningElement {
    portalConfig = {
        recordid: 'your-record-id',
        disableheaders: true,
        customflow: 'withtheme',
        meetingtitle: 'Quarterly Review',
        // ... other configuration options
    };
}
```

```html
<!-- Example: customPortalWrapper.html -->
<template>
    <c-portal 
        src="https://your-booking-platform.com"
        record-id={recordId}
        object-api-name={objectApiName}
        config-override={portalConfig}>
    </c-portal>
</template>
```

## Configuration Properties Reference

### Record Management Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `recordid` | String | `this.recordId` | The Salesforce record ID associated with the meeting |
| `accountId` | String | `this.recordId` | The account ID for the meeting context |
| `recordname` | String | `this.objectApiName` | The name/type of the record |
| `objectApiName` | String | `this.objectApiName` | The Salesforce object API name |

### Meeting Configuration Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `meetingtitle` | String | `undefined` | Predetermined title for the meeting. When set, this title will be automatically applied to new meetings |
| `meetingid` | String | `undefined` | ID of an existing meeting to load/update |
| `subthemeid` | String | `undefined` | Booking platform subtheme ID to preload the flow with custom styling/configuration |
| `configid` | String | `undefined` | ID of the SObject config (custom metadata) to use for meeting settings |
| `customflow` | String | `undefined` | Name of custom flow to use. Valid values: `"withtheme"`, `"cancel"`, `"update"` |

### UI Control Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disableheaders` | Boolean | `false` | Removes headers from screens in the booking flow for a cleaner interface |
| `disableprogressbar` | Boolean | `false` | Hides the progress indicator bar from the booking flow |
| `removeclosebutton` | Boolean | `false` | Removes the close button from the meeting confirmation page |

### Feature Toggle Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disableshowavailabletimesascustomerfilter` | Boolean | `false` | Disables the "show available times as customer" filter option on the meeting planner |
| `disableadditionalcontacts` | Boolean | `false` | Prevents users from adding additional contacts/attendees to meetings |
| `disablecreaterecordcheckbox` | Boolean | `false` | Removes the option to create a related Salesforce record when scheduling meetings |
| `disablecustommeetingtitle` | Boolean | `false` | Prevents users from entering custom meeting titles (useful when using predetermined titles) |
| `disablecustomermeetings` | Boolean | `false` | Hides the screen showing upcoming meetings for the customer |

### Advisor Configuration

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `advisortypewhitelist` | String | `undefined` | Restricts available advisor types. Valid values: `'SpecificAdvisors'`, `'LocalAdvisors'`, `'AllAdvisors'` |

## Common Use Cases

### 1. Simplified Meeting Creation Flow
```javascript
// Remove all optional UI elements for a streamlined experience
const simplifiedConfig = {
    meetingtitle: 'Standard Consultation',
    disableheaders: true,
    disableprogressbar: true,
    disablecustommeetingtitle: true,
    disableadditionalcontacts: true
};
```

### 2. Update Existing Meeting
```javascript
// Configuration for updating an existing meeting
const updateMeetingConfig = {
    meetingid: 'existing-meeting-id',
    customflow: 'update',
    removeclosebutton: false
};
```

### 3. Restricted Advisor Selection
```javascript
// Limit to local advisors only
const localAdvisorsConfig = {
    advisortypewhitelist: 'LocalAdvisors',
    disableshowavailabletimesascustomerfilter: true
};
```

### 4. Themed Custom Flow
```javascript
// Use a custom themed flow with specific branding
const themedFlowConfig = {
    customflow: 'withtheme',
    subthemeid: 'brand-theme-123',
    disableheaders: false,
    disableprogressbar: false
};
```

## Communication Flow

The Iframe component uses a postMessage API to communicate with the embedded iframe:

1. **Initialization**: When the iframe loads, it sends an `IFRAME_READY` message
2. **Configuration**: The Iframe component responds by sending the `configOverride` object via postMessage
3. **Runtime Updates**: The iframe can send height change requests (`CONTENT_HEIGHT_CHANGE`) to dynamically adjust its display size

## Best Practices

1. **Always specify required fields**: Ensure `recordid` and `objectApiName` are properly set when creating meetings related to Salesforce records

2. **Use meaningful titles**: When setting `meetingtitle`, use descriptive names that clearly indicate the meeting purpose

3. **Consider user experience**: Be cautious when disabling features - ensure users still have access to necessary functionality

4. **Test thoroughly**: Different combinations of settings can significantly change the user experience, so test your specific configuration thoroughly

5. **Handle undefined values**: The component gracefully handles undefined values by using defaults, but explicitly set values when you need specific behavior

## Example: Complete Wrapper Component

```javascript
// portalWrapper.js
import { LightningElement, api } from 'lwc';

export default class PortalWrapper extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    // Define your custom configuration
    get customConfig() {
        return {
            recordid: this.recordId,
            objectApiName: this.objectApiName,
            meetingtitle: 'Customer Review Meeting',
            subthemeid: 'corporate-theme',
            disableheaders: false,
            disableprogressbar: false,
            advisortypewhitelist: 'LocalAdvisors',
            disableadditionalcontacts: false,
            disablecreaterecordcheckbox: true,
            disablecustommeetingtitle: true,
            removeclosebutton: false,
            customflow: 'withtheme',
            disablecustomermeetings: false
        };
    }
}
```

```html
<!-- portalWrapper.html -->
<template>
    <c-portal 
        src="https://booking.example.com"
        record-id={recordId}
        object-api-name={objectApiName}
        config-override={customConfig}>
    </c-portal>
</template>
```

```xml
<!-- portalWrapper.js-meta.xml -->
<?xml version="1.0" encoding="UTF-8"?>
<LightningComponentBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>62.0</apiVersion>
    <isExposed>true</isExposed>
    <masterLabel>Custom Portal Wrapper</masterLabel>
    <targets>
        <target>lightning__RecordPage</target>
    </targets>
    <targetConfigs>
        <targetConfig targets="lightning__RecordPage">
            <supportedFormFactors>
                <supportedFormFactor type="Large"/>
                <supportedFormFactor type="Small"/>
            </supportedFormFactors>
        </targetConfig>
    </targetConfigs>
</LightningComponentBundle>
```

## Notes

- The `configOverride` object is sent to the iframe via postMessage when the iframe signals it's ready
- Changes to the configuration after the initial load may not take effect unless the component is re-rendered
- The iframe application must be designed to handle and process these configuration options
- Always ensure your iframe source URL is trusted and secure when passing configuration data