---
layout: default
title: Setup in Salesforce
parent: Embeddable UI
nav_order: 2
---

# Salesforce Integration Guide: Portal and Quick Actions

This guide provides step-by-step instructions for integrating the &Money Portal and configuring quick actions within your Salesforce organization.

## Prerequisites

- Administrator access to your Salesforce organization
- Appropriate permissions to edit page layouts and create flows
- Access to the &Money embeddable UI environment URLs

## Portal Setup

### Adding the Portal Component

1. Navigate to the target account record
2. Access the Lightning App Builder by clicking **Settings** → **Edit Page**
3. Choose the desired location for the component:
   - Add a new tab, or
   - Select an existing section
4. Locate **&Money Portal** in the components panel
5. Drag the component to your chosen location
6. Configure the component by adding the source URL for the embeddable UI
7. Click **Save** to apply changes

### Initial Organization Setup

For first-time implementations, configure the embeddable UI URL as a Trusted URL with required Content Security Policy (CSP) directives.

### Environment-Specific URLs

| Environment | Embeddable UI URL                                 |
| ----------- | ------------------------------------------------- |
| Development | `https://embeddable.dev-env.booking.andmoney.dk`  |
| Test        | `https://embeddable.test-env.booking.andmoney.dk` |
| Production  | `https://embeddable.booking.andmoney.dk`          |

### Configuring Trusted URLs

#### Step 1: Access Trusted URLs Configuration

1. Navigate to **Setup** in Salesforce
2. Search for "Trusted URLs" in the Quick Find box
3. Select **Trusted URLs** from the search results

#### Step 2: Create Trusted URL Entry

1. Click **New Trusted URL**
2. Complete the configuration:
   - **Name:** Enter a descriptive identifier (e.g., "&Money Embeddable UI")
   - **URL:** Select the appropriate URL from the environment table above
   - **CSP Directives:** Enable the following permissions:
     - ✅ **frame-src** – Enables iframe embedding capability
     - ✅ **img-src** – Permits image resource loading from the domain
3. Click **Save** to confirm the configuration

#### Step 3: Validate Configuration

1. Verify the URL appears in the Trusted URLs list
2. Confirm both `frame-src` and `img-src` directives show as active
3. Test the integration by loading a page with the embedded component

> **Important:** This is a one-time configuration per Salesforce organization. Future deployments and updates will not require modifications to these Trusted URL settings.

## Quick Action Configuration

Quick actions provide users with fast access to customer overview functionality directly from record pages.

### Step 1: Create a Screen Flow

#### Access Flow Builder
1. Navigate to **Setup** → **Process Automation** → **Flows**
2. Click **New Flow**
3. Select **Screen Flow** as the flow type
4. Click **Create**

#### Configure Screen Component
1. Add a Screen element between the Start and End nodes:
   - Click the **+** icon on the flow canvas
   - Select **Screen** from the element list
2. Configure the screen properties:
   - **Label:** Kundeoverblik
   - **API Name:** CustomerOverview
3. Add the &Money Portal component:
   - Locate **&Money Portal** in the components panel
   - Drag it into the screen canvas area
   - Configure component settings:
     - **API Name:** customer_overview
     - **Source URL:** `[Environment URL]/customerOverview` (refer to the environment table above)
     - **Record ID:** Create a text variable named `recordId`
4. Click **Done** to save the screen configuration

#### Save and Activate Flow
1. Click **Save** in the top toolbar
2. Configure flow properties:
   - **Flow Label:** &Money Customer Overview
   - **Flow API Name:** money_customer_overview
3. Click **Save**
4. Activate the flow from the Flows overview page

### Step 2: Create Quick Action

1. Navigate to the target object:
   - Go to **Setup** → **Object Manager**
   - Select the relevant object (e.g., Account)
2. Access action configuration:
   - Select **Buttons, Links, and Actions** from the sidebar
   - Click **New Action**
3. Configure the action:
   - **Action Type:** Flow
   - **Flow:** &Money Customer Overview
   - **Label:** Kundeopsummering
   - **Name:** Customer_Overview
4. Click **Save**

### Step 3: Deploy to Page Layouts

1. Navigate to page layout configuration:
   - In Object Manager, select **Page Layouts**
   - Choose the appropriate layout
2. Add the action to the layout:
   - Locate **Kundeopsummering** in the Mobile & Lightning Actions palette
   - Drag the action to the **Salesforce Mobile and Lightning Experience Actions** section
   - Position it at the beginning of the action list for prominent visibility
3. Click **Save** to apply the layout changes

### Visual Reference

![Adding quick action to Salesforce page layout]({{ site.baseurl }}/assets/images/embeddable-ui/iframe-salesforce-add-action.png)

## Troubleshooting

### Common Issues and Solutions

| Issue | Solution |
| ----- | -------- |
| Portal not displaying | Verify Trusted URL configuration and CSP directives |
| Flow not available in actions | Ensure flow is activated and has correct permissions |
| Quick action not visible | Check page layout assignment and user profile permissions |
| Cross-origin errors | Confirm the embeddable UI URL matches the Trusted URL exactly |