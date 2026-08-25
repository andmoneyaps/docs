---
layout: "default"
title: "Superbrugerguide – Servicegrupper"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 207
lang: "da"
---
# Schedule – superbrugerguide: Servicegrupper
_Servicegrupper, kompetencegrupper og betjeningsniveau i Management UI · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-servicegrupper.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-servicegrupper.pdf)

## Formål og værdi

En **servicegruppe** er en pulje af medarbejdere, der kan betjene kunder på tværs af afdelinger. Når der ikke er ledig tid hos en lokal medarbejder, kan kunden i stedet bookes hos en kvalificeret medarbejder fra en servicegruppe. Som superbruger styrer du, **hvornår** en servicegruppe aktiveres (aktiveringsregler), **hvad** den tilbyder (serviceniveau), **hvem** den består af (medarbejdere/kompetencegrupper), og **i hvilken rækkefølge** den tilbydes (betjeningsniveau).

### Ordliste
- **Servicegruppe**: En pulje af medarbejdere, der aktiveres for en booking ud fra regler og tilbyder et bestemt serviceniveau.
- **Kompetencegruppe**: En gruppering af medarbejdere med kompetencer (mødeemner + kundetyper) — dvs. hvad de kan afholde møder om. Kan tilføjes en servicegruppe samlet.
- **Aktiveringsregler**: Betingelser (lokation, kundetype, mødeemne), der bestemmer, hvornår en servicegruppe aktiveres for en booking.
- **Serviceniveau**: Hvad servicegruppen tilbyder: hvilke mødetyper og lokationer kunden kan booke.
- **Betjeningsniveau**: Prioritetsrækkefølgen for, hvem kunden tilbydes (Eksplicit valgt → Lokal rådgiver → Servicegruppe via label).
- **Label**: Et mærkat på en service-/kompetencegruppe, der bruges til at prioritere grupper i betjeningsniveauet.
- **Mødetype**: Online, Fysisk, Telefon eller Off site.


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator, der opsætter Schedule.
- Roller: **Servicegrupper** kræver rollen **Manager** eller **Admin**; **kompetencegrupper** og **betjeningsniveau** kan tilgås af **Configurator** eller **Admin**.
- Følgende er oprettet på forhånd: **kundetyper**, **lokationer**, **mødeemner** og **medarbejdere** (med tilgængelighed). **Kompetencegrupper** anbefales. Mangler noget af det, oprettes det andetsteds i Schedule — kontakt din administrator, hvis du ikke har adgang.
- Managed Schedule-pakke er installeret (fuld funktion).

{: .note }
> **Bemærk:** Brand-navnet er **Schedule**; i selve systemet/menuen kan du stadig møde det tidligere navn (schedule). Det er det samme produkt.


## Dit udbytte

Efter denne guide kan du:

- Oprette en kompetencegruppe og en servicegruppe.
- Sætte aktiveringsregler og serviceniveau, så de rette kunder tilbydes de rette medarbejdere.
- Prioritere servicegrupper i betjeningsniveauet med labels.
- Forstå, hvad hver indstilling betyder for tilgængeligheden — og fejlfinde de mest gængse problemer.


## Overblik (rækkefølge)

- Trin 1: Opret **kompetencegrupper** (anbefalet — så medarbejderpuljer er nemme at vedligeholde).
- Trin 2: Opret **servicegruppen** (navn, e-mail, labels, medarbejdere, max timer).
- Trin 3: Sæt **aktiveringsregler** (hvornår gruppen aktiveres).
- Trin 4: Sæt **serviceniveau** (hvad gruppen tilbyder).
- Trin 5: Prioritér i **betjeningsniveau** (rækkefølgen kunden tilbydes).


## Sådan hænger det sammen

- **Kompetencegruppe** = **hvad** medarbejderne kan (mødeemner + kundetyper).
- **Servicegruppe** = **hvem** der tilbydes (medlemmer) + **hvornår** (aktiveringsregler) + **hvad** (serviceniveau).
- **Betjeningsniveau** = **i hvilken rækkefølge** kunden tilbydes (lokal medarbejder før servicegruppe osv.).


## Trin-for-trin (Management UI)


### Trin 1 · Opret en kompetencegruppe (anbefalet)

_Hvorfor: Kompetencegrupper gør det nemt at styre, hvad medarbejderne kan — og at tilføje hele puljer til en servicegruppe._

- Gå til **Schedule** → **Kompetencegrupper** → klik **Opret**.
- Udfyld **Navn**, og tilføj evt. **Labels**.
- Under **Kompetencer**: vælg de **Mødeemner** og **Kundetyper**, medarbejderne kan afholde møder om.
- Under **Medlemskaber**: tilføj **Medarbejdere** (og evt. **Undergrupper** — deres medarbejdere arver gruppens kompetencer).


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-servicegrupper/sched_kompetencegruppe.png)

*Skærmbillede 1 (Management UI) — Schedule → Kompetencegrupper — opret/redigér med **Kompetencer** (mødeemner + kundetyper) og **Medarbejdere***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Kompetencegruppen vises i listen med antal undergrupper og medarbejdere.


