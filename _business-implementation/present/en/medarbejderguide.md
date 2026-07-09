---
layout: "default"
title: "Employee guide"
parent: "English"
grand_parent: "Present"
nav_order: 302
lang: "en"
---
# Present – employee guide
_How to generate a customer presentation in Salesforce (the Present component) · v1.0 · 09.06.2026_


## Purpose and value

With Present you create a finished customer presentation — with your design and logo — in a few minutes — straight from the meeting in Salesforce. You choose a template and the slides you want to use, and the customer's data is merged in automatically. That way you spend your time on the customer instead of building slides.

### Glossary
- **Present component**: The box (“Meeting presentation”) you open on a meeting in Salesforce, where you build the presentation.
- **Master template**: A finished PowerPoint template that a super-user has uploaded, which you choose between.
- **Customer type**: The customer's category (e.g. private/business); it determines which templates you are shown.
- **Slide**: A single slide in the presentation.
- **Section**: A group of slides in the template (e.g. Agenda, Investment).
- **Tag**: A placeholder that is filled with customer data from Salesforce — e.g. the customer's name.
- **Meeting (Event)**: The meeting record itself in Salesforce (called “Event” in the system).


## Prerequisites

- You have a Present licence (if you don't, contact your super-user/administrator).
- The customer has a customer type set on their account in Salesforce (otherwise no templates are shown).
- You are working on a **meeting** in Salesforce (called “Event” in the system) — that is where the Present component lives.

{: .note }
> **Note:** If you see no templates, it is usually because of a missing customer type on the account or a missing licence — contact your super-user (see “See also”).


## What you get out of it

After this guide you can:

- Open Present on a meeting in Salesforce.
- Choose a template and the right slides (including several at once).
- Fill in the fields that are not filled automatically.
- Generate the presentation as PowerPoint and convert it to PDF.
- Use editable slides and active/interactive links.


## Overview

You create the presentation in these steps — typically in **a few minutes**:

- Step 1: Open Present on the meeting.
- Step 2: Write an agenda (optional).
- Step 3: Choose the customer type.
- Step 4: Choose sections and slides.
- Step 5: Fill in the fields and generate.
- Step 6: Open or convert to PDF.


## Step-by-step


### Step 1 · Open Present on the meeting

_Why: Present works from the meeting and the customer, so data is merged in correctly._

- Open (or create) the **meeting** on the customer's account in Salesforce.
- Click the **Present** tab — the Present component (Meeting presentation) opens.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/present/en/medarbejderguide/sf_present_komponent.png)

*Screenshot 1 (Present component in Salesforce) — The meeting (Event) in Salesforce with the **Present** tab open — the Present component*

{: .hint }
> ✓ **How you know it worked:** The Present component appears with an agenda field, customer-type tabs and sections.


### Step 2 · Write an agenda (optional)

_Why: The agenda can be merged onto an agenda slide, so the meeting starts in a structured way._

- Type or paste the agenda into the **agenda field** on the left (bullet points are preserved).
- The text is saved automatically when you leave the field.

{: .hint }
> ✓ **How you know it worked:** The agenda is saved — the text remains when you leave the field.


### Step 3 · Choose the customer type (shows the templates)

_Why: The customer type controls which templates suit this particular customer._

- Choose the right **customer type** in the tabs at the top — only templates for that type are shown.
- The templates for the chosen customer type now appear as **sections** that you choose from in Step 4.
- If **Filters** is available, you can narrow further by choosing a label.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/present/en/medarbejderguide/present_wrapper.png)

*Screenshot 2 (Present component in Salesforce) — The Present component: Agenda, customer-type tabs and section buttons*

{: .hint }
> ✓ **How you know it worked:** The sections for the chosen customer type appear — ready to choose slides from.


### Step 4 · Choose sections and slides

_Why: You assemble the presentation from exactly the slides the meeting needs._

- Click a **section** (e.g. Agenda, Investment) — a window shows the section's slides.
- Choose slides: click a single one (green frame = selected), or use **Select all**/**Deselect all** for the whole section/sub-section.
- Double-click a slide for a large preview. A star (*) marks a recommended slide.
- Click **Close and add selected slides**.
- In the list of selected slides you can drag to **change the order** and use the bin to remove a slide.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/present/en/medarbejderguide/sf_slide_vindue.png)

*Screenshot 3 (Present component in Salesforce) — The slide window with **Select all**/**Deselect all** and slides in a grid*

{: .hint }
> ✓ **How you know it worked:** The selected slides appear in the “selected slides” list at the bottom, in the order they will come in the presentation.


### Step 5 · Fill in the fields and generate

_Why: This is where you make sure all content is correct before the presentation is created._

- Click **Generate presentation** — the **Text to insert** window opens with the fields.
- **Fields with data from Salesforce** are pre-filled (e.g. **date** and **customer**). You can edit them — the change applies only to this presentation, not to Salesforce.
- **Empty fields** (shown as “No value”) and editable slides you fill in yourself. The fields may have technical names (e.g. **dineforventninger**) — just fill in the ones you want to use.
- Click **Generate presentation** **at the bottom of the window** to create the PowerPoint file (PPTX).
- **Wait a moment** while the file is created (typically a few seconds to about 1 minute) — don't click multiple times.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/present/en/medarbejderguide/sf_felt_vindue.png)

*Screenshot 4 (Present component in Salesforce) — The field window “Text to insert”: pre-filled fields (from Salesforce, e.g. date/customer) + empty fields you fill in yourself*

{: .hint }
> ✓ **How you know it worked:** You get the message that the presentation is ready, and the PowerPoint file is saved on the meeting under **Files (Filer)**.

{: .important }
> **Remember:** If [tag:...] appears as text in the presentation, the field was missing data — fill it in the field window, or contact your super-user.


### Step 6 · Open or convert to PDF

_Why: Choose the format the meeting requires — an editable PowerPoint or a PDF to send out._

- Click **Open presentation** to open the PowerPoint file and fine-tune it if needed.
- Click **Convert to PDF** for a PDF version (good for sending or printing).
- **Share with the customer**: send the PDF, or present directly from the PowerPoint file (in-person meeting or Teams screen sharing).

{: .hint }
> ✓ **How you know it worked:** The file (PowerPoint and/or PDF) is on the meeting under **Files (Filer)** and can be shared with the customer.


## What do the fields mean?

Here is what each choice controls — so you know what you are choosing:


| Field / choice | What it controls | Effect on the presentation |
|---|---|---|
| Agenda (text field) | The meeting's agenda | Merged onto slides with an agenda; bullet points are preserved. Fill it in before you generate. |
| Customer type (tabs) | Which templates you see | Only templates for the chosen customer type are shown — controls the entire selection. |
| Filters / label | Narrows the templates | Shows only templates with the chosen label; does not change the content. |
| Select all / Deselect all | Select many slides at once | Time-saving: take the whole section and then deselect individual slides. |
| Select a single slide | Add/remove one slide | Green frame = selected. Double-click for a large preview. |
| Drag to reorder | The order of the slides | Determines the order in the finished presentation. |
| Fields with Salesforce data | Pre-filled customer data | Retrieved automatically; can be edited — applies only to this presentation, not to Salesforce. |
| Empty / editable fields | Free text you write yourself | For content that changes from meeting to meeting (e.g. the meeting focus). |
| Generate presentation | Creates the PowerPoint file | Builds the PowerPoint file (PPTX) from the selected slides + fields; saved on the meeting. |
| Convert to PDF | PDF version | For sending out/printing; saved alongside the PowerPoint file. |


## Advanced options

- **Editable slides**: some slides have fields you fill in yourself in the field window (e.g. the customer's goals) — your text is included in the presentation.
- **Active links**: links to a website are clickable in presentation mode — a single click opens the page, and with **ALT+TAB** you get back. In Teams meetings: share as a **screen share** so the customer sees the same thing.
- **Hyperlinks**: can jump between slides (e.g. from a logo back to the agenda slide).
- **Interactive slides**: some slides have interactive elements that make the meeting more engaging.

{: .note }
> **Note:** The preview in Salesforce is not always accurate. These are not fully supported: **charts, graphic elements, image types, active links, interactive slides and fonts**. Download and open the **PowerPoint file** and present from there — not from the preview.


## Troubleshooting

- No **Present** tab on the meeting: check that you have opened a **meeting (Event)**, and that you have a Present licence — otherwise contact your super-user.
- No templates are shown: check that the customer has a customer type, and that you have a Present licence — otherwise contact your super-user.
- The “Generate” button is greyed out: choose at least one slide first.
- [tag:...] appears as text in the presentation: the field was missing data — fill it in the field window, or ask your super-user to check the template.
- The presentation looks wrong in the Salesforce preview: download the PowerPoint file — it looks correct in PowerPoint.
- Links/interactive elements don't work: you are in the preview — use the downloaded PowerPoint file (not the PDF).

### See also
- **Present – super-user guide (setup in the Management UI)** — if templates, customer types or fields are missing (super-user/admin).
- **Setting up master slides (PowerPoint)** — how the templates are built (in the super-user guide).
- **Present – FAQ** (typical questions, errors and answers).


## Latest update

- 09.06.2026 (v1.0) — First version of the employee guide for generating a presentation in Salesforce.


{: .hint }
> ✅ **Done!** Your customer presentation is now created and is on the meeting — ready for the customer.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 09.06.2026_
