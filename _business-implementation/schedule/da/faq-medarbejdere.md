---
layout: "default"
title: "FAQ – Medarbejdere"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 409
lang: "da"
---
# Schedule – FAQ: Medarbejdere
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-medarbejdere.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-medarbejdere.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved medarbejder-tilgængelighed i Schedule. Uddybende trin findes i **Schedule – superbrugerguide: Medarbejdere**.


## Tilgængelighed


**“Kan bookes” står på Ja, men der er stadig ingen tider.**

Gå diagnosen igennem i denne rækkefølge (hyppigst først): 1) **Outlook-kalenderen** optaget på tidspunktet? 2) **mødetype**/**lokation** ikke valgt for dagen (fx kun Online, men kunden vil Fysisk)? 3) sat til **kun specifik medarbejder**? 4) ingen **kompetencegruppe** matcher emne/kundetype? 5) bookingen kræver en **servicegruppe**, medarbejderen ikke er med i? 6) uden for **arbejdsdag/-tid**? 7) **max. timer pr. dag** nået?


**Hvordan ved jeg, om det er Outlook-kalenderen, der blokerer?**

Hvis konfigurationen ser rigtig ud, men netop ét tidsrum mangler, er det typisk en optaget tid i medarbejderens **Outlook-kalender**. Bemærk, at også heldagsbegivenheder og “foreløbige” (tentative) aftaler kan blokere tider.


**Medarbejderen er i den rette kompetencegruppe, men vises stadig ikke.**

Så er det ofte **servicegruppe-gating**: kræver bookingen en servicegruppe (fx fjern-/national pulje), skal medarbejderen være med i en gruppe, der **aktiveres** for den kundetype/emne/lokation. Tjek servicegruppens aktiveringsregler og medlemmer.


**Jeg slog “Opsæt særlige regler” til, og nu er én dag tom.**

Med særlige regler sætter du tider/mødetyper/lokation **pr. dag** — en dag, du ikke har udfyldt, giver ingen tider. Udfyld dagen, eller slå særlige regler fra for at bruge det fælles tidsrum igen.


**Hvad sker der, hvis jeg lader Lokation stå tom?**

Så bruges medarbejderens **standard-lokation** fra profilen. Vil du have en anden lokation (eller flere), vælger du dem eksplicit.


**Hvad betyder “Kan medarbejderen tage opkald fra udlandet”?**

Det er global tilgængelighed — slå til, hvis medarbejderen må indgå i bookinger på tværs af landegrænser.


**Hvad gør “Kan medarbejderen bookes til kundemøder”?**

Det er hovedkontakten. Står den på **Nej**, udelukkes medarbejderen helt fra al booking — uanset alle andre indstillinger.


**Hvad betyder “Kan kun bookes som specifik medarbejder”?**

Står den på **Ja**, vises medarbejderen ikke i den almene pulje af ledige tider — kun hvis kunden eller en medarbejder vælger personen specifikt ved navn.


**Hvordan sætter jeg forskellige tider på forskellige dage?**

Slå **Opsæt særlige regler** til under Arbejdstid (og evt. Mødetyper/Lokation). Så kan hver enkelt dag have sit eget tidsrum, sine mødetyper og sin lokation.


**Mine ændringer slår ikke igennem.**

Husk at klikke **Gem** — ser du kvitteringen “Tilgængelighed opdateret”, er ændringen gemt. Kundevisningen kan være **få minutter** om at følge med; prøv en ny søgning/opdatér. Bruger du særlige regler pr. dag, så tjek, at du har redigeret den rigtige dag.


**Hvad er “Max. timer pr. dag”, og hvorfor virker det ikke?**

Et loft over, hvor mange timers kundemøder medarbejderen kan bookes til pr. dag. Det gælder kun **kundemøder** — interne møder tæller ikke med. Er medarbejderen i en servicegruppe, gælder den **højeste** grænse. Er det ikke sat, bruges standardværdien.


## Medarbejdere & grupper


**Hvor kommer medarbejderne fra, og hvorfor mangler en?**

Medarbejdere synkroniseres ind fra jeres **Entra** (AD). Mangler en person i **Vælg medarbejder**, er det en synk-/adgangs-sag — kontakt din administrator.


**Kan jeg deaktivere en medarbejder?**

Der er ingen separat “inaktiv”-knap. Sæt **Kan medarbejderen bookes** til **Nej** — så indgår medarbejderen ikke i booking.


**Hvordan tilføjer jeg en medarbejder til en kompetence- eller servicegruppe?**

Det gøres på selve **gruppen** (Kompetencegrupper/Servicegrupper). På medarbejderen er **Grupper** kun en read-only oversigt.


**Hvad betyder “direkte” og “arvet” kompetencegruppe?**

Direkte = medarbejderen er tilføjet gruppen direkte. Arvet = medarbejderen er med via en undergruppe og påtager sig også overgruppens kompetencer.


## Adgang og roller


**Hvem kan opsætte medarbejder-tilgængelighed?**

Rollen **Configurator** eller **Admin** i Management UI. Kontakt din administrator, hvis du mangler adgang.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
