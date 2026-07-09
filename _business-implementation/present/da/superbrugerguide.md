---
layout: "default"
title: "Superbrugerguide"
parent: "Dansk"
grand_parent: "Present"
nav_order: 201
lang: "da"
---
# Present – superbrugerguide
_Opsætning i Management UI · v1.2 · 10.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/present/da/superbrugerguide.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/present/da/superbrugerguide.pdf)

## Formål og værdi

Present lader medarbejdere generere færdige, on-brand kundepræsentationer på sekunder — direkte fra data i jeres kundesystem (CRM), i stedet for at bygge slides manuelt. Som superbruger sikrer du, at de rigtige skabeloner og felt-fletninger er på plads, så medarbejderne altid har korrekte og opdaterede præsentationer klar til mødet.

### Ordliste
- **CRM**: Jeres kundesystem (her Salesforce), hvor kundedata bor.
- **Management UI**: &moneys administrationsside, hvor du som superbruger opsætter produkterne (“UI” = brugerflade).
- **Master-skabelon**: En PowerPoint-fil, du bygger, og som medarbejderne vælger imellem, når de laver en præsentation.
- **Tag**: En pladsholder i PowerPoint, fx [tag:account_name], der automatisk fyldes med data fra CRM.
- **Tag-mapping**: At bestemme, hvilket CRM-felt et tag henter sin data fra.
- **Kundetype**: En kategori af kunde (oprettes i Schedule), som en skabelon knyttes til.
- **Label**: Et mærkat, du kan sætte på en skabelon, så den er nem at finde og vælge.
- **Objekttype**: Den type CRM-post et tag henter fra: Account (kunde), Contact (kontaktperson), Event (møde) eller Specifik (særlige felter som dagsorden og bydeformer).
- **Entra**: Microsofts system til brugeradgang; din Entra-/IT-administrator tildeler licenser og rettigheder.
- **Ledsagende guide**: En særskilt vejledning, der dækker et tilstødende emne (fx opsætning i CRM-komponenten).


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator, der opsætter og vedligeholder Present i Management UI.
- Present-pakken er installeret i organisationen.
- Du har en færdig **PowerPoint-fil (.pptx)** klar som master-skabelon — eller følg afsnittet “Forbered din master-skabelon” nedenfor først.
- De medarbejdere, der skal bruge Present, har fået tildelt en Present-licens.
- Du har adgang til Management UI med rettighederne **Configurator** eller **Admin**.
- Kundetyper er oprettet (gøres i Schedule).
- Til testen i Trin 3 skal du bruge den ledsagende guide til Present-komponenten i CRM (se “Se også”).

{: .note }
> **Bemærk:** Mangler du licens eller rettigheder, så bestil dem hos din IT-/Entra-administrator (eller &money-support), før du går i gang — så undgår du at gå i stå halvvejs.


## Dit udbytte

Efter denne guide kan du:

- Forberede en master-skabelon i PowerPoint (sektioner, slide-navne og tags).
- Uploade og validere master-skabeloner.
- Knytte en skabelon til den rigtige kundetype.
- Mappe tags til de rigtige felter i CRM.
- Teste, at en præsentation bliver korrekt.
- Deaktivere/genaktivere skabeloner og følge brugen i rapportering.


## Overblik

Opsætningen består af disse trin:

- Forbered: byg din master-skabelon i PowerPoint (sektioner, slide-navne, tags).
- Trin 1: Upload master-skabelonen og vælg kundetype.
- Trin 2: Map tags, så CRM-data flettes korrekt ind.
- Trin 3: Test, at en præsentation bliver korrekt.
- Trin 4: Vedligehold skabelonerne og følg brugen.

Tidsforbrug: forberedelse af master-skabelonen afhænger af design; selve opsætningen i Management UI tager typisk **20–30 minutter**.


## Forbered din master-skabelon (PowerPoint)

En master-skabelon er den PowerPoint, medarbejderne vælger imellem. Du bygger den i PowerPoint, før du uploader den i Trin 1.


### Forbered · Byg master-skabelonen

_Hvorfor: Skabelonens opbygning bestemmer, hvilke slides medarbejderen kan vælge, og hvor CRM-data flettes ind._

