---
layout: "default"
title: "Super-user guide – Multilingual booking"
parent: "English"
grand_parent: "Schedule"
nav_order: 203
lang: "en"
---
# Schedule – super-user guide: Language Management (multilingual booking)
_Show the customer-facing booking in multiple languages — Danish, English, Greenlandic and more · v1.1 · 02.07.2026_


## Purpose and value

**Language Management** lets you show the customer-facing booking in **multiple languages** — for example Danish, English and Greenlandic (kalaallisut) — so that customers who do not speak Danish can book meetings **themselves**, without manual help. You enable the bank's languages under **Admin → Language Management** and enter the translations directly in **Schedule → Meeting configuration**. The translations are **saved and used in the customer-facing booking** — the text is shown in the customer's language, and Danish is used automatically wherever a translation is missing.

{: .note }
> **Note:** **Danish is always the fallback.** If a translation is missing for a field, the Danish text is shown — the customer never sees an empty value. Danish (da-DK) therefore cannot be deselected.


## What can be translated — and what you do not control yourself

You translate selected **names and titles** in the booking content itself. This is done in **two places** in Meeting configuration. The surrounding flow text (buttons, guidance, confirmations, e-mails) is owned by your **booking portal/integrator** — not by these fields.


| What you translate | Where in the Management UI | What the customer sees |
|---|---|---|
| Naming of meeting types (Physical · Online · Phone · Other location) | Meeting configuration → General (Default values) | The meeting type's name in the booking |
| Naming of employee types | Meeting configuration → General (Default values) | The type of employee the customer books |
| iCal meeting title and description | Meeting configuration → General (Default values) | The title/description in the calendar invitation |
| Meeting topics and subtopics | Meeting configuration → Meeting topics | The topics the customer chooses between |

{: .important }
> **Remember:** Confirmations, e-mail templates and the surrounding portal text are **outside** Language Management — those are delivered by your booking portal/integrator. Machine translation is not used; you enter the translations yourself.


## Audience and prerequisites

- **Role:** administrator/super-user with access to both Admin and the Schedule configuration in the Management UI.
- **Languages enabled:** the languages you want to translate into must be switched on for the bank under **Admin → Language Management** (Danish is always active).
- **Translations ready:** have the finished translations to hand before you start typing — for example Greenlandic (kalaallisut) texts, which you obtain yourself. &money does not translate for you.


## Overview (quick guide)

- 1) **Admin → Language Management:** enable the languages the bank should be able to author content in.
- 2) **Meeting configuration → General:** translate meeting-type names, employee-type names and the iCal title/description.
- 3) **Meeting configuration → Meeting topics:** translate topic and subtopic names.
- 4) The translations are **saved** and shown automatically in the customer-facing booking; Danish is used wherever something is missing.

{: .note }
> **Note:** The language fields appear **dynamically** based on the languages your bank has enabled — not a fixed number. If the bank has only Danish + English enabled, you can only add an English translation.


## How to add a translation (the same mechanic everywhere)

All translation fields work the same way: **the Danish field is always visible**, and beneath it sits a row of **language codes** for the bank's other languages. Click a language code to expand the field and write the translation.

- Write the Danish text in the main field (**required**).
- **Click a language code** below the Danish field (for example **en-GB** or **kl-GL**) to add a translation in that language.
- Use **Show translations / Hide translations** to expand or collapse all languages.
- An empty language field **falls back to Danish** — you do not have to fill in every language straight away.

{: .note }
> **Note:** The field shows a status, for example **"All translations complete"** or **"Translations: 2 / 3 translated"**, so you can see what is missing.


## Step by step


### Step 1 · Enable the bank's languages (Admin → Language Management)

_Why: The language fields in Meeting configuration appear based on the languages the bank has enabled — so start by switching on the right languages. Disabled languages are not shown to customers._

- Go to **Management UI → Admin → Language Management**.
- Click **Add language** and choose the language the bank should be able to author content in (for example **British English (en-GB)** or **kl / Greenland (kl-GL)**).
- **Danish (da-DK)** is listed as **Primary** and cannot be removed — it is always the fallback.
- The language is saved **immediately** (you get the message "Languages updated") — there is no separate save button here.

{: .important }
> **Remember:** If you remove a language (the bin icon), it is hidden from customers, but **the translations you have already made are kept** and reappear if the language is enabled again.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-flersproget-booking/sprog_admin.png)

*Screenshot 1 (Admin → Language Management) — Admin → Language Management — the bank's enabled languages with the "Primary" marker on Danish and the "Add language" button.*

{: .hint }
> ✓ **How you know it worked:** The language now appears in the list with its language code (for example en-GB), and the message "Languages updated" confirms it is saved. You can now add translations in that language in Meeting configuration.

{: .note }
> **Note:** Languages that can be enabled: Danish (da-DK, always primary), British English (en-GB), Greenlandic/kalaallisut (kl-GL), Swedish (sv-SE), Norwegian Bokmål (nb-NO), German (de-DE / de-AT), French (fr-FR / fr-BE), Finnish (fi-FI) and Faroese (fo-FO). If you cannot select a language you want, it is not supported yet — contact &money.


### Step 2 · Translate meeting types, employee types and iCal texts (General)

