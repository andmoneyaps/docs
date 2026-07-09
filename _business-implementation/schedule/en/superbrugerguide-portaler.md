---
layout: "default"
title: "Super-user guide – Portals"
parent: "English"
grand_parent: "Schedule"
nav_order: 205
lang: "en"
---
# Schedule – super-user guide: Portals
_Booking portals + CRM Configurations in the Management UI · v1.0 · 11.06.2026_



{: .note }
> **Note:** The screenshots below show the Danish Management UI; English-interface screenshots are being added.

## Purpose and value

A **portal** is the page where your customers book meetings themselves. As a super-user you set up the portal: which customers it is for (customer data), how it looks (styling), which fields the customer has to fill in, and how the booking's data lands in your CRM. The customer-data choice also controls which times the customer is shown.

### Glossary
- **Portal**: The customer-facing booking page, where the customer chooses a time and books a meeting themselves.
- **Customer data**: The portal's pre-selection of customer type, meeting topic and location — it scopes which times and employees the customer is shown.
- **CRM Configuration**: The ⟦old⟧ field mapping (being phased out) that determines how booking data is written to the CRM. Replaced by the Playbook.
- **Login type**: How the customer logs in to the portal: Azure AD or MitID.
- **Portal fields**: The fields the customer fills in to book (can be required, optional or hidden, with validation).
- **CRM Creation Strategy**: How booking data is sent to the CRM: ⟦Playbook⟧ (the going-forward standard) or ⟦CRM configuration (standard)⟧ (the old model, being phased out).
- **Playbook**: An automated flow that sends booking data to the CRM (trigger → data blocks → CRM). Created under Admin → Playbooks. The going-forward standard for portals.
- **Label**: A marker for organising and filtering portals.


## Audience and prerequisites

- Audience: super-user/administrator (role **Configurator** or **Admin**).
- The following have been created in advance: **customer types**, **meeting topics**, **locations**, **meeting configuration**, **employees** (with availability) and possibly **service groups** — together they determine which times the portal can show.
- If you use **CRM configuration (standard)**, a **CRM Configuration** must have been created (Step 1).
- The managed BookMe package is installed. If a prerequisite is missing, it is created elsewhere in Schedule — contact your administrator if you do not have access.

{: .note }
> **Note:** The brand name is **Schedule**; in the system/menu you may still encounter the earlier name (bookme). It is the same product.

{: .note }
> **Note:** Going forward, portals send booking data to the CRM via a **Playbook**. The old model **CRM configuration (standard)** is being phased out and is used by only a few customers during a transition period.


## What you get out of it

After this guide you can:

- Create a CRM Configuration (field mapping to the CRM).
- Create a portal with customer data, styling and fields.
- Understand how the customer-data choice scopes the shown times.
- Test the portal and troubleshoot the most common problems.


## Overview (order)

- Step 1: Create a **CRM Configuration** (if you use CRM configuration (standard)).
- Step 2: Create the portal — **Portal information** (name, login, CRM strategy).
- Step 3: Set **Customer data** (customer type/meeting topic/location) — scopes the times.
- Step 4: **Styling** + **Labels**.
- Step 5: **Fields** (what the customer fills in) + validation.
- Step 6: Test the portal.


## Step-by-step (Management UI)

{: .note }
> **Note:** The portal is saved **as a whole** when you click **Create** (new) or **Save** (edit) at the bottom of the dialog. If you close the dialog or choose **Cancel**, the changes are not saved — so fill in the steps and save at the end.


### Step 1 · Prepare the CRM flow (Playbook)

_Why: Going forward, portals use a ⟦Playbook⟧ to send booking data to the CRM — an automated flow: the customer's booking (trigger) → data blocks → CRM (can also run AI and fetch/enrich data)._

- **Playbooks** are created and managed under **Admin → Playbooks** (typically by you together with &money). Make sure the desired Playbook exists before you create the portal.
- **Old model (being phased out):** if you are still running on **CRM configuration (standard)**, you instead create a CRM Configuration under **Schedule → CRM Configurations** → **Create new**: fill in the **Name**, and map portal fields (**Key**) and **Standard fields** to CRM fields via **Object** (e.g. Contact.Email).


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-portaler/sched_crm_konfiguration.png)

