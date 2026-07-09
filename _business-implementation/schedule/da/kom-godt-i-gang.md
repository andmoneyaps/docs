---
layout: "default"
title: "Kom godt i gang"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 101
lang: "da"
---
# Schedule – kom godt i gang
_Overblik, bookingflows og opsætnings-rejsen · start her · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/kom-godt-i-gang.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/kom-godt-i-gang.pdf)

## Formål og værdi

**Schedule** er jeres booking-platform: den styrer, **hvornår** kunder og medarbejdere kan booke møder, **hvem** der tilbydes, og **hvor**. Denne guide er **start her** — et overblik over delene, de fire bookingflows og rækkefølgen, du sætter op i, med links til de uddybende guider.

{: .note }
> **Bemærk:** Hvor Schedule sidder: Schedule er **booking-delen**. Bookingens data gemmes i jeres **CRM** (via Playbook). **Insights** er et separat produkt (prognose for tilgængelighed), og **Present/Assist** er andre &money Engage-produkter.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/kom-godt-i-gang/schedule_oversigt.png)

*Skærmbillede 1 (Management UI) — Schedule i Management UI — menuen med Mødeopsætning, Medarbejdere, Servicegrupper, Kompetencegrupper, Portaler og Rapportering*


## De fire bookingflows — den vigtigste skelnen

Et møde kan komme i stand på fire måder. Den vigtigste skelnen er **internt vs. kundevendt**:

- **Interne møder (sagsbehandling):** en medarbejder booker internt — **springer næsten alle reglerne over**.
- **Rådgiver-booket:** en medarbejder booker for/med en kunde.
- **Kunde-booket:** kunden booker selv (fx via et direkte link).
- **Portal-møde:** kunden booker via en portal.

{: .note }
> **Bemærk:** De tre **kundevendte** flows (rådgiver, kunde, portal) bruger den **samme regel-motor** — forskellen er entry point + hvor konteksten kommer fra. **Tommelfingerregel: lær reglerne én gang; internt springer dem over.** Den fulde **bookingflow-matrix** findes i **Schedule – superbrugerguide: Mødeopsætning**.


## Schedule-områderne — og hvilken guide hører til


| Område | Hvad det er | Guide |
|---|---|---|
| Mødeopsætning | Reglerne: standardværdier, kundetyper, mødeemner, lokationer, mødekonfiguration, betjeningsniveau. | Mødeopsætning |
| Medarbejdere | Den enkelte medarbejders tilgængelighed (dage/tider/mødetyper/lokation) + kompetencer. | Medarbejdere |
| Service- og kompetencegrupper | Puljer af medarbejdere + hvad de kan; prioritet via betjeningsniveau. | Servicegrupper |
| Portaler | Den kundevendte booking-side; sender data til CRM via Playbook. | Portaler |
| Playbooks (under Admin) | Automatisk flow: portal-booking → CRM (den fremadrettede standard). | Playbooks |
| Rapportering | Statistik over de faktiske bookede møder. | Rapportering |
| Insights (eget produkt) | Prognose for fremtidig tilgængelighed; data leveres natligt via Salesforce CRM analytics. | Insights |

Hvert område har sin egen guide: **Schedule – superbrugerguide: [område]** + en tilhørende **FAQ** (Insights hedder dog blot **Insights – superbrugerguide**). Se den fulde liste under ‘Alle Schedule-guider’ nederst.


## Opsætnings-rejsen (rækkefølge på tværs)

Sæt tingene op i denne rækkefølge — hver del bygger på den forrige:

- 1. **Mødeopsætning** — sæt reglerne (Standardværdier → Kundetyper → Mødeemner → Lokationer → Mødekonfiguration → Betjeningsniveau).
- 2. **Medarbejdere** — gør medarbejderne bookbare (tilgængelighed) og tjek deres kompetencer.
- 3. **Service- og kompetencegrupper** — opret puljer med aktiveringsregler + serviceniveau, og prioritér dem i betjeningsniveau.
- 4. **Portaler** — byg den kundevendte side, og kobl den til en **Playbook** (CRM).
- 5. **Følg op** — **Rapportering** (faktiske møder) og **Insights** (prognose for tilgængelighed).

