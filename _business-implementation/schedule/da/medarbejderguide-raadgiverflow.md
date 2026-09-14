---
layout: "default"
title: "Medarbejderguide – Rådgiverflow (Salesforce)"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 301
lang: "da"
---
# Schedule – medarbejderguide: Rådgiverflow
_Sådan booker du et kundemøde fra Salesforce · v1.0 · 14.09.2026_

<!-- download: 📄 Hent denne guide: DOCX/PDF-links indsættes, når filerne er lagt under files/business-implementation/schedule/da/ -->

## Formål og værdi

Med rådgiverflowet booker du et kundemøde direkte fra kundens side i Salesforce. Du vælger emne, lokation og mødetype, og Schedule finder de ledige tider for dig. Når du bekræfter, lægger Schedule mødet i din kalender og opretter mødet i Salesforce. Så slipper du for at slå kalendere op og taste mødet ind to steder.

### Ordliste
- **Rådgiverflowet**: Bookingkomponenten på kundens side i Salesforce, hvor du som medarbejder booker et møde for eller med en kunde.
- **Emne og underemne**: Det, mødet handler om (fx “Bolig” → “Køb af bolig”). Emnet styrer, hvilke rådgivere, mødetyper og varigheder der tilbydes.
- **Lokation**: Den filial eller det center, mødet holdes i. Lokationen afgør, hvilke rådgivere og lokaler der er i spil.
- **Visningsnavn**: Det navn på en lokation, som jeres superbruger har valgt i Schedule. Er der ikke sat et visningsnavn, ser du det interne navn fra jeres brugerkatalog.
- **Mødetype**: Hvordan mødet holdes: fysisk, online, telefon eller ude af huset. Jeres bank bestemmer selv, hvad mødetyperne hedder hos jer.
- **Ude af huset**: Et møde, hvor du kører ud til kunden. Her angiver du en startadresse og en slutadresse, så Schedule kan sætte køretid af i din kalender.
- **Adressevælgeren**: Den nationale adressetjeneste, som foreslår adresser, mens du skriver.


## Målgruppe og forudsætninger

- Målgruppe: rådgiver eller anden medarbejder, der booker kundemøder fra Salesforce.
- Du har **adgang til mødebooking** i Salesforce. Mangler knappen, så kontakt din superbruger.
- Du står på en **kunde** i Salesforce, dvs. en Account, Opportunity, Lead eller Case. Fra en Contact kan du ikke booke.
- Din browser kan nå adressetjenesten, hvis du booker møder ude af huset. Det er normalt allerede på plads hos jer.

{: .note }
> **Bemærk:** Knapper og felter kan hedde lidt andet hos jer. Jeres bank kan selv omdøbe teksterne i pakken. Navnene i denne guide er standardnavnene.


## Dit udbytte

Efter denne guide kan du:

- Starte en booking fra kundens side og vælge emne.
- Vælge den rigtige lokation ud fra det navn, I bruger til daglig.
- Finde en ledig tid for én rådgiver, for en lokation eller for alle.
- Vælge mødetype og udfylde mødet.
- Booke et møde ude af huset med en korrekt slutadresse.
- Forstå, hvad Schedule fortæller dig undervejs, og hvad du gør, hvis noget driller.


## Overblik

- Åbn kunden → **Book møde**.
- Vælg **emne** (og evt. underemne).
- Vælg **lokation**, hvem der skal holde mødet, og en **ledig tid** → **Fortsæt**.
- Vælg **mødetype**, tilføj deltagere og evt. adresser → **Book møde**.
- Se **bekræftelsen** → **Luk mødebooking**.

Øverst i flowet ser du tre trin: **Emne**, **Dato og tid** og **Bekræftelse**. Du kan altid gå et trin tilbage med pilen øverst til venstre.


## Trin-for-trin (Salesforce)


### Trin 1 · Start bookingen fra kunden

_Hvorfor: Mødet skal hænge på den rigtige kunde, så det havner det rigtige sted i Salesforce._

- Åbn kunden i Salesforce.
- Find området **Mødebooking**. Her ser du kundens kommende møder.
- Klik **Book møde**.

<!-- screenshot: kundens side i Salesforce med området "Mødebooking" og knappen "Book møde" -->

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du ser skærmen **Vælg emne**.