*Screenshot 1 (Management UI) — Schedule → CRM Configurations (old model) — field mapping to the CRM*

{: .hint }
> ✓ **How you know it worked:** The desired Playbook (or — on the old model — CRM Configuration) exists. When the selector is available in your tenant, it can be chosen on the portal.

**Example:** the portal field **Email** → **Key** "email" → CRM **Object** Contact.Email. You choose the same **Key** on the portal field in Step 5, so the field is linked to the mapping.


### Step 2 · Create the portal — Portal information

_Why: The portal itself — name, login and how data lands in the CRM._

- Go to **Schedule** → **Portals** → click **Create portal**.
- Fill in the **Name** (the portal's name).
- Choose **Login type**: **Azure AD** (internal/employees) or **MitID** (citizens).
- Choose **CRM Creation Strategy** = **Playbook** (the going-forward standard). Linking to a specific Playbook currently happens together with &money — the portal's **Playbook** selector still shows "No playbooks available" and will open soon.
- **Old model:** if you are still running on **CRM configuration (standard)**, you instead choose it and a **Configuration**.
- Optionally set **iCal** (calendar file for the customer).


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-portaler/sched_portal_information.png)

*Screenshot 2 (Management UI) — **Portal information** — CRM Creation Strategy = **Playbook** (standard) + Login type, iCal etc.*

{: .note }
> **Note:** **Playbook** is the going-forward standard for portals. **CRM configuration (standard)** is the old model, which is being phased out and is used by only a few customers during a transition period.


### Step 3 · Set Customer data (scopes the shown times)

_Why: Customer data determines which customers the portal is for — and thereby which employees and times are shown._

- Under **Customer data**: choose **Customer type** (required).
- Optionally choose **Meeting topic** — empty = all meeting topics for the customer type.
- Optionally choose **Location** — empty = the customer chooses the location during booking.
- Read the shown note about which **service groups** can affect the times on display.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-portaler/sched_portal_kundedata.png)

*Screenshot 3 (Management UI) — Portal → **Customer data** — **Customer type**, **Meeting topic**, **Location** + service-group note*

{: .note }
> **Note:** **Customer data** is what scopes availability: customer type + (optionally) meeting topic + (optionally) location determine which employees/service groups — and thereby which times — the customer is shown.


### Step 4 · Styling and labels

_Why: Give the portal your look, and organise it with labels._

- Open **Portal styling**: set the **Logo** (a URL to the image) and **Logo height** (in pixels), and optionally **styling** (colours).
- Optionally add **Labels** to organise and filter portals.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-portaler/sched_portal_styling.png)

*Screenshot 4 (Management UI) — Portal → **Portal styling** (Logo, Logo height, styling) + **Labels***

