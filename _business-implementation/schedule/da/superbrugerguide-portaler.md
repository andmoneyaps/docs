---
layout: "default"
title: "Superbrugerguide – Portaler"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 205
lang: "da"
---
# Schedule – superbrugerguide: Portaler
_Booking-portaler + CRM Konfigurationer i Management UI · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-portaler.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-portaler.pdf)

## Formål og værdi

En **portal** er den side, hvor jeres kunder selv booker møder. Som superbruger opsætter du portalen: hvilke kunder den er til (kundedata), hvordan den ser ud (styling), hvilke felter kunden skal udfylde, og hvordan bookingens data lander i jeres CRM. Kundedata-valget styrer samtidig, hvilke tider kunden får vist.

### Ordliste
- **Portal**: Den kundevendte booking-side, hvor kunden selv vælger tid og booker et møde.
- **Kundedata**: Portalens forudvalg af kundetype, mødeemne og lokation — det scoper, hvilke tider og medarbejdere kunden får vist.
- **CRM Konfiguration**: Den ⟦gamle⟧ felt-mapning (udfases), der bestemmer, hvordan booking-data skrives til CRM. Erstattes af Playbook.
- **Login type**: Hvordan kunden logger ind på portalen: Azure AD eller MitID.
- **Portal-felter**: De felter, kunden udfylder for at booke (kan være påkrævet, valgfri eller skjult, med validering).
- **CRM oprettelsesstrategi**: Hvordan booking-data sendes til CRM: ⟦Playbook⟧ (standard fremadrettet) eller ⟦CRM-konfiguration (standard)⟧ (gammel model, udfases).
- **Playbook**: Et automatisk flow, der sender booking-data til CRM (trigger → datablokke → CRM). Oprettes under Admin → Playbooks. Den fremadrettede standard for portaler.
- **Label**: Et mærkat til at organisere og filtrere portaler.


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator (rolle **Configurator** eller **Admin**).
- Følgende er oprettet på forhånd: **kundetyper**, **mødeemner**, **lokationer**, **mødekonfiguration**, **medarbejdere** (med tilgængelighed) og evt. **servicegrupper** — de bestemmer sammen, hvilke tider portalen kan vise.
- Bruger du **CRM-konfiguration (standard)**, skal en **CRM Konfiguration** være oprettet (Trin 1).
- Managed BookMe-pakke er installeret. Mangler en forudsætning, oprettes den andetsteds i Schedule — kontakt din administrator, hvis du ikke har adgang.

{: .note }
> **Bemærk:** Brand-navnet er **Schedule**; i systemet/menuen kan du stadig møde det tidligere navn (bookme). Det er det samme produkt.

{: .note }
> **Bemærk:** Fremadrettet sender portaler booking-data til CRM via en **Playbook**. Den gamle model **CRM-konfiguration (standard)** udfases og bruges kun af enkelte kunder i en overgangsperiode.


## Dit udbytte

Efter denne guide kan du:

- Oprette en CRM Konfiguration (felt-mapning til CRM).
- Oprette en portal med kundedata, styling og felter.
- Forstå, hvordan kundedata-valget scoper de viste tider.
- Teste portalen og fejlfinde de mest gængse problemer.


## Overblik (rækkefølge)

- Trin 1: Opret en **CRM Konfiguration** (hvis du bruger CRM-konfiguration (standard)).
- Trin 2: Opret portalen — **Portal information** (navn, login, CRM-strategi).
- Trin 3: Sæt **Kundedata** (kundetype/mødeemne/lokation) — scoper tiderne.
- Trin 4: **Styling** + **Labels**.
- Trin 5: **Felter** (hvad kunden skal udfylde) + validering.
- Trin 6: Test portalen.


## Trin-for-trin (Management UI)

{: .note }
> **Bemærk:** Portalen gemmes **samlet**, når du klikker **Opret** (ny) eller **Gem** (redigér) nederst i dialogen. Lukker du dialogen eller vælger **Annuller**, gemmes ændringerne ikke — så udfyld trinnene og gem til sidst.


