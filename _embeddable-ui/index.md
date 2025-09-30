---
layout: default
title: Embeddable UI
nav_order: 6
has_children: true
permalink: /embeddable-ui
---

# Embeddable UI Documentation

Welcome to the &Money Embeddable UI documentation. This section covers embeddable components and integrations designed for seamless integration into external applications and CRM systems.

## Available Components

### BookMe Iframe Component
The BookMe iframe component enables seamless integration of meeting booking functionality into Salesforce and other platforms. This component allows users to:

- Schedule meetings directly within their CRM
- View and manage existing bookings
- Access advisor availability in real-time
- Customize the booking experience through configuration options

**Key Features:**
- Embedded iframe solution for Salesforce Lightning pages
- PostMessage API communication for secure data exchange
- Configurable UI elements and booking flows
- Support for custom themes and branding
- Real-time height adjustment for optimal display

#### Access Requirements

To use the BookMe iframe component, users must have proper access configured in your organization's identity provider:

- **User Access**: Bank employees need to be assigned the **'Employee'** role in the BookingPlatform Management API application
- **Authentication**: Users must be authenticated through Microsoft Entra ID (Azure AD)
- **Permissions**: Access is granted through Enterprise Applications in the Azure portal

For detailed technical configuration steps, see the [Entra ID Integration Guide](../bookme/entra-integration.md#iframe-access-configuration).

### Summary Component
The Summary component provides a rich text editor with advanced formatting capabilities that can be embedded in Salesforce and other CRM platforms. Key features include:

- Rich text editing with Lexical editor
- Link management functionality
- Markdown support
- Secure URL validation
- Cross-browser compatibility