{: .important }
> **Remember:** The **Logo** is given as a **URL** or an embedded image (data URI) — not an uploaded file; **Logo height** only controls the size. **Styling** is optional and can be advanced CSS (e.g. the &money portal sets the colours to #004568). Colour choices affect the visibility of buttons and logo — contact your &money contact if you would like help with the logo or colours.


### Step 5 · Fields (what the customer fills in)

_Why: The fields are what the customer fills in to book — e.g. name, email, purpose._

- Under **Fields**: click **Add field**.
- Fill in **Field name**, optionally **Field description** and **Default value**, choose **Field type** (Text, Number, Date, Time, etc.) and **Order**.
- Set **Required field** and/or **Hidden field** as needed.
- Optionally add **Validations**: choose a **predefined regex** (CPR, email, phone, name, URL) or write your own **regular expression** + an **Error message**.
- Optionally link the field to a **Key**, so it is mapped to the CRM via the CRM Configuration.


![Screenshot 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-portaler/sched_portal_felter.png)

*Screenshot 5 (Management UI) — Portal → **Fields** — field setup (name, type, order, required/hidden) + **Validations***

{: .note }
> **Note:** Do not make a field both **Required** and **Hidden** — the customer cannot fill in a hidden field. Hidden fields are used for pre-filled/default values; required fields must be visible.


### Step 6 · Test the portal

_Why: Confirm that the portal works before it is put into use._

- Open the portal (the link icon in the portal list).
- Complete a **test booking** as a customer of the chosen customer type.
- Confirm that times are shown, that the fields work, and that the booking lands correctly in the CRM.

{: .hint }
> ✓ **How you know it worked:** The customer can see times, fill in the fields and book — and the data lands in the CRM as expected.

{: .note }
> **Note:** The portal's customer-facing page is opened via **Open portal** / the link icon in the portal list. That is the link you share with customers (e.g. on your website or in an email).

{: .important }
> **Remember:** If the portal is to use **MitID**, a real test booking requires a MitID login. Test the logic first via an **Azure AD** portal/internal user.


**Checklist before the portal is put into use**

- Available times are shown for the chosen customer type/meeting topic/location.
- The fields appear in the right order and validate correctly (e.g. CPR/email).
- Login (Azure AD/MitID) works for the target group.
- The booking lands in the CRM on the right fields (check a test booking).


## What do the fields mean? — Portal


| Field | What it controls | Meaning (★ = affects availability) |
|---|---|---|
| Name | The portal's name | Identification and display. |
| Login type | Access | Azure AD (internal) or MitID (citizens) — controls login, not availability. |
| CRM Creation Strategy | How data lands in the CRM | Playbook (standard) runs an automated flow to the CRM. CRM configuration (standard) (old model) uses a fixed field mapping. |
| Configuration | Field mapping to the CRM | Only chosen on the old model (CRM configuration (standard)). |
| iCal | Calendar file | Whether the customer gets a calendar file for the meeting. |
| Customer type | ★ Who the portal is for | Scopes employees/service groups and thereby the shown times. Required. |
| Meeting topic | ★ Topic | Scopes further by topic. Empty = all topics for the customer type. |
| Location | ★ Place | Empty = the customer chooses. Set = the portal books at that location (can trigger a requirement for an available room). |
| Logo / Logo height / styling | Look | Branding. Logo requires a URL; colours affect visibility. |


## What do the fields mean? — Fields and CRM Configuration


| Field | What it controls | Meaning |
|---|---|---|
| Field name / description | What the customer sees | Label + help text on the field. |
| Field type | Input type | Text, Number, Date, Time, Text area, Yes/no. |
| Order | Display order | Lower number is shown first. |
| Required field | Must be filled in | The customer cannot book without it. |
| Hidden field | Hidden from the customer | For pre-filled/default values — do not combine with Required. |
| Validation (regex) | Input control | Predefined (CPR/email/phone/name/URL) or your own regular expression + error message. |
| CRM: Key / Standard field → Object | Field mapping | Links a portal field (Key) or system field (Standard field) to a CRM field (Object, e.g. Contact.Email). |


## What controls the shown times?

The portal's **Customer data** (customer type + optionally meeting topic + optionally location) determines, together with your other setup, which times the customer is shown:

- **Customer type** + **meeting topic** → which employees are qualified (via competence groups), and which service groups are activated.
- **Location** → employees at that location; can trigger **require available meeting room** for physical meetings (set on the location under Meeting setup → Locations).
- The employees' **availability**, meeting configuration (duration, meeting types, lead times) and closing days always apply.


## Troubleshooting

- The customer sees no times: check that there are qualified employees (competence group) with availability for the portal's **customer type/meeting topic/location**; for a physical meeting — check **require available meeting room** (set on the location under **Meeting setup → Locations**, outside Portals).
- The logo does not appear: **Logo** must be a **URL** to an image; **Logo height** only controls the size.
- A field cannot be filled in: it is set as **Hidden** and **Required** at the same time — make it visible, or remove required.
- Data does not land in the CRM: check that the portal uses the right **Playbook** (or — on the old model — **CRM configuration (standard)** with a chosen Configuration).
- I can't select a configuration: create a **CRM Configuration** first (Step 1).
- No Playbook to choose: the Playbook must first be created under **Admin → Playbooks** — contact your administrator/&money.

### See also / prerequisites
- **Schedule – FAQ (Portals)** — typical questions, errors and answers.
- **Schedule – super-user guide: Service groups** — service groups affect the times the portal shows.
- **Schedule – Playbooks** — upcoming guide to setting up Playbooks (Admin → Playbooks).
- **Schedule – super-user guide (full setup)** — upcoming guide (default values, customer types, locations, meeting topics, availability).


## Latest update

- 11.06.2026 (v1.0) — First version (portals + CRM configurations).


{: .hint }
> ✅ **Done!** The portal is ready for your customers.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
