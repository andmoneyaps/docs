---
layout: "default"
title: "Superbrugerguide – Rapportering"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 206
lang: "da"
---
# Schedule – superbrugerguide: Rapportering
_Booking-statistik og fordelinger i Management UI · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-rapportering.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-rapportering.pdf)

## Formål og værdi

**Rapportering** giver dig et hurtigt overblik over jeres booking-aktivitet: hvor mange møder der er booket, **hvordan** de bookes (af medarbejdere, af kunder eller via portaler), og hvordan de fordeler sig på **kundetype**, **mødetype** og **mødeemne**. Det er et **læse-overblik** (read-only) — du bruger det til at følge udviklingen og træffe beslutninger om fx portaler og ressourcer.

### Ordliste
- **Booket møder**: Det samlede antal bookede møder i den valgte periode (tæller møder, ikke unikke kunder).
- **Booking-kilde**: Hvor mødet blev booket: ⟦Medarbejder⟧, ⟦Kunde⟧ (direkte) eller via en navngiven ⟦portal⟧.
- **Andel**: Den enkelte kildes/kategoris procentdel af det samlede antal møder.
- **Fordeling**: Hvordan møderne er fordelt — over uger, kundetyper, mødetyper og mødeemner.
- **Periode**: Tidsvinduet for rapporten — de seneste 2, 7, 14, 30, 60 eller 90 dage.
- **Kundetype**: Filter, der begrænser visningen til én kundetype (eller Alle).

{: .note }
> **Bemærk:** Dette er det indbyggede overblik i Schedule. **Detaljeret mødedata** leveres desuden til jer via **Salesforce CRM analytics**, hvor I kan lave dybere analyser på de enkelte møder.


## Målgruppe og forudsætninger

- Målgruppe: **Manager** eller **Admin** — rapporten viser hele organisationens booking-data.
- Der skal være **bookede møder** i systemet, for at rapporten viser data.
- **Kundetyper**, **mødeemner** og **portaler** skal være oprettet/navngivet for at vises med navn (ellers fx ‘Portal’ eller ‘Ingen’).
- Rapporten er **read-only**: ingen redigering, og der er ikke eksport eller frit datointerval.

{: .note }
> **Bemærk:** Brand-navnet er **Schedule**; i systemet/menuen kan du stadig møde det tidligere navn (schedule). Det er det samme produkt.


## Dit udbytte

Efter denne guide kan du:

- Vælge periode og kundetype og aflæse det samlede antal møder.
- Se, hvordan møderne fordeler sig på booking-kilder (medarbejder/kunde/portal).
- Læse fordelingerne på uger, kundetype, mødetype og mødeemne.
- Forstå de typiske ‘gotchas’ (fx afrunding) og fejlfinde en tom rapport.


## Sådan læser du rapporten


### Trin 1 · Vælg periode og kundetype

_Hvorfor: Filtrene øverst styrer, hvilke møder rapporten viser._

- Gå til **Schedule** → **Rapportering**.
- Vælg **Periode** (2, 7, 14, 30, 60 eller 90 dage — standard er 30).
- Vælg evt. **Kundetype** (**Alle** som standard). Hele rapporten opdateres automatisk.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-rapportering/sched_rapport_oversigt.png)

*Skærmbillede 1 (Management UI) — Schedule → Rapportering — filtre (**Periode**, **Kundetype**) + **Booket møder** og fordelings-tabel*


### Trin 2 · Aflæs opsummeringen (booking-kilder)

_Hvorfor: Det store tal er det samlede antal møder; tabellen viser, hvor de er booket._

- Aflæs **Booket møder** (det samlede antal i perioden).
- I tabellen ser du pr. kilde: **Antal** og **Andel** — **Booket møder af medarbejdere**, **Booket møder af kunder** og **Booket via [portalnavn]**.
- En kilde vises kun, hvis den har mindst ét møde i perioden.

**Eksempel:** Booket møder = 142 → Medarbejdere 90 (63 %), Kunder 40 (28 %), Portal 1 12 (8 %). Bemærk: 63 + 28 + 8 = 99 % pga. afrunding — det er forventet.


### Trin 3 · Læs ‘Fordeling af møder’ (over tid)

_Hvorfor: Søjlediagrammet viser antal møder pr. uge, opdelt på booking-kilder._

- Hver søjle er én **uge**; farverne i søjlen er de enkelte kilder (medarbejder/kunde/portaler).
- Klik på en kilde i **signaturen** for at fremhæve netop den kildes bidrag.
- Uger uden møder vises ikke som søjle.


### Trin 4 · Læs fordelingerne (kundetype, mødetype, mødeemne)

