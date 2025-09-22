---
layout: default
title: Link Functionality
parent: Summary Component
grand_parent: iFrame Components
nav_order: 1
---

# Link Functionality Guide

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [How to Use Links](#how-to-use-links)
- [Working with Link Formats](#working-with-link-formats)
- [Security and Validation](#security-and-validation)
- [Browser Compatibility](#browser-compatibility)

## Overview

The andMoney editor provides a complete set of link management tools that make it easy to add, edit, and remove hyperlinks in your content. Whether you're linking to websites, email addresses, or phone numbers, the editor handles everything seamlessly while ensuring your links are secure and properly formatted.

## Features

The editor includes everything you need for managing links:

- **Quick Link Creation**: Transform any text into a clickable link with just a few clicks
- **Easy Link Editing**: Update existing links without having to recreate them
- **Simple Link Removal**: Remove unwanted links while keeping your text intact
- **Automatic Format Recognition**: The editor recognizes and converts standard link formats automatically

## How to Use Links

### Creating a New Link

Adding a link to your text is straightforward:

1. **Select Your Text**: Highlight the words you want to make clickable
2. **Open the Link Tool**: Click the link icon (🔗) in the toolbar
3. **Add Your URL**: A small input box appears where you can type or paste your web address
4. **Save Your Link**: Press Enter or click the checkmark to create the link

![iFrame create link](../../../assets/images/iframe/iframe-add-new-link.png)

### Editing an Existing Link

Need to update a link? Here's how:

1. **Click the Link**: Simply click on any existing link in your content
2. **Update the Address**: The link editor opens automatically showing the current URL
3. **Make Your Changes**: Edit the web address as needed
4. **Save or Cancel**: Use the checkmark to save your changes or the X to cancel

![iFrame edit link](../../../assets/images/iframe/iframe-edit-existing-link.png)

### Understanding the Link Workflow

When working with links, the editor responds intelligently to your actions:

- When you select text, the link button becomes available in the toolbar
- Clicking the link button opens a floating input box pre-filled with "https://" to help you get started
- As you type, the editor checks that your URL is properly formatted
- For existing links, clicking them brings up the same editor with the current URL ready for editing
- If you're creating a new link and cancel, the text remains unchanged
- If you're editing an existing link and cancel, it keeps its original URL

## Working with Link Formats

### Creating Links in the Editor

To add any type of link to your content, you must use the link icon (🔗) in the toolbar. Simply pasting a URL into the editor won't automatically create a link - you need to:

1. Select the text you want to make clickable
2. Click the link icon in the toolbar
3. Enter your URL in the input box that appears
4. Confirm to create the link

### Types of Links You Can Create

The link tool supports various formats:

- **Website Links**: Add links to company websites, documentation, or any web resource
- **Email Links**: Create links that open the user's email program with a pre-filled recipient address
- **Phone Links**: Add clickable phone numbers that can initiate calls on mobile devices
- **SMS Links**: Create links that open text messaging applications

## Security and Validation

### How Links Are Validated

The editor uses a comprehensive two-step validation process to ensure all links are safe and properly formatted:

**Step 1: Format Validation**
The editor first checks that your URL follows proper formatting rules. When you start creating a new link, the editor helpfully pre-fills "https://" to guide you toward creating a secure web link. It then verifies that whatever you type follows standard URL patterns. If it isn't valid, the editor sets the URL back to be "https://".

**Step 2: Security Sanitization**
After confirming the format is correct, the editor performs security checks to ensure the link is safe. This process examines the protocol (the part before the colon in a URL) and verifies it's one of the approved, safe types.

### Supported Link Types

The editor accepts these standard and safe link formats:

- **HTTP and HTTPS**: Regular website addresses (with HTTPS being the secure, encrypted version)
- **Mailto**: Email addresses that open your default email application
- **SMS**: Text messaging links for mobile devices
- **Tel**: Phone number links that can initiate calls

### Security Features

Your content is protected by multiple security measures:

- **Protection Against Code Injection**: The editor blocks any attempts to embed executable code through links, preventing malicious scripts from running
- **URL Sanitization**: Malformed or suspicious URLs are automatically cleaned up or rejected to prevent security issues
- **Safe Fallbacks**: If an unsafe protocol is detected, the link is replaced with a harmless placeholder rather than allowing potentially dangerous content
- **Trusted Protocols Only**: Only industry-standard, safe link types are permitted - experimental or potentially harmful protocols are blocked

## Browser Compatibility

The link functionality is compatible with all modern browsers:

### Desktop Browsers

- **Chrome/Edge**: Version 90+ (Full support)
- **Firefox**: Version 88+ (Full support)
- **Safari**: Version 14+ (Full support)
- **Opera**: Version 76+ (Full support)

### Mobile Browsers

- **iOS Safari**: Version 14+ (Full support)
- **Chrome Mobile**: Version 90+ (Full support)
- **Firefox Mobile**: Version 88+ (Full support)
- **Samsung Internet**: Version 14+ (Full support)