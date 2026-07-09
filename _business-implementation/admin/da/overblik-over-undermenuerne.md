---
layout: "default"
title: "Overblik over undermenuerne"
parent: "Dansk"
grand_parent: "Admin"
nav_order: 205
lang: "da"
---
# Admin – overblik over undermenuerne
_Hvad hver fane gør · hvad du reelt ser · konsekvensen af ændringer · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/admin/da/overblik-over-undermenuerne.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/admin/da/overblik-over-undermenuerne.pdf)

## Formål og værdi

**Admin**-menuen rummer de tekniske og organisatoriske indstillinger, der får Engage til at hænge sammen — forbindelsen til CRM og Microsoft 365, brugere/licenser, og loggene. Flere af fanerne er **høj-risiko**: en forkert ændring kan stoppe kalender-sync eller fjerne brugeres adgang. Denne guide giver overblikket: hvad hver fane gør, **hvad du reelt ser**, og — vigtigst — **konsekvensen** af at ændre noget.

{: .note }
> **Bemærk:** **Logs er alarmer** til jer (kunden) og jeres administrator — ikke en kø, &money/jeres driftspartner overvåger. En alarm betyder, at noget kræver handling, ofte i jeres egen Entra/M365. Fejlkatalog + ansvarsfordeling findes i **Admin – Logs & synkroniseringsfejl**.

{: .important }
> **Husk:** **Rør aldrig disse tre alene i drift:** ① **Microsoft → Proxy URL** (stopper AL sync) · ② **Brugerstyring → auto-fjern licenser** (fjerner adgang) · ③ **Mødeopsætning → kopiér** (overskriver målet). Aftal altid med IT/jeres driftspartner/&money først.


## Risiko-overblik (alle faner)


| Fane | Hvad det er | Risiko | Hvem ændrer |
|---|---|---|---|
| Logs | Alarmer om bl.a. sync (møder, medarbejdere, lokaler, Present). | Høj — alarmer kræver handling. | Du (alarm) |
| Mødeoversigt | Se alle møder for en medarbejder på en valgt dato. | Lav — read-only. | Du |
| CRM Opsætning | Forbindelse til Salesforce/Dynamics, grænser, licenser. | Høj — forkert = ingen CRM-data. | jeres driftspartner/&money |
| Forretningsobjekter | Definitioner og felt-mapping for CRM-objekter. | Middel — forkert mapning = data lander forkert. | &money/jeres driftspartner |
| Playbooks | Automatiske flows fra booking til CRM (egen guide). | Middel. | jeres driftspartner/&money |
| Microsoft | Graph Proxy-URL + Teams-mødeindstillinger. | Høj — forkert proxy = ingen sync. | jeres driftspartner/IT |
| Mødeopsætning (kopiér) | Kopiér opsætning fra én kunde/bank til en anden. | Høj — overskriver målet. | jeres driftspartner |
| Skabeloner | Skabeloner til mødereferater. | Lav. | Du |
| Brugerstyring | Brugere, lokaler, auto-licensstyring, validér sync. | Høj — auto-licens kan fjerne adgang. | Du/IT |
| Labels | Mærkater til at organisere ressourcer. | Lav. | Du |
| Operationer | Drifts-/vedligeholdelses-handlinger. | Middel–høj. | jeres driftspartner/&money |
| Fejlfinding | Diagnostik: møde-sync og tilgængelighed. | Lav — diagnosticerer. | Du |


## De høj-risiko faner — hvad du reelt ser, og konsekvensen


**Logs — alarmer om sync m.m.**

**Hvad du reelt ser:** faner for **Møder**, **Medarbejdere** (kalender-sync), **Lokaler**, **Present**, **Audit** og **Reports** — med status (Information/Advarsel/Fejl/Succes) og fejlkoder (**CAL-ERR-xx**). **Konsekvens:** en fejl betyder typisk, at en medarbejders tilgængelighed eller et møde ikke synkroniseres. **Hvad gør du:** se **Admin – Logs & synkroniseringsfejl** (fejlkatalog + hvem-gør-hvad).


**CRM Opsætning**

