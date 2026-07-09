---
layout: "default"
title: "FAQ"
parent: "English"
grand_parent: "Present"
nav_order: 403
lang: "en"
---
# Present – FAQ
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors in Present. Find your question below. More detailed steps are in the **Present – employee guide** and the **Present – super-user guide**.


## For employees (generate a presentation in Salesforce)


**No templates appear when I want to generate.**

The customer is missing a customer type on their account, or you are missing a Present licence. Check the customer type, and otherwise contact your super-user.


**The “Generate” button is greyed out.**

Select at least one slide first — the button is then enabled.


**[tag:...] shows up as text in the presentation.**

The field was missing data or is not mapped. Fill it in in the field window (“Text to insert”), or ask your super-user to check the tag mapping.


**What is the “Text to insert” field window?**

The window that opens when you generate. Here, fields with data from Salesforce are pre-filled (e.g. date/customer), and empty fields (“No value”) you fill in yourself. Click “Generate presentation” at the bottom to create the file.


**Where do I find the finished presentation?**

On the meeting itself (Event) in Salesforce, under Files. It can be shared, and you can make a PDF with “Convert to PDF”.


**The presentation looks wrong in the preview.**

Download the PowerPoint file — it looks correct in PowerPoint. The preview in Salesforce does not show everything (charts, graphic elements, image types, active/interactive links and fonts).


**Links or interactive elements don't work.**

You are in the preview — use the downloaded PowerPoint file (not the PDF). Active links only work when the presentation is opened in PowerPoint.


**How do I share the presentation with the customer?**

Send the PDF (Convert to PDF), or present directly from the PowerPoint file (in-person meeting or Teams screen share).


**Generation is hanging, or I clicked several times.**

Generation typically takes 10–60 seconds. Wait a moment; if it hangs, close the window and try again. Check under Files whether a presentation has already been created (duplicate).


## For super-users (Management UI)


**The template cannot be uploaded.**

Check the Validation field in the upload dialog — fix the errors shown in PowerPoint, and upload again.


**Where do I upload a master template?**

Go to Present → Setup → Templates → Upload. Choose the .pptx file and the right customer type.


**How do I deactivate an old template?**

Click the delete icon in Templates and confirm in “Deactivate template”. The template is hidden from employees, but data is kept for reporting (status “Inactive”).


**The customer type doesn't exist when I upload.**

Create the customer type in Schedule (Meeting setup → Customer types) first, then try again.


**The employee can't see Present.**

Check that the user has a Present licence, and that Present is enabled in the Management UI.


**Where do I map tags to CRM fields?**

Present → Setup → Tags → Create. Choose the tag, object type and object field.


**I can't see Setup or Tags.**

This requires the right permissions in the Management UI. Contact your administrator to get access.


**What happens to the tag mappings when I upload a corrected template?**

The tag mappings (Tags) apply per tag and are kept across templates. If you have added new tags in the corrected template, they need to be mapped.


## Master slides and PowerPoint


**Generation fails, or slides come out wrong.**

The most common cause is that the slide size is not set to “Custom” in PowerPoint (Design → Slide Size → Custom Slide Size). Imported/Templafy layouts can also cause errors.


**My upload fails because of the layout (Templafy/imported).**

Avoid layouts with numbers in the name, use clear layout names, and use the “Blank” layout if in doubt.


**What is the maximum file size?**

The total PowerPoint file must not exceed 10 MB (otherwise upload fails). Per image, about 1 MB is recommended.


**How do I compress images?**

Select an image → the Picture Format tab → Compress Pictures → choose a lower resolution and “Delete cropped areas of pictures”; untick “Apply only to this picture” to apply to the whole file. Compress videos too (File → Info → Compress Media).


**How do I name slides?**

In the notes field on each slide: [slide:slide_name] — lowercase, no spaces, underscore as the word separator.


**How do I create sections and sub-sections?**

Use PowerPoint's section function (right-click between slides → Add Section). A sub-section is created by naming the section “Section name -- Sub-section name”.


**How do I insert a hyperlink (e.g. logo → agenda)?**

Select the element → Insert → Link → “Place in This Document” → choose the destination slide (e.g. agenda). Active/external links work when the file is opened in PowerPoint — not in the preview.


## Tags and fields


**I can't find my tag in the “Choose a tag” list.**

Check that the tag is spelled correctly in PowerPoint, and that the file has been uploaded.


**Which CRM field should a tag point to?**

See the “Most-used tags” reference table in the super-user guide. If in doubt, contact your CRM/super-user lead or &money support.


**How do I map the agenda and forms of address?**

Against Object type “Specific”: agenda → the field “Meeting agenda”; forms of address (Dine/Jeres, Du/I, Dig/Jer, Din/Jeres, Dit/Jeres — Danish grammatical address forms) → the corresponding Specific fields.


**What are tag modifiers?**

They format data from Salesforce before insertion: capitalize (initial capital), uppercase, lowercase, title, trim. They are chained with a colon, e.g. [tag:firmanavn:trim:uppercase].


**How do I replace an image dynamically?**

Name the image in PowerPoint (via the Selection Pane) with [image:image_name]. When generating, the image is replaced with the image linked to the image tag.


**The presentation is missing data.**

Check that the relevant tags are mapped under Tags, and that the CRM fields actually contain data.


**My image was not replaced ([image:...] doesn't work).**

Check that the image is named exactly [image:image_name] (via the Selection Pane in PowerPoint), and that the name matches the image tag the image should pull from.


**The agenda doesn't come through on the slide.**

The agenda tag must be set as bullet points on the slide to work. Also check that the agenda is mapped (Object type Specific → “Meeting agenda”), and that the agenda has been filled in on the meeting.


**Wrong data comes in (e.g. wrong date).**

The tag is probably mapped to a different field than expected — for example [tag:dato] pulls Event → End date (the meeting's end time). Check the mapping under Tags.


**What rules apply to slide and tag names?**

Only lowercase letters, digits, underscore (_) and hyphen (-) — no spaces, uppercase letters or special characters. Tag names must match exactly between PowerPoint and the mapping in Tags.


## Validation messages on upload (what do they mean?)

When you upload a template, Info, Warning and Error messages are shown. Only **Errors** block the upload — warnings you can often live with.


| Message (excerpt) | Meaning | What you do |
|---|---|---|
| Slide name missing on slide | A slide has no name in the notes field | Add [slide:name] in the notes field. |
| Slide name/tag contains invalid characters | Only lowercase letters, digits, _ and - are allowed | Remove spaces, uppercase letters and special characters. |
| The slide name is used more than once | Two slides have the same name | Make the slide names unique. |
| Invalid layout reference | The slide uses a layout Present cannot read (often Templafy/imported) | Avoid numbers in layout names; use the “Blank” layout. |
| Unsupported modifier | A tag uses an unknown modifier | Use only: capitalize, uppercase, lowercase, title, trim. |
| Invalid chart | A chart cannot be handled correctly | Simplify the chart, or insert it as an image. |
| The image is large (max. 1 MB recommended) | An image takes up a lot of space (warning) | Compress the image (Picture Format → Compress Pictures). |
| Fonts found | Special/custom fonts do not show in the preview (warning) | Use standard fonts, or present from the PowerPoint file. |
| Links between slides found | Internal links only work if the destination slide is included (warning) | Include the slides your links point to. |
| Transitions found | Slide transitions may not display as expected (warning) | Avoid transitions between slides that are not always included. |
| The template contains validation errors and therefore cannot be uploaded | At least one blocking error | Fix the errors above, and upload again. |


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