### Trin 2 · Vælg emne

_Hvorfor: Emnet bestemmer, hvilke rådgivere, mødetyper og mødelængder Schedule tilbyder._

- Klik på det **emne**, mødet handler om.
- Har emnet underemner, ser du skærmen **Vælg underemne**. Klik på det underemne, der passer bedst.

{: .note }
> **Bemærk:** Ser du ikke det emne, du leder efter, er det ikke sat op til booking hos jer. Spørg din superbruger.


### Trin 3 · Vælg lokation, rådgiver og tid

_Hvorfor: Her fortæller du Schedule, hvor og med hvem mødet skal holdes. Så viser Schedule kun de tider, der reelt er ledige._

Skærmen hedder **Tilpas hvilke ledige tider du ser**.

- Under **Valg af rådgiver** vælger du, hvem der skal holde mødet:
  - **Specifik medarbejder**: Du søger en bestemt rådgiver frem.
  - **Center**: Alle rådgivere på den valgte lokation.
  - **Alle tilgængelige**: Alle rådgivere, der kan tage mødet.
- Under **Vælg lokation** står kundens egen lokation som udgangspunkt. Skal mødet holdes et andet sted, så skriv en del af navnet, og vælg lokationen fra listen.
- Under **Mødelokale** kan du vælge et lokale, hvis jeres opsætning kræver det.
- Under **Valg af tidspunkt** vælger du **Vælg ledig tidspunkt** for at se ledige tider, eller **Manuel** for selv at taste dato, starttid og varighed.
- Brug **Filtre** til at skære tiderne til, fx **Vis kun tider med ledigt lokale** eller **Vis kun tider som kunden ser**.
- Klik på den tid, du vil booke. Ser du ikke en passende tid, så klik **Hent flere tider**.
- Klik **Fortsæt**.

<!-- screenshot: skærmen "Tilpas hvilke ledige tider du ser" med "Valg af rådgiver", "Vælg lokation" (med visningsnavn), "Valg af tidspunkt" og listen af ledige tider -->

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du ser skærmen **Book mødet** med **Lokation**, **Dato**, **Tid** og **Emne for mødet** udfyldt øverst.

{: .note }
> **Bemærk:** Lokationen vises med det navn, I bruger til daglig, ikke det interne navn. Læs mere under **Lokationens navn** nedenfor.


### Trin 4 · Vælg mødetype og udfyld mødet

_Hvorfor: Mødetypen afgør, om Schedule skal finde et lokale, sende et online-link eller sætte køretid af._

Skærmen hedder **Book mødet**.

- Under **Vælg mødetype** vælger du, hvordan mødet holdes: fysisk, online, telefon eller ude af huset.
- Ved et fysisk møde vælger du et lokale under **Mødelokale**. Står der **Ingen ledige lokaler**, er alle lokaler optaget på det tidspunkt.
- Ved et møde ude af huset udfylder du **Startaddresse** og **Slutaddresse**. Se Trin 5.
- Giv evt. mødet en **Mødetitel**.
- Skriv en **uddybelse** af, hvad kunden gerne vil tale om. Teksten kommer med i mødet.
- Tilføj kundens deltagere med **Søg i kundekontakter** eller **Tilføj kundedeltager**. Under **Bankens deltagere** ser du de rådgivere, der deltager.
- Lad **Send mødebekræftelse til kundedeltagere** være markeret, hvis kunden skal have besked efter jeres opsætning.

<!-- screenshot: skærmen "Book mødet" med "Vælg mødetype", "Mødetitel", "Mødelokale", uddybelsesfeltet, deltagere og knappen "Book møde" -->

{: .note }
> **Bemærk:** Knappen **Book møde** er grå, indtil mødet er komplet. Det sker typisk, fordi der mangler en mødetype, en deltager eller en slutadresse ved et møde ude af huset.


### Trin 5 · Møder ude af huset: start- og slutadresse

_Hvorfor: Schedule bruger adresserne til at beregne køretid og sætte den af i din kalender. Slutadressen bruger banken også i sine skabeloner, så den er obligatorisk._