- Sæt **slidestørrelsen** til **Brugerdefineret** (Design → Slidestørrelse) — ellers kan generering fejle (se quickguiden nederst).
- Opret **sektioner**: højreklik mellem to slides i venstre slide-rude → **Tilføj sektion** (eller fanen **Hjem → Sektion → Tilføj sektion**). Omdøb: højreklik på sektionen → **Omdøb sektion**. Inddel fx i forside, agenda, om kunden, produkter, pris, afslutning.
- Lav **undersektioner** ved at navngive sektionen “Sektionsnavn -- Undersektionsnavn”.
- Navngiv hvert slide i **notefeltet** med syntaksen [slide:slide_navn] — små bogstaver, ingen mellemrum, brug underscore (_) som ordadskiller.
- Indsæt **tags** dér, hvor CRM-data skal flettes ind, fx [tag:account_name]. Justér evt. visningen med modifikatorer: [tag:company_name:uppercase] (STORE BOGSTAVER), :capitalize (stort begyndelsesbogstav), :trim (fjerner overflødige mellemrum) — kan kombineres: [tag:company_name:trim:uppercase].
- Indsæt **billede-tags** for at erstatte billeder dynamisk: navngiv selve billedet i PowerPoint (via **Markeringsruden**) med syntaksen [image:image_name]. Når præsentationen genereres, erstattes billedet automatisk med det billede, der er knyttet til image-tagget.
- Agenda/dagsorden: agenda-tagget skal stå som **bullet-points** for at virke korrekt.
- Tilføj **hyperlinks**: marker tekst, objekt eller et logo → **Indsæt → Link** (Ctrl+K). Link til en webside (URL) eller til et andet slide via **Placer i dette dokument**. Mange kunder linker fra et **logo** til **agenda-slidet** (slidet med [slide:agenda]), så medarbejderen hurtigt kan hoppe til dagsordenen under mødet. Aktive links virker, når præsentationen åbnes i PowerPoint — ikke i CRM-forhåndsvisningen.
- **Komprimér billeder**, så filen er let — se **Quickguide til komprimering af billeder** nedenfor.
- Hold den samlede filstørrelse så lav som muligt, så skabelonen uploader og genererer hurtigt.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/slide_name.png)

*Skærmbillede 1 (PowerPoint) — Eksempel fra PowerPoint: [slide:agenda] i note-feltet og [tag:agenda] på slidet*


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/section_names.png)

*Skærmbillede 2 (PowerPoint) — Sektioner i PowerPoint, inkl. en undersektion (Sektionsnavn -- undersektion)*

{: .important }
> **Husk:** Et tag, der ikke mappes i Trin 2, vises som et **tomt felt**, medarbejderen selv kan udfylde — det er bevidst, men gennemgå dine tags, så intet vigtigt glemmes.

{: .hint }
> **Bemærk:** Begrænsninger for filstørrelse: Den samlede PowerPoint-fil må **ikke overstige 10 MB** — ellers fejler upload. Videoer understøttes, men tæller med i størrelsen. Pr. billede er den anbefalede grænse **1 MB** (systemet advarer ved større billeder). Gør derfor præsentationen så let som muligt — komprimér billeder (se quickguiden nedenfor).

{: .note }
> **Bemærk:** Layouts: layouts importeret fra Templafy, andre systemer eller ældre præsentationer kan indeholde formateringer, der giver fejl i Present. Sørg derfor for at: ① undgå layouts med **tal i navnet** (kan give fejl under upload); ② brug altid **entydige og genkendelige layout-navne**; ③ er du i tvivl, brug layoutet **Tom**, som giver fuld kontrol over opsætningen.


## Formatér logo, ikoner og billeder på masterslides

Vil du have logo, ikoner og billeder til at sidde fast og korrekt på de enkelte masterslides, kan du arbejde med dem via slidemasteren:

- Åbn master-skabelonen i PowerPoint.
- Gå til **Vis → Slidemaster**.
- Højreklik på fx banklogoet på den relevante masterslide (eller ikoner/billeder på øvrige slides) → **Gem som billede** (gem fx på skrivebordet, så det kan genbruges).
- Klik **Luk mastervisning**, og gem skabelonen.
- Upload den opdaterede skabelon i Management UI under **Present → Opsætning**.


## Hyperlinks og aktive links

Hyperlinks understøtter ikke-lineær navigation i mødet (fx hurtigt tilbage til agenda-slidet), og aktive links kan åbne en hjemmeside. Begge oprettes i PowerPoint og bevares ved upload.


