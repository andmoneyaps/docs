---
layout: "default"
title: "Superbrugerguide – Medarbejdere"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 202
lang: "da"
---
# Schedule – superbrugerguide: Medarbejdere
_Tilgængelighed, arbejdstid, mødetyper og lokationer i Management UI · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-medarbejdere.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-medarbejdere.pdf)

## Formål og værdi

På **Medarbejdere** styrer du den enkelte medarbejders **tilgængelighed**: om medarbejderen overhovedet kan bookes, hvornår (dage og tider), til hvilke **mødetyper** og på hvilke **lokationer**. Det er her, du bestemmer, hvilke ledige tider kunderne får vist — så denne skærm er motoren bag tilgængeligheden.

### Ordliste
- **Medarbejder**: En person, der kan bookes til kundemøder. Medarbejdere synkroniseres ind fra jeres Entra (AD) — du opsætter deres tilgængelighed her.
- **Kan bookes**: Hovedkontakten: om medarbejderen overhovedet kan bookes til kundemøder. Slået fra = vises aldrig.
- **Specifik medarbejder**: Medarbejderen vises kun, hvis kunden/medarbejderen vælger personen specifikt ved navn — ikke i den almene pulje.
- **Arbejdsdage / Arbejdstid**: De dage og det tidsrum, medarbejderen kan bookes inden for. Kan sættes ens for alle dage eller pr. dag.
- **Mødetyper**: Fysisk, Online, Telefon eller Offsite — hvad medarbejderen kan bookes til.
- **Lokation**: Den lokation, medarbejderen er tilgængelig for møder på (kan variere pr. dag).
- **Max. timer pr. dag**: Loft over, hvor mange timers kundemøder medarbejderen kan bookes til pr. dag.
- **Grupper**: Read-only oversigt over de kompetence- og servicegrupper, medarbejderen er med i (styrer emner/kundetyper og puljer).


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator (rolle **Configurator** eller **Admin**).
- Medarbejdere **synkroniseres fra Entra** (AD) og vises i feltet **Vælg medarbejder** — du opretter dem ikke her, men opsætter deres tilgængelighed.
- Følgende bør være oprettet: **lokationer**, **kompetencegrupper** (emner + kundetyper) og evt. **servicegrupper** — de afgør sammen med tilgængeligheden, hvilke tider der vises.
- Mangler en medarbejder i listen, er det typisk en synk-sag — kontakt din administrator.

{: .note }
> **Bemærk:** Brand-navnet er **Schedule**; i systemet/menuen kan du stadig møde det tidligere navn (bookme). Det er det samme produkt.


## Dit udbytte

Efter denne guide kan du:

- Slå en medarbejder til/fra for booking og styre, om de kun kan vælges specifikt.
- Sætte arbejdsdage, arbejdstid, mødetyper og lokation — ens eller pr. dag.
- Sætte et loft for max. timer pr. dag.
- Aflæse medarbejderens grupper og fejlfinde, hvorfor en medarbejder ikke vises.


## Overblik (rækkefølge)

- Trin 1: **Vælg medarbejder**.
- Trin 2: **Kan medarbejderen bookes?** (og evt. kun som specifik medarbejder).
- Trin 3: **Arbejdsdage** og **arbejdstid** (ens eller særlige regler pr. dag).
- Trin 4: **Mødetyper** og **lokation** (ens eller pr. dag).
- Trin 5: **Max. timer pr. dag**.
- Trin 6: **Gem** — og tjek medarbejderens **grupper**.


## Trin-for-trin (Management UI)

{: .note }
> **Bemærk:** Ændringer gemmes, når du klikker **Gem** nederst (kvittering: **Tilgængelighed opdateret** = ændringen er gemt). Kundevisningen kan være et øjeblik (typisk få minutter) om at følge med. Forlader du siden med **ugemte ændringer**, advarer systemet dig.


### Trin 1 · Vælg medarbejder

_Hvorfor: Find den medarbejder, du vil opsætte tilgængelighed for._

- Gå til **Schedule** → **Medarbejdere** (afsnittet **Kalender og tilgængeligheder**).
- Søg i **Vælg medarbejder** på navn, initialer eller e-mail.
- Medarbejderens opsætning vises herunder. Siden har to faner: **Tilgængelighed** (indstillinger) og **Grupper** (read-only medlemskaber).


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-medarbejdere/sched_medarb_vaelg.png)

*Skærmbillede 1 (Management UI) — Schedule → Medarbejdere — **Vælg medarbejder** + medarbejderens tilgængelighed*

{: .note }
> **Bemærk:** **Labels** (lige under medarbejder-valget) er valgfrit og bruges kun til at organisere/filtrere medarbejdere — det påvirker ikke booking.


