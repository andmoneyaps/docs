---
layout: "default"
title: "Superbrugerguide"
parent: "Dansk"
grand_parent: "Insights"
nav_order: 201
lang: "da"
---
# Insights – superbrugerguide
_Opsætning af datasæt til medarbejder-tilgængelighed · data leveres natligt · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/insights/da/superbrugerguide.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/insights/da/superbrugerguide.pdf)

## Formål og værdi

**Insights** danner et datasæt om jeres medarbejderes tilgængelighed et stykke tid frem (typisk omkring 60 dage): **hvornår** er der ledige tider, og **hvorfor** er der ikke (fx uden for arbejdstid, optaget, eller ikke kvalificeret). I Management UI **opsætter** du datasættene — selve dataet **leveres til jer hver nat** via **Salesforce CRM analytics**, hvor I selv analyserer det.

{: .note }
> **Bemærk:** Der er **ikke** en resultat- eller analyseskærm i Management UI til jer. I Management UI opretter og vedligeholder I **opsætningerne**; den detaljerede analyse foregår i **Salesforce CRM analytics**, hvor data leveres til hver nat.

### Ordliste
- **Insight-opsætning**: Et datasæt, du definerer (kundetype + mødeemne + mødekonfiguration), som danner grundlag for analysen.
- **Datakørsel**: Insights genererer data automatisk (natligt). ⟦Seneste datakørsel⟧ viser, hvornår det sidst skete.
- **Brugsscenarie**: Om datasættet skal indeholde ⟦alle⟧ tider med årsag (Fuldt datasæt) eller ⟦kun ledige⟧ (Kun tilgængelige møder).
- **Årsag**: Hvorfor en tid ikke er ledig (fx Udenfor arbejdstid, Optaget, Ikke kvalificeret) — eller Tilgængelig.
- **Mødekonfiguration**: De regler (åbningstid, varighed, buffere, mødetyper m.m.), simuleringen regner med.


## Målgruppe og forudsætninger

- Målgruppe: **Configurator** eller **Admin**.
- Schedule skal være sat op: **kundetyper**, **mødeemner**, **mødekonfiguration**, **medarbejdere** (med kompetencer + kalender) og **lokationer** — Insights bygger oven på disse data.
- Data genereres **automatisk (natligt)** pr. opsætning og **leveres til jer via Salesforce CRM analytics**.
- En ny opsætning leverer først data efter første natkørsel.

{: .note }
> **Bemærk:** Insights tilgås i menuen under **Insights → Opsætning**.


## Dit udbytte

Efter denne guide kan du:

- Oprette en Insight-opsætning (kundetype, mødeemne, mødekonfiguration, brugsscenarie).
- Forstå, hvornår og hvordan data genereres og leveres.
- Forstå, hvad datasættet indeholder (dimensioner og ‘årsager’).
- Fejlfinde de typiske problemer.


## Opret en Insight-opsætning


### Trin 1 · Start en ny opsætning og vælg datasæt

_Hvorfor: Opsætningen bestemmer, hvilket scenarie analysen simulerer._

- Gå til **Insights** → **Opsætning** → klik **Opret ny**.
- Under **Opsætning**: vælg **Kundetype**, **Mødeemne** og **Tidszone** (standard Europe/Copenhagen).
- Bemærk tooltippen: i datasættet medregnes medarbejdernes **kompetencegruppe-tilhør** ikke i tilgængelighedsberegningen, hvis du vælger at ignorere kompetencegrupper.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/insights/da/superbrugerguide/insights_opret.png)

*Skærmbillede 1 (Management UI) — Insights → Opsætning → **Opret Insight opsætning** — Navn, Kundetype, Tidszone, Brugsscenarie og Mødekonfiguration*


### Trin 2 · Navngiv og sæt mødekonfiguration

_Hvorfor: Mødekonfigurationen styrer de regler, simuleringen regner med._

- Giv opsætningen et **Navn**.
- Under **Mødekonfigurationer**: vælg en eksisterende konfiguration eller opsæt en ny — **Åbningstid**, **Lukketid**, **Mødets varighed**, **Tid mellem møder**, bufferne (**Arbejdstid/Kalendertid fra booking til møde**, evt. **ekskl. weekend**), **Maks mødetid pr. dag** og **Mødetyper**.


### Trin 3 · Vælg brugsscenarie og valgmuligheder

_Hvorfor: Brugsscenariet bestemmer, hvad datasættet indeholder._

- Vælg **Brugsscenarie**: **Fuldt datasæt** (alle tidspunkter med en årsag) eller **Kun tilgængelige møder** (kun de ledige).
- Sæt evt. **Ignorér kompetence grupper** (brug det, når du vil se den **rå kapacitet** uanset kompetencer) og **Inkludér ‘Kan kun bookes specifikt’ medarbejdere** (når du også vil have specialist-medarbejdere med).

{: .note }
> **Bemærk:** **Fuldt datasæt** er bedst, når I vil forstå **hvorfor** tider ikke er ledige (årsager). **Kun tilgængelige møder** fokuserer på den reelle ledige kapacitet.


### Trin 4 · Opret — og vent på datakørslen

_Hvorfor: Opsætningen gemmes og kører automatisk._

- Klik **Opret insights indstilling** (kvittering: **Insights indstillingen oprettet**).
- Opsætningen vises i listen med **Navn**, **Kundetype** og **Seneste datakørsel**.
- Data genereres natligt — en opsætning oprettet i dag leverer først data efter **næste** natkørsel (typisk i morgen).


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/insights/da/superbrugerguide/insights_opsaetning.png)

*Skærmbillede 2 (Management UI) — Insights → Opsætning — listen med **Navn**, **Kundetype** og **Seneste datakørsel***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Opsætningen er oprettet og vises i listen — og data leveres ved næste natkørsel.


