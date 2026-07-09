---
layout: "default"
title: "Medarbejderguide (Salesforce)"
parent: "Dansk"
grand_parent: "Present"
nav_order: 302
lang: "da"
---
# Present – medarbejderguide
_Sådan genererer du en kundepræsentation i Salesforce (Present-komponenten) · v1.0 · 09.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/present/da/medarbejderguide.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/present/da/medarbejderguide.pdf)

## Formål og værdi

Med Present laver du en færdig kundepræsentation — med jeres design og logo — på få minutter — direkte fra mødet i Salesforce. Du vælger en skabelon og de slides, du vil bruge, og data om kunden flettes automatisk ind. Så bruger du tiden på kunden i stedet for på at bygge slides.

### Ordliste
- **Present-komponent**: Den boks (“Mødepræsentation”), du åbner på et møde i Salesforce, hvor du laver præsentationen.
- **Master-skabelon**: En færdig PowerPoint-skabelon, en superbruger har lagt op, som du vælger imellem.
- **Kundetype**: Kundens kategori (fx privat/erhverv); bestemmer hvilke skabeloner du får vist.
- **Slide**: Et enkelt dias i præsentationen.
- **Sektion**: En gruppe af slides i skabelonen (fx Agenda, Investering).
- **Tag**: En pladsholder, der fyldes med kundedata fra Salesforce — fx kundens navn.
- **Møde (Event)**: Selve mødeposten i Salesforce (kaldes “Event” i systemet).


## Forudsætninger

- Du har en Present-licens (mangler du den, så kontakt din superbruger/administrator).
- Kunden har en kundetype sat på sin konto i Salesforce (ellers vises ingen skabeloner).
- Du arbejder på et **møde** i Salesforce (kaldes “Event” i systemet) — det er her, Present-komponenten findes.

{: .note }
> **Bemærk:** Ser du ingen skabeloner, skyldes det oftest manglende kundetype på kontoen eller manglende licens — kontakt din superbruger (se “Se også”).


## Dit udbytte

Efter denne guide kan du:

- Åbne Present på et møde i Salesforce.
- Vælge skabelon og de rigtige slides (også flere ad gangen).
- Udfylde de felter, der ikke fyldes automatisk.
- Generere præsentationen som PowerPoint og konvertere til PDF.
- Bruge redigerbare slides og aktive/interaktive links.


## Overblik

Du laver præsentationen i disse trin — typisk på **få minutter**:

- Trin 1: Åbn Present på mødet.
- Trin 2: Skriv en agenda (valgfrit).
- Trin 3: Vælg kundetype.
- Trin 4: Vælg sektioner og slides.
- Trin 5: Udfyld felter og generér.
- Trin 6: Åbn eller konverter til PDF.


## Trin-for-trin


### Trin 1 · Åbn Present på mødet

_Hvorfor: Present arbejder ud fra mødet og kunden, så data flettes korrekt ind._

- Åbn (eller opret) **mødet** på kundens konto i Salesforce.
- Klik fanen **Present** — Present-komponenten (Mødepræsentation) åbner.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/present/da/medarbejderguide/sf_present_komponent.png)

*Skærmbillede 1 (Present-komponent i Salesforce) — Mødet (Event) i Salesforce med fanen **Present** åben — Present-komponenten*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Present-komponenten vises med et agenda-felt, kundetype-faner og sektioner.


### Trin 2 · Skriv en agenda (valgfrit)

_Hvorfor: Agendaen kan flettes ind på et agenda-slide, så mødet starter struktureret._

- Skriv eller indsæt dagsordenen i **agenda-feltet** til venstre (punktopstilling bevares).
- Teksten gemmes automatisk, når du forlader feltet.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Agendaen er gemt — teksten bliver stående, når du forlader feltet.


### Trin 3 · Vælg kundetype (viser skabelonerne)

_Hvorfor: Kundetypen styrer, hvilke skabeloner der passer til netop denne kunde._

- Vælg den rette **kundetype** i fanerne øverst — kun skabeloner for den type vises.
- Skabelonerne for den valgte kundetype vises nu som **sektioner**, du vælger fra i Trin 4.
- Er **Filtre** tilgængelig, kan du indsnævre yderligere ved at vælge et mærkat (label).


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/present/da/medarbejderguide/present_wrapper.png)

*Skærmbillede 2 (Present-komponent i Salesforce) — Present-komponenten: Dagsorden, kundetype-faner og sektions-knapper*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Sektionerne for den valgte kundetype vises — klar til at vælge slides fra.


### Trin 4 · Vælg sektioner og slides

_Hvorfor: Du sammensætter præsentationen af præcis de slides, mødet har brug for._

- Klik en **sektion** (fx Agenda, Investering) — et vindue viser sektionens slides.
- Vælg slides: klik et enkelt (grøn ramme = valgt), eller brug **Vælg alle**/**Fravælg alle** for hele sektionen/undersektionen.
- Dobbeltklik et slide for en stor forhåndsvisning. En stjerne (*) markerer et anbefalet slide.
- Klik **Luk og tilføj valgte slides**.
- I listen over valgte slides kan du trække for at **ændre rækkefølgen** og bruge papirkurven for at fjerne et slide.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/present/da/medarbejderguide/sf_slide_vindue.png)

*Skærmbillede 3 (Present-komponent i Salesforce) — Slide-vinduet med **Vælg alle**/**Fravælg alle** og slides i et gitter*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** De valgte slides vises i listen “valgte slides” nederst, i den rækkefølge de kommer i præsentationen.


### Trin 5 · Udfyld felter og generér

_Hvorfor: Her sikrer du, at alt indhold er korrekt, før præsentationen dannes._

- Klik **Generér præsentation** — vinduet **Tekst der indsættes** åbner med felterne.
- **Felter med data fra Salesforce** er forudfyldt (fx **dato** og **kunde**). Du kan rette dem — ændringen gælder kun denne præsentation, ikke Salesforce.
- **Tomme felter** (vist som “Ingen værdi”) og redigerbare slides udfylder du selv. Felterne kan have tekniske navne (fx **dineforventninger**) — udfyld blot dem, du vil bruge.
- Klik **Generér præsentation** **nederst i vinduet** for at danne PowerPoint-filen (PPTX).
- **Vent et øjeblik**, mens filen dannes (typisk få sekunder til ca. 1 minut) — klik ikke flere gange.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/present/da/medarbejderguide/sf_felt_vindue.png)

*Skærmbillede 4 (Present-komponent i Salesforce) — Felt-vinduet “Tekst der indsættes”: forudfyldte felter (fra Salesforce, fx dato/kunde) + tomme felter, du selv udfylder*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du får beskeden om, at præsentationen er klar, og PowerPoint-filen gemmes på mødet under **Filer (Files)**.

{: .important }
> **Husk:** Står der [tag:...] som tekst i præsentationen, manglede feltet data — udfyld det i felt-vinduet, eller kontakt din superbruger.


### Trin 6 · Åbn eller konverter til PDF

_Hvorfor: Vælg det format, mødet kræver — redigerbar PowerPoint eller en PDF til udsendelse._

- Klik **Åbn præsentation** for at åbne PowerPoint-filen og evt. finjustere.
- Klik **Konverter til PDF** for en PDF-udgave (god til at sende eller printe).
- **Del med kunden**: send PDF’en, eller præsentér direkte fra PowerPoint-filen (fysisk møde eller Teams-skærmdeling).

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Filen (PowerPoint og/eller PDF) ligger på mødet under **Filer (Files)** og kan deles med kunden.


## Hvad betyder felterne?

Her er, hvad de enkelte valg styrer — så du ved, hvad du vælger:


| Felt / valg | Hvad det styrer | Betydning for præsentationen |
|---|---|---|
| Agenda (tekstfelt) | Mødets dagsorden | Flettes ind på slides med agenda; punktopstilling bevares. Udfyld før du genererer. |
| Kundetype (faner) | Hvilke skabeloner du ser | Kun skabeloner for den valgte kundetype vises — styrer hele udvalget. |
| Filtre / mærkat | Indsnævrer skabeloner | Viser kun skabeloner med det valgte mærkat (label); ændrer ikke indholdet. |
| Vælg alle / Fravælg alle | Markér mange slides på én gang | Tidsbesparende: tag hele sektionen og fravælg derefter enkelte. |
| Markér enkelt-slide | Tilføj/fjern ét slide | Grøn ramme = valgt. Dobbeltklik for stor forhåndsvisning. |
| Træk for at omrokere | Rækkefølgen af slides | Bestemmer rækkefølgen i den færdige præsentation. |
| Felter med Salesforce-data | Forudfyldt kundedata | Hentet automatisk; kan rettes — gælder kun denne præsentation, ikke Salesforce. |
| Tomme / redigerbare felter | Fri tekst du selv skriver | Til indhold der skifter fra møde til møde (fx mødefokus). |
| Generér præsentation | Danner PowerPoint-filen | Laver PowerPoint-filen (PPTX) ud fra valgte slides + felter; gemmes på mødet. |
| Konverter til PDF | PDF-udgave | Til udsendelse/print; gemmes ved siden af PowerPoint-filen. |


## Avancerede muligheder

- **Redigerbare slides**: nogle slides har felter, du selv udfylder i felt-vinduet (fx kundens mål) — din tekst kommer med i præsentationen.
- **Aktive links**: links til en hjemmeside er klikbare i præsentationsmode — ét klik åbner siden, og med **ALT+TAB** kommer du tilbage. På Teams-møder: del som **skærmdeling**, så kunden ser det samme.
- **Hyperlinks**: kan hoppe mellem slides (fx fra et logo tilbage til agenda-slidet).
- **Interaktive slides**: nogle slides har interaktive elementer, der gør mødet mere levende.

{: .note }
> **Bemærk:** Forhåndsvisningen i Salesforce er ikke altid retvisende. Disse understøttes ikke fuldt: **grafer, grafiske elementer, billedtyper, aktive links, interaktive slides og fonte**. Download og åbn **PowerPoint-filen** og præsentér derfra — ikke fra forhåndsvisningen.


## Fejlfinding

- Ingen **Present**-fane på mødet: kontrollér, at du har åbnet et **møde (Event)**, og at du har en Present-licens — ellers kontakt din superbruger.
- Ingen skabeloner vises: kontrollér, at kunden har en kundetype, og at du har en Present-licens — ellers kontakt din superbruger.
- “Generer”-knappen er grå: vælg mindst ét slide først.
- Der står [tag:...] som tekst i præsentationen: feltet manglede data — udfyld det i felt-vinduet, eller bed din superbruger tjekke skabelonen.
- Præsentationen ser forkert ud i Salesforce-forhåndsvisningen: download PowerPoint-filen — den ser korrekt ud i PowerPoint.
- Links/interaktive elementer virker ikke: du er i forhåndsvisningen — brug den downloadede PowerPoint-fil (ikke PDF).

### Se også
- [**Present – superbrugerguide (opsætning i Management UI)**](superbrugerguide) — hvis skabeloner, kundetyper eller felter mangler (superbruger/admin).
- [**Opsætning af master-slides (PowerPoint)**](superbrugerguide) — hvordan skabelonerne bygges (i superbrugerguiden).
- [**Present – FAQ**](faq-typiske-spoergsmaal-og-fejl) (typiske spørgsmål, fejl og svar).


## Seneste opdatering

- 09.06.2026 (v1.0) — Første version af medarbejderguiden til at generere en præsentation i Salesforce.


{: .hint }
> ✅ **Færdig!** Din kundepræsentation er nu dannet og ligger på mødet — klar til kunden.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 09.06.2026_
