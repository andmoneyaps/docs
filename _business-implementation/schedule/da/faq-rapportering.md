---
layout: "default"
title: "FAQ – Rapportering"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 413
lang: "da"
---
# Schedule – FAQ: Rapportering
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-rapportering.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-rapportering.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Rapportering i Schedule. Uddybende findes i **Schedule – superbrugerguide: Rapportering**.


## Rapportering


**Hvem kan se Rapportering?**

Rollen **Manager** eller **Admin**. Rapporten viser hele organisationens booking-data (ikke filtreret pr. afdeling/lokation).


**Kan jeg få mere detaljeret mødedata end dette overblik?**

Ja. Ud over Rapportering-overblikket leveres **detaljeret mødedata** til jer via **Salesforce CRM analytics**, hvor I kan analysere de enkelte møder i dybden.


**Rapporten er tom — hvorfor?**

Der er ingen bookede møder i den valgte periode, eller kundetype-filteret udelukker alt. Vælg en længere **Periode** (fx 90 dage) og **Kundetype = Alle**, og tjek, at der er bookinger i systemet.


**Hvorfor summer procenterne til 99 % eller 101 %?**

Andelene rundes til hele procent. Derfor kan delene tilsammen give 99 eller 101 % — det er forventet og ikke en fejl.


**Tæller tallene møder eller kunder?**

Møder. **Booket møder** er antallet af bookede møder (tidspunkter) — ikke antallet af unikke kunder.


**Påvirker kundetype-filteret det samlede tal?**

Nej — kundetype-filteret ændrer kun, hvad der vises. Det samlede **Booket møder** dækker stadig alle kundetyper.


**En portal vises som ‘Portal’ uden navn — hvorfor?**

Portalen mangler et navn. Giv den et navn under **Schedule → Portaler**, så vises navnet i rapporten.


**Hvorfor mangler en mødetype eller et mødeemne i grafen?**

Meget små andele (under ca. 1 % af alle møder) vises ikke i type-/emne-graferne, så grafen forbliver overskuelig.


**Kan jeg eksportere rapporten eller vælge et frit datointerval?**

Nej. Rapporten er read-only, og du vælger mellem faste perioder (2/7/14/30/60/90 dage). Der er ikke eksport eller frit datointerval.


**Hvor ofte opdateres tallene?**

Løbende (realtid) — nye bookinger afspejles typisk inden for sekunder til minutter.


**Hvad er den hvide del i cirkeldiagrammet?**

Møder uden kundetype (ukategoriserede). De vises som en hvid del uden label.


**Jeg kan ikke se Rapportering i menuen.**

Din rolle er sandsynligvis ikke **Manager** eller **Admin**. Kontakt din administrator for at få den rette adgang.


**Tallet ændrede sig / et møde forsvandt fra rapporten.**

Rapporten tæller de bookede møder i perioden. Afbestilles eller flyttes et møde, kan tallet ændre sig. Perioden er desuden et rullende vindue (seneste N dage), så ældre møder falder ud over tid.


**Kilde-tallene summer ikke til ‘Booket møder’.**

Det kan skyldes, at meget små kilder/kategorier (eller kilder med 0 i perioden) ikke vises som egen række, samt afrunding. Det samlede **Booket møder** er altid totalen.


**Hvilke 30 dage er det præcis?**

De seneste 30 dage frem til i dag (et rullende vindue). Skift **Periode** for et andet vindue (2/7/14/30/60/90 dage).


**Min kollega ser andre tal end mig.**

Det bør I ikke — alle Managers/Admins ser hele organisationens data. Små forskelle skyldes typisk, at I kigger på forskellige tidspunkter (realtid) eller forskellige filtre (Periode/Kundetype).


**Hvad er der i ‘Andre’ i cirkeldiagrammet?**

De kundetyper, der ligger uden for de tre største, samlet i én del. Den hvide del uden label er møder **uden** kundetype (ukategoriserede) — adskilt fra ‘Andre’. Ingen af dem kan klikkes for detaljer.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
