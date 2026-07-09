---
layout: "default"
title: "Superbrugerguide – flersproget booking"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 208
lang: "da"
---
# Schedule – superbrugerguide: Sprogstyring (flersproget booking)
_Vis den kundevendte booking på flere sprog — dansk, engelsk, grønlandsk m.fl. · v1.1 · 02.07.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-flersproget-booking.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-flersproget-booking.pdf)

## Formål og værdi

**Sprogstyring** gør det muligt at vise den kundevendte booking på **flere sprog** — fx dansk, engelsk og grønlandsk (kalaallisut) — så også kunder, der ikke taler dansk, kan booke møder **selv**, uden manuel hjælp. I aktiverer bankens sprog under **Admin → Sprogstyring** og indtaster oversættelserne direkte i **Schedule → Mødeopsætning**. Oversættelserne **gemmes og bruges i den kundevendte booking** — teksten vises på kundens sprog, og dansk bruges automatisk, hvor en oversættelse mangler.

{: .note }
> **Bemærk:** **Dansk er altid fallback.** Mangler en oversættelse for et felt, vises den danske tekst — kunden ser aldrig en tom værdi. Dansk (da-DK) kan derfor ikke fravælges.


## Hvad kan oversættes — og hvad I ikke selv styrer

I oversætter udvalgte **navne og titler** i selve booking-indholdet. Det gøres **to steder** i Mødeopsætning. Den omkringliggende flow-tekst (knapper, vejledninger, bekræftelser, e-mails) ejes af jeres **bookingportal/integrator** — ikke af disse felter.


| Hvad I oversætter | Hvor i Management UI | Hvad kunden ser |
|---|---|---|
| Navngivning af mødetyper (Fysisk · Online · Telefon · Andet sted) | Mødeopsætning → Generelt (Standardværdier) | Mødetypens navn i booking |
| Navngivning af medarbejdertyper | Mødeopsætning → Generelt (Standardværdier) | Den type medarbejder, kunden booker |
| iCal-mødetitel og -beskrivelse | Mødeopsætning → Generelt (Standardværdier) | Titel/beskrivelse i kalenderinvitationen |
| Mødeemner og underemner | Mødeopsætning → Mødeemner | De emner, kunden vælger imellem |

{: .important }
> **Husk:** Bekræftelser, e-mail-skabeloner og den omkringliggende portaltekst er **uden for** Sprogstyring — dem leverer jeres bookingportal/integrator. Maskinoversættelse bruges ikke; I indtaster selv oversættelserne.


## Målgruppe og forudsætninger

- **Rolle:** administrator/superbruger med adgang til både Admin og Schedule-opsætning i Management UI.
- **Sprog aktiveret:** de sprog, I vil oversætte til, skal være slået til for banken under **Admin → Sprogstyring** (dansk er altid aktivt).
- **Oversættelser klar:** hav de færdige oversættelser klar, før I taster — fx grønlandske (kalaallisut) tekster, som I selv indhenter. &money oversætter ikke for jer.


## Overblik (quickguide)

- 1) **Admin → Sprogstyring:** aktivér de sprog, banken skal kunne oprette indhold på.
- 2) **Mødeopsætning → Generelt:** oversæt mødetype-navne, medarbejdertype-navne og iCal-titel/-beskrivelse.
- 3) **Mødeopsætning → Mødeemner:** oversæt emne- og underemne-navne.
- 4) Oversættelserne **gemmes** og vises automatisk i den kundevendte booking; dansk bruges, hvor noget mangler.

{: .note }
> **Bemærk:** Sprogfelterne vises **dynamisk** ud fra de sprog, jeres bank har aktiveret — ikke et fast antal. Har banken kun dansk + engelsk aktiveret, kan I kun tilføje engelsk oversættelse.


## Sådan tilføjer du en oversættelse (samme mekanik overalt)

Alle oversættelsesfelter fungerer ens: **det danske felt er altid synligt**, og under det ligger en række **sprogkoder** for bankens øvrige sprog. Klik på en sprogkode for at folde feltet ud og skrive oversættelsen.

- Skriv den danske tekst i hovedfeltet (**påkrævet**).
- **Klik på en sprogkode** under det danske felt (fx **en-GB** eller **kl-GL**) for at tilføje en oversættelse på det sprog.
- Brug **Vis oversættelser / Skjul oversættelser** til at folde alle sprog ud eller sammen.
- Et tomt sprogfelt **falder tilbage til dansk** — du behøver ikke udfylde alle sprog med det samme.