**Hyperlink mellem slides (fx logo → agenda)**

- Marker elementet (fx logoet) — eller læg et usynligt **tekstfelt** oven på det (Indsæt → Tekstfelt → **Placer forrest** → fjern baggrunds-/stregfarve).
- Højreklik → **Link** → **En placering i dette dokument** → vælg destinations-slidet (fx agenda) → **OK**.

{: .note }
> **Bemærk:** Hyperlinks fungerer kun i slideshow/præsentation og bør pege på slides i **samme** præsentation. Ændrer du rækkefølgen, virker linket stadig (det peger på sliden, ikke nummeret).


**Aktive links (til en hjemmeside)**

- Tilføj linket som et hyperlink, men peg på en **webadresse (URL)**.
- I præsentationsmode åbner ét klik hjemmesiden; med **ALT+TAB** kommer du tilbage til præsentationen.
- På Teams-møder: del præsentationen som **skærmdeling**, så kunden ser det samme — og brug ALT+TAB for at vende tilbage.

{: .note }
> **Bemærk:** Aktive og interaktive links virker i PowerPoint, **ikke** i Salesforce-forhåndsvisningen (kendt begrænsning).


## Quickguide til komprimering af billeder i din mødepræsentation

Store billeder fylder hurtigt meget. Sådan komprimerer du dem i PowerPoint:

- Marker et billede i præsentationen.
- Gå til fanen **Billedformat** → **Komprimer billeder**.
- Vælg en lavere opløsning (fx **Web (150 ppi)** eller **E-mail (96 ppi)**).
- Sæt flueben i **Slet beskårne områder af billeder**.
- Fjern fluebenet **Anvend kun på dette billede** for at komprimere **alle** billeder i filen.
- Klik **OK**.
- Komprimér også videoer: **Filer → Oplysninger → Komprimer medie**.
- Tjek til sidst filstørrelsen (**Filer → Oplysninger**) — mål: samlet under 10 MB, ca. 1 MB pr. billede.

{: .hint }
> **Anbefalet:** Komprimér før upload — det giver hurtigere upload og generering og holder dig under 10 MB-grænsen.


## Trin-for-trin (Management UI)


### Trin 1 · Upload master-skabelonen

_Hvorfor: Når skabelonen er uploadet, kan medarbejderne vælge den, når de genererer en præsentation._

- Gå til **Present** → **Opsætning** → **Præsentationer** i Management UI.
- Klik **Upload**.
- Vælg din PowerPoint-fil (.pptx) via **Upload fil**.
- Se resultatet under **Validering** — eventuelle fejl skal rettes i PowerPoint, før du kan uploade.
- Vælg den rette kundetype under **Vælg kundetype**.
- Klik **Upload** igen for at gemme (knappen i dialogen; tager typisk 10–60 sekunder).


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_templates_oversigt.png)

*Skærmbillede 3 (Management UI) — Present → Præsentationer — oversigten med knappen **Upload** og statusfilteret*


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_upload_dialog.png)

*Skærmbillede 4 (Management UI) — Dialogen **Upload præsentation** — **Upload fil**, **Validering** og **Vælg kundetype***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Skabelonen vises nu i listen under **Præsentationer** med status **Aktiv**.

{: .note }
> **Bemærk:** Viser **Validering** fejl, kan skabelonen ikke uploades. Ret fejlene i PowerPoint og prøv igen.


### Trin 2 · Map tags til CRM-felter

_Hvorfor: Mapningen bestemmer, hvilket CRM-felt hvert tag i skabelonen henter data fra._

- Gå til **Present** → **Opsætning** → **CRM Konfiguration**.
- Klik **Opret**.
- Vælg tagget fra skabelonen under **Vælg et tag** (listen dannes automatisk ud fra de tags, du satte i PowerPoint).
- Vælg **Objekttype**: Account (kunden/virksomheden), Contact (kontaktpersonen), Event (mødet) eller **Specifik** (særlige felter som dagsorden og bydeformer).
- Vælg det konkrete felt på objektet, tagget skal hente fra.
- Klik **Opret**.

{: .important }
> **Husk:** Eksempel: tagget [tag:account_name] mappes som **Objekttype = Account** → feltet **Navn**. Så henter tagget automatisk kundens navn fra CRM.

