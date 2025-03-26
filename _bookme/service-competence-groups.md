---
layout: default
title: Service & Competence Groups
nav_order: 9
parent: BookMe
---

# Service- &amp; competence groups

---

## Requirements for Full Implementation

To fully utilize the functions, your company must:

- Use the latest managed BookMe package 
- Run on package 1.12 - 1.13 in BookMe's unmanaged package

**Note:** If your company has not installed any of the aforementioned packages, you will only be able to offer extended service levels via service groups for "Online" meetings.

---

## How to Get Started

We recommend that you start by creating your Competence Groups (Groups).

---

## General Information About Competence Groups

- Competencies are assigned based on:
    - **Meeting type**
    - **Customer category**
- Competencies are **not** based on the advisor's actual skills (e.g., investment, pension, real estate), which are managed via Salesforce or MS Entra AD settings.
- Competencies can be managed via the **Management UI** without Administrator/IT assistance.

**Note:** Competencies apply to all subgroups within the Competence Group.

---

## 1. Creating a Competence Group

### 1.1 Purpose

- Groups connect multiple advisors, allowing customer service across locations.
- Competence groups, together with service groups, increase meeting availability and service levels.
- Competence groups can be structured with or without competency requirements.

### 1.2 Steps to Create a Competence Group

1. **Create and Name Competence Group/Subgroup** (Recommended Setup for a Bank):
    - Create a group for each department/center (local) including their employees.
        - Recommended groups:
            - Private
            - Business
            - Agriculture
            - Private Banking
    - Create regional service groups and link departments/centers.
    - Create national groups and link regions/departments.

    **Important:** A maximum of **5 layers** can be created within groups, so segmenting competence groups is crucial.

2. **Add Members (Employees):**

    - Members are added individually.

3. **Add Group Relations:**

    - Example: Subgroups such as centers.

---

## 2. Creating a Service Group

### 2.1 Purpose

- Service groups connect multiple advisors, allowing customer service across locations.
- They increase availability and service levels for customers.

### 2.2 Benefits

- Customers can book meetings at other departments/centers.
- Access to more available time slots.
- Can work with or without a competence group.

### 2.3 Steps to Create a Service Group

1. **Create and Name the Service Group** (Recommended Setup for a Bank):

    - Create a service group.

2. **Set Activation Rules (Restrictions):**

    - Define based on:
        - Location
        - Customer category
        - Meeting theme
    - **Note:** If all three are selected, all must be fulfilled. If nothing is selected, all locations apply.

3. **Create Service Levels:**

    - Determine what should be offered to customers beyond current services.
    - Customers can access selected locations in addition to their regular department.
    - Meeting themes must fulfill the activation rules.

4. **Set Service Level by Location/Meeting Type:**

    - Recommended groups:
        - Private
        - Business
        - Agriculture
        - Private Banking

5. **Create Campaign Team/Members:**

    - Members are statically assigned and valid within their calendar.

6. **Add Members:**

    - Competence groups can be linked.
    - Service groups operating "online" can serve across departments, whereas physical meetings require the advisor's physical presence.

7. **Set Service Group Email:**

    - Employees can book themselves using the service group email.

---

## Important Note

**USE COMPETENCE GROUPS TO CONNECT MANY EMPLOYEES TO A SERVICE GROUP!**
"""