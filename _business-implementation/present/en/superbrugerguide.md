---
layout: "default"
title: "Super-user guide"
parent: "English"
grand_parent: "Present"
nav_order: 201
lang: "en"
---
# Present – super-user guide
_Setup in the Management UI · v1.2 · 10.06.2026_


## Purpose and value

Present lets employees generate finished, on-brand customer presentations in seconds — straight from the data in your customer system (CRM), instead of building slides by hand. As a super-user you make sure the right templates and field merges are in place, so employees always have correct, up-to-date presentations ready for the meeting.

### Glossary
- **CRM**: Your customer system (here Salesforce), where customer data lives.
- **Management UI**: &money's administration site, where you as super-user set up the products (“UI” = user interface).
- **Master template**: A PowerPoint file you build, which employees choose between when they create a presentation.
- **Tag**: A placeholder in PowerPoint, e.g. [tag:account_name], that is filled automatically with data from the CRM.
- **Tag mapping**: Deciding which CRM field a tag pulls its data from.
- **Customer type**: A customer category (created in Schedule) that a template is linked to.
- **Label**: A marker you can put on a template so it is easy to find and choose.
- **Object type**: The type of CRM record a tag pulls from: Account (customer), Contact (contact person), Event (meeting) or Specific (special fields such as agenda and forms of address).
- **Entra**: Microsoft's system for user access; your Entra/IT administrator assigns licences and permissions.
- **Companion guide**: A separate guide covering an adjacent topic (e.g. setup in the CRM component).


## Audience and prerequisites

- Audience: super-user/administrator who sets up and maintains Present in the Management UI.
- The Present package is installed in the organisation.
- You have a finished **PowerPoint file (.pptx)** ready as the master template — or follow the “Prepare your master template” section below first.
- The employees who will use Present have been assigned a Present licence.
- You have access to the Management UI with the **Configurator** or **Admin** role.
- Customer types have been created (done in Schedule).
- For the test in Step 3 you need the companion guide for the Present component in the CRM (see “See also”).

{: .note }
> **Note:** If you are missing a licence or permissions, request them from your IT/Entra administrator (or &money support) before you start — so you don't get stuck halfway.


## What you get out of it

After this guide you can:

- Prepare a master template in PowerPoint (sections, slide names and tags).
- Upload and validate master templates.
- Link a template to the right customer type.
- Map tags to the right fields in the CRM.
- Test that a presentation comes out correctly.
- Deactivate/reactivate templates and follow usage in reporting.


## Overview

The setup consists of these steps:

- Prepare: build your master template in PowerPoint (sections, slide names, tags).
- Step 1: Upload the master template and choose a customer type.
- Step 2: Map tags so CRM data merges in correctly.
- Step 3: Test that a presentation comes out correctly.
- Step 4: Maintain the templates and follow usage.

Time required: preparing the master template depends on the design; the setup in the Management UI itself typically takes **20–30 minutes**.


## Prepare your master template (PowerPoint)

A master template is the PowerPoint that employees choose between. You build it in PowerPoint before you upload it in Step 1.


### Prepare · Build the master template

_Why: The template's structure determines which slides the employee can choose, and where CRM data is merged in._

- Set the **slide size** to **Custom** (Design → Slide Size) — otherwise generation can fail (see the quick guide at the bottom).
- Create **sections**: right-click between two slides in the left slide pane → **Add Section** (or the **Home → Section → Add Section** tab). Rename: right-click the section → **Rename Section**. Divide it into e.g. cover, agenda, about the customer, products, price, closing.
- Create **sub-sections** by naming the section “Section name -- Sub-section name”.
- Name each slide in the **notes field** with the syntax [slide:slide_name] — lowercase, no spaces, use underscore (_) as the word separator.
- Insert **tags** where CRM data should be merged in, e.g. [tag:account_name]. Adjust the display if needed with modifiers: [tag:company_name:uppercase] (UPPERCASE), :capitalize (initial capital), :trim (removes redundant spaces) — can be combined: [tag:company_name:trim:uppercase].
- Insert **image tags** to replace images dynamically: name the image itself in PowerPoint (via the **Selection Pane**) with the syntax [image:image_name]. When the presentation is generated, the image is automatically replaced with the image linked to the image tag.
- Agenda: the agenda tag must be set as **bullet points** to work correctly.
- Add **hyperlinks**: select text, an object or a logo → **Insert → Link** (Ctrl+K). Link to a web page (URL) or to another slide via **Place in This Document**. Many customers link from a **logo** to the **agenda slide** (the slide with [slide:agenda]), so the employee can quickly jump to the agenda during the meeting. Active links work when the presentation is opened in PowerPoint — not in the CRM preview.
- **Compress images** so the file is light — see the **Quick guide to compressing images** below.
- Keep the total file size as low as possible, so the template uploads and generates quickly.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/slide_name.png)

*Screenshot 1 (PowerPoint) — Example from PowerPoint: [slide:agenda] in the notes field and [tag:agenda] on the slide*


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/section_names.png)

*Screenshot 2 (PowerPoint) — Sections in PowerPoint, including a sub-section (Section name -- sub-section)*

{: .important }
> **Remember:** A tag that is not mapped in Step 2 shows as an **empty field** the employee can fill in themselves — this is intentional, but review your tags so nothing important is forgotten.

{: .note }
> **Note:** File-size limits: the total PowerPoint file must **not exceed 10 MB** — otherwise upload fails. Videos are supported but count towards the size. Per image the recommended limit is **1 MB** (the system warns for larger images). So make the presentation as light as possible — compress images (see the quick guide below).

{: .note }
> **Note:** Layouts: layouts imported from Templafy, other systems or older presentations can contain formatting that causes errors in Present. So make sure to: ① avoid layouts with **numbers in the name** (can cause errors during upload); ② always use **clear, recognisable layout names**; ③ if in doubt, use the **Blank** layout, which gives full control over the setup.


## Format logo, icons and images on the master slides

If you want logos, icons and images to sit fixed and correctly on the individual master slides, you can work with them via the slide master:

- Open the master template in PowerPoint.
- Go to **View → Slide Master**.
- Right-click e.g. the bank logo on the relevant master slide (or icons/images on other slides) → **Save as Picture** (save e.g. to the desktop so it can be reused).
- Click **Close Master View** and save the template.
- Upload the updated template in the Management UI under **Present → Setup**.


## Hyperlinks and active links

Hyperlinks support non-linear navigation in the meeting (e.g. jumping quickly back to the agenda slide), and active links can open a website. Both are created in PowerPoint and preserved on upload.


**Hyperlink between slides (e.g. logo → agenda)**

- Select the element (e.g. the logo) — or place an invisible **text box** on top of it (Insert → Text Box → **Bring to Front** → remove fill/line colour).
- Right-click → **Link** → **Place in This Document** → choose the destination slide (e.g. agenda) → **OK**.

{: .note }
> **Note:** Hyperlinks only work in slideshow/presentation mode and should point to slides in the **same** presentation. If you change the order, the link still works (it points to the slide, not the number).


**Active links (to a website)**

- Add the link as a hyperlink, but point it to a **web address (URL)**.
- In presentation mode a single click opens the website; use **ALT+TAB** to get back to the presentation.
- In Teams meetings: share the presentation as a **screen share** so the customer sees the same thing — and use ALT+TAB to return.

{: .note }
> **Note:** Active and interactive links work in PowerPoint, **not** in the Salesforce preview (known limitation).


## Quick guide to compressing images in your meeting presentation

Large images add up quickly. Here's how to compress them in PowerPoint:

- Select an image in the presentation.
- Go to the **Picture Format** tab → **Compress Pictures**.
- Choose a lower resolution (e.g. **Web (150 ppi)** or **Email (96 ppi)**).
- Tick **Delete cropped areas of pictures**.
- Untick **Apply only to this picture** to compress **all** images in the file.
- Click **OK**.
- Compress videos too: **File → Info → Compress Media**.
- Finally check the file size (**File → Info**) — target: total under 10 MB, about 1 MB per image.

{: .hint }
> **Recommended:** Compress before upload — it makes upload and generation faster and keeps you under the 10 MB limit.


## Step-by-step (Management UI)


### Step 1 · Upload the master template

_Why: Once the template is uploaded, employees can choose it when they generate a presentation._

