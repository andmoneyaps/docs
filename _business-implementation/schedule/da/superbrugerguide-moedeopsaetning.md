---
layout: "default"
title: "Superbrugerguide – Mødeopsætning"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 203
lang: "da"
---
# Schedule – superbrugerguide: Mødeopsætning
_De seks faner, indstillingerne og de fire bookingflows · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-moedeopsaetning.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-moedeopsaetning.pdf)

## Formål og værdi

**Mødeopsætning** er navet i Schedule: her bestemmer du, **hvornår** og **hvordan** møder kan bookes. Området har seks faner, der hænger tæt sammen — og den **samme** indstilling kan slå forskelligt igennem afhængigt af, hvordan mødet bookes. Denne guide giver dig både **overblikket** (rækkefølge + bookingflows) og **detaljerne** (hvad hvert felt reelt gør).


## De fire bookingflows — og den vigtigste skelnen

Et møde kan komme i stand på fire måder. Den vigtigste skelnen er **internt vs. kundevendt**:

- **Interne møder (sagsbehandling):** en medarbejder booker internt. Dette flow **springer næsten alle reglerne over** (se matrixen).
- **Rådgiver-booket:** en medarbejder booker et møde for/med en kunde.
- **Kunde-booket:** kunden booker selv (fx via et direkte link).
- **Portal-møde:** kunden booker via en portal.

{: .note }
> **Bemærk:** De **tre kundevendte flows** (rådgiver, kunde, portal) bruger den **samme regel-motor**. De adskiller sig kun i, hvor man starter, og hvor konteksten (kundetype/emne/lokation) kommer fra: rådgiveren vælger den manuelt · kunden via sit link · portalen forudvælger den. **Tommelfingerregel: lær reglerne én gang (kundevendt) — internt springer dem over.**


## Bookingflow-matrix — hvilke indstillinger gælder hvor?

Oversigt over, hvornår de vigtigste indstillinger er i spil (Ja = gælder, Nej = springes over):


| Indstilling | Internt | Rådgiver | Kunde | Portal |
|---|---|---|---|---|
| Buffere (kalender-/arbejdstid, tid mellem møder, rejsetid, for-/efterbehandling) | Nej | Ja | Ja | Ja |
| Max. timer pr. dag (pr. medarbejder) | Nej (ubegrænset) | Ja | Ja | Ja |
| Betjeningsniveau (prioritet/valg af medarbejder) | Nej (vælger selv) | Ja | Ja | Ja |
| Kundetype-filtrering | Nej | Ja | Ja | Ja |
| Mødetyper (begrænset af konfiguration) | Nej (alle) | Ja | Ja | Ja |
| Mødevarighed | Ja (30 min std.) | Ja | Ja | Ja |
| Lukkedage | Ja | Ja | Ja | Ja |
| Tilbyd fast medarbejder | — | Ja | Ja | Ja |
| Kontekst (kundetype/emne/lokation) kommer fra | medarbejder | medarbejder | kundens link | portalens forudvalg |

{: .note }
> **Bemærk:** **Lukkedage** er den ene store undtagelse: de blokerer **alle** flows — også interne møder (organisationen er lukket). Internt får møder stadig en **varighed**, fordi mødet skal optage tid i kalenderen.

{: .note }
> **Bemærk:** **Matrixens ‘Buffere’ = disse felter i Mødekonfiguration (Fane 5):** Kalendertid, Arbejdstid, Tid mellem møder, Rejsetid og For-/Efterbehandling. Ser kunden ingen tider, mens interne møder kan bookes, er det næsten altid en af disse kundevendte regler — se **Fejlfinding**.


## Eksempel — et møde gennem motoren

**En Privat-kunde booker selv et fysisk rådgivningsmøde:** 1) **Kundetype** = Privat → den mødekonfiguration gælder; 2) **Mødetyper** skal indeholde **Fysisk**; 3) **bufferne** (kalender-/arbejdstid, tid mellem møder) skubber de nærmeste tider væk; 4) **Max. timer pr. dag** kan fjerne en travl dag; 5) **Betjeningsniveau** vælger medarbejderen; 6) ved fysisk møde tjekkes **ledigt lokale** (hvis krævet); 7) **Lukkedage** blokerer helligdage. Var det samme møde **internt**, sprang trin 3–5 over.

### Ordliste
- **Standardværdier**: Organisationens grund-indstillinger (åbningstider, max timer/dag, lukkedage m.m.) — defaults, som de øvrige faner arver fra.
- **Mødekonfiguration**: Reglerne pr. ⟦kundetype⟧ og ⟦mødeemne⟧ (varighed, mødetyper, buffere, hvem der kan booke) — overstyrer standardværdierne.
- **Kundetype**: En kundekategori (fx Privat, Erhverv), du kan sætte særlige regler for.
- **Mødeemne**: Et møde-tema (med evt. underemner), bookinger kan handle om.
- **Buffer**: Tid, der reserveres (varsel før mødet kan bookes, pause mellem møder, rejsetid, for-/efterbehandling).
- **Lukkedage**: Dage, hvor der ikke kan bookes (helligdage m.m.) — gælder alle flows.


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator (rolle **Configurator** eller **Admin**; **Manager** kan nogle dele).
- Lokationer/lokaler synkroniseres fra **SCIM**/M365; medarbejdere fra Entra.
- Managed BookMe-pakke er installeret.


