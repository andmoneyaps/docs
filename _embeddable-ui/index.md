---
layout: default
title: Embeddable UI
nav_order: 6
has_children: true
permalink: /embeddable-ui
---

# Embeddable UI Documentation

Welcome to the &Money Embeddable UI documentation. This section covers embeddable components and integrations designed for seamless integration into external applications and CRM systems.

## Available Pages

### BookMe Iframe Component
The BookMe iframe component enables seamless integration of meeting booking functionality into Salesforce and other platforms. This component allows users to:

- Schedule meetings directly within their CRM
- View and manage existing bookings
- Embed in iframe solution for Salesforce Lightning pages

#### Access Requirements

To use the BookMe iframe component, users must have proper access configured in your organization's identity provider:

- **User Access**: Bank employees need to be assigned the **'Employee'** role in the BookingPlatform Management API application
- **Authentication**: Users must be authenticated through Microsoft Entra ID (Azure AD)
- **Permissions**: Access is granted through Enterprise Applications in the Azure portal

For detailed technical configuration steps, see the [Entra ID Integration Guide](../bookme/entra-integration.md#iframe-access-configuration).

### Summary Component
The Summary component provides a rich text editor with advanced formatting capabilities that can be embedded in Salesforce and other CRM platforms. Key features include:
### Setup and Configuration
- **[Setup in Salesforce]({{ site.baseurl }}/embeddable-ui/setup-in-salesforce/)** - Complete guide for integrating &Money Portal and quick actions in Salesforce

### Component Documentation
- **[Summary Component]({{ site.baseurl }}/embeddable-ui/summary/)** - Rich text editor with advanced formatting capabilities
  - [Link Functionality]({{ site.baseurl }}/embeddable-ui/summary/link-functionality/)** - Complete guide to link management features
- **[Confirmation Screen]({{ site.baseurl }}/embeddable-ui/confirmation-screen/)** - Session-based meeting confirmation view with event integration
