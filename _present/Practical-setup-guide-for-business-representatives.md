---
layout: default
title: Practical setup guide for business representatives
nav_order: 3
parent: Present
collection: present
---

# Practical setup guide for business representatives

## Contents

- [General Overview](#general-overview)  
- [How to Use Present](#how-to-use-present)  
  - [Admin/Customer Responsible](#admincustomer-responsible)  
  - [Employee](#employee)  
- [Questions](#questions)

---

## General Overview

**Present** is designed to allow company employees to easily create meeting presentations directly within the CRM system, ensuring consistent, on-brand customer communication.

---

## How to Use Present

### Admin/Customer Responsible

Before employees can use Present in the CRM system, setup is required via &money's Management UI.

🔗 [Go to Management UI](https://management.andmoney.dk)

This guide assumes that the user has been granted **Admin access** to the Management UI by their Entra administrator, and that the customer uses **Salesforce** as their CRM.

> ⚠️ Screenshots are examples only and may not reflect the current CVI design.

#### 1. Open the Management UI

Access: [https://management.andmoney.dk](https://management.andmoney.dk)

#### 2. Configure Customer Types

- In the left menu, go to `BookMe > Meeting Setup > Customer Types`
- Create or add customer types.
- Customer types used specifically for Present can be configured under `BookMe > Meeting Setup > Meeting configuration` and set as unavailable for regular meeting bookings.

#### 3. Go to Present Setup

- In the left menu, click `Present > Setup`.

#### 4. Upload Master templates

- Upload master templates for each customer type.
- Multiple master templaes can be uploaded per type to avoid oversized master template files.

> ✅ Master templates (Presentations) are automatically validated during upload.  
> 📖 [Read more about validation](https://andmoneyaps.github.io/docs/present/Validation-tool-Master-template/)

#### 5. Configure Master templates

Follow these setup guides before employees begin using Present:

- [Present Usage Guide](https://andmoneyaps.github.io/docs/present/Present-Usage/)
- [Tag Mapping Guide](https://andmoneyaps.github.io/docs/present/tag-mapping/)

Once this is complete, Present is ready for use in Salesforce. Employees will access Present from a meeting event within a customer account.

---

### Employee

#### 1. Access the Meeting Event

- In Salesforce, go to a customer account.
- Open the relevant **Meeting Event**.

#### 2. Use the "Meeting Presentation" Tab

- Click the **Meeting Presentation** tab.
- Here, employees can write an agenda and select slides for the customer presentation.

#### 3. Create the Agenda

- Add bullet points under **Agenda**.
- These will automatically transfer into the customer meeting presentation.

Sub-points under bullets are also added automatically in the final customer presentation deck.

#### 4. Add Slides

- Select slides from the presentations configured for each customer type (e.g. Private, Business).
- Click **Add Slides**.

> 💡 These customer types are based on admin setup in Steps 2 and 3.

#### 5. Select Sections and Slides

- Click a section under **Slide Sections** to view available slides.
- `*` next to a section indicates a Next Best Action or Potential. Hover to view.

##### Slide Selection Interface

- A new window opens showing slides.
- Double-click to preview a slide.
- If subsections exist, they're listed at the top. Clicking a subsection scrolls to it.
- Click a slide to select (highlighted with a green border).
- Click **Close and Add Selected Slides** to add them to your presentation.

#### 6. Finalize the Presentation

- Drag slides to reorder them.
- Delete slides using the trash icon.
- Click **Generate Presentation** to create a PowerPoint (.pptx) file.

##### Tag Review

- A pop-up appears showing auto-filled data fields (tags).
- You may edit these before finalizing the customer presentation.

> 📂 The file is saved under **Files** at the Meeting Event.

#### 7. Edit or Update Presentation

- Reopen by clicking the file or using **Reopen Presentation**.
- To add a custom slide:
  - Download the PowerPoint file
  - Edit locally
  - Re-upload to **Files** under the Meeting Event

#### 8. Send a PDF After the Meeting

- Click **Generate PDF** after the meeting.
- A PDF is created and stored under **Files**, ready to be send to the customer.

> ⚠️ PowerPoint previews in Salesforce may not display correct fonts/colors. Download the file to view properly.