_Hvorfor: De øvrige grafer viser, hvordan møderne fordeler sig._

- **Fordeling af kundetype** (cirkeldiagram): de tre største kundetyper vises hver for sig, resten samles som **Andre** (møder uden kundetype vises som en **hvid del uden label**, adskilt fra ‘Andre’).
- **Fordeling af mødetype** (Fysisk/Online/Telefon m.fl.) og **Fordeling af mødeemner** (vandrette søjler) viser de mest bookede typer/emner.
- Meget små andele (under ~1 %) vises ikke i type-/emne-graferne.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-rapportering/sched_rapport_fordeling_typer.png)

*Skærmbillede 2 (Management UI) — **Fordeling af mødetype** + **Fordeling af mødeemner***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du har nu overblik over antal, kilder og fordelinger for den valgte periode.


## Hvad betyder felterne og tallene?


| Felt / tal | Hvad det viser | Godt at vide |
|---|---|---|
| Periode | Tidsvinduet (seneste N dage) | Rullende vindue; standard 30 dage. Intet frit datointerval. |
| Kundetype | Filter på kundetype | Påvirker kun visningen — ikke beregningen af totalen. |
| Booket møder | Samlet antal møder i perioden | Tæller møder (tidspunkter), ikke unikke kunder. |
| Antal | Antal møder pr. kilde | Heltal. |
| Andel | Kildens procentdel af totalen | Rundet til hele procent — derfor kan summen blive 99 % eller 101 %. |
| Booket møder af medarbejdere | Møder booket af medarbejdere | Fx via Management UI/kalender. |
| Booket møder af kunder | Møder booket direkte af kunder | Uden om en navngiven portal. |
| Booket møder - andre | Øvrige booking-kilder | Møder, der ikke er medarbejder, kunde eller navngiven portal. |
| Booket via [portal] | Møder booket via en portal | Én række pr. portal; uden navn vises ‘Portal’. |
| Fordeling af kundetype | Cirkeldiagram | Top 3 + ‘Andre’. Ukategoriserede møder = hvid del uden label. |


## Godt at vide

- **Afrunding:** procenterne rundes til hele tal, så delene kan summe til 99 % eller 101 % — det er forventet.
- **Tæller møder, ikke kunder:** et tal er antal bookede møder, ikke antal unikke kunder.
- **Kundetype-filteret** ændrer kun visningen; det samlede tal dækker stadig alle kundetyper.
- **Små andele skjules:** mødetyper/-emner under ca. 1 % vises ikke i graferne.
- **Realtid:** tallene afspejler bookinger løbende (typisk inden for sekunder/minutter).
- **Rullende vindue:** perioden er de seneste N dage frem til i dag.
- **Aflyst/flyttet:** afbestilles eller flyttes et møde, kan tallet ændre sig.
- **Samme data for alle:** alle Managers/Admins ser hele organisationens tal — så to brugere ser de samme tal.


## Sådan kan du bruge tallene

- Stor andel **Booket møder af medarbejdere** vs. **portaler** → overvej at fremme selvbetjening via en portal.
- Stor **Andre**-andel i kundetype-fordelingen → der mangler måske kundetyper, eller møder oprettes uden kundetype.
- De mest bookede **mødeemner**/**mødetyper** → brug det til at prioritere kompetencer, lokaler og bemanding.


## Fejlfinding

- Rapporten er tom: der er ingen møder i perioden, eller kundetype-filteret udelukker alt → vælg en længere **Periode** (fx 90 dage) og **Kundetype = Alle**.
- Tallene stemmer ikke helt: det skyldes **afrunding** af procenter — delene kan summe til 99/101 %.
- En portal vises som ‘Portal’ (uden navn): giv portalen et navn under **Schedule → Portaler**.
- Kundetype-filteret er tomt: der er ikke oprettet kundetyper endnu → opret dem under **Mødeopsætning → Kundetyper**.
- Du kan ikke se **Rapportering** i menuen: din rolle er ikke **Manager** eller **Admin** → kontakt din administrator.
- ‘Kunne ikke hente data’: opdatér siden (F5); fortsætter det, kontakt support.

### Se også / forudsætninger
- **Schedule – FAQ (Rapportering)** — typiske spørgsmål, fejl og svar.
- **Schedule – superbrugerguide: Portaler** — portaler optræder som booking-kilder i rapporten.
- **Schedule – superbrugerguide: Medarbejdere** — medarbejder-bookinger i rapporten.


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (Rapportering).


{: .hint }
> ✅ **Færdig!** Du kan nu læse og bruge booking-statistikken i Rapportering.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
