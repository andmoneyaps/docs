---
layout: "default"
title: "FAQ – Portals"
parent: "English"
grand_parent: "Schedule"
nav_order: 414
lang: "en"
---
# Schedule – FAQ: Portals
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors relating to portals in Schedule. More detailed steps are in the **Schedule – super-user guide: Portals**.


## Portals


**The customer sees no times on the portal.**

This is almost always customer data vs. availability. Check: are there qualified employees (competence group) for the portal's customer type/meeting topic, do they have availability on that location/day, and — for in-person meetings — is **require a free meeting room** satisfied? Also check closing days and lead times.


**What does “Customer data” do on the portal?**

Customer data (customer type, meeting topic, location) pre-selects who the portal is for — and thereby scopes which employees/service groups and times the customer is shown. Customer type is required; an empty meeting topic = all topics; an empty location = the customer chooses.


**What does the note “The following service groups may have an influence…” mean?**

When you select a customer type (plus any topic/location), the system calculates which service groups are activated for that combination. The note shows them — they may offer other times/meeting types/locations than the local employees.


**What is the difference between “Playbook” and “CRM configuration (standard)”?**

Playbook is the **going-forward standard**: an automatic flow that sends booking data to the CRM (and can run AI, fetch/enrich data, and more). CRM configuration (standard) is the **old model** with a fixed field mapping — it is being phased out and is only used by a few customers during a transition period.


**What is a Playbook, and where do I create it?**

A Playbook is an automatic flow: the customer's booking (trigger) → data blocks → CRM. Playbooks are created and managed under **Admin → Playbooks** (typically by you together with &money).


**How do I connect a portal to a Playbook?**

Set the portal's **CRM creation strategy** = **Playbook**. Selecting a specific Playbook currently happens in collaboration with &money — the portal's Playbook selector still shows “No playbooks available” and will open soon. Playbooks are created under **Admin → Playbooks**.


**The logo does not appear.**

**Logo** must be a **URL** to an image (not an uploaded file). **Logo height** only controls the size in pixels.


**Can I change the order of the fields?**

Yes — each field has an **Order** number. A lower number is shown first on the portal's form.


**Can a field be both required and hidden?**

No — avoid this. A hidden field cannot be filled in by the customer, so a required + hidden field blocks the booking. Hidden fields are for pre-filled/default values; required fields must be visible.


**Can I use my own regex for validation?**

Yes. You can choose a **predefined regex** (CPR, e-mail, telephone, name, URL) or write your own **regular expression** plus an error message.


**What is the difference between Login type Azure AD and MitID?**

Azure AD is typically used for internal users/employees; MitID for citizens (Danish ID). Choose the one that suits the portal's audience.


**Require a free meeting room blocks all in-person times — where do I change it?**

The **require a free meeting room** setting is configured on the individual location under **Meeting setup → Locations** (outside Portals). Create/free up a meeting room at the location, or turn the requirement off. Contact your administrator if you do not have access.


**How do customers get to the portal, and when do changes go live?**

The portal's customer-facing page is opened via **Open portal** / the link icon in the portal list — that link is the one you share with customers (website, e-mail, and so on). Changes take effect at the next load/booking search; if you experience a delay, refresh the page.


**Validation rejects valid input (e.g. CPR).**

Check the field's **regular expression**. The predefined regexes have specific formats (e.g. CPR with/without a hyphen). Choose the correct predefined regex, or adjust the expression — and provide a helpful **Error message**.


**What does the customer get via iCal?**

If you enable **iCal**, the customer can receive a calendar file (.ics) for the booked meeting, so it is easy to add to their calendar.


**Login (MitID or Azure AD) fails for the customer.**

Check that the portal's **Login type** matches the audience (Azure AD = internal; MitID = citizens). If the error persists, contact support — it may be a setup issue in your identity solution.


## CRM configurations


**What is a CRM configuration?**

A field mapping that determines how the booking's data is written to your CRM — both portal fields (**New portal fields**) and system fields such as meeting date/employee (**Existing Schedule meeting fields**).


**Do I need a CRM configuration for every portal?**

Only if the portal uses **CRM configuration (standard)**. Several portals can use the same configuration. (The Playbook strategy requires no configuration, but has not yet been opened.)


**I can't select a configuration on the portal.**

Create a CRM configuration first (Schedule → CRM configurations → Create new), then you can select it on the portal.


**Can I delete or deactivate a portal or a CRM configuration that is in use?**

A CRM configuration may be used by several portals — move the portals onto another configuration first. Be aware of the effect on existing/in-progress bookings; contact your administrator/support if in doubt.


## Access and roles


**Who can create portals and CRM configurations?**

The **Configurator** or **Admin** role in the Management UI. Contact your administrator if you are missing access.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
