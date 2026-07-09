---
layout: "default"
title: "Medarbejderguide (Salesforce)"
parent: "Dansk"
grand_parent: "Assist"
nav_order: 302
lang: "da"
---
# Assist – medarbejderguide
_Sådan bruger du Assist på mødet i Salesforce · v1.0 · 10.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/assist/da/medarbejderguide.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/assist/da/medarbejderguide.pdf)

## Formål og værdi

Med Assist får du en AI-mødeassistent på kundemødet. Assist transskriberer samtalen, følger jeres mødemål og samler op på opmærksomhedspunkter og aftaler undervejs — og danner et færdigt referat efter mødet. Så kan du være nærværende med kunden i stedet for at tage noter.

### Ordliste
- **Assist**: &moneys AI-mødeassistent i Salesforce — transskription, indsigter, mødemål og referat.
- **Møde (Event)**: Selve mødeposten i Salesforce, hvor du åbner Assist (fanen “Assist”).
- **Transskription**: Den løbende tekst af, hvad der bliver sagt på mødet (tale-til-tekst).
- **Mødemål**: Mål for mødet, som Assist følger og vurderer undervejs. (Kommer snart — endnu ikke åbnet.)
- **Opmærksomhedspunkter & aftaler**: Vigtige punkter og aftaler, Assist fanger automatisk fra samtalen.
- **Referat**: Mødereferatet, Assist danner efter mødet — et kundereferat (til kunden) og et grundreferat (internt).


## Målgruppe og forudsætninger

- Målgruppe: medarbejder, der holder kundemøder og vil bruge Assist.
- Du har **Assist-licens/adgang** (ellers kontakt din superbruger).
- Du arbejder på et **møde (Event)** i Salesforce — det er her, **Assist**-fanen findes.
- **Mikrofon** er tilsluttet, og browseren (Chrome/Edge) må bruge den.
- Du har **informeret kunden** om, at mødet optages og transskriberes med AI (se “Samtykke” nedenfor).

{: .note }
> **Bemærk:** Assist optager og transskriberer mødet. Fortæl altid kunden det, og sørg for et gyldigt grundlag, før du starter — det er dit ansvar som medarbejder.


## Dit udbytte

Efter denne guide kan du:

- Åbne og klargøre Assist på et møde.
- Starte et møde med transskription og mødemål.
- Følge indsigter, opmærksomhedspunkter og aftaler undervejs.
- Afslutte mødet og få et færdigt referat.
- Finde, gennemse og dele referatet (afhængigt af jeres opsætning).


## Overblik

- Åbn mødet → fanen **Assist**.
- Klargør: sprog, mikrofon, deltagere, mødemål.
- **Start møde** → hold mødet → **Afslut & dan referat**.
- Gennemse, gem og del referatet.


## Samtykke — før du starter

Assist optager og transskriberer samtalen. Inden du starter:

- Fortæl kunden, at mødet optages og transskriberes med AI, og hvorfor (fx for at lave et referat).
- Sørg for et gyldigt grundlag efter jeres retningslinjer.
- Assist viser en note om AI-transskription — men den erstatter ikke din egen information til kunden.

**Sig fx til kunden:** “Til mødet bruger jeg en AI-assistent, der optager og laver en tekst af samtalen, så jeg kan skrive et referat — er det i orden med dig?”


## Tjekliste før mødet

- ☐ Event åbnet, og **Assist**-fanen er åben.
- ☐ **Mikrofon** valgt og testet — vælg din eksterne mik/headset (ikke kun “Systemstandard”).
- ☐ **Deltagere** er indlæst med korrekt rolle (kunde/medarbejder).
- ☐ **Laptoppen** er åben — og bliver stående åben under hele mødet.
- ☐ Kunden er **informeret**, og samtykke er på plads.


## Trin-for-trin (Salesforce)


### Trin 1 · Åbn Assist på mødet

_Hvorfor: Assist findes på selve mødet (Event) i Salesforce._

- Åbn (eller opret) **mødet** på kundens konto i Salesforce.
- Klik fanen **Assist**. Fanen kan hedde noget andet hos jer — fx **Assist Lite**, **Transskriber** eller et navn, jeres organisation selv har valgt.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/assist/da/medarbejderguide/assist_sf_fane.png)

*Skærmbillede 1 (Salesforce · Assist) — Mødet (Event) med Assist-fanen åben (her “Assist Lite”) — klargøringsskærmen*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Assist åbner og er klar til at blive klargjort.


### Trin 2 · Klargør mødet

_Hvorfor: Her sikrer du, at Assist optager korrekt og følger de rigtige mål._

- Tjek **deltagere** og deres rolle (kunde/medarbejder) — de kan tage et øjeblik at indlæse.
- Lad **Live møde** være valgt (**Upload transskription** er kun til at uploade en eksisterende optagelse).
- Vælg og test **mikrofon** under **Mikrofonindstillinger** (giv browseren tilladelse, hvis den spørger).
- **Mødemål** (mål, Assist følger på mødet) **kommer snart** og er endnu ikke åbnet.


### Trin 3 · Start mødet

_Hvorfor: Når du starter, begynder optagelse og live-transskription._

- Klik **Start møde**. Knappen er grå, indtil deltagere er indlæst, og en mikrofon er valgt (typisk få sekunder) — bliver den ved, så vælg en mikrofon manuelt og opdatér siden.
- Hold mødet som normalt — Assist transskriberer og analyserer i baggrunden.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du ser, at live-transskriptionen kører, og teksten kommer løbende.


### Trin 4 · Følg med undervejs

_Hvorfor: Assist hjælper dig i realtid, så du kan være nærværende._

- **Transskribering**: samtalen som tekst, navngivet pr. taler.
- **Mødemål**: markeres efterhånden, som de nås.
- **Opmærksomhedspunkter & aftaler**: vigtige punkter og aftaler fanges automatisk.
- **Taletidsfordeling**: hvor meget taler hhv. du og kunden.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/assist/da/medarbejderguide/assist_sf_live.png)