{: .important }
> **Husk:** Agenda-tagget mappes som **Objekttype = Specifik** → feltet **Møde dagsorden** (string), så mødets dagsorden flettes ind på agenda-slidet.

{: .important }
> **Husk:** På samme måde kan **bydeformer** (tiltaleformer) mappes mod **Objekttype = Specifik** — så I kan bruge bydeformer i jeres slides, og medarbejderne får dem flettet ind automatisk i stedet for selv at skrive dem.


![Skærmbillede 5]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_tags_oversigt.png)

*Skærmbillede 5 (Management UI) — Present → CRM Konfiguration — tabellen (**Tag-navn**, **CRM Objektfelt**, **Præsentationer**) og knappen **Opret***


![Skærmbillede 6]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_tag_dialog.png)

*Skærmbillede 6 (Management UI) — Dialogen **Opret tag konfiguration** — **Vælg et tag** og **Objekttype***

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Mapningen vises i tabellen med **Tag-navn** og **CRM Objektfelt** udfyldt. Gentag, til alle dine tags er mappet.


## Mest anvendte tags (reference)

Oversigt over de mest anvendte tags og hvilket Salesforce-felt de hentes fra:


| Visningsnavn | Tag | Salesforce-felt (Objekttype → felt) |
|---|---|---|
| Mødedato | [tag:dato] | Event → Slutdato (mødets sluttidspunkt) |
| Dagsorden / agenda | [tag:agenda] | Specifik → Møde dagsorden |
| Kundenavn | [tag:kundenavn] | Contact → Fornavn |
| Kundens fulde navn | [tag:kundens_fulde_navn] | Contact → Navn |
| Bydeform: Dine/Jeres | [tag:dine_jeres] | Specifik → Dine/Jeres |
| Bydeform: Du/I | [tag:du_i] | Specifik → Du/I |
| Bydeform: Dig/Jer | [tag:dig_jer] | Specifik → Dig/Jer |
| Bydeform: Din/Jeres | [tag:din_jeres] | Specifik → Din/Jeres |
| Bydeform: Dit/Jeres | [tag:dit_jeres] | Specifik → Dit/Jeres |

{: .important }
> **Husk:** Bydeformer (Dine/Jeres, Du/I …) mappes alle mod **Objekttype = Specifik** — så medarbejderne får den rigtige tiltaleform flettet ind automatisk.


## Tag-modifiers (formatér data)

Med tag-modifiers kan du formatere data fra Salesforce, før de indsættes — uden at ændre kilde-dataene. Syntaks: [tag:tag-navn:modifier]. Flere kan kædes og behandles fra venstre mod højre.


| Modifier | Effekt | Eksempel → resultat |
|---|---|---|
| capitalize | Stort begyndelsesbogstav | [tag:kundenavn:capitalize]: john → John |
| uppercase | STORE BOGSTAVER | [tag:firmanavn:uppercase]: Acme Corp → ACME CORP |
| lowercase | små bogstaver | [tag:kode:lowercase]: AB12 → ab12 |
| title | Hvert Ord Med Stort | [tag:emne:title]: quarterly review → Quarterly Review |
| trim | Fjerner overflødige mellemrum | [tag:beskrivelse:trim] |

Kædning: **[tag:firmanavn:trim:uppercase]** trimmer først mellemrum og konverterer derefter til store bogstaver.


### Trin 3 · Test, at en præsentation bliver korrekt

_Hvorfor: En test sikrer, at skabelon og mapning virker, før medarbejderne bruger den med rigtige kunder._

- Åbn en testkunde eller et testmøde i jeres CRM (brug demo-/testdata).
- Generér en præsentation med din nye skabelon (sker via Present-komponenten i CRM — se “Se også”).
- Kontrollér, at de felter, du har mappet, er fyldt med data, og at der ikke er uventede **tomme pladsholdere**.
- Kontrollér, at de rigtige slides og sektioner er med.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Præsentationen genereres, felterne er fyldt korrekt, og der er ingen uventede tomme pladsholdere.

{: .note }
> **Bemærk:** Forhåndsvisningen i Salesforce er ikke altid retvisende for den genererede PowerPoint. Disse understøttes ikke fuldt i forhåndsvisningen: **grafer, grafiske elementer, billedtyper, aktive links, interaktive slides og fonte**. Test og præsentér derfor i selve PowerPoint-filen.


