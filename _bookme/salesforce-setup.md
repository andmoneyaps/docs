---
layout: default
title: Salesforce BookMe Integration Setup
nav_order: 13
parent: BookMe
collection: bookme
---


## Introduction
BookMe-Salesforce integration enables seamless booking capabilities within your Salesforce organization. This integration allows you to configure meeting settings, manage bookings, and customize the booking experience according to your organization's needs.

## Prerequisites
- Salesforce Developer/Admin account with appropriate permissions
- [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli) installed
- Git installed on your local machine
- Access to the BookMe-Salesforce repository

## Repository Setup
You can clone the [BookMe-Salesforce repository](https://github.com/andmoneyaps/bookme-salesforce#) using any of the following methods:

### Via GitHub Desktop
![Cloning using github desktop](../../assets/images/gh-desktop-clone.png)
1. Open GitHub Desktop
2. Go to File > Clone Repository
3. Select the bookme-salesforce repository
4. Choose your local path
5. Click Clone

### Via HTTPS
```bash
git clone https://github.com/andmoneyaps/bookme-salesforce.git
```

### Via SSH
```bash
git clone git@github.com:andmoneyaps/bookme-salesforce.git
```
Note: Ensure you have configured your SSH keys in GitHub before using this method.

## Initial Configuration

### Setting Up Salesforce CLI
1. Install the Salesforce CLI by downloading it from [the official site](https://developer.salesforce.com/tools/salesforcecli)
2. Authenticate with your Salesforce org using:
```bash
sf org login web
```

## Metadata Components
The integration relies on several custom metadata types, each serving a specific purpose in the booking configuration:

### AMB Meeting Configuration
**Purpose**: Controls meeting title and location display settings.

**Key Points**:
- Requires an Apex class implementing the Callable interface
- Class name and action name must be specified in the record
- Example implementation: `BookMeMeetingConfiguration`

### Booking Platform DI Implementation
**Purpose**: Configures the booking platform's Dependency Injection implementation.

**Components**:
- Requires Callable interface implementation
- Available implementations:
  - `BookMeCompetenceProvider`
  - `BookMeSearchProvider`
  - `BookMeSlaProvider`

### AMB Brand Setting
**Purpose**: Defines the visual theme for employee and customer flows.

**Configuration**:
- Create records specifying the desired theme name
- Defaults to 'AndMoney' theme if not specified

### AMB Config Components
These components work together to manage sObject creation and updates in the booking flow:

1. **AMB Config**
   - Primary configuration record
   - Links to SObject Config

2. **AMB SObject Config**
   - Defines SObject settings
   - References Field Mapping records

3. **AMB Config Relation**
   - Manages relationships between sObjects

4. **AMB Config Field Mapping**
   - Specifies field-level mappings
   - Can utilize utility methods for DTO-to-SObject mapping
   - Requirements:
     - Utility methods must be in a global class
     - Example implementation: `BookMeConfigCallable`

## Configuration Examples

### Sample Field Mapping
```apex
global class BookMeConfigCallable implements Callable {
    global Object call(String action, Map<String, Object> args) {
        // Implementation details
    }
}
```

### Deployment Script
The `AMBConfigDeploymentScript` can be used to deploy configurations to your Salesforce org.

## Testing & Validation
1. Verify metadata configuration deployment
2. Test booking flow end-to-end
3. Validate field mappings
4. Check theme applications

## Troubleshooting
- Ensure all required permissions are configured
- Verify Callable implementation class names
- Check field mapping utility method accessibility
- Confirm metadata record relationships

For more detailed information or support, refer to the repository documentation or contact the BookMe support team.