- Under **Startaddresse** står din faste startadresse, hvis den er sat op på din profil. Ellers skriver du, hvor du kører fra.
- Under **Slutaddresse** skriver du, hvor mødet holdes, typisk kundens adresse.
- Skriv mindst tre tegn, fx “Vesterbrog”. Forslagene kommer efter et kort øjeblik.
- Vælg den rigtige adresse fra listen. Så får adressen en position, og Schedule kan beregne køretid.
- Ser du en **vejnavn-række** uden husnummer, kan du klikke på den. Så udfylder Schedule vejnavnet og viser adresserne på den vej.

Under feltet fortæller Schedule dig, hvor langt du er:

- **Addresse fundet** med et grønt flueben: Adressen er valgt fra listen og har en position.
- **Addresse ikke fundet** med en advarsel: Du har skrevet en tekst, men ikke valgt fra listen. Adressen gemmes som tekst, men Schedule beregner ingen køretid.
- **Der opstod en fejl. Adressesøgning er ikke tilgængelig i øjeblikket.**: Adressetjenesten svarer ikke. Prøv igen om lidt. Du kan stadig booke med adressen som ren tekst.

<!-- screenshot: felterne "Startaddresse" og "Slutaddresse" med en forslagsliste åben under slutadressen og teksten "Addresse fundet" under startadressen -->

{: .important }
> **Husk:** **Slutaddresse** skal udfyldes ved møder ude af huset. Er feltet tomt, er knappen **Book møde** grå, og du kan ikke booke. Det gælder for alle banker.

{: .note }
> **Bemærk:** Du kan ikke længere søge på stednavne som “Tivoli”. Skriv i stedet gadeadressen, fx “Vesterbrogade 3, 1630 København V”.

{: .note }
> **Bemærk:** Har du faste adresser på din profil, finder Schedule dem frem igen, hver gang du åbner en booking. Du skal ikke gøre noget.


### Trin 6 · Book og bekræft

_Hvorfor: Først når du klikker **Book møde**, reserverer Schedule tiden og opretter mødet i Salesforce._

- Tjek, at **Lokation**, **Dato**, **Tid** og **Emne for mødet** øverst er rigtige.
- Vil du vælge en anden tid, så klik **Vælg et andet møde**.
- Klik **Book møde**.
- Skærmen **Bekræftelse** viser mødets dato, tid, lokation, lokale, mødetype, emne og rådgivere.
- Klik **Luk mødebooking**.

<!-- screenshot: skærmen "Bekræftelse" med "Lokation" vist med visningsnavn, "Mødetype", "Emne for mødet" og "Rådgivere" -->

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Mødet står på listen under **Mødebooking** på kunden og i din kalender.


## Lokationens navn – hvad du ser

Når du vælger en lokation, viser Schedule det **visningsnavn**, jeres superbruger har sat op i Schedule. Det er typisk det navn, I bruger til daglig, fx “Filial Aarhus C” frem for en intern kode. Har superbrugeren ikke sat et visningsnavn, ser du det interne navn fra jeres brugerkatalog.

Visningsnavnet følger med hele vejen: i lokationsvælgeren, øverst på **Book mødet** og på **Bekræftelse**. Bag skærmen bruger Schedule stadig det interne navn, så mødet lander det rigtige sted.

Kræver BookMe-pakke 1.29.0 eller nyere.

{: .note }
> **Bemærk:** Ser du stadig interne navne, kan det være, at jeres superbruger ikke har sat visningsnavne op endnu. Superbrugeren gør det under **Mødeopsætning → Lokationer** i Schedule.


## Hvad betyder felterne?

Her er, hvad de enkelte valg styrer, så du ved, hvad du vælger:


| Felt / valg | Hvad det styrer | Betydning for mødet |
|---|---|---|
| Emne / underemne | Hvad mødet handler om | Styrer, hvilke rådgivere, mødetyper og varigheder du får tilbudt. |
| Valg af rådgiver | Hvem der kan tage mødet | Specifik medarbejder, alle på lokationen (**Center**) eller alle tilgængelige. |
| Vælg lokation | Hvor mødet holdes | Afgør rådgivere og lokaler. Vises med visningsnavn. |
| Valg af tidspunkt | Ledige tider eller manuel tid | **Vælg ledig tidspunkt** følger jeres regler. **Manuel** lader dig selv taste tiden. |
| Filtre | Hvilke tider du ser | Fx kun tider med ledigt lokale, eller kun tider kunden selv ville se. |
| Vælg mødetype | Hvordan mødet holdes | Fysisk giver et lokale. Ude af huset giver adressefelter og køretid. |
| Mødelokale | Lokalet ved fysisk møde | Lokalet reserveres sammen med mødet. |
| Startaddresse / Slutaddresse | Kørsel ved møde ude af huset | Køretid beregnes, når adressen er valgt fra listen. Slutadressen er obligatorisk. |
| Mødetitel | Mødets navn | Bruges som titel på mødet i Salesforce. |
| Uddybelse | Hvad kunden vil tale om | Kommer med i mødets beskrivelse. |
| Send mødebekræftelse til kundedeltagere | Besked til kunden | Om kunden skal have besked. Afhænger af jeres opsætning. |
| Book møde | Reserverer tiden | Opretter mødet i din kalender og i Salesforce. |


## Fejlfinding

- Knappen **Book møde** er grå: Tjek, at du har valgt en mødetype, at der er mindst én deltager, og at **Slutaddresse** er udfyldt ved et møde ude af huset.
- Knappen **Book møde** er grå et kort øjeblik, lige efter du har valgt en adresse: Schedule henter adressens position. Vent et sekund og prøv igen.
- Der står **Addresse ikke fundet** under adressen: Du har ikke valgt fra listen. Skriv en del af adressen igen, og klik på det rigtige forslag.
- Listen af adresser er tom: Skriv mindst tre tegn. Søg på gadeadressen, ikke på et stednavn som “Tivoli”.
- Der står **Der opstod en fejl. Adressesøgning er ikke tilgængelig i øjeblikket.**: Adressetjenesten svarer ikke lige nu. Prøv igen om lidt. Sker det tit, så kontakt din superbruger.
- Lokationen vises med et internt navn: Jeres superbruger har ikke sat et visningsnavn op for den lokation.
- Jeg kan ikke finde lokationen: Skriv en del af det navn, I bruger til daglig. Er lokationen ikke på listen, er den ikke sat op i Schedule.
- Ingen ledige tider: Prøv **Alle tilgængelige** under **Valg af rådgiver**, fjern filtre, eller klik **Hent flere tider**. Er der stadig ingen tider, så spørg din superbruger.
- Jeg kan ikke booke fra en Contact: Det er ikke muligt. Åbn kundens Account, Opportunity, Lead eller Case i stedet.

Flere typiske spørgsmål og fejl: se **Schedule – FAQ**.


## Ofte stillede spørgsmål

**Hvorfor skal jeg udfylde en slutadresse ved møder ude af huset?**
Banken bruger slutadressen i sine skabeloner og til at beregne din køretid. Uden adressen står felterne tomme, og køretiden kommer ikke i din kalender.

**Kan jeg booke, selv om adressen ikke bliver fundet?**
Ja. Adressen gemmes som tekst, og du kan booke. Men Schedule beregner ingen køretid, før adressen er valgt fra listen.

**Hvorfor kan jeg ikke søge på “Tivoli” længere?**
Adressetjenesten kender kun adresser og vejnavne, ikke stednavne. Skriv gadeadressen i stedet.

**Hvad sker der med mine faste adresser?**
De bliver stående på din profil og bliver fundet frem igen, hver gang du åbner en booking. Du behøver ikke at taste dem igen.

**Hvorfor ser jeg et andet navn på lokationen end før?**
Jeres superbruger har sat et visningsnavn op. Mødet lander stadig på den samme lokation.

**Hvem ændrer visningsnavnet på en lokation?**
Din superbruger, under **Mødeopsætning → Lokationer** i Schedule.

### Se også
- [Address Lookup for Offsite Meetings]({{ site.baseurl }}/bookme/address-lookup/) — teknisk beskrivelse af adressesøgningen (engelsk).
- **Schedule – superbrugerguide: Mødeopsætning** — lokationer, visningsnavne og mødetyper.
- **Schedule – FAQ (typiske spørgsmål og fejl)**.


## Seneste opdatering

- 14.09.2026 (v1.0) — Første version (booking fra Salesforce, visningsnavn på lokation, adressesøgning og krav om slutadresse).


{: .hint }
> ✅ **Færdig!** Du har booket et kundemøde fra Salesforce.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 14.09.2026_