## Sådan leveres og bruges data

Når opsætningen er kørt (natligt), **leveres datasættet til jer via Salesforce CRM analytics**. Dér bygger I selv dashboards, analyser og rapporter på data — fx ledig kapacitet pr. ugedag, eller hvilke **årsager** der oftest blokerer tider.

- Datasættet indeholder pr. medarbejder og tidspunkt: **ugedag**, **tidspunkt på dagen**, **lokation**, **mødetype**, **startdato** og varighed.
- Hver tid har en **årsag**: enten **Tilgængelig** eller hvorfor den ikke er ledig (se tabellen nedenfor).
- **Seneste datakørsel** i listen viser, hvornår data sidst blev dannet og leveret.

{: .note }
> **Bemærk:** Den detaljerede analyse (filtre, grupperinger, diagrammer) foregår i **Salesforce CRM analytics** — ikke i Management UI.


## Årsager i datasættet

Hver tid i datasættet har en **årsag** — den er enten tilgængelig, eller også forklarer årsagen, hvorfor den ikke er ledig:


| Årsag | Betydning |
|---|---|
| Tilgængelig | Tiden er ledig. |
| Reserveret/Booket | Allerede optaget af et møde. |
| Optaget | Optaget i kalenderen (ekstern aftale). |
| Bank lukket | Lukkedag. |
| Udenfor arbejdstid | Uden for medarbejderens arbejdstid. |
| Indenfor arbejdstid | Inden for arbejdstid (men evt. blokeret af anden årsag). |
| Maks møder pr. dag | Dagens loft for mødetid er nået. |
| Mødetype utilgængelig | Den ønskede mødetype tilbydes ikke. |
| Ugedag utilgængelig | Medarbejderen arbejder ikke den dag. |
| Ikke kvalificeret | Medarbejderen har ikke kompetencen (emne/kundetype). |
| Kan ikke bookes | Medarbejderen kan ikke bookes til kundemøder. |
| Arbejder et andet sted | Medarbejderen er på en anden lokation. |
| Arbejdstidsbuffer / Kalendertidsbuffer | For tæt på nu — buffer fra booking til møde. |
| Tid mellem møder | Blokeret af pausen mellem møder. |
| Ingen / Ukendt | Ingen eller ukendt årsag. |

{: .note }
> **Bemærk:** **Sådan retter du de hyppigste årsager (i Schedule):** **Optaget** → medarbejderens Outlook-kalender; **Ikke kvalificeret** → kompetencer (Schedule → Medarbejdere/Kompetencegrupper); **Udenfor arbejdstid**/**Ugedag utilgængelig** → arbejdsdage/-tid; **Kan ikke bookes** → indstillingen ‘Kan medarbejderen bookes’.


## Hvad betyder felterne? — Opsætning


| Felt | Hvad det styrer |
|---|---|
| Kundetype + Mødeemne | Hvilket scenarie der simuleres (hvilke medarbejdere/konfiguration der gælder). |
| Tidszone | Hvordan tidspunkter angives i data. |
| Åbningstid / Lukketid | Det tidsrum, simuleringen regner som muligt. |
| Mødets varighed / Tid mellem møder | Mødelængde og pause mellem møder. |
| Arbejdstid / Kalendertid fra booking til møde | Buffer (varsel) fra booking til mødet kan holdes. |
| Maks mødetid pr. dag | Loft for mødetid pr. dag pr. medarbejder. |
| Mødetyper | Hvilke mødetyper (Online/Fysisk/Telefon/Offsite) der indgår. |
| Brugsscenarie | Fuldt datasæt (alle tider m. årsag) eller Kun tilgængelige møder. |
| Ignorér kompetence grupper | Om kompetencegruppe-tilhør udelades i beregningen. |


## Godt at vide

- **Natlig kørsel + levering:** data genereres automatisk og leveres til Salesforce CRM analytics; en ny opsætning leverer først data efter første kørsel (se **Seneste datakørsel**).
- **Simulering frem i tid:** Insights forudser tilgængelighed et stykke frem (typisk ~60 dage).
- **Kompetencer betyder noget:** en medarbejder uden den rette kompetence (emne/kundetype) tæller som **Ikke kvalificeret** — medmindre du har valgt at ignorere kompetencegrupper.
- **Rediger/slet:** du kan se, redigere eller slette en opsætning via ikonerne i listen.


## Fejlfinding

- ‘Fejl ved oprettelse af insights indstillingen’: et påkrævet felt mangler (kundetype, mødeemne, tidszone, mødetyper) eller en ugyldig tid/varighed → tjek felterne.
- Datasættet er ikke kommet / mangler i Salesforce: tjek **Seneste datakørsel** — er den tom eller gammel, kan natkørslen være fejlet → kontakt din administrator (Admin → Logs) eller support.
- En medarbejder mangler i datasættet: medarbejderen har ikke den rette **kompetence** (emne/kundetype) for opsætningen, eller kan ikke bookes → tjek Schedule → Medarbejdere.
- Tallene passer ikke med faktiske bookinger: Insights er en **simulering** af fremtidig tilgængelighed — til faktiske, bookede møder bruger du **Rapportering**.

### Se også / forudsætninger
- **Insights – FAQ** — typiske spørgsmål, fejl og svar.
- **Schedule – superbrugerguide: Medarbejdere** — tilgængelighed og kompetencer, Insights bygger på.
- **Schedule – superbrugerguide: Rapportering** — booking-statistik (faktiske møder).


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (Insights-opsætning + natlig datalevering).


{: .hint }
> ✅ **Færdig!** Din Insight-opsætning er oprettet — data leveres ved næste natkørsel.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
