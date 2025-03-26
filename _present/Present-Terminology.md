---
layout: default
title: Terminology
nav_order: 12
parent: Present
collection: present
---

# Present Terminology

This reference article provides a comprehensive list of terms and concepts used throughout the Present application. Understanding these terms is essential for effective use of the platform.

## Terms

- **Master Template**: A PowerPoint template file that contains placeholders and tags for dynamic content generation.
- **Tag**: A placeholder in a template that gets replaced with actual content during presentation generation.
- **Customer Type**: A classification that determines which templates are available for specific customer segments.
- **LWC (Lightning Web Component)**: The main interface component used to interact with Present in Salesforce.
- **Present Backend**: The server-side component that handles template processing and presentation generation.
- **Content Version**: A Salesforce object that stores template files and generated presentations.
- **Tag Mapping**: The configuration that defines how template tags are replaced with Salesforce data.

## Configuration Options

### Template Settings
- **Customer Type Mapping**: Determines which templates are available based on account classification
- **Default Templates**: Templates that are automatically included in new presentations
- **Template Categories**: Organization structure for grouping related templates

### User Permissions
- **Template Administrator**: Can upload and manage master templates
- **Template User**: Can generate presentations using existing templates
- **Present Manager**: Has access to all Present features and settings

### Integration Settings
- **Named Credentials**: Configuration for connecting to the Present Backend
- **Remote Site Settings**: Required URLs for Present Backend communication
- **API Configuration**: Settings for Present API access and authentication