## Opsætningsrækkefølge (og hvad der arver fra hvad)

Sæt fanerne op i denne rækkefølge — hver bygger på den forrige:

- 1. **Standardværdier** — organisationens defaults (åbningstider, max timer/dag, lukkedage, navngivning).
- 2. **Kundetyper** — de kundekategorier, du vil kunne sætte særlige regler for.
- 3. **Mødeemner** — emner og underemner.
- 4. **Lokationer** — fysiske steder og lokaler (krav om ledigt lokale).
- 5. **Mødekonfiguration** — reglerne pr. kundetype/emne (overstyrer standardværdierne).
- 6. **Betjeningsniveau** (Fane 6) — prioritet, når flere medarbejdere er ledige.
- Relaterede områder (egne guider): **Servicegrupper** (puljer) og **Portaler** (den kundevendte side).

{: .note }
> **Bemærk:** **Arv:** Standardværdier er defaults; i Mødekonfiguration kan du **overstyre** pr. kundetype og pr. mødeemne med **Opsæt særlige regler**.


## Fane 1 — Standardværdier

Organisationens grund-indstillinger, alt andet arver fra.


| Felt | Hvad du reelt indstiller |
|---|---|
| Standard åbningstider (Fra/Til kl.) | Det generelle tidsrum, der kan bookes inden for. |
| Maximum tid fra booking til afholdelse | Hvor langt ud i fremtiden der kan bookes (fx 30 dage). |
| Max. timer pr. dag (pr. medarb.) | Loft for kundemøder pr. dag pr. medarbejder. ★ Gælder ikke interne møder. |
| Tidszone | Grundlag for alle tidsberegninger. |
| Vis kun tidspunkter, som kunden ser | I den medarbejdervendte booking: vis kun de tider, kunden ville se (ellers alle). |
| Lukkedage | Dage uden booking (helligdage m.m.) — gælder alle flows. |
| Navngivning af mødetyper | Hvad Fysisk/Online/Telefon/Off site hedder over for kunden. |
| Navngivning af medarbejdertyper | Hvad ‘fast medarbejder’ og ‘alle tilgængelige’ hedder over for kunden. |
| iCal (mødetitel/beskrivelse) | Tekst i den .ics-kalenderfil, kunden kan hente. |


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-moedeopsaetning/msetup_standardvaerdier.png)

*Skærmbillede 1 (Management UI) — Mødeopsætning → **Standardværdier** — åbningstider, max. timer/dag, lukkedage og navngivning*


## Fane 2 — Kundetyper

De kundekategorier (fx Privat, Erhverv), du senere kan sætte **særlige regler** for i Mødekonfiguration. Opret dem med **Opret kundetyper** → **Navn**.


## Fane 3 — Mødeemner

Møde-temaerne, bookinger kan handle om. Opret et **mødeemne** (Navn) og tilføj evt. **underemner** (Tilføj underemne). Emnerne bruges som akse i Mødekonfiguration og på portaler/servicegrupper.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-moedeopsaetning/msetup_modeemner.png)

*Skærmbillede 2 (Management UI) — Mødeopsætning → **Mødeemner** — emner og underemner*


## Fane 4 — Lokationer

Fysiske steder og deres lokaler.


| Felt | Hvad du reelt indstiller |
|---|---|
| Navn | Internt navn — skal matche ⟦SCIM⟧-lokationen ⟦præcist⟧ (versalfølsomt!), ellers findes ingen medarbejdere. |
| Visningsnavn (Navn i mødebooking) | Det navn, kunden ser ved booking. |
| Kræv ledigt mødelokale for at kunne booke fysisk møde | ★ Kun tider med et ledigt lokale vises for fysiske møder. |
| Tilføj lokale til det bookede møde | Lokale-vælger vises, og lokalet sættes på bookingen. |
| Lokaler på lokationen | Read-only — synkroniseres fra SCIM/M365. |


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-moedeopsaetning/msetup_lokationer.png)

*Skærmbillede 3 (Management UI) — Mødeopsætning → **Lokationer** — Navn/Visningsnavn + krav om ledigt lokale*


## Fane 5 — Mødekonfiguration (kernen)

Her sætter du reglerne — generelt eller pr. **kundetype** og pr. **mødeemne** (Opsæt særlige regler). De fleste felter gælder kun de **kundevendte** flows (jf. matrixen). Den **mest specifikke** konfiguration vinder: en konfiguration for **både mødeemne og kundetype** slår en for kun kundetype, som slår den **generelle**, som slår **standardværdierne**.


