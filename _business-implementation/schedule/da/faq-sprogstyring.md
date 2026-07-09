---
layout: "default"
title: "FAQ – Sprogstyring"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 414
lang: "da"
---
# Schedule – FAQ: Sprogstyring (flersproget booking)
_Typiske spørgsmål, fejl og svar · v1.0 · 02.07.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-sprogstyring.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-sprogstyring.pdf)

Hurtige svar på de mest almindelige spørgsmål om flersproget booking (Sprogstyring) i Schedule. Uddybende trin findes i **Schedule – superbrugerguide: Sprogstyring**.


## Kom godt i gang


**Hvad er Sprogstyring?**

Muligheden for at vise den kundevendte booking på **flere sprog**. I aktiverer bankens sprog under **Admin → Sprogstyring** og indtaster oversættelser i **Schedule → Mødeopsætning**. Dansk er altid fallback.


**Hvor aktiverer jeg et sprog?**

Under **Admin → Sprogstyring**. Klik **+ Tilføj sprog** og vælg sproget. Det gemmes med det samme (“Sprog opdateret”).


**Hvilke sprog kan aktiveres?**

Dansk (da-DK, altid primær), britisk engelsk (en-GB), grønlandsk/kalaallisut (kl-GL), svensk (sv-SE), norsk bokmål (nb-NO), tysk (de-DE / de-AT), fransk (fr-FR / fr-BE), finsk (fi-FI) og færøsk (fo-FO). Er sproget ikke på listen, er det ikke understøttet endnu — kontakt &money.


**Hvor indtaster jeg selve oversættelserne?**

To steder i Mødeopsætning: **Generelt (Standardværdier)** — mødetype-navne, medarbejdertype-navne, iCal-titel/-beskrivelse — og **Mødeemner** — emne- og underemne-navne.


## Fallback og adfærd


**Hvad sker der, hvis en oversættelse mangler?**

Så vises den **danske** tekst. Kunden ser aldrig en tom værdi. Derfor er det danske felt påkrævet.


**Kan jeg fjerne dansk?**

Nej. Dansk (da-DK) er primært sprog og altid fallback — det kan ikke fjernes.


**Hvordan tilføjer jeg en oversættelse til et felt?**

Skriv den danske tekst, og **klik en sprogkode** under det danske felt (fx en-GB) for at skrive oversættelsen. Brug **Vis/Skjul oversættelser** til at folde sprogene ud/sammen.


**Hvordan ved jeg, at et felt er færdigoversat?**

Feltets status viser fx “Alle oversættelser er færdige” eller “Oversættelser: 2 / 3 oversat — mangler: …”.


**Kan jeg fortryde en oversættelse?**

Ja — ryd sprogfeltet og gem, så falder feltet tilbage til dansk.


## Typiske fejl


**Jeg har indtastet oversættelsen, men kunden ser stadig dansk.**

Tjek at du klikkede **Gem** (Generelt) eller **Opret**/**Gem** (Mødeemne). Ændringen vises i bookingen, næste gang kunden åbner den.


**Et sprog kan ikke vælges som sprogkode på felterne.**

Sproget er ikke aktiveret for banken — tilføj det under **Admin → Sprogstyring** først.


**Jeg fjernede et sprog — er mine oversættelser væk?**

Nej. De **bevares** og vises automatisk igen, hvis sproget aktiveres på ny. De er blot skjult for kunderne imens.


**Knapper og bekræftelser er ikke oversat.**

De ejes af jeres **bookingportal/integrator** — de ligger uden for disse felter.


## Adgang og roller


**Hvem kan bruge Sprogstyring?**

Aktivering af sprog kræver adgang til **Admin**; indtastning af oversættelser kræver **Configurator**/**Admin** i Mødeopsætning. Kontakt din administrator ved manglende adgang.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 02.07.2026_
