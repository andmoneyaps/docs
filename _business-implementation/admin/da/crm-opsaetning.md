---
layout: "default"
title: "CRM Opsætning"
parent: "Dansk"
grand_parent: "Admin"
nav_order: 202
lang: "da"
---
# Admin – CRM Opsætning (deep-dive)
_Forbindelsen til jeres CRM · hvad du reelt ser · konsekvensen af ændringer · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/admin/da/crm-opsaetning.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/admin/da/crm-opsaetning.pdf)

## Formål og værdi

**CRM Opsætning** forbinder Engage med jeres CRM (**Salesforce** eller **Dynamics 365**). Det er rygraden i, at booking-data — møder, kundetyper, mødeemner — havner det rigtige sted i CRM’et. Området er delt i tre sider: **CRM Konfiguration** (forbindelse + provisionering), **Grænser** (forbrug i Salesforce) og **Automatisk licensstyring** — plus **Validér brugere**. De fleste handlinger her er **sjældne opsætnings-trin**, ikke daglig drift.

{: .note }
> **Bemærk:** **Domænenavnet kan ofte kun ændres af &money/servicedesk.** Ser du teksten ‘kontakt servicedesk for assistance’, er det med vilje — det er en høj-risiko-værdi. Kontakt &money i stedet for at forsøge at omgå det.


## Hvem ændrer hvad (og risikoen)


| Handling | Hvem | Risiko |
|---|---|---|
| Domænenavn / Miljø-URL | &money / servicedesk | Høj — forkert = ingen CRM-data. |
| Test forbindelse / Test CRM | Du | Ingen — read-only test. |
| Opret (provisionér BookMe) | Du / jeres driftspartner | Lav — idempotent, kan trygt gentages. |
| Skub (kundetyper/mødeemner) | Du / jeres driftspartner | Lav–middel — synkroniserer konfiguration. |
| Skub EngageMe-komponenter (deploy) | jeres driftspartner / &money | Høj — OVERSKRIVER Salesforce-komponenten. |
| Grænser | Du (overvåg) | — læs/overvåg forbrug. |
| Validér brugere | Du | — diagnostik (e-mail-match). |


## Hvad du reelt ser


**CRM Konfiguration**

**Hvad du reelt ser:** feltet **Domænenavn** (Salesforce: **https://___.my.salesforce.com**) eller **Miljø-URL** (Dynamics); **Test forbindelse**; **Opret** (provisionér BookMe-forbindelsen); evt. **Test Present forbindelse**; **&money EngageMe-komponenter** med knappen **Skub** (+ en note: ‘Skubning overskriver den samme Salesforce-komponent’); **Skub** af kundetyper/mødeemner; og **Test CRM**.

- **Opret** er **idempotent** (en ‘upsert’) — den kan trygt køres igen uden at ødelægge noget; den opretter/opdaterer blot forbindelsen.
- **Skub EngageMe-komponenter** (deploy) er derimod **indgribende**: den **overskriver** den eksisterende komponent i Salesforce. Bekræft **komponenttype** (Standard vs. Selvstændig) før du skubber.
- **Domænenavn** valideres på format — et forkert format giver fejlen ‘Misdannet URL’, og du kan ikke gemme.


**Grænser**

**Hvad du reelt ser:** en tabel over jeres Salesforce-grænser (**Grænsenavn**, **Status**, **Brugt**, **Maksimum**, **Resterende**, **Forbrug**). Status er farvekodet:


| Status | Forbrug | Hvad det betyder |
|---|---|---|
| Sund | 0–69 % | Normalt — ingen handling. |
| Advarsel | 70–89 % | Hold øje — overvej oprydning/mere kapacitet. Reagér HER. |
| Kritisk | 90 %+ | Tæt på loftet — ved 100 % afviser Salesforce flere kald, og CRM-skrivninger (møder/data) kan stoppe. |


**Automatisk licensstyring**

**Hvad du reelt ser:** opsætning af, hvilke licenser og rettigheder medarbejdere automatisk får (eller mister). Dette er **høj-risiko** og har sin egen guide — se **Admin – Brugerstyring (deep-dive)**, hvor auto-tildel/auto-fjern, rettighedssæt og **Nulstil til Standard** er beskrevet.


**Validér brugere**

**Hvad du reelt ser:** tre lister, der sammenholder Schedule-brugere med CRM: **Dublerede** (matcher mere end én e-mail i CRM), **Manglende** (findes ikke i CRM) og **Valide** (rent 1-til-1-match). **Konsekvens:** der skal være **1-til-1**, før sync og auto-licens virker pålideligt. Dubletter og manglende skal ryddes i CRM/Schedule.


## Konsekvens af en forkert værdi


| Hvis … | Så … | Vises som |
|---|---|---|
| Forkert domæne/URL (men gyldigt format) | Test fejler; provisionering + sync til CRM fejler | ‘Fejl i integrationen til CRM’ |
| Misdannet domæne/URL | Kan ikke gemmes | ‘Misdannet URL’ (rød) |
| Skub EngageMe-komponenter på eksisterende | Den eksisterende komponent overskrives | ‘Skubning overskriver …’ |
| Grænse rammer Kritisk (90 %+) | CRM-skrivninger nær stop ved 100 % | Status Kritisk (rød) |


## Før du ændrer noget

- **Domænenavn/URL:** overlad det til &money/servicedesk — det er en høj-risiko-værdi, og forkert = ingen CRM-data.
- **Test bagefter:** brug **Test forbindelse**/**Test CRM** efter enhver ændring, og lav en **testbooking**.
- **Opret kan gentages** (idempotent) — men **Skub/deploy** OVERSKRIVER; bekræft komponenttype og mål.
- **Overvåg Grænser:** reagér ved **Advarsel** (70 %+), ikke først ved Kritisk.
- **Validér brugere** skal være 1-til-1, før I slår auto-licens til (ellers fejler tildelingen).

### Se også / forudsætninger
- **Admin – Brugerstyring (deep-dive)** — automatisk licensstyring + Validér brugere i detaljer.
- **Admin – Microsoft (deep-dive)** — kalender-sync (Graph proxy).
- **Admin – Logs & synkroniseringsfejl** — fejlkatalog + ansvarsfordeling.
- **Admin – overblik over undermenuerne** — alle faner kort.


## Seneste opdatering

- 12.06.2026 (v1.0) — Første version (CRM Opsætning deep-dive).


{: .warning }
> ⚠️ **Husk** — Domænenavn = &money; Opret kan gentages; Skub/deploy overskriver; test altid bagefter.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
