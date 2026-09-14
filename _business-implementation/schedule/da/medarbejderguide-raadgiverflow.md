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

Med rådgiverflowet booker du et kundemøde direkte fra kundens side i Salesforce. Du vælger emne, lokation og mødetype, og Schedule finder de ledige tider. Når du bekræfter, lander mødet i din kalender og i Salesforce på én gang.


## Før du går i gang

- Du står på en **kunde** i Salesforce: en Account, Opportunity, Lead eller Case. Fra en Contact kan du ikke booke.
- Du har adgang til **Mødebooking** på kundens side. Mangler knappen, så kontakt din superbruger.

{: .note }
> **Bemærk:** Jeres bank kan selv omdøbe knapper og felter. Navnene i denne guide er standardnavnene.


## Overblik

1. Åbn kunden → **Book møde**.
2. Vælg **emne**.
3. Vælg **lokation**, rådgiver og en **ledig tid** → **Fortsæt**.
4. Vælg **mødetype**, tilføj deltagere og evt. adresser → **Book møde**.
5. Se **bekræftelsen** → **Luk mødebooking**.

Øverst i flowet ser du tre trin: **Emne**, **Dato og tid** og **Bekræftelse**. Pilen øverst til venstre tager dig et trin tilbage.


## Trin-for-trin (Salesforce)


### Trin 1 · Start bookingen fra kunden

- Åbn kunden i Salesforce, og find området **Mødebooking**.
- Klik **Book møde**.

<!-- screenshot: kundens side i Salesforce med området "Mødebooking" og knappen "Book møde" -->


### Trin 2 · Vælg emne

_Emnet bestemmer, hvilke rådgivere, mødetyper og mødelængder Schedule tilbyder._

- Klik på det **emne**, mødet handler om. Har emnet underemner, vælger du også et **underemne**.

{: .note }
> **Bemærk:** Mangler et emne på listen, er det ikke sat op til booking hos jer. Spørg din superbruger.


### Trin 3 · Vælg lokation, rådgiver og tid

Skærmen hedder **Tilpas hvilke ledige tider du ser**.

- Under **Valg af rådgiver** vælger du **Specifik medarbejder**, **Center** (alle på lokationen) eller **Alle tilgængelige**.
- Under **Vælg lokation** står kundens egen lokation. Skal mødet holdes et andet sted, så skriv en del af navnet, og vælg fra listen.
- Under **Valg af tidspunkt** ser du ledige tider. Vælg **Manuel**, hvis du selv vil taste dato og tid.
- Klik på den tid, du vil booke. Ser du ingen passende tid, så klik **Hent flere tider** eller prøv **Filtre**.
- Klik **Fortsæt**.

<!-- screenshot: skærmen "Tilpas hvilke ledige tider du ser" med "Valg af rådgiver", "Vælg lokation" (med visningsnavn), "Valg af tidspunkt" og listen af ledige tider -->

{: .note }
> **Bemærk:** Lokationer vises med det navn, I bruger til daglig, fx “Filial Aarhus C”. Det er jeres superbruger, der sætter navnet op under **Mødeopsætning → Lokationer**. Er der ikke sat et navn, ser du det interne navn. Kræver Schedule-pakke 1.30.0 eller nyere.


### Trin 4 · Vælg mødetype og udfyld mødet

Skærmen hedder **Book mødet**. Tjek først, at **Lokation**, **Dato**, **Tid** og **Emne** øverst er rigtige. Vil du en anden tid, så klik **Vælg et andet møde**.

- Under **Vælg mødetype** vælger du fysisk, online, telefon eller ude af huset.
- Fysisk møde: vælg et lokale under **Mødelokale**.
- Ude af huset: udfyld **Startaddresse** og **Slutaddresse**. Se Trin 5.
- Giv evt. mødet en **Mødetitel**, og skriv en **uddybelse** af, hvad kunden vil tale om.
- Tilføj kundens deltagere med **Søg i kundekontakter** eller **Tilføj kundedeltager**.
- **Send mødebekræftelse til kundedeltagere** gemmer, om kunden skal have besked. Selve beskeden sender jeres egen opsætning i Salesforce.

