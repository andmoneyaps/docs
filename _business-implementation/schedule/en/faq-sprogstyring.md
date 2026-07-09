---
layout: "default"
title: "FAQ – Multilingual booking"
parent: "English"
grand_parent: "Schedule"
nav_order: 416
lang: "en"
---
# Schedule – FAQ: Language management (multilingual booking)
_Typical questions, errors and answers · v1.0 · 02.07.2026_

Quick answers to the most common questions about multilingual booking (Language management) in Schedule. More detailed steps are in the **Schedule – super-user guide: Language management**.


## Getting started


**What is Language management?**

The ability to show the customer-facing booking in **several languages**. You enable the bank's languages under **Admin → Language Management** and enter translations in **Schedule → Meeting setup**. Danish is always the fallback.


**Where do I enable a language?**

Under **Admin → Language Management**. Click **Add language** and choose the language. It is saved immediately (“Languages updated”).


**Which languages can be enabled?**

Danish (da-DK, always primary), British English (en-GB), Greenlandic/Kalaallisut (kl-GL), Swedish (sv-SE), Norwegian Bokmål (nb-NO), German (de-DE / de-AT), French (fr-FR / fr-BE), Finnish (fi-FI) and Faroese (fo-FO). If the language is not on the list, it is not yet supported — contact &money.


**Where do I enter the translations themselves?**

Two places in Meeting setup: **Default values** — meeting-type names, employee-type names, iCal title/description — and **Meeting topics** — topic and sub-topic names. Note that Meeting configuration has no translatable fields.


## Fallback and behaviour


**What happens if a translation is missing?**

The **Danish** text is shown. The customer never sees an empty value. That is why the Danish field is mandatory.


**Can I remove Danish?**

No. Danish (da-DK) is the primary language and always the fallback — it cannot be removed.


**How do I add a translation to a field?**

Enter the Danish text, then **click a language code** below the Danish field (e.g. en-GB) to write the translation. Use **Show/Hide translations** to expand or collapse the languages.


**How do I know a field is fully translated?**

The field's status shows, for example, “All translations complete” or “Translations: 2 / 3 translated — missing: …”.


**Can I undo a translation?**

Yes — clear the language field and save, and the field falls back to Danish.


## Common errors


**I have entered the translation, but the customer still sees Danish.**

Check that you clicked **Save** (Default values) or **Create**/**Save** (Meeting topic). The change appears in the booking the next time the customer opens it.


**A language cannot be selected as a language code on the fields.**

The language is not enabled for the bank — add it under **Admin → Language Management** first.


**I removed a language — are my translations gone?**

No. They are **kept** and appear automatically again if the language is re-enabled. They are simply hidden from customers in the meantime.


**Buttons and confirmations are not translated.**

They are owned by your **booking portal/integrator** — they sit outside these fields.


## Access and roles


**Who can use Language management?**

Enabling languages requires access to **Admin**; entering translations requires **Configurator**/**Admin** in Meeting setup. Contact your administrator if you lack access.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 02.07.2026_
