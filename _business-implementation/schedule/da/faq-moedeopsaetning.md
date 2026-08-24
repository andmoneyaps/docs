---
layout: "default"
title: "FAQ – Mødeopsætning"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 410
lang: "da"
---
# Schedule – FAQ: Mødeopsætning
_Typiske spørgsmål, fejl og svar · v1.0 · 12.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-moedeopsaetning.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-moedeopsaetning.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Mødeopsætning i Schedule. Uddybende findes i **Schedule – superbrugerguide: Mødeopsætning**.


## Bookingflows


**Hvorfor kan interne møder bookes, når kunden ikke kan se nogen tider?**

Fordi interne møder (sagsbehandling) **springer de fleste regler over**: buffere, max. timer pr. dag, kundetype-filtrering og betjeningsniveau gælder ikke internt. En kundevendt regel blokerer altså kundens tider — fx daglig grænse eller en buffer.


**Hvad er forskellen på rådgiver-, kunde- og portal-booket?**

De bruger den **samme regel-motor**. Forskellen er, hvor man starter, og hvor konteksten (kundetype/emne/lokation) kommer fra: rådgiveren vælger den manuelt, kunden via sit link, portalen forudvælger den.


**Gælder lukkedage også interne møder?**

Ja. Lukkedage er den ene undtagelse — de blokerer **alle** flows, også interne.


**Gælder ‘max. timer pr. dag’ for interne møder?**

Nej. Den daglige grænse gælder kun de kundevendte flows. Medarbejdere kan booke ubegrænset internt.


## Indstillinger


**Hvor sætter jeg særlige regler for én kundetype?**

I **Mødekonfiguration** med **Opsæt særlige regler** (pr. kundetype) eller specifikke konfigurationer pr. mødeemne. De overstyrer standardværdierne.


**Hvad er forskellen på ‘kalendertid’ og ‘arbejdstid fra booking til møde’?**

Begge er et **mindste varsel** før et møde kan bookes. **Kalendertid** tæller almindelige timer; **arbejdstid** tæller kun arbejdstimer (og krydser dage).


**‘Forberedelsestid’ — er det et klokkeslæt?**

Nej, det er en **varighed** (fx 15 min), medarbejderen blokeres før (forberedelse) og efter (efterbehandling) mødet. Er bufferens **Vis som** sat til **ledig**, kan kunder stadig booke tiden.


**Hvad gør ‘Tilbyd fast medarbejder’?**

Bestemmer, om kunden tilbydes sin **faste medarbejder** eller **alle tilgængelige** i bookingflowet.


**Hvad betyder ‘Vis kun tidspunkter, som kunden ser’?**

I den medarbejdervendte booking viser den kun de tider, kunden selv ville se — i stedet for alle tider.


## Lokationer og fejl


**Der vises ingen medarbejdere på en lokation.**

Lokationens **Navn** skal matche **SCIM**-lokationen **præcist** (versalfølsomt). Tjek stavning og versaler.


**Lokale-vælgeren mangler ved fysisk møde.**

Slå **Kræv ledigt mødelokale** og/eller **Tilføj lokale til det bookede møde** til på lokationen, og tjek, at lokaler er synkroniseret fra SCIM.


**Slet ingen tider for en kundetype/et emne.**

Der mangler en **mødekonfiguration** for den kombination — opret en generel konfiguration eller en specifik pr. kundetype/emne.


**Der er en mødekonfiguration, men kunden ser stadig ingen tider.**

Den **mest specifikke** konfiguration vinder (både emne+kundetype slår kun-kundetype slår generel slår standardværdier) — og der falder **ikke** tilbage til den generelle. Er den specifikke ufuldstændig (fx ingen mødetyper eller en hård buffer), giver den ingen tider. Tjek netop den konfiguration.


**Kunden ser færre tider end forventet (ikke nul).**

Noget trimmer listen. Tjek i rækkefølge: **max. timer pr. dag** → **buffere** (kalender-/arbejdstid, tid mellem møder) → **rejsetid** → krav om **ledigt lokale**.


**Vi omdøbte en lokation i M365/SCIM, og booking gik i stykker.**

Lokationens **Navn** i Schedule skal matche SCIM **præcist**. Ændrer M365-navnet sig, bliver Schedule-navnet ‘forældet’, og der findes ingen medarbejdere. Ret navnet, så det matcher igen.


**Hvad kan en Manager ændre i Mødeopsætning?**

Configurator/Admin kan alt; Manager har typisk begrænset adgang (bl.a. servicegrupper). Er du i tvivl om en bestemt fane, så kontakt din administrator.


## Adgang og roller


**Hvem kan ændre Mødeopsætning?**

Rollen **Configurator** eller **Admin** (nogle dele også **Manager**). Kontakt din administrator.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