<!-- screenshot: skærmen "Book mødet" med "Vælg mødetype", "Mødetitel", "Mødelokale", uddybelsesfeltet, deltagere og knappen "Book møde" -->

{: .note }
> **Bemærk:** Knappen **Book møde** er grå, indtil mødet er komplet: mødetype, mindst én deltager og, ved møder ude af huset, en slutadresse.


### Trin 5 · Møder ude af huset: start- og slutadresse

_Schedule bruger adresserne til at beregne køretid og sætte den af i din kalender. Slutadressen bruger banken også i sine skabeloner, så den er obligatorisk._

- **Startaddresse** er udfyldt på forhånd, hvis du har en fast adresse på din profil.
- Under **Slutaddresse** skriver du, hvor mødet holdes. Skriv mindst tre tegn, og vælg adressen fra listen.
- Klikker du på et **vejnavn** i listen, viser Schedule adresserne på den vej.

Under feltet ser du, om det lykkedes:

- **Addresse fundet** ✓: Adressen er valgt fra listen, og Schedule beregner køretid.
- **Addresse ikke fundet**: Du har skrevet en tekst uden at vælge fra listen. Du kan stadig booke, men uden køretid.
- **Der opstod en fejl. Adressesøgning er ikke tilgængelig i øjeblikket.**: Adressetjenesten svarer ikke. Prøv igen om lidt, eller book med adressen som tekst.

<!-- screenshot: felterne "Startaddresse" og "Slutaddresse" med en forslagsliste åben under slutadressen og teksten "Addresse fundet" under startadressen -->

{: .important }
> **Husk:** **Slutaddresse** skal udfyldes ved møder ude af huset. Ellers er **Book møde** grå.

{: .note }
> **Bemærk:** Søg på gadeadressen, fx “Vesterbrogade 3, 1630 København V”. Stednavne som “Tivoli” virker ikke længere.


### Trin 6 · Book og bekræft

_Schedule holder den valgte tid for dig i fem minutter. Klikker du ikke **Book møde** inden da, bliver tiden ledig igen._

- Klik **Book møde**.
- Skærmen **Bekræftelse** viser dato, tid, lokation, mødetype, emne og rådgivere.
- Klik **Luk mødebooking**.

<!-- screenshot: skærmen "Bekræftelse" med "Lokation" vist med visningsnavn, "Mødetype", "Emne for mødet" og "Rådgivere" -->

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Mødet står under **Mødebooking** på kunden og i din kalender.


## Fejlfinding

- **Book møde** er grå: Tjek mødetype, deltager og slutadresse. Lige efter du har valgt en adresse, henter Schedule dens position; vent et sekund.
- **Addresse ikke fundet**: Skriv en del af adressen igen, og klik på det rigtige forslag.
- Adresselisten er tom: Skriv mindst tre tegn, og søg på gadeadressen, ikke et stednavn.
- Ingen ledige tider: Prøv **Alle tilgængelige** under **Valg af rådgiver**, fjern filtre, eller klik **Hent flere tider**.
- Lokationen står med et internt navn: Jeres superbruger har ikke sat et visningsnavn op endnu.
- Jeg kan ikke finde lokationen: Er den ikke på listen, er den ikke sat op i Schedule. Spørg din superbruger.


### Se også
- [Address Lookup for Offsite Meetings]({{ site.baseurl }}/bookme/address-lookup/) — teknisk beskrivelse af adressesøgningen (engelsk).
- **Schedule – superbrugerguide: Mødeopsætning** — lokationer, visningsnavne og mødetyper.


## Seneste opdatering

- 14.09.2026 (v1.0) — Første version (booking fra Salesforce, visningsnavn på lokation, adressesøgning og krav om slutadresse).


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 14.09.2026_