{: .note }
> **Bemærk:** Feltet viser en status, fx **“Alle oversættelser er færdige”** eller **“Oversættelser: 2 / 3 oversat”**, så du kan se, hvad der mangler.


## Trin for trin


### Trin 1 · Aktivér bankens sprog (Admin → Sprogstyring)

_Hvorfor: Sprogfelterne i Mødeopsætning vises ud fra de sprog, banken har aktiveret — så start med at slå de rigtige sprog til. Deaktiverede sprog vises ikke til kunderne._

- Gå til **Management UI → Admin → Sprogstyring**.
- Klik **+ Tilføj sprog** og vælg det sprog, banken skal kunne oprette indhold på (fx **britisk engelsk (en-GB)** eller **kl / Grønland (kl-GL)**).
- **Dansk (da-DK)** står som **Primær** og kan ikke fjernes — det er altid fallback.
- Sproget gemmes **med det samme** (du får beskeden “Sprog opdateret”) — der er ingen separat gem-knap her.

{: .important }
> **Husk:** Fjerner du et sprog (papirkurv-ikonet), skjules det for kunderne, men **de oversættelser, I allerede har lavet, bevares** og vises igen, hvis sproget aktiveres på ny.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-flersproget-booking/sprog_admin.png)

*Skærmbillede 1 (Admin → Sprogstyring) — Admin → Sprogstyring — bankens aktiverede sprog med “Primær”-markering på dansk og knappen “Tilføj sprog”.*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Sproget står nu i listen med sin sprogkode (fx en-GB), og beskeden “Sprog opdateret” bekræfter, at det er gemt. Nu kan I tilføje oversættelser på det sprog i Mødeopsætning.

{: .note }
> **Bemærk:** Mulige sprog at aktivere: dansk (da-DK, altid primær), britisk engelsk (en-GB), grønlandsk/kalaallisut (kl-GL), svensk (sv-SE), norsk bokmål (nb-NO), tysk (de-DE / de-AT), fransk (fr-FR / fr-BE), finsk (fi-FI) og færøsk (fo-FO). Kan I ikke vælge et ønsket sprog, er det ikke understøttet endnu — kontakt &money.


### Trin 2 · Oversæt mødetyper, medarbejdertyper og iCal-tekster (Generelt)

_Hvorfor: De tre feltgrupper sætter I ét sted — under Generelt (Standardværdier) — og de optræder direkte i kundens booking og kalenderaftale._

- Gå til **Management UI → Schedule → Mødeopsætning → Generelt** (fanen **Standard værdier**).
- Under **Navngivning af mødetyper** og **Navngivning af medarbejdertyper**: udfyld **Navn**, og klik en sprogkode under det danske felt for at tilføje oversættelsen pr. sprog.
- Under **iCal**: oversæt **Mødetitel** og **Beskrivelse** — det er dem, kunden ser i sin kalenderinvitation.
- Klik **Gem** nederst til højre for at gemme ændringerne.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-flersproget-booking/sprog_generelt.png)

*Skærmbillede 2 (Schedule → Mødeopsætning → Generelt) — Generelt (Standardværdier) — flersprogede felter med det danske felt og statuslinjen “Ingen oversættelser endnu — falder tilbage til dansk” (mødetype- og medarbejdertype-navngivning).*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Efter **Gem** skifter feltets status fra “Ingen oversættelser endnu” til fx “Oversættelser: 2 / 3 oversat” eller “Alle oversættelser er færdige”.


### Trin 3 · Oversæt mødeemner og underemner (Mødeemner)

_Hvorfor: Emnerne er det, kunden vælger imellem, når de booker — derfor er de centrale for en forståelig oplevelse på alle sprog._

- Gå til **Management UI → Schedule → Mødeopsætning → Mødeemner**.
- Klik **Opret emne** (eller blyant-ikonet for at redigere et eksisterende emne).
- Udfyld **Navn** (emne) og **Underemne** — klik en sprogkode under det danske felt for hver oversættelse.
- Klik **Opret** (eller **Gem**) i dialogen for at gemme.


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-flersproget-booking/sprog_moedeemner.png)

*Skærmbillede 3 (Schedule → Mødeopsætning → Mødeemner) — Mødeemner — “Opret mødeemne”-dialogen med flersproget Navn (emne) og Underemne.*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Feltets status viser “Alle oversættelser er færdige”, og et udfyldt sprogfelt vises til kunder, der booker på det sprog — dansk bruges, hvor en oversættelse mangler.