*Skærmbillede 2 (Salesforce · Assist) — Live, kort efter start — knappen **Afslut & dan referat** og kortene **Opmærksomhedspunkter**/**Aftaler** (endnu tomme). Transskription og taletid ses ved at scrolle i panelet.*

{: .note }
> **Bemærk:** **Transskription** og **taletidsfordeling** ser du ved at scrolle i panelet. **Opmærksomhedspunkter** og **aftaler** udfyldes først efter et par minutter (du ser fx “X beskeder til næste opdatering”) — det er ikke en fejl.


### Trin 5 · Afslut mødet

_Hvorfor: Når mødet er slut, danner Assist referatet automatisk._

- Klik **Afslut & dan referat**.
- **Vent et øjeblik** (typisk under et minut), mens grundreferat og kundereferat dannes.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Referatet er klar til gennemsyn.

{: .important }
> **Husk:** Klik altid **Afslut & dan referat** — ellers dannes referatet ikke, og transskriptionen slettes efter 48 timer. (Automatisk dannelse, hvis du glemmer det, er på vej.)


### Trin 6 · Gennemse, gem og del referatet

_Hvorfor: Du har det sidste ord — gennemse og ret, før du gemmer og deler._

- Læs **kundereferatet** igennem, og ret om nødvendigt.
- Gem referatet i Salesforce (se “Hvor finder jeg referatet?” nedenfor).
- Del med kunden efter jeres retningslinjer.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/assist/da/medarbejderguide/assist_sf_referat.png)

*Skærmbillede 3 (Salesforce · Assist) — Referat-visning: kundereferatet klar til gennemsyn og gem*

{: .important }
> **Husk:** Referatet er AI-genereret — gennemlæs det altid og ret fejl, før du gemmer eller sender det til kunden.

{: .note }
> **Bemærk:** Står der fx “Ingen aftaler indgået endnu”, er det normalt — Assist fandt blot ingen konkrete aftaler i samtalen.


## Få den bedste optagelse på fysiske møder

Assist transskriberer ud fra mikrofonen. På et fysisk møde får du den bedste optagelse — og bedst adskillelse af jeres stemmer — sådan her:

- Brug helst en **ekstern mikrofon** eller et **headset** frem for den indbyggede laptop-mikrofon — vælg den eksplicit under **Mikrofonindstillinger**.
- Placér laptoppen/mikrofonen **midt på bordet** mellem dig og kunden, så begge stemmer fanges lige godt.
- Hold mikrofonen **fri** — undgå at dække den med papir, mapper eller hænder.
- Vælg et **roligt lokale** uden baggrundsstøj (ventilation, gang, andre samtaler) — det forbedrer både transskription og adskillelse af talere.
- Undgå **dublerede lydenheder** (fx Bluetooth-headset + dock + laptop-mikrofon på én gang) — vælg én enhed.
- Tal i **normalt tempo**, og undgå at tale i munden på hinanden — så kan Assist bedre adskille, hvem der siger hvad.
- **Test mikrofonen** kort før mødet (vælg enhed, og se at niveauet reagerer).
- **Luk ikke laptoppen** sammen ved mødestart — det kan afbryde optagelsen; lad den stå åben under hele mødet.
- Du kan trygt **skifte til andre faner eller programmer** (Present, PowerPoint, netbank, andre faner) og vende tilbage — optagelsen fortsætter.
- **Hybridmøder** (både fysiske og online deltagere) afholdes i Teams.


## Hvad betyder felterne?

Her er, hvad de enkelte valg styrer — så du ved, hvad du vælger:


| Felt / valg | Hvad det styrer | Betydning for præsentationen |
|---|---|---|
| Sprog | Mødets sprog | Styrer transskription og referat — vælg det sprog, mødet holdes på. |
| Mikrofon | Lydkilde | Bestemmer, hvilken mikrofon der optager; afgørende for kvaliteten. |
| Deltagere + rolle | Navngivning af tale | Knytter stemmer til navne/roller, så transskriptionen er let at læse. |
| Mødemål (kommer snart) | Hvad Assist følger | Assist vurderer, om målene nås. Funktionen er endnu ikke åbnet. |
| Start møde / Afslut & dan referat | Optagelse til/fra | Starter optagelse/transskription, og afslutter mødet + danner referatet. |
| Kundereferat | Referat til kunden | Den kundevendte version — gennemse og ret, før du sender. |
| Grundreferat | Internt referat | Det fulde, interne referat fra mødet. |
| Gem i Salesforce | Gemmer referatet | Lægger referatet på mødet (placering afhænger af jeres opsætning). |


## Automatisk referat og opbevaring

- Når du afslutter mødet, danner Assist **automatisk et referat** (et kundereferat og et grundreferat) ud fra transskriptionen — du skal ikke skrive det selv.
- Referatet gemmes i **Salesforce** og er den blivende kopi (se “Hvor finder jeg referatet?” nedenfor).
- Selve **transskriptionen opbevares i op til 48 timer** og slettes derefter — så husk at gennemse og gemme referatet.
- Behandlingen sker i **EU**, og indholdet bruges ikke til at træne AI-modeller.


## Hvor finder jeg referatet?

Referatet gemmes i Salesforce. Afhængigt af jeres opsætning ligger det enten på selve mødet (Event) eller i en dedikeret fane — flere organisationer navngiver fanen selv, fx “Referat”.

{: .note }
> **Bemærk:** Er du i tvivl om, hvor referatet lander hos jer, så spørg din superbruger.


## Fejlfinding

- Mikrofonen virker ikke: giv browseren tilladelse (Chrome/Edge), og tjek, at den rigtige mikrofon er valgt.
- Ingen **Assist**-fane på mødet: kontrollér, at du har åbnet et **møde (Event)** og har en Assist-licens — ellers kontakt din superbruger.
- Transskriptionen kommer ikke: tjek mikrofon og internetforbindelse, og start mødet igen.
- Jeg kan ikke finde referatet: se “Hvor finder jeg referatet?” — det afhænger af jeres opsætning (på mødet vs. “Referat”-fane).

Flere typiske spørgsmål og fejl: se **Assist – FAQ**.

### Se også
- **Assist – superbrugerguide (Management UI)** — rapportering og mødemål — ledsagende guide.
- **Assist – FAQ** (typiske spørgsmål, fejl og svar).


## Seneste opdatering

- 10.06.2026 (v1.0) — Første version (brug af Assist på mødet i Salesforce).


{: .hint }
> ✅ **Færdig!** Du har holdt et møde med Assist og fået et referat.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 10.06.2026_