### Trin 1 · Forbered CRM-flowet (Playbook)

_Hvorfor: Fremadrettet bruger portaler en ⟦Playbook⟧ til at sende booking-data til CRM — et automatisk flow: kundens booking (trigger) → datablokke → CRM (kan også køre AI og hente/berige data)._

- **Playbooks** oprettes og administreres under **Admin → Playbooks** (typisk af jer sammen med &money). Sørg for, at den ønskede Playbook findes, før du opretter portalen.
- **Gammel model (udfases):** kører I stadig på **CRM-konfiguration (standard)**, opretter du i stedet en CRM Konfiguration under **Schedule → CRM Konfigurationer** → **Opret ny**: udfyld **Navn**, og map portal-felter (**Nøgle**) og **Standard felter** til CRM-felter via **Objekt** (fx Contact.Email).


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-portaler/sched_crm_konfiguration.png)

*Skærmbillede 1 (Management UI) — Schedule → CRM Konfigurationer (gammel model) — felt-mapning til CRM*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Den ønskede Playbook (eller — på den gamle model — CRM Konfiguration) findes og kan vælges på portalen.

**Eksempel:** portal-feltet **E-mail** → **Nøgle** "email" → CRM **Objekt** Contact.Email. Den samme **Nøgle** vælger du på portal-feltet i Trin 5, så feltet kobles til mapningen.


### Trin 2 · Opret portalen — Portal information

_Hvorfor: Selve portalen — navn, login og hvordan data lander i CRM._

- Gå til **Schedule** → **Portaler** → klik **Opret portal**.
- Udfyld **Navn** (portalens navn).
- Vælg **Login type**: **Azure AD** (interne/medarbejdere) eller **MitID** (borgere).
- Vælg **CRM oprettelsesstrategi** = **Playbook** (den fremadrettede standard). Selve koblingen til en konkret Playbook sker pt. i samarbejde med &money — portalens **Playbook**-vælger viser stadig “Ingen playbooks tilgængelige” og åbnes snart.
- **Gammel model:** kører I stadig på **CRM-konfiguration (standard)**, vælger du i stedet den og en **Konfiguration**.
- Sæt evt. **iCal** (kalenderfil til kunden).


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-portaler/sched_portal_information.png)

*Skærmbillede 2 (Management UI) — **Portal information** — CRM oprettelsestrategi = **Playbook** (standard) + Login type, iCal m.m.*

{: .note }
> **Bemærk:** **Playbook** er den fremadrettede standard for portaler. **CRM-konfiguration (standard)** er den gamle model, der udfases og kun bruges af enkelte kunder i en overgangsperiode.


### Trin 3 · Sæt Kundedata (scoper de viste tider)

_Hvorfor: Kundedata bestemmer, hvilke kunder portalen er til — og dermed hvilke medarbejdere og tider der vises._

- Under **Kundedata**: vælg **Kundetype** (påkrævet).
- Vælg evt. **Mødeemne** — tomt = alle mødeemner for kundetypen.
- Vælg evt. **Lokation** — tomt = kunden vælger selv lokation under booking.
- Læs den viste note om, hvilke **servicegrupper** der kan påvirke de udstillede tider.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-portaler/sched_portal_kundedata.png)

*Skærmbillede 3 (Management UI) — Portal → **Kundedata** — **Kundetype**, **Mødeemne**, **Lokation** + servicegruppe-note*

{: .note }
> **Bemærk:** **Kundedata** er det, der scoper tilgængeligheden: kundetype + (evt.) mødeemne + (evt.) lokation afgør, hvilke medarbejdere/servicegrupper — og dermed hvilke tider — kunden får vist.


### Trin 4 · Styling og labels

_Hvorfor: Giv portalen jeres udseende, og organisér den med labels._