## Konsekvens og fallback — vigtigt at forstå

- **Manglende oversættelse = dansk.** Et tomt sprogfelt giver ikke en tom tekst hos kunden — den danske tekst vises i stedet.
- **Dansk kan ikke fravælges** og er altid fallback; derfor er det danske felt påkrævet.
- **Deaktiverede sprog vises ikke** til kunderne — men allerede indtastede oversættelser bevares, hvis sproget slås til igen.
- **Ændringer gemmes og slår igennem i drift** — ret med omtanke, og tjek den kundevendte booking bagefter.
- **Kun navne/titler i disse to områder** er flersprogede. Ser kunden dansk i knapper/bekræftelser, er det jeres bookingportal/integrators tekst — ikke disse felter.


## Hvem gør hvad


| Opgave | Hvem |
|---|---|
| Aktivere bankens sprog (Admin → Sprogstyring) | Jer (bank-admin) i Management UI |
| Indtaste oversættelser (Generelt + Mødeemner) | Jer (bank-admin) i Management UI |
| Levere selve oversættelserne (fx grønlandsk/kalaallisut) | Jer / jeres sprogleverandør |
| Omkringliggende flow-tekst, bekræftelser, e-mails | Jeres bookingportal/integrator |
| Platform: flersprogede felter + levering til booking | &money |


## Fejlfinding


| Symptom | Sandsynlig årsag → handling |
|---|---|
| Kunden ser dansk, selvom de valgte engelsk | Engelsk oversættelse mangler for feltet → udfyld den i Mødeopsætning (dansk er fallback). |
| Jeg har indtastet oversættelsen, men kunden ser stadig dansk | Tjek at du klikkede ⟦Gem⟧ (Generelt) / ⟦Opret⟧ (Mødeemne). Ændringen vises i bookingen, næste gang kunden åbner den. |
| Et sprog kan ikke vælges / mangler som sprogkode | Sproget er ikke aktiveret for banken → tilføj det under Admin → Sprogstyring (er det ikke på listen, er det ikke understøttet endnu). |
| Jeg vil fjerne en oversættelse | Ryd sprogfeltet og gem → feltet falder tilbage til dansk. |
| Jeg kan ikke fjerne dansk | Dansk (da-DK) er primært sprog og altid fallback — det kan ikke fjernes. |
| Grønlandsk (kalaallisut) tekst mangler | Oversættelsen er ikke indtastet → indhent teksten og udfyld sprogfeltet. |
| Bekræftelses-/e-mailtekst er ikke oversat | Den ejes af jeres bookingportal/integrator — uden for disse felter. |

### Ordliste
- **iCal**: Kalenderfilen, kunden modtager som mødeinvitation (mødetitel + beskrivelse).
- **Bookingportal/integrator**: Den løsning, jeres bank bruger til at vise selve booking-siden; den ejer knapper, bekræftelser og e-mails.
- **Sprogkode**: Standardkode for et sprog, fx da-DK (dansk), en-GB (britisk engelsk), kl-GL (grønlandsk).
- **Fallback**: Reservesprog: mangler en oversættelse, vises den danske tekst i stedet.

### Se også / forudsætninger
- **Schedule – superbrugerguide: Mødeopsætning** — felterne (Generelt/Standardværdier, Mødeemner), som Sprogstyring lægger sprog på.
- **Admin – overblik over undermenuerne** — hvor bankens sprog aktiveres (Sprogstyring).
- **Schedule – FAQ (Sprogstyring)** — typiske spørgsmål om flersproget booking.


## Seneste opdatering

- 02.07.2026 (v1.1) — Opdateret til den nuværende funktion: sprog aktiveres under **Admin → Sprogstyring** (da-DK primær, kan ikke fjernes); oversættelser indtastes **to steder** — Generelt (Standardværdier) og Mødeemner. Rettet mekanik og fallback.
- 17.06.2026 (v1.0) — Første version bygget på feature-specen (Roadmap `#306`).


{: .warning }
> ⚠️ **Husk** — Dansk er altid fallback og kan ikke fjernes; aktivér sprog i Admin → Sprogstyring; oversæt i Generelt + Mødeemner; tjek den kundevendte booking efter ændringer.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.1 · 02.07.2026_