{: .note }
> **Bemærk:** Rækkefølgen afspejler afhængighederne: Standardværdier er defaults, som Mødekonfiguration overstyrer; medarbejdere/servicegrupper bygger på reglerne; portaler bygger på det hele.


## Roller

- **Manager** — bl.a. servicegrupper og rapportering.
- **Configurator** — mødeopsætning, medarbejdere, kompetence-/betjeningsniveau, portaler, insights.
- **Admin** — fuld adgang, inkl. Playbooks og logs.


## Forudsætninger (teknik)

- Managed **BookMe**-pakke installeret.
- **Entra**-roller tildelt; medarbejdere synkroniseret (Entra), lokationer/lokaler (SCIM/M365).
- **M365-kalender** forbundet (optagede tider blokerer).
- **CRM-forbindelse** (til portaler/Playbooks).


## Kort om de tekniske ord

### Ordliste
- **BookMe**: Det tekniske navn for Schedule (i koden/menuer kan du møde ‘bookme’).
- **Entra**: Microsoft Entra (tidl. Azure AD) — hvorfra medarbejdere og roller synkroniseres.
- **SCIM / M365**: Synkronisering af lokationer/lokaler og medarbejder-kalendere fra Microsoft 365.
- **Playbook**: Et automatisk flow, der sender en portal-bookings data til CRM.
- **Regel-motor**: Den fælles logik, de kundevendte flows bruger til at finde ledige tider.


## Første-gangs-tjekliste

{: .note }
> **Bemærk:** **Hurtigste vej til en testbooking:** Standardværdier → én generel mødekonfiguration → én bookbar medarbejder med de rette kompetencer → testbooking. Resten (servicegrupper, portaler, Playbook) kan komme bagefter.

- **Standardværdier** sat (åbningstider, tidszone, lukkedage, max. timer/dag).
- Mindst én **kundetype**, ét **mødeemne** og én **lokation**.
- En **mødekonfiguration** (mindst en generel) for kundetype/emne.
- **Medarbejdere** bookbare, med arbejdsdage/-tider og de rette kompetencer.
- Evt. en **servicegruppe** + prioritering i **betjeningsniveau**.
- En **portal** (+ Playbook), hvis kunderne skal selvbooke.
- En **testbooking** pr. relevant flow.


## Faldgruber på tværs

- **Internt springer reglerne over:** buffere, daglig grænse, prioritet og kundetype gælder ikke interne møder — kun lukkedage og varighed.
- **Lokationsnavn = SCIM:** skal matche præcist (versalfølsomt), ellers vises ingen medarbejdere.
- **Mangler mødekonfiguration** for en kundetype/et emne → ingen tider.
- **Mest specifikke konfiguration vinder** (emne+kundetype → kundetype → generel → standardværdier).
- **Kompetencer:** en medarbejder uden den rette kompetence tilbydes ikke i kundevendte flows.

### Se også / forudsætninger
- **Schedule – superbrugerguide: Mødeopsætning** (+ FAQ) — reglerne + bookingflow-matrix.
- **Schedule – superbrugerguide: Medarbejdere** (+ FAQ) — tilgængelighed.
- **Schedule – superbrugerguide: Servicegrupper** (+ FAQ) — puljer + betjeningsniveau.
- **Schedule – superbrugerguide: Portaler** (+ FAQ) — kundevendt side + CRM.
- **Schedule – superbrugerguide: Playbooks** (+ FAQ) — flow til CRM.
- **Schedule – superbrugerguide: Rapportering** (+ FAQ) — booking-statistik.
- **Insights – superbrugerguide** (+ FAQ) — prognose for tilgængelighed.


## Seneste opdatering

- 12.06.2026 (v1.0) — Første version (tværgående overblik).


{: .hint }
> ✅ **Start her** — følg opsætnings-rejsen, og dyk ned i den enkelte guide ved behov.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