### Trin 4 · Vedligehold og følg brugen

_Hvorfor: Hold skabelonerne opdaterede og ryd op i gamle versioner, så medarbejderne kun ser relevante valg._

- Rediger labels: klik redigér-ikonet i **Præsentationer**, brug **Tilføj label**, og afslut med **Gem**.
- Deaktiver en gammel skabelon: klik slet-ikonet og bekræft i **Deaktiver præsentation** (skjules for medarbejderne, men data bevares til rapportering).
- Genaktiver: sæt statusfilteret til **Inaktive**, find skabelonen og bekræft i **Genaktiver**.
- Følg brugen: gå til **Present** → **Rapportering**.


![Skærmbillede 7]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_templates_inaktive.png)

*Skærmbillede 7 (Management UI) — Present → Præsentationer med statusfilteret sat til **Inaktive***


![Skærmbillede 8]({{ site.baseurl }}/assets/images/business-implementation/present/superbrugerguide/present_rapportering.png)

*Skærmbillede 8 (Management UI) — Present → Rapportering — møder med kundepræsentation*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Skabelonen skifter status i listen (**Aktiv**/**Inaktiv**); kun aktive skabeloner vises for medarbejderne.

{: .hint }
> **Anbefalet:** Brug sigende navne og labels på skabelonerne — så er det nemt for medarbejderne at vælge den rigtige.


## Fejlfinding

- Skabelonen kan ikke uploades: tjek **Validering** — ret de viste fejl i PowerPoint og upload igen.
- Fejl ved generering af slides: slidestørrelsen er ofte ikke sat til **Brugerdefineret** i PowerPoint — kontrollér det altid (se quickguiden nedenfor).
- Jeg kan ikke finde mit tag i listen **Vælg et tag**: kontrollér, at tagget er stavet korrekt i PowerPoint, og at filen er uploadet.
- Jeg ved ikke, hvilket CRM-felt et tag skal pege på: kontakt din CRM-/superbruger-ansvarlige eller &money-support.
- Præsentationen mangler data: kontrollér, at de relevante tags er mappet under **CRM Konfiguration**, og at CRM-felterne indeholder data.
- Kundetypen findes ikke ved upload: opret kundetypen i Schedule først, og prøv igen.
- Medarbejderen kan ikke se Present: kontrollér, at brugeren har en Present-licens, og at **Present** er aktiveret i Management UI.


## Quickguide til PowerPoint – slidestørrelse (brugerdefineret)

{: .note }
> **Bemærk:** Oplever du fejl ved generering af slides i Present, skyldes det ofte, at slidestørrelsen **ikke er sat til “Brugerdefineret”** i PowerPoint. Kontrollér det altid som administrator.

- Gå til fanen **Design** i PowerPoint → klik **Slidestørrelse** (i menuen til højre) → vælg **Brugerdefineret slidestørrelse**.
- Tryk på pilen for at vælge **Brugerdefineret**, og afslut med **OK**.

### Se også / forudsætninger
- **Forbered din master-skabelon (PowerPoint)** — afsnittet ovenfor i denne guide (forudsætning for Trin 1).
- **Present – FAQ** (typiske spørgsmål, fejl og svar).
- **Opsætning og ibrugtagning af Present i CRM-komponenten** (Salesforce-pakke / Present-komponent) — ledsagende guide (bruges i Trin 3 til at generere en præsentation).
- **Valideringsværktøj til master-skabeloner** — ledsagende guide (hjælper med at finde fejl før upload).
- **Tag-mapping i detaljer**, herunder modifikatorer (uppercase, capitalize, trim) — ledsagende guide.


## Seneste opdatering

- 10.06.2026 (v1.2) — Tilføjet referencetabel for tags (inkl. bydeformer), tag-modifiers, slidemaster, hyperlinks/aktive links og preview-begrænsninger; slidestørrelse flyttet op; ordliste rettet.
- 09.06.2026 (v1.1) — Tilføjet ordliste, afsnit om opsætning af master-slides, konkret mapping-eksempel, succes-indikatorer, testtrin samt “Se også”-henvisninger.
- 09.06.2026 (v1.0) — Første version (opsætning i Management UI).


{: .hint }
> ✅ **Færdig!** Din skabelon er nu uploadet, mappet og testet — og klar til medarbejderne.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.2 · 10.06.2026_