### Trin 2 · Opret servicegruppen

_Hvorfor: Selve servicegruppen — navn, medlemmer og evt. en daglig tidsgrænse._

- Gå til **Schedule** → **Servicegrupper** → klik **Opret**.
- **Generel:** udfyld **Navn** og evt. **E-mail for servicegruppen** (så interne medarbejdere kan selv-booke via gruppen).
- **Labels:** tilføj labels (bruges til at prioritere gruppen i betjeningsniveauet).
- **Medarbejdere:** tilføj enkelte **Medarbejdere** og/eller **Kompetencegrupper** (alle medarbejdere fra gruppen tilknyttes).
- **Max. timer pr. dag:** vælg evt. en grænse, ellers **Ingen tilsidesættelse (brug standard)**.
- Gem servicegruppen.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-servicegrupper/sched_servicegruppe_opret.png)

*Skærmbillede 2 (Management UI) — Dialogen **Opret servicegruppe** — **Generel**, **Labels**, **Medarbejdere** + **Kompetencegrupper** og **Max. timer pr. dag***

{: .note }
> **Bemærk:** **Aktiveringsregler** og **Serviceniveau** kan først sættes, **når servicegruppen er oprettet** — derfor: gem først, redigér så (Trin 3–4).


### Trin 3 · Sæt aktiveringsregler (hvornår aktiveres gruppen?)

_Hvorfor: Aktiveringsreglerne bestemmer, hvilke bookinger servicegruppen kommer i spil for._

- Åbn servicegruppen igen (redigér).
- Under **Aktiveringsregler**: vælg de **Steder** (lokationer), **Kundetyper** og/eller **Mødeemner**, der skal aktivere gruppen.
- Gruppen aktiveres, når **mindst én** af de valgte regler er opfyldt (reglerne ‘eller’-sammensættes).
- Gem.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-servicegrupper/sched_servicegruppe_aktivering.png)

*Skærmbillede 3 (Management UI) — Servicegruppe → **Aktiveringsregler** — **Steder**, **Kundetyper** og **Mødeemner***

{: .note }
> **Bemærk:** Lader du **Steder** stå tom, kan gruppen servicere **alle** lokationer, der opfylder de øvrige regler. Sæt reglerne bevidst, så gruppen ikke aktiveres for bredt.


### Trin 4 · Sæt serviceniveau (hvad tilbyder gruppen?)

_Hvorfor: Serviceniveauet styrer, hvilke mødetyper og lokationer der vises tid for._

- Stadig i redigér: under **Serviceniveau** vælg **Mødetyper** (Online, Fysisk, Telefon, Off site).
- Vælg **Lokationer** — de mødesteder kunden kan vælge ved **fysiske** møder.
- Gem.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-servicegrupper/sched_servicegruppe_serviceniveau.png)

*Skærmbillede 4 (Management UI) — Servicegruppe → **Serviceniveau** — **Mødetyper** og **Lokationer***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Servicegruppen vises i listen med medarbejderantal og er nu klar til at indgå i bookinger.

{: .note }
> **Bemærk:** Under **Serviceniveau** skal du aktivt **vælge mindst én mødetype**, som servicegruppen kan håndtere. Vælger du **Fysisk**, skal du også tilføje **lokationer** — ellers vises der ingen fysiske tider. Et tomt serviceniveau giver ingen tider.


### Trin 5 · Prioritér i betjeningsniveauet

_Hvorfor: Betjeningsniveauet bestemmer rækkefølgen, kunden tilbydes medarbejdere i — fx lokal medarbejder før servicegruppe._

- Gå til **Schedule** → **Mødeopsætning** → **Serviceniveau**. Selve afsnittet hedder **Betjeningsniveau** (samme skærm).
- Tilføj/justér prioritetsniveauer med **Tilføj betjeningsniveau** og **pilene** (øverst = højest prioritet).
- Pr. niveau: vælg **Type** (**Eksplicit valgt**, **Lokal rådgiver** eller **Servicegruppe**), skriv en **Beskrivelse**, og vælg **Label** (kun for type Servicegruppe). **Vælg den samme label, du gav servicegruppen i Trin 2** — det er koblingen mellem servicegruppen og dens prioritet.
- Gem.


![Skærmbillede 5]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-servicegrupper/sched_betjeningsniveau.png)

*Skærmbillede 5 (Management UI) — **Betjeningsniveau** — prioritetsniveauer med **Type**, **Beskrivelse** og **Label** + pile til rækkefølge*

{: .note }
> **Bemærk:** **Eksplicit valgt** og **Lokal rådgiver** kan kun optræde én gang hver; **Servicegruppe** kan optræde flere gange (med hver sin label) — så du kan lave primære, sekundære osv. servicegrupper.


### Trin 6 · Test, at det virker

_Hvorfor: Bekræft, at servicegruppen rent faktisk tilbydes, før du stoler på den i drift._