- Go to **Present** → **Setup** → **Templates** in the Management UI.
- Click **Upload**.
- Choose your PowerPoint file (.pptx) via **Upload file**.
- See the result under **Validation** — any errors must be fixed in PowerPoint before you can upload.
- Choose the right customer type under **Select Customer type**.
- Click **Upload** again to save (the button in the dialog; typically takes 10–60 seconds).


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_templates_oversigt.png)

*Screenshot 3 (Management UI) — Present → Templates — the overview with the **Upload** button and the status filter*


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_upload_dialog.png)

*Screenshot 4 (Management UI) — The **Upload template** dialog — **Upload file**, **Validation** and **Select Customer type***

{: .hint }
> ✓ **How you know it worked:** The template now appears in the list under **Templates** with status **Active**.

{: .note }
> **Note:** If **Validation** shows errors, the template cannot be uploaded. Fix the errors in PowerPoint and try again.


### Step 2 · Map tags to CRM fields

_Why: The mapping determines which CRM field each tag in the template pulls data from._

- Go to **Present** → **Setup** → **Tags**.
- Click **Create**.
- Choose the tag from the template under **Choose a tag** (the list is built automatically from the tags you set in PowerPoint).
- Choose **Object type**: Account (the customer/company), Contact (the contact person), Event (the meeting) or **Specific** (special fields such as agenda and forms of address).
- Choose the specific field on the object the tag should pull from.
- Click **Create**.

{: .important }
> **Remember:** Example: the tag [tag:account_name] is mapped as **Object type = Account** → the field **Name**. Then the tag automatically pulls the customer's name from the CRM.

{: .important }
> **Remember:** The agenda tag is mapped as **Object type = Specific** → the field **Meeting agenda** (string), so the meeting's agenda is merged onto the agenda slide.

{: .important }
> **Remember:** In the same way, **forms of address** (Danish address forms) can be mapped to **Object type = Specific** — so you can use forms of address in your slides, and employees get them merged in automatically instead of typing them themselves.


![Screenshot 5]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_tags_oversigt.png)

*Screenshot 5 (Management UI) — Present → Tags — the table (**Tag-name**, **CRM Object field**, **Templates**) and the **Create** button*


![Screenshot 6]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_tag_dialog.png)

*Screenshot 6 (Management UI) — The **Create tag configuration** dialog — **Choose a tag** and **Object type***

{: .hint }
> ✓ **How you know it worked:** The mapping appears in the table with **Tag-name** and **CRM Object field** filled in. Repeat until all your tags are mapped.


## Most-used tags (reference)

Overview of the most-used tags and which Salesforce field they pull from:


| Display name | Tag | Salesforce field (Object type → field) |
|---|---|---|
| Meeting date | [tag:dato] | Event → End date (the meeting's end time) |
| Agenda | [tag:agenda] | Specific → Meeting agenda |
| Customer name | [tag:kundenavn] | Contact → First name |
| Customer's full name | [tag:kundens_fulde_navn] | Contact → Name |
| Form of address: Dine/Jeres | [tag:dine_jeres] | Specific → Dine/Jeres |
| Form of address: Du/I | [tag:du_i] | Specific → Du/I |
| Form of address: Dig/Jer | [tag:dig_jer] | Specific → Dig/Jer |
| Form of address: Din/Jeres | [tag:din_jeres] | Specific → Din/Jeres |
| Form of address: Dit/Jeres | [tag:dit_jeres] | Specific → Dit/Jeres |

{: .important }
> **Remember:** Forms of address (Dine/Jeres, Du/I …) are all mapped to **Object type = Specific** — so employees get the correct form of address merged in automatically. (These are Danish grammatical address forms; keep the tag names as they appear in your Danish slides.)


## Tag modifiers (format data)

With tag modifiers you can format data from Salesforce before it is inserted — without changing the source data. Syntax: [tag:tag-name:modifier]. Several can be chained and are processed left to right.


| Modifier | Effect | Example → result |
|---|---|---|
| capitalize | Initial capital | [tag:kundenavn:capitalize]: john → John |
| uppercase | UPPERCASE | [tag:firmanavn:uppercase]: Acme Corp → ACME CORP |
| lowercase | lowercase | [tag:kode:lowercase]: AB12 → ab12 |
| title | Each Word Capitalised | [tag:emne:title]: quarterly review → Quarterly Review |
| trim | Removes redundant spaces | [tag:beskrivelse:trim] |

Chaining: **[tag:firmanavn:trim:uppercase]** first trims spaces and then converts to uppercase.


### Step 3 · Test that a presentation comes out correctly

_Why: A test makes sure the template and mapping work before employees use it with real customers._

- Open a test customer or a test meeting in your CRM (use demo/test data).
- Generate a presentation with your new template (this happens via the Present component in the CRM — see “See also”).
- Check that the fields you mapped are filled with data, and that there are no unexpected **empty placeholders**.
- Check that the right slides and sections are included.

{: .hint }
> ✓ **How you know it worked:** The presentation is generated, the fields are filled correctly, and there are no unexpected empty placeholders.

{: .note }
> **Note:** The preview in Salesforce is not always accurate for the generated PowerPoint. These are not fully supported in the preview: **charts, graphic elements, image types, active links, interactive slides and fonts**. So test and present in the PowerPoint file itself.


### Step 4 · Maintain and follow usage

_Why: Keep the templates up to date and clean up old versions, so employees only see relevant choices._

- Edit labels: click the edit icon in **Templates**, use **Add label**, and finish with **Save**.
- Deactivate an old template: click the delete icon and confirm in **Deactivate template** (hidden from employees, but data is kept for reporting).
- Reactivate: set the status filter to **Inactive**, find the template and confirm in **Reactivate**.
- Follow usage: go to **Present** → **Reporting**.


![Screenshot 7]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_templates_inaktive.png)