_Why: You set the three field groups in one place — under General (Default values) — and they appear directly in the customer's booking and calendar appointment._

- Go to **Management UI → Schedule → Meeting configuration → General** (the **Default values** tab).
- Under **Naming of meeting types** and **Naming of employee types**: fill in **Name**, and click a language code below the Danish field to add the translation per language.
- Under **iCal**: translate **Meeting title** and **Description** — these are what the customer sees in the calendar invitation.
- Click **Save** at the bottom right to save the changes.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-flersproget-booking/sprog_generelt.png)

*Screenshot 2 (Schedule → Meeting configuration → General) — General (Default values) — multilingual fields with the Danish field and the status line "No translations yet — falls back to Danish" (meeting-type and employee-type naming).*

{: .hint }
> ✓ **How you know it worked:** After **Save**, the field's status changes from "No translations yet" to, for example, "Translations: 2 / 3 translated" or "All translations complete".


### Step 3 · Translate meeting topics and subtopics (Meeting topics)

_Why: The topics are what the customer chooses between when booking — so they are central to a clear experience in every language._

- Go to **Management UI → Schedule → Meeting configuration → Meeting topics**.
- Click **Create Meeting topic** (or the pencil icon to edit an existing topic).
- Fill in **Name** (topic) and **Subtopic** — click a language code below the Danish field for each translation.
- Click **Create** (or **Save**) in the dialog to save.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-flersproget-booking/sprog_moedeemner.png)

*Screenshot 3 (Schedule → Meeting configuration → Meeting topics) — Meeting topics — the "Create Meeting topic" dialog with multilingual Name (topic) and Subtopic.*

{: .hint }
> ✓ **How you know it worked:** The field's status shows "All translations complete", and a filled-in language field is shown to customers who book in that language — Danish is used wherever a translation is missing.


## Effect and fallback — important to understand

- **Missing translation = Danish.** An empty language field does not give the customer an empty text — the Danish text is shown instead.
- **Danish cannot be deselected** and is always the fallback; that is why the Danish field is required.
- **Disabled languages are not shown** to customers — but translations already entered are kept if the language is switched on again.
- **Changes are saved and take effect in production** — edit with care, and check the customer-facing booking afterwards.
- **Only names/titles in these two areas** are multilingual. If the customer sees Danish in buttons/confirmations, that is your booking portal/integrator's text — not these fields.


## Who does what


| Task | Who |
|---|---|
| Enable the bank's languages (Admin → Language Management) | You (bank admin) in the Management UI |
| Enter translations (General + Meeting topics) | You (bank admin) in the Management UI |
| Provide the translations themselves (for example Greenlandic/kalaallisut) | You / your language supplier |
| Surrounding flow text, confirmations, e-mails | Your booking portal/integrator |
| Platform: multilingual fields + delivery to the booking | &money |


## Troubleshooting


| Symptom | Likely cause → action |
|---|---|
| The customer sees Danish even though they chose English | The English translation is missing for the field → fill it in under Meeting configuration (Danish is the fallback). |
| I entered the translation, but the customer still sees Danish | Check that you clicked ⟦Save⟧ (General) / ⟦Create⟧ (Meeting topic). The change appears in the booking the next time the customer opens it. |
| A language cannot be selected / is missing as a language code | The language is not enabled for the bank → add it under Admin → Language Management (if it is not on the list, it is not supported yet). |
| I want to remove a translation | Clear the language field and save → the field falls back to Danish. |
| I cannot remove Danish | Danish (da-DK) is the primary language and always the fallback — it cannot be removed. |
| Greenlandic (kalaallisut) text is missing | The translation has not been entered → obtain the text and fill in the language field. |
| Confirmation/e-mail text is not translated | It is owned by your booking portal/integrator — outside these fields. |

### Glossary
- **iCal**: The calendar file the customer receives as a meeting invitation (meeting title + description).
- **Booking portal/integrator**: The solution your bank uses to display the booking page itself; it owns the buttons, confirmations and e-mails.
- **Language code**: The standard code for a language, for example da-DK (Danish), en-GB (British English), kl-GL (Greenlandic).
- **Fallback**: A reserve language: if a translation is missing, the Danish text is shown instead.

### See also / prerequisites
- **Schedule – super-user guide: Meeting configuration** — the fields (General/Default values, Meeting topics) that Language Management adds languages to.
- **Admin – overview of the submenus** — where the bank's languages are enabled (Language Management).
- **Schedule – FAQ (Language Management)** — typical questions about multilingual booking.


## Latest update

- 02.07.2026 (v1.1) — Updated against the actual feature in the Demo environment: languages are enabled under **Admin → Language Management** (da-DK primary, cannot be removed); translations are entered in **two places** — General (Default values) and Meeting topics. Corrected mechanic (click a language code below the Danish field) and fallback; exact UI labels confirmed against the code.
- 17.06.2026 (v1.0) — First version built on the feature spec (Roadmap #306).


{: .important }
> ⚠️ **Remember** — Danish is always the fallback and cannot be removed; enable languages in Admin → Language Management; translate in General + Meeting topics; check the customer-facing booking after changes.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.1 · 02.07.2026_