- Lav en **testbooking** som en kunde af den kundetype/lokation/mødeemne, der matcher aktiveringsreglerne.
- Bekræft, at der vises ledige tider fra servicegruppen (og i den rigtige prioritet).
- Vises der ingen tider, så tjek aktiveringsregler, serviceniveau (mødetyper + lokationer) og medlemmernes tilgængelighed.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Kunden tilbydes tider fra servicegruppen som forventet — så er opsætningen i mål.

**Eksempel — Servicegruppe “Bolig Vest”:** aktiveringsregler = kundetype **Privat** + lokation **Aarhus** + mødeemne **Boliglån**; serviceniveau = mødetyper **Online** + **Fysisk** og lokationer **Aarhus**; label **sekundaer**; i betjeningsniveauet ligger label **sekundaer** under **Lokal rådgiver**.


## Hvad betyder felterne? — Servicegruppe


| Felt | Hvad det styrer | Betydning (★ = påvirker tilgængelighed) |
|---|---|---|
| Navn | Visningsnavn | Vises i admin og over for kunden. Brug et sigende navn. |
| E-mail for servicegruppen | Intern selv-booking | Medarbejdere kan booke møder via gruppen på denne e-mail. Valgfri. |
| Labels | Prioritering | ★ Bruges i betjeningsniveauet til at rangere gruppen (primær/sekundær). |
| Medarbejdere | Medlemspulje | ★ De medarbejdere (direkte + via kompetencegrupper), der kan tilbydes. |
| Kompetencegrupper | Medlemspulje (samlet) | ★ Alle medarbejdere fra gruppen tilknyttes servicegruppen. |
| Max. timer pr. dag | Daglig tidsgrænse | ★ Begrænser, hvor meget tid medlemmerne kan bookes pr. dag. Tom = standard; flere grupper = højeste grænse; individuel grænse vinder. |


## Hvad betyder felterne? — Aktiveringsregler og serviceniveau


| Felt | Hvad det styrer | Betydning (★ = påvirker tilgængelighed) |
|---|---|---|
| Aktivering: Steder | Hvornår (lokation) | ★ Gruppen aktiveres for disse lokationer. Tom = alle lokationer (der opfylder øvrige regler). |
| Aktivering: Kundetyper | Hvornår (kundetype) | ★ Gruppen aktiveres for disse kundetyper. Tom = alle kundetyper. |
| Aktivering: Mødeemner | Hvornår (emne) | ★ Gruppen aktiveres for disse mødeemner. Tom = alle mødeemner. |
| Serviceniveau: Mødetyper | Hvad (kanal) | ★ Hvilke mødetyper gruppen tilbyder: Online (videomøde), Fysisk (fremmøde — kræver lokationer), Telefon (telefonmøde), Off site (møde uden for jeres lokationer). |
| Serviceniveau: Lokationer | Hvad (fysisk sted) | ★ Mødesteder kunden kan vælge ved fysiske møder. |

{: .important }
> **Husk:** Aktiveringsreglerne ‘eller’-sammensættes: gruppen aktiveres, når **mindst én** regel er opfyldt. Vil du være præcis, så sæt alle tre bevidst.


## Hvad betyder felterne? — Betjeningsniveau


| Felt | Hvad det styrer | Betydning |
|---|---|---|
| Type: Eksplicit valgt | Kunden valgte selv medarbejderen | Højeste relevans — kun én gang. |
| Type: Lokal rådgiver | Medarbejder på kundens egen lokation | Typisk høj prioritet — kun én gang. |
| Type: Servicegruppe | Medarbejdere fra en servicegruppe | Kan optræde flere gange (én pr. label) til primær/sekundær. |
| Beskrivelse | Forklaring af niveauet | Intern tekst, så I kan kende niveauet. |
| Label | Hvilke servicegrupper niveauet gælder | ★ Kun for type Servicegruppe: matcher servicegrupper med denne label. |
| Pile (rækkefølge) | Prioritet | ★ Øverst = højest prioritet; systemet tager første match nedefra og ned. |


## Fejlfinding

- Servicegruppen aktiveres aldrig: tjek **aktiveringsreglerne** (kundetype/lokation/mødeemne), og at medlemmerne har **tilgængelighed/arbejdstid** på de matchende dage.
- Medarbejdere mangler i valglisten: kontrollér, at de er synkroniseret og kan **bookes** (se Tilgængelighed).
- Kunden får kun lokale medarbejdere: justér **betjeningsniveauet**, så servicegruppens label prioriteres.
- Max-timer slår ikke igennem: en individuel grænse på medarbejderen vinder over servicegruppens.
- Aktiveringsregler/serviceniveau kan ikke sættes: servicegruppen skal **oprettes først** — gem og redigér derefter.
- Label virker ikke i betjeningsniveau: sørg for, at mindst én servicegruppe har den valgte label.

### Se også / forudsætninger
- **Schedule – FAQ** (typiske spørgsmål, fejl og svar) — ledsagende dokument.
- **Schedule – superbrugerguide (samlet opsætning)** — kommende guide (standardværdier, kundetyper, lokationer, mødeemner, tilgængelighed, portaler).


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (servicegrupper + kompetencegrupper + betjeningsniveau).


{: .hint }
> ✅ **Færdig!** Servicegruppen er klar til bookinger.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