*Screenshot 7 (Management UI) — Present → Templates with the status filter set to **Inactive***


![Screenshot 8]({{ site.baseurl }}/assets/images/business-implementation/present/en/superbrugerguide/present_rapportering.png)

*Screenshot 8 (Management UI) — Present → Reporting — meetings with a customer presentation*

{: .hint }
> ✓ **How you know it worked:** The template changes status in the list (**Active**/**Inactive**); only active templates are shown to employees.

{: .hint }
> **Recommended:** Use descriptive names and labels on the templates — that makes it easy for employees to choose the right one.


## Troubleshooting

- The template cannot be uploaded: check **Validation** — fix the shown errors in PowerPoint and upload again.
- Error generating slides: the slide size is often not set to **Custom** in PowerPoint — always check it (see the quick guide below).
- I can't find my tag in the **Choose a tag** list: check that the tag is spelled correctly in PowerPoint and that the file has been uploaded.
- I don't know which CRM field a tag should point to: contact your CRM/super-user lead or &money support.
- The presentation is missing data: check that the relevant tags are mapped under **Tags**, and that the CRM fields contain data.
- The customer type doesn't exist on upload: create the customer type in Schedule first, and try again.
- The employee can't see Present: check that the user has a Present licence, and that **Present** is enabled in the Management UI.


## Quick guide to PowerPoint – slide size (custom)

{: .note }
> **Note:** If you experience errors generating slides in Present, it is often because the slide size is **not set to “Custom”** in PowerPoint. Always check this as an administrator.

- Go to the **Design** tab in PowerPoint → click **Slide Size** (in the menu on the right) → choose **Custom Slide Size**.
- Use the arrow to select **Custom**, and finish with **OK**.

### See also / prerequisites
- **Prepare your master template (PowerPoint)** — the section above in this guide (a prerequisite for Step 1).
- **Present – FAQ** (typical questions, errors and answers).
- **Setting up and adopting Present in the CRM component** (Salesforce package / Present component) — companion guide (used in Step 3 to generate a presentation).
- **Validation tool for master templates** — companion guide (helps find errors before upload).
- **Tag mapping in detail**, including modifiers (uppercase, capitalize, trim) — companion guide.


## Latest update

- 10.06.2026 (v1.2) — Added reference table for tags (incl. forms of address), tag modifiers, slide master, hyperlinks/active links and preview limitations; slide size moved up; glossary corrected.
- 09.06.2026 (v1.1) — Added glossary, section on setting up master slides, concrete mapping example, success indicators, test step and “See also” references.
- 09.06.2026 (v1.0) — First version (setup in the Management UI).


{: .hint }
> ✅ **Done!** Your template is now uploaded, mapped and tested — and ready for the employees.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.2 · 10.06.2026_