- Åbn **Portal styling**: angiv **Logo** (en URL til billedet) og **Logo højde** (i pixels), og evt. **styling** (farver).
- Tilføj evt. **Labels** til at organisere og filtrere portaler.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-portaler/sched_portal_styling.png)

*Skærmbillede 4 (Management UI) — Portal → **Portal styling** (Logo, Logo højde, styling) + **Labels***

{: .important }
> **Husk:** **Logo** angives som en **URL** eller et indlejret billede (data-URI) — ikke en uploadet fil; **Logo højde** styrer kun størrelsen. **Styling** er valgfri og kan være avanceret CSS (fx sætter &money-portalen farverne til #004568). Farvevalg påvirker synligheden af knapper og logo — kontakt din &money-kontakt, hvis du vil have hjælp til logo eller farver.


### Trin 5 · Felter (hvad kunden skal udfylde)

_Hvorfor: Felterne er det, kunden udfylder for at booke — fx navn, e-mail, formål._

- Under **Felter**: klik **Tilføj felt**.
- Udfyld **Felt navn**, evt. **Felt beskrivelse** og **Standardværdi**, vælg **Felt type** (Tekst, Tal, Dato, Tid, m.m.) og **Rækkefølge**.
- Sæt **Påkrævet felt** og/eller **Skjult felt** efter behov.
- Tilføj evt. **Valideringer**: vælg en **predefineret regex** (CPR, e-mail, telefon, navn, URL) eller skriv dit eget **regulært udtryk** + en **Fejlbesked**.
- Knyt evt. feltet til en **Nøgle**, så det mappes til CRM via CRM Konfigurationen.


![Skærmbillede 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-portaler/sched_portal_felter.png)

*Skærmbillede 5 (Management UI) — Portal → **Felter** — felt-opsætning (navn, type, rækkefølge, påkrævet/skjult) + **Valideringer***

{: .note }
> **Bemærk:** Gør ikke et felt både **Påkrævet** og **Skjult** — kunden kan ikke udfylde et skjult felt. Skjulte felter bruges til forudfyldte/standardværdier; påkrævede felter skal være synlige.


### Trin 6 · Test portalen

_Hvorfor: Bekræft, at portalen virker, før den tages i brug._

- Åbn portalen (link-ikonet i portal-listen).
- Gennemfør en **testbooking** som en kunde af den valgte kundetype.
- Bekræft, at der vises tider, at felterne virker, og at bookingen lander korrekt i CRM.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Kunden kan se tider, udfylde felterne og booke — og data lander i CRM som forventet.

{: .note }
> **Bemærk:** Portalens kundevendte side åbnes via **Åben portal** / link-ikonet i portal-listen. Det er dét link, du deler med kunderne (fx på jeres hjemmeside eller i en e-mail).

{: .important }
> **Husk:** Skal portalen bruge **MitID**, kræver en rigtig testbooking et MitID-login. Test gerne logikken først via en **Azure AD**-portal/intern bruger.


**Tjekliste før portalen tages i brug**

- Der vises ledige tider for den valgte kundetype/mødeemne/lokation.
- Felterne vises i rigtig rækkefølge og validerer korrekt (fx CPR/e-mail).
- Login (Azure AD/MitID) virker for målgruppen.
- Bookingen lander i CRM på de rigtige felter (tjek en testbooking).


## Hvad betyder felterne? — Portal


| Felt | Hvad det styrer | Betydning (★ = påvirker tilgængelighed) |
|---|---|---|
| Navn | Portalens navn | Identifikation og visning. |
| Login type | Adgang | Azure AD (interne) eller MitID (borgere) — styrer login, ikke tilgængelighed. |
| CRM oprettelsesstrategi | Hvordan data lander i CRM | Playbook (standard) kører et automatisk flow til CRM. CRM-konfiguration (standard) (gammel model) bruger en fast felt-mapning. |
| Konfiguration | Felt-mapning til CRM | Vælges kun på den gamle model (CRM-konfiguration (standard)). |
| iCal | Kalenderfil | Om kunden får en kalenderfil for mødet. |
| Kundetype | ★ Hvem portalen er til | Scoper medarbejdere/servicegrupper og dermed de viste tider. Påkrævet. |
| Mødeemne | ★ Emne | Scoper yderligere på emne. Tom = alle emner for kundetypen. |
| Lokation | ★ Sted | Tom = kunden vælger selv. Sat = portalen booker på den lokation (kan udløse krav om ledigt lokale). |
| Logo / Logo højde / styling | Udseende | Branding. Logo kræver en URL; farver påvirker synlighed. |


## Hvad betyder felterne? — Felter og CRM Konfiguration


| Felt | Hvad det styrer | Betydning |
|---|---|---|
| Felt navn / beskrivelse | Det kunden ser | Label + hjælpetekst på feltet. |
| Felt type | Inputtype | Tekst, Tal, Dato, Tid, Tekstområde, Ja/nej. |
| Rækkefølge | Visningsorden | Lavere tal vises først. |
| Påkrævet felt | Skal udfyldes | Kunden kan ikke booke uden. |
| Skjult felt | Skjules for kunden | Til forudfyldte/standardværdier — kombinér ikke med Påkrævet. |
| Validering (regex) | Inputkontrol | Predefineret (CPR/e-mail/telefon/navn/URL) eller eget regulært udtryk + fejlbesked. |
| CRM: Nøgle / Standard felt → Objekt | Felt-mapning | Knytter et portal-felt (Nøgle) eller systemfelt (Standard felt) til et CRM-felt (Objekt, fx Contact.Email). |


## Hvad styrer de viste tider?

Portalens **Kundedata** (kundetype + evt. mødeemne + evt. lokation) afgør sammen med jeres øvrige opsætning, hvilke tider kunden får vist:

- **Kundetype** + **mødeemne** → hvilke medarbejdere er kvalificerede (via kompetencegrupper), og hvilke servicegrupper aktiveres.
- **Lokation** → medarbejdere på den lokation; kan udløse **kræv ledigt mødelokale** for fysiske møder (indstilles på lokationen under Mødeopsætning → Lokationer).
- Medarbejdernes **tilgængelighed**, mødekonfiguration (varighed, mødetyper, lead times) og lukkedage gælder altid.


## Fejlfinding

- Kunden ser ingen tider: tjek, at der er kvalificerede medarbejdere (kompetencegruppe) med tilgængelighed for portalens **kundetype/mødeemne/lokation**; ved fysisk møde — tjek **kræv ledigt mødelokale** (sættes på lokationen under **Mødeopsætning → Lokationer**, uden for Portaler).
- Logoet vises ikke: **Logo** skal være en **URL** til et billede; **Logo højde** styrer kun størrelsen.
- Et felt kan ikke udfyldes: det er sat som **Skjult** og **Påkrævet** samtidig — gør det synligt, eller fjern påkrævet.
- Data lander ikke i CRM: tjek, at portalen bruger den rette **Playbook** (eller — på den gamle model — **CRM-konfiguration (standard)** med en valgt Konfiguration).
- Jeg kan ikke vælge en konfiguration: opret en **CRM Konfiguration** først (Trin 1).
- Ingen Playbook at vælge: Playbooken skal være oprettet under **Admin → Playbooks** først — kontakt din administrator/&money.

### Se også / forudsætninger
- **Schedule – FAQ (Portaler)** — typiske spørgsmål, fejl og svar.
- **Schedule – superbrugerguide: Servicegrupper** — servicegrupper påvirker de tider, portalen viser.
- **Schedule – Playbooks** — kommende guide til opsætning af Playbooks (Admin → Playbooks).
- **Schedule – superbrugerguide (samlet opsætning)** — kommende guide (standardværdier, kundetyper, lokationer, mødeemner, tilgængelighed).


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (portaler + CRM konfigurationer).


{: .hint }
> ✅ **Færdig!** Portalen er klar til jeres kunder.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