### Trin 2 · Kan medarbejderen bookes?

_Hvorfor: Hovedkontakten for, om medarbejderen indgår i booking — og om de kun kan vælges specifikt._

- Under **Kundemøder**: sæt **Kan medarbejderen bookes til kundemøder** til **Ja** (**Nej** = medarbejderen vises aldrig).
- Under **Specifikke tilgængeligheder**: sæt evt. **Kan kun bookes som specifik medarbejder** til **Ja** — så vises medarbejderen kun, når de vælges specifikt ved navn (ikke i den almene pulje).
- Sæt evt. **Kan medarbejderen tage opkald fra udlandet** (global tilgængelighed) efter behov.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-medarbejdere/sched_medarb_kundemoeder.png)

*Skærmbillede 2 (Management UI) — **Kundemøder** (Kan bookes) + **Specifikke tilgængeligheder** (kun specifik medarbejder)*

{: .note }
> **Bemærk:** **Kan medarbejderen bookes** er hovedkontakten: står den på **Nej**, vises medarbejderen ikke, uanset alt andet.


### Trin 3 · Arbejdsdage og arbejdstid

_Hvorfor: Hvilke dage og inden for hvilket tidsrum medarbejderen kan bookes._

- Under **Arbejdsdage**: vælg de dage, medarbejderen er tilgængelig (fravalgt dag = ingen tider den dag).
- Under **Arbejdstid**: sæt **Fra klokken** og **Til klokken** — gælder som udgangspunkt alle arbejdsdage.
- Vil du have forskellige tider pr. dag: sæt **Opsæt særlige regler**, så kan hver dag have sit eget tidsrum.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-medarbejdere/sched_medarb_arbejdstid.png)

*Skærmbillede 3 (Management UI) — **Arbejdsdage** + **Arbejdstid** (Fra/Til klokken) med **Opsæt særlige regler***

{: .important }
> **Husk:** **Opsæt særlige regler** lader dig sætte tider (og mødetyper/lokation) **pr. dag** i stedet for ét fælles. Slår du det til, så **udfyld hver relevant dag** — en dag, du ikke udfylder, giver ingen tider. Slår du det fra igen, gælder det fælles tidsrum.


### Trin 4 · Mødetyper og lokation

_Hvorfor: Hvad medarbejderen kan bookes til — og hvor._

- Under **Mødetyper**: vælg **Fysisk**, **Online**, **Telefon** og/eller **Offsite** (kun valgte typer tilbydes).
- Under **Lokation**: vælg den/de lokationer, medarbejderen er tilgængelig på (tom = medarbejderens standard-lokation).
- Begge kan sættes ens for alle dage eller pr. dag via **Opsæt særlige regler**.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-medarbejdere/sched_medarb_modetyper_lokation.png)

*Skærmbillede 4 (Management UI) — **Mødetyper** (Fysisk/Online/Telefon/Offsite) + **Lokation***

{: .note }
> **Bemærk:** Standarder, du arver: tom **Lokation** = medarbejderens **standard-lokation** fra profilen; **Ingen tilsidesættelse (brug standard)** under Max. timer = den organisations-standard, der er sat under **Mødeopsætning → Standardværdier**.


### Trin 5 · Max. timer pr. dag

_Hvorfor: Et valgfrit loft over, hvor mange timers kundemøder medarbejderen kan bookes til pr. dag._

- Under **Max. timer pr. dag**: vælg et loft, eller behold **Ingen tilsidesættelse (brug standard)**.
- Er loftet nået for en dag, vises ingen flere tider den dag.

{: .note }
> **Bemærk:** **Max. timer pr. dag** gælder kun **kundemøder** — interne møder tæller ikke med. Er medarbejderen i en servicegruppe, gælder den højeste grænse.


### Trin 6 · Gem og tjek grupper

_Hvorfor: Gem opsætningen, og aflæs medarbejderens grupper._

- Klik **Gem** — du får kvitteringen **Tilgængelighed opdateret**.
- Klik fanen **Grupper** (øverst) — her ser du (read-only) medarbejderens **Kompetencegrupper** (direkte og arvede) og **Servicegrupper**.
- Mangler en kompetence/servicegruppe, tilføjes medarbejderen på selve gruppen (ikke her).


![Skærmbillede 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-medarbejdere/sched_medarb_grupper.png)

*Skærmbillede 5 (Management UI) — **Grupper** — read-only oversigt over Kompetencegrupper (direkte/arvet) og Servicegrupper*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Tilgængeligheden er gemt, og medarbejderens grupper ser rigtige ud.

