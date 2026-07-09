---
layout: "default"
title: "FAQ"
parent: "Dansk"
grand_parent: "Insights"
nav_order: 402
lang: "da"
---
# Insights – FAQ
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/insights/da/faq.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/insights/da/faq.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Insights. Uddybende trin findes i **Insights – superbrugerguide**.


## Insights


**Hvad er Insights, og hvad bruger jeg det til?**

Insights simulerer og analyserer medarbejdernes tilgængelighed et stykke tid frem (typisk ~60 dage): hvornår der er ledige tider, og hvorfor tider ikke er ledige. Du bruger det til at forstå kapacitet og flaskehalse.


**Hvad er forskellen på Insights og Rapportering?**

**Insights** er en **prognose/simulering** af fremtidig tilgængelighed. **Rapportering** viser **faktiske** bookede møder bagud. De to supplerer hinanden.


**Hvor ser jeg resultaterne / dataene?**

Data leveres til jer **hver nat** via **Salesforce CRM analytics**, hvor I selv bygger dashboards og analyser. Der er **ikke** en resultat-/analyseskærm i Management UI — her opretter I kun selve opsætningerne.


**Hvor opretter jeg en opsætning?**

Under **Insights → Opsætning → Opret ny**. Vælg kundetype, mødeemne, tidszone, mødekonfiguration og brugsscenarie.


**Hvornår leveres data?**

Data genereres og leveres **natligt** pr. opsætning (til Salesforce CRM analytics). En ny opsætning leverer først data efter første kørsel — se **Seneste datakørsel** i listen.


**Hvad er forskellen på ‘Fuldt datasæt’ og ‘Kun tilgængelige møder’?**

**Fuldt datasæt** indeholder alle tidspunkter med en **årsag** (også de optagede) — godt til at forstå hvorfor. **Kun tilgængelige møder** viser kun de ledige tider — godt til at se reel kapacitet.


**Hvorfor mangler en medarbejder i datasættet?**

Typisk fordi medarbejderen ikke har den rette **kompetence** (mødeemne/kundetype) for opsætningen, eller ikke kan bookes. Tjek Schedule → Medarbejdere. Du kan også sætte **Ignorér kompetence grupper** i opsætningen.


**Hvad gør ‘Ignorér kompetence grupper’?**

Så medregnes medarbejdernes kompetencegruppe-tilhør ikke i beregningen — alle medarbejdere indgår uanset kompetencer. Brug det, når du vil se den rå kapacitet.


**Hænger Insights sammen med Salesforce CRM analytics?**

Ja. Insights-data kan sendes videre til **Salesforce CRM analytics**, hvor I kan lave dybere, forretningsbrede analyser.


**Jeg oprettede en opsætning i dag og har stadig ikke fået data.**

Data genereres og leveres **natligt**. En opsætning oprettet i dag leverer først data efter næste natkørsel (typisk i morgen). Tjek **Seneste datakørsel** i listen.


**‘Seneste datakørsel’ er gammel / data opdateres ikke.**

Natkørslen kan være fejlet. Kontakt din administrator, som kan tjekke **Admin → Logs** for fejl i Insights-kørslen.


**‘Fejl ved oprettelse af insights indstillingen’.**

Et påkrævet felt mangler (kundetype, mødeemne, tidszone, mødetyper) eller en tid/varighed er ugyldig. Tjek alle felter og prøv igen.


**Tallene ser forkerte ud / passer ikke med de faktiske bookinger.**

Insights er en **simulering** af fremtidig tilgængelighed — ikke faktiske møder. Til faktiske, bookede møder bruger du **Rapportering**.


**I datasættet er næsten alt samme årsag (fx Optaget eller Ikke kvalificeret) — hvad gør jeg?**

Det peger på en Schedule-opsætning: **Optaget** → Outlook-kalender; **Ikke kvalificeret** → kompetencer; **Udenfor arbejdstid** → arbejdsdage/-tid; **Kan ikke bookes** → ‘Kan medarbejderen bookes’. Ret det i Schedule → Medarbejdere.


**Kan jeg redigere eller slette en opsætning?**

Ja — brug ikonerne i listen (se, åbn, slet). Ændringer afspejles ved næste natkørsel.


## Adgang og roller


**Hvem kan bruge Insights?**

Rollen **Configurator** eller **Admin**. Kontakt din administrator, hvis du mangler adgang.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
