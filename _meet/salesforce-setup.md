---
layout: default
title: Salesforce Setup
nav_order: 1
parent: Meet
---

# Salesforce Setup for Meet

This guide covers configuring the Meet component in your Salesforce organization, including Trusted URL configuration and verification steps.

## Prerequisites

- Administrator access to your Salesforce organization
- The &money Portal component deployed to Salesforce
- Meet environment URL provided by &money

For Portal component deployment, see [Deploying Iframe LWC to Salesforce]({{ site.baseurl }}/bookme/salesforce-iframe-lwc-deployment/).

## Environment URLs

| Environment | Meet URL |
|-------------|----------|
| Test | `https://app.meet.test-env.andmoney.dk` |
| Production | `https://app.meet.andmoney.dk` |

## Portal Component Setup

Meet is embedded using the same Portal component as other &money embeddable features (such as Referat). The setup follows the same pattern described in [Setup in Salesforce]({{ site.baseurl }}/embeddable-ui/setup-in-salesforce/).

### Adding the Portal Component to an Event Page

1. Navigate to an Event record in Salesforce
2. Access the Lightning App Builder by clicking **Settings** → **Edit Page**
3. Choose the desired location for the component:
   - Add a new tab, or
   - Select an existing section
4. Locate **&money Portal** in the components panel
5. Drag the component to your chosen location
6. Configure the component:
   - **Source URL**: Enter the Meet URL provided by &money
7. Click **Save** to apply changes

The component uses the Event's `recordId` to establish context, which is passed automatically.

## Trusted URL Configuration

Meet requires additional Content Security Policy (CSP) directives compared to other embeddable components, due to real-time transcription and microphone access requirements.

### Step 0: Enable Permissions-Policy HTTP Header

1. Navigate to **Setup** in Salesforce
2. Search for "Session Settings" in the Quick Find box
3. Scroll to the **Browser Feature Policies** section
4. Check **Include Permissions-Policy HTTP header**
5. Set **Microphone** to **Trusted URLs Only**
6. Click **Save**

> **Note**: This is a one-time configuration per Salesforce organization. Without this setting, the microphone permission in Trusted URLs will not take effect.

### Step 1: Access Trusted URLs Configuration

1. Navigate to **Setup** in Salesforce
2. Search for "Trusted URLs" in the Quick Find box
3. Select **Trusted URLs** from the search results

### Step 2: Create Trusted URL Entry

1. Click **New Trusted URL**
2. Complete the configuration:
   - **API Name**: Enter an identifier, e.g., `meet_iframe`
   - **URL**: Enter the Meet URL provided by &money
   - **CSP Context**: Select **Lightning Experience Pages**

3. Under **CSP Directives**, enable the following:

| Directive | Enable | Purpose |
|-----------|--------|---------|
| connect-src (scripts) | ✅ | WebSocket connections for real-time transcription |
| font-src (fonts) | ☐ | Not required |
| frame-src (iframe content) | ☐ | Not required |
| img-src (images) | ☐ | Not required |
| media-src (audio and video) | ✅ | Microphone audio capture |
| style-src (stylesheets) | ✅ | Material-UI component styling |

4. Under **Permissions Policy Directives**, enable the following:

| Directive | Enable | Purpose |
|-----------|--------|---------|
| camera | ☐ | Not required |
| microphone | ✅ | Audio recording for meetings |

5. Click **Save** to confirm the configuration

### Step 3: Validate Configuration

1. Verify the Meet URL appears in the Trusted URLs list
2. Confirm CSP directives are enabled: `connect-src`, `media-src`, `style-src`
3. Confirm Permissions Policy directive `microphone` is enabled
4. Test the integration by loading Meet on an Event page

> **Note**: This is a one-time configuration per Salesforce organization. Future updates will not require modifications to these Trusted URL settings.

## Verifying the Installation

After completing the setup, verify that Meet is working correctly:

### Step 1: Open Meet from an Event Record

1. Navigate to an Event record in Salesforce
2. Locate the Meet component on the page
3. The Meet interface should load within the component

### Step 2: Verify Authentication

1. Meet will initiate SSO login using your Salesforce user's federation ID (if configured) or email
2. You should be authenticated automatically via Azure AD
3. If prompted, sign in with your organizational credentials
4. Meet validates that your authenticated identity matches your Salesforce user context

### Step 3: Test Microphone Access

1. Click the gear icon to open settings
2. Your browser should prompt for microphone permission (if not already granted)
3. Grant microphone access when prompted
4. Verify that the microphone selector shows available devices

### Step 4: Confirm Record Context

1. Participants from the Event record should be auto-suggested
2. The meeting context should reflect the Event details

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Meet not displaying | Verify Trusted URL configuration and CSP directives are enabled |
| Microphone not detected | Check browser permissions, `media-src` CSP directive, `microphone` Permissions Policy, and Session Settings Permissions-Policy HTTP header |
| WebSocket connection errors | Verify `connect-src` CSP directive is enabled for the Meet URL |
| Authentication failures | Ensure user has appropriate access and Azure AD SSO is configured |
| Cross-origin errors | Confirm the Meet URL matches the Trusted URL exactly |
| Styling issues | Verify `style-src` CSP directive is enabled |

## Related Documentation

- [Deploying Iframe LWC to Salesforce]({{ site.baseurl }}/bookme/salesforce-iframe-lwc-deployment/) — Portal component deployment
- [Setup in Salesforce]({{ site.baseurl }}/embeddable-ui/setup-in-salesforce/) — General Portal and Quick Action configuration
- [Salesforce Iframe LWC Configuration]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) — Advanced configuration options