| Felt | Hvad du reelt indstiller | Flow |
|---|---|---|
| Hvem kan booke (Alle møder kan bookes pr) | Kun internt i banken, eller Kunden i selvbetjening. | Alle |
| Tilbyd fast medarbejder | Om kunden tilbydes sin faste medarbejder eller alle tilgængelige. | Kundevendt |
| Mødevarighed (Alle møder har en varighed på) | Mødelængde (interne defaulter til 30 min, hvis ikke sat). | Alle |
| Mødetyper (Alle møder kan afholdes som) | Fysisk/Online/Telefon/Off site, kunden tilbydes. | Kundevendt |
| Kalendertid fra booking til møde | Mindste varsel i ⟦kalendertimer⟧ før et møde kan bookes. | Kundevendt |
| Arbejdstid fra booking til møde | Mindste varsel i ⟦arbejdstimer⟧ (krydser dage). | Kundevendt |
| Tid mellem møder | Påkrævet pause mellem to møder. | Kundevendt |
| Rejsetidsbuffer | Ekstra tid oven i beregnet rejsetid (flere lokationer). | Kundevendt |
| Forberedelses- / Efterbehandlingstid | ⟦Varighed⟧ (ikke klokkeslæt!), medarbejderen blokeres før/efter mødet. | Kundevendt |
| Opsæt særlige regler / specifikke pr. mødeemne | Overstyr ovenstående pr. kundetype og pr. mødeemne. | — |

{: .important }
> **Husk:** **Forberedelses-** og **Efterbehandlingstid** er en **varighed** (fx 15 min), ikke et klokkeslæt — en klassisk faldgrube.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/da/superbrugerguide-moedeopsaetning/msetup_modekonfiguration.png)

*Skærmbillede 4 (Management UI) — Mødeopsætning → **Mødekonfiguration** — Hvem kan booke, mødevarighed, mødetyper og buffere*


## Fane 6 — Betjeningsniveau

Bestemmer prioriteringen, når flere medarbejdere er ledige (Eksplicit valgt → Lokal → Servicegruppe via label). **Gælder kun kundevendte flows** — internt vælger medarbejderen selv. Uddybes i **Schedule – superbrugerguide: Servicegrupper**.


## Faldgruber og godt at vide

- **Internt springer reglerne over:** buffere, daglig grænse, prioritet og kundetype gælder **ikke** interne møder — kun lukkedage og varighed.
- **Lokationsnavn = SCIM:** navnet skal matche SCIM-lokationen præcist (versalfølsomt), ellers vises ingen medarbejdere.
- **Varighed, ikke klokkeslæt:** for-/efterbehandlingstid angives som en varighed.
- **Arv:** Standardværdier er defaults; Mødekonfiguration overstyrer pr. kundetype/emne.
- **Lukkedage gælder alle:** også interne møder kan ikke bookes på lukkedage.


## Fejlfinding

- Kunden ser ingen tider, men interne møder kan bookes: det er som regel en **kundevendt** regel — **max. timer pr. dag** nået, en **buffer** eller manglende **mødekonfiguration** for kundetype/emne.
- Slet ingen tider for en kombination: der mangler en **mødekonfiguration** for den kundetype/det mødeemne — opret en generel eller specifik konfiguration.
- Der er en mødekonfiguration, men stadig ingen tider: en **specifik** konfiguration (pr. emne/kundetype) er måske ufuldstændig — tjek mødetyper/buffere på netop den, ellers falder den ikke tilbage til den generelle.
- **Færre** tider end forventet (ikke nul): noget trimmer listen — tjek i rækkefølge **max. timer pr. dag** → **buffere** → **rejsetid** → **ledigt lokale**.
- Ingen medarbejdere på en lokation: **lokationsnavnet** matcher ikke SCIM (tjek versaler).
- Lokale-vælger mangler ved fysisk møde: slå **Kræv ledigt mødelokale**/**Tilføj lokale** til på lokationen, og tjek at lokaler er synkroniseret.
- En ændring slår ikke igennem: ændringer gælder ved næste booking-søgning — lav en ny søgning for den kundetype/det emne for at bekræfte. På kunde-link/portal kan der være kort forsinkelse.

### Se også / forudsætninger
- **Schedule – FAQ (Mødeopsætning)** — typiske spørgsmål, fejl og svar.
- **Schedule – superbrugerguide: Servicegrupper** — servicegrupper + betjeningsniveau.
- **Schedule – superbrugerguide: Medarbejdere** — tilgængelighed pr. medarbejder.
- **Schedule – superbrugerguide: Portaler** — den kundevendte booking-side.


## Seneste opdatering

- 12.06.2026 (v1.0) — Første version (alle faner + bookingflow-matrix).


{: .hint }
> ✅ **Færdig!** Mødeopsætningen er på plads.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
