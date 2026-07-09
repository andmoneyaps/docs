---
layout: "default"
title: "FAQ – typiske spørgsmål og fejl"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 416
lang: "da"
---
# Schedule – FAQ
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-typiske-spoergsmaal-og-fejl.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-typiske-spoergsmaal-og-fejl.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved servicegrupper i Schedule. Uddybende trin findes i **Schedule – superbrugerguide: Servicegrupper**.


## Servicegrupper


**Servicegruppen aktiveres aldrig for bookinger.**

Tjek aktiveringsreglerne (kundetype/lokation/mødeemne), og at medlemmerne har tilgængelighed/arbejdstid på de matchende dage og lokationer. Gruppen aktiveres, når mindst én aktiveringsregel er opfyldt.


**Jeg kan ikke sætte aktiveringsregler eller serviceniveau.**

De kan først sættes, når servicegruppen er oprettet. Gem gruppen først (Generel + medlemmer), og redigér den derefter for at tilføje aktiveringsregler og serviceniveau.


**Medarbejdere mangler i valglisten.**

Kontrollér, at medarbejderne er synkroniseret og kan bookes (se Medarbejdere → Tilgængelighed).


**Hvad betyder en tom aktiveringsregel?**

En tom liste betyder “alle”: er fx ingen lokation valgt, kan gruppen servicere alle lokationer, der opfylder de øvrige regler. Sæt reglerne bevidst, så gruppen ikke aktiveres for bredt.


**“Max. timer pr. dag” slår ikke igennem.**

En individuel grænse på medarbejderen vinder over servicegruppens. Er medarbejderen i flere servicegrupper, gælder den højeste grænse.


**Hvad er forskellen på en servicegruppe og en kompetencegruppe?**

Kompetencegruppe = hvad medarbejderne kan (mødeemner + kundetyper). Servicegruppe = hvem der tilbydes (medlemmer), hvornår (aktiveringsregler) og hvad (serviceniveau).


**Hvad er “E-mail for servicegruppen”?**

En valgfri e-mail, som interne medarbejdere kan bruge til selv at booke møder via gruppen.


**Hvilke mødetyper kan en servicegruppe tilbyde?**

Online, Fysisk, Telefon og Off site — det vælges under Serviceniveau. Vælges Fysisk, kan kunden vælge blandt servicegruppens lokationer.


**Servicegruppen er aktiv, men kunden ser ingen tider.**

Aktivering betyder ikke automatisk, at der vises tider. Tjek serviceniveauet: er der valgt **mødetyper**, og — ved Fysisk — **lokationer**? Et tomt serviceniveau giver ingen tider. Tjek også, at medlemmerne har tilgængelighed på de matchende dage.


**Min ændring slår ikke igennem for kunden.**

Ændringer gælder ved næste booking-søgning. Opdatér siden og prøv en ny søgning; fortsætter det, kontakt support.


**Kan jeg deaktivere eller slette en servicegruppe?**

Vil du midlertidigt tage gruppen ud af spil, kan du fjerne dens aktiveringsregler eller medlemmer. For permanent sletning, kontakt din administrator/support — vær opmærksom på effekten på eksisterende bookinger.


**Hedder det Schedule eller bookme?**

Det er samme produkt. Brand-navnet er Schedule; i systemet/menuen kan du stadig møde det tidligere navn bookme.


## Kompetencegrupper


**Hvad styrer en kompetencegruppe?**

Hvilke mødeemner og kundetyper medarbejderne i gruppen kan afholde møder om. Den kan tilføjes en servicegruppe samlet, så alle dens medarbejdere tilknyttes.


**Arver undergrupper kompetencer?**

Ja. Medarbejdere i undergrupper påtager sig også kompetencer fra overgruppen, og medlemmer fra undergrupper vises på gruppen.


## Betjeningsniveau / prioritet


**Kunden får kun lokale medarbejdere — ikke servicegruppen.**

Justér betjeningsniveauet, så servicegruppens label prioriteres. Rækkefølgen er typisk: Eksplicit valgt → Lokal rådgiver → Servicegruppe(r) via label.


**Label virker ikke i betjeningsniveauet.**

Sørg for, at mindst én servicegruppe har den valgte label. Labels sættes på service-/kompetencegrupper.


**Kan jeg have flere servicegruppe-niveauer?**

Ja. “Servicegruppe” kan optræde flere gange (én pr. label) — fx primær og sekundær. “Eksplicit valgt” og “Lokal rådgiver” kan kun optræde én gang hver.


**Vises “Beskrivelse” for kunden?**

Nej — beskrivelsen på et betjeningsniveau er intern og hjælper jer med at kende niveauet.


**Hvad sker der, hvis ingen i servicegruppen har ledig tid?**

Så går systemet videre til næste betjeningsniveau og tilbyder tider derfra.


## Adgang og roller


**Jeg kan ikke se Servicegrupper i menuen.**

Servicegrupper kræver rollen Manager eller Admin. Kompetencegrupper og betjeningsniveau kan tilgås af Configurator eller Admin. Kontakt din administrator.


**Jeg er Configurator og kan ikke oprette servicegruppen.**

Servicegrupper kræver rollen Manager eller Admin. Som Configurator kan du oprette kompetencegrupper og betjeningsniveau, men ikke servicegrupper — kontakt din administrator.


**Hvor opretter jeg labels?**

Labels sættes på den enkelte service-/kompetencegruppe (felt “Labels”) og bruges derefter i betjeningsniveauet til at prioritere.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
