---
layout: default
title: Portals
nav_order: 8
parent: BookMe
---

# Portals

---

## Requirements

To fully utilize the function, your company must:

- Use the latest managed BookMe package 
- Run on package 1.12 - 1.13 in BookMe's unmanaged package

{: .note }
> If your company has not installed any of the mentioned packages, you will only be able to offer the basic functionality.

---

## Purpose

With Portals, your partners and customers can book meetings with their advisor or selected advisors. Portals enhance your accessibility to customers and ensure that valuable meeting leads are not lost in the process.

---

## 1. Portal Configuration

### Steps to Configure a Portal:

1. Go to **Management UI** and select **BookMe -> Portals**
2. Click on the **"CRM Configuration** tab
3. Click **Create New**

<img src="../../assets/images/bookme/portals/new-config.png" width="1000" alt="Create new portal configuration button"/>

<img src="../../assets/images/bookme/portals/new-config-modal.png" width="1000" alt="Create new portal configuration modal"/>

4. Enter **Configuration Name**
5. Set up Portal configuration fields
    - **CRM Portal - new portal - create field setup**
      - Choose **Key**
      - Select **Object**
      - Select **Object field**
   - **CRM Portal - Bookme meeting fields - create standard field setup**
     - Choose **Key**
     - Select **Object**
     - Select **Object field** 
6. Click **Create** to save configuration 
7. Go to **Management UI** and select **BookMe -> Portals** and choose your new Portal.
8. Choose your new configuration under **Configuration** and click **Save**
9. Publish the Portal for partners and internal/external users

Note: Before using the portal, it must be configured with your CRM system.

## 2. Creating a Portal

### Steps to Create a Portal:

1. Go to **Management UI** and select **BookMe -> Portals**
2. Click **Create Portal**

<img src="../../assets/images/bookme/portals/create-portal.png" width="1000" alt="Create new portal button"/>

<img src="../../assets/images/bookme/portals/create-new-portal.png" width="1000" alt="Create new portal modal"/>

3. Enter the **Portal Name**
4. Choose **Configuration** (select after it has been created)
5. Select **Login Type** (Azure AD / MitID)
6. Enable/disable **iCal**
7. Configure **Styling**
    - Insert URL to the logo
    - Enter desired logo height
    - Customize portal styling such as colors for bullets, header background, buttons, etc.
8. Configure **Customer Data Setup**
   - Select **Customer category**
   - Choose **Theme**
   - Assign **Department** to receive meeting bookings
9. Set up Fields for the Portal
   - Click **Add Field**
   - Enter **Key**
   - Provide **Field Name**
   - Add **Field Description**
   - Select **Default Value**
   - Define **Order** for field display
   - Choose **Field Type**
   - Indicate if the field is **Required**
   - Indicate if the field should be **Hidden** (e.g., pre-filled text/value)
   - Configure Regex **Validations** (choose from predefined options or create custom ones)
10. Finalize by clicking **Create**
11. Test the Portal by clicking on the portal icon (square with an arrow) on the homepage

<img src="../../assets/images/bookme/portals/test-a-portal.png" width="1000" alt="Test a portal"/>

Note: Before using the portal, it must be configured with your CRM system.

---
## Portal Styling
You have the option to style your Portal under **Custom styling**

Example: 
- Setting background-, stepicon og text color:

      --mui-palette-primary-main: #153C56;

      .MuiStepIcon-root {
      color: #B5101F;
      }

      .MuiTypography-root {
      color: #B5101F;
      }

      .MuiStepper-root {
      width: 50%;
      }

{: .warning }
> Ensure colors do not obscure button visibility.

---
## Regex validation rules
When setting up your Portal you can choose to add a validation rule for the specific field

The following regex validation rules comes as standalone formulas:

| Fields              | Regex validation formula |
|---------------------|--------------------------------------------------|
| Cpr-number          | ^\d{6}-\d{4}$                                    |
| Customer name       | ^[a-zA-ZæøåÆØÅ]+$                                |
| e-mail              | ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ |
| Danish phone number | ^\+45\d{8}$                                      |
| Url                 | ^[^ ]+\.[^ ]+$                                   |

---

## **Important Note**

Ensure that your Portal is properly configured to align with your CRM system requirements before going live.

---