**Hvad du reelt ser:** **Salesforce** (Domænenavn) eller **Dynamics 365** (Miljø-URL); **Test forbindelse**/**Test BookMe integration**; **Opret** (provisionér integration); **Grænser** (status Sund/Advarsel/**Kritisk**); **Licenser** og **Permission set**; **Validér brugere**. **Konsekvens:** forkert domæne/URL eller manglende provisionering = **ingen booking-data i CRM**; rammer du en **Kritisk** grænse, kan CRM-skrivninger stoppe. **Opret** (provisionér) kan trygt gentages (idempotent) — det er **Skub/deploy** af komponenter, der overskriver. **Gør:** test forbindelsen efter ændring; hold øje med grænser. Se **Admin – CRM Opsætning (deep-dive)**.


**Microsoft (Graph API + Teams)**

**Hvad du reelt ser:** **Proxy URL** til Microsoft Graph + **Test forbindelse**; **Teams - mødeindstillinger** (tillad optagelse/transskription, auto-optagelse, mødeskabelon-ID). **Konsekvens:** en forkert eller utilgængelig **Proxy URL** betyder, at **kalender-sync ikke kan oprette forbindelse** (giver fejl CAL-ERR-14 for alle medarbejdere). **Gør:** rør kun proxy-URL’en efter aftale med jeres IT/jeres driftspartner; **Test forbindelse** bagefter. Se **Admin – Microsoft (deep-dive)**.


**Brugerstyring**

**Hvad du reelt ser:** **Brugere** og **Lokaler** (opret/rediger, labels); **Automatisk licensstyring** (auto-tildel/auto-fjern licenser, rettighedssæt og rettighedsgrupper) med **Auto-Opdage Mappings** og **Nulstil til Standard**. **Konsekvens:** **Auto-fjern** kan **fjerne licenser/adgang** fra medarbejdere automatisk; manuelt oprettede brugere kan kollidere med dem, der kommer via SCIM (opstår en dublet, så behold **SCIM**-brugeren og fjern den manuelle). **Gør:** vær varsom med auto-licens-reglerne; test på få brugere først. Se **Admin – Brugerstyring (deep-dive)**.


**Mødeopsætning (kopiér)**

**Hvad du reelt ser:** **Kopier mødeopsætning** fra én kilde til ét mål — du vælger, hvad der kopieres (**Standard værdier**, **Kundetyper**, **Mødeemner**, **Mødekonfigurationer**). **Konsekvens:** kopieringen **overskriver** målets opsætning, og ‘standard indstillinger skal sættes op manuelt’. **Gør:** bekræft kilde og mål nøje; brug det primært til ny-opsætning, ikke på en kunde i drift.


**Forretningsobjekter**

**Hvad du reelt ser:** definitioner og felt-mapning for de CRM-objekter, booking-data skrives til. **Konsekvens:** en forkert mapning betyder, at data lander i de forkerte felter (eller slet ikke). **Gør:** ændr kun sammen med &money/jeres driftspartner; test en booking bagefter.


## De lavere-risiko faner

- **Mødeoversigt** — slå op, hvilke møder en medarbejder har en given dato (read-only).
- **Skabeloner** — opret/redigér skabeloner til mødereferater.
- **Labels** — mærkater til at organisere og filtrere ressourcer (portaler, brugere m.m.).
- **Operationer** — drifts-/vedligeholdelses-handlinger (kan være indgribende). **Kør ikke handlinger her uden en jeres driftspartner/&money-sag** — risikoen afhænger helt af den enkelte handling.
- **Fejlfinding** — diagnostik-værktøjer (møde-sync og tilgængelighed) til at finde, hvorfor en tid/sync driller.
- **Playbooks** — automatiske flows fra portal-booking til CRM (se **Schedule – superbrugerguide: Playbooks**).


## Symptom → hvilken fane (hurtig triage)

Ringer en medarbejder med et symptom, så start her — og tjek altid **Logs** først.


| Symptom | Sandsynlig fane | Først |
|---|---|---|
| Ingen tilgængelighed / kalender synker ikke for alle | Microsoft (Proxy URL) — CAL-ERR-14 | Logs → Medarbejdere |
| Booking havner ikke i CRM | CRM Opsætning / Forretningsobjekter | Test forbindelse + Logs |
| Medarbejder har mistet licens/adgang | Brugerstyring (auto-fjern licenser) | Tjek auto-licens-regler |
| Online møde uden Teams-link | Microsoft (Teams) + brugerens licens | Logs → Møder |
| Møde booket oven i en aftale / dobbeltbooking | Kalender-sync forsinket | Logs → Medarbejdere |
| En enkelt tid/sync driller for én bruger | Fejlfinding (diagnostik) | Kør diagnostik |


## Før du ændrer noget i Admin

- **Forstå konsekvensen først:** Admin-ændringer rammer ofte **alle** medarbejdere/møder, ikke kun ét.
- **Notér den gamle værdi først:** skriv fx Proxy URL eller CRM-domæne ned, før du ændrer en høj-risiko-indstilling — så kan du sætte den tilbage.
- **Høj-risiko = aftal med IT/jeres driftspartner/&money:** Microsoft (proxy), Forretningsobjekter, auto-licens og kopiér-opsætning bør ikke ændres alene i drift.
- **Test bagefter:** brug **Test forbindelse** (CRM/Microsoft) og lav en **testbooking**, når noget i sync-kæden er rørt.
- **Loggene er din kvittering:** tjek **Logs** efter en ændring for at se, at sync stadig kører.

### Se også / forudsætninger
- **Admin – Logs & synkroniseringsfejl** — fejlkatalog (CAL-ERR-xx) + ansvarsfordeling (RACI).
- **Admin – CRM Opsætning / Microsoft / Brugerstyring (deep-dives)** — de tre høj-risiko faner i detaljer.
- **Schedule – superbrugerguide: Playbooks** — flows til CRM.
- **Schedule – superbrugerguide: Mødeopsætning** — selve møde-reglerne (kopiér-funktionen kopierer disse).
- **Schedule – kom godt i gang** — tværgående overblik.


## Seneste opdatering

- 12.06.2026 (v1.1) — Hvem-ændrer-kolonne, symptom→fane-triage, rollback-note, top-3 ‘rør ikke alene’, Operationer/CRM/SCIM præciseret (persona-feedback).
- 12.06.2026 (v1.0) — Første version (Admin-overblik).


{: .warning }
> ⚠️ **Husk** — Admin-ændringer rammer bredt; forstå konsekvensen, og test bagefter.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
