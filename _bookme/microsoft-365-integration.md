---
layout: default
title: Microsoft 365 Integration
nav_order: 9
parent: BookMe
collection: bookme
---

# Setting up the integration between &money and Microsoft 365

BookMe integrates natively with your Organizations Microsoft 365 account. This ensures that your BookMe users, resources and calendars are always in sync with your Microsoft 365 account.

## Introduction

This guide provides a high-level overview of configuring Entra ID for both single-tenant and multi-tenant deployments. It covers the necessary steps for setting up SCIM integrations and the Management UI for Enterprise Applications. This document serves as a roadmap, directing you to detailed instructions needed for each stage of the configuration.

## Overview of Entra ID Configuration

The Entra ID configuration process involves several key steps to ensure seamless integration and management across tenants. The process is designed to:

- Automate end-user provisioning through SCIM.
- Assign appropriate roles for access control within the Management UI for administrative users and management.

## Configuration Steps

### 1. Creation of Enterprise Applications

For both single-tenant and multi-tenant deployments, you must create Enterprise Applications within your Entra Organization to provide administrative users with access to the &Money Financial Platform Management UI.

- **For detailed steps, refer to the [Enterprise Application Installation Guide](../app-registration-installation).**

### 2. Role Assignment for Management UI

Assign roles within the BookingPlatform Mgmt API to control access and permissions for users interacting with the Management UI. This applies to both deployment models.

- **For detailed role assignment instructions, see the [Role Assignment Documentation](../app-registration-installation/#role-assignment-for-the-management-ui).**

### 3. Microsoft 365 User, Room and Calendar integration

Easily install and configure our Azure Marketplace offer to configure Entra Enterprise Apps for SCIM provisioning and Microsoft Graph API access for calendar information.

- **For detailed instructions, refer to the [Marketplace App Offer Installation Guide](../installation-marketplace-app-offer).**

## Accessing the Management UI

Once the enterprise application and its permission has been approved for the tenant and a user has been assigned one of
the roles mentioned above you can try logging in using this url:

Test: [](https://self.test-env.booking.andmoney.dk/)

Production: [](https://self.booking.andmoney.dk/)

Once the configurations are complete, users can access the Management UI based on their assigned roles, ensuring they have the appropriate permissions for their responsibilities.

## Conclusion

Following this guide ensures a comprehensive configuration of Entra ID for your deployment, whether single-tenant or multi-tenant. Utilize the links provided to access detailed instructions and complete each step effectively.