**Eksempel:** Gør en medarbejder bookbar **mandag–torsdag 09–15** til **Fysisk** + **Online** på **Filial Aarhus**, max **4 timer/dag**: Trin 2 Kan bookes = Ja; Trin 3 vælg man–tor + arbejdstid 09–15; Trin 4 mødetyper Fysisk+Online, lokation Filial Aarhus; Trin 5 max 4 timer; Trin 6 Gem.


## Hvad betyder felterne?


| Felt | Hvad det styrer | Betydning (★ = påvirker tilgængelighed) |
|---|---|---|
| Kan medarbejderen bookes | Hovedkontakt | ★ Nej = medarbejderen vises aldrig. Ja = indgår (afhænger af resten). |
| Kan kun bookes som specifik medarbejder | Synlighed | ★ Ja = vises kun ved specifikt valg ved navn, ikke i den almene pulje. |
| Kan tage opkald fra udlandet | Global tilgængelighed | Om medarbejderen kan tages med i bookinger på tværs af grænser. |
| Arbejdsdage | Dage | ★ Kun valgte dage giver tider. Fravalgt dag = ingen tider. |
| Arbejdstid (Fra/Til klokken) | Tidsrum | ★ Kun tider inden for vinduet vises. Kan sættes pr. dag. |
| Mødetyper | Kanal | ★ Kun valgte typer (Fysisk/Online/Telefon/Offsite) tilbydes. |
| Lokation | Sted | ★ Medarbejderen vises kun for bookinger på den/de valgte lokationer. |
| Max. timer pr. dag | Dagligt loft | ★ Når loftet er nået, vises ingen flere tider den dag (kun kundemøder). |
| Opsæt særlige regler | Pr.-dag-styring | Slå til for at sætte forskellige tider/mødetyper/lokation pr. dag. |
| Grupper (Kompetence-/Service-) | Emner/kundetyper/puljer | Read-only her. Styrer hvilke emner/kundetyper medarbejderen kan tage, og hvilke puljer de indgår i. |


## Hvad styrer de viste tider?

En tid vises kun, når **alle** betingelser er opfyldt for medarbejderen:

- **Kan bookes** = Ja, og (hvis relevant) medarbejderen er ikke sat til kun-specifik.
- Dagen er en **arbejdsdag**, og tiden ligger inden for **arbejdstiden**.
- Den ønskede **mødetype** og **lokation** er valgt for medarbejderen (den dag).
- **Max. timer pr. dag** er ikke nået.
- Medarbejderen er kvalificeret via **kompetencegruppe** (emne + kundetype) — og evt. aktiveret via **servicegruppe**.
- Medarbejderens **kalender** (Outlook) er fri på tidspunktet.


## Fejlfinding


**Medarbejderen vises ikke i tilgængelighed**

Tjek i denne rækkefølge (hyppigst først):

- **Kan medarbejderen bookes** står på **Nej** → sæt til **Ja**.
- Medarbejderens **Outlook-kalender** er optaget (også heldags-/tentative aftaler kan blokere) → tjek kalenderen.
- Den ønskede **mødetype** eller **lokation** er ikke valgt for dagen (fx kun Online, men kunden vil Fysisk) → tilføj dem.
- Medarbejderen er sat til **kun specifik** → vises kun ved specifikt valg ved navn.
- Ingen **kompetencegruppe** matcher emne/kundetype → tilføj til den rette gruppe.
- Bookingen kræver en **servicegruppe** (fx fjern-/national pulje), og medarbejderen er ikke med i en aktiveret gruppe → tilføj/aktivér gruppen.
- **Arbejdsdag** ikke valgt, eller tiden ligger uden for **arbejdstiden** → justér dage/tider.
- **Max. timer pr. dag** er nået (kan give tomme eftermiddage) → vent på ny dag eller hæv loftet.
- **Særlige regler pr. dag**: en dag mangler mødetype/lokation/tid → udfyld dagen.


**Ændringer slår ikke igennem**

- Husk at klikke **Gem** (kvittering: **Tilgængelighed opdateret**).
- Bruger du **særlige regler pr. dag**, så tjek, at du har redigeret den rigtige dag.
- Ændringer kan tage et øjeblik at slå igennem i booking — prøv en ny søgning/opdatér.


**Medarbejderen mangler i listen**

Medarbejdere kommer fra **Entra** (synk). Mangler en person, er det en synk-/adgangs-sag — kontakt din administrator.

### Se også / forudsætninger
- **Schedule – FAQ (Medarbejdere)** — typiske spørgsmål, fejl og svar.
- **Schedule – superbrugerguide: Servicegrupper** — puljer og prioritet.
- **Schedule – superbrugerguide: Portaler** — den kundevendte booking-side.


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (medarbejder-tilgængelighed).


{: .hint }
> ✅ **Færdig!** Medarbejderens tilgængelighed er sat op og gemt.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
