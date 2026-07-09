---
layout: "default"
title: "FAQ – Portaler"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 412
lang: "da"
---
# Schedule – FAQ: Portaler
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-portaler.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-portaler.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved portaler i Schedule. Uddybende trin findes i **Schedule – superbrugerguide: Portaler**.


## Portaler


**Kunden ser ingen tider på portalen.**

Det er næsten altid kundedata vs. tilgængelighed. Tjek: er der kvalificerede medarbejdere (kompetencegruppe) for portalens kundetype/mødeemne, har de tilgængelighed på den lokation/dag, og — ved fysisk møde — er **kræv ledigt mødelokale** opfyldt? Tjek også lukkedage og lead times.


**Hvad gør “Kundedata” på portalen?**

Kundedata (kundetype, mødeemne, lokation) forudvælger, hvem portalen er til — og scoper dermed, hvilke medarbejdere/servicegrupper og tider kunden får vist. Kundetype er påkrævet; tomt mødeemne = alle emner; tom lokation = kunden vælger selv.


**Hvad betyder noten “Følgende Servicegrupper kan have indflydelse…”?**

Når du vælger kundetype (+ evt. emne/lokation), beregner systemet, hvilke servicegrupper der aktiveres for den kombination. Noten viser dem — de kan tilbyde andre tider/mødetyper/lokationer end de lokale medarbejdere.


**Hvad er forskellen på “Playbook” og “CRM-konfiguration (standard)”?**

Playbook er den **fremadrettede standard**: et automatisk flow, der sender booking-data til CRM (og kan køre AI, hente/berige data m.m.). CRM-konfiguration (standard) er den **gamle model** med en fast felt-mapning — den udfases og bruges kun af enkelte kunder i en overgangsperiode.


**Hvad er en Playbook, og hvor opretter jeg den?**

En Playbook er et automatisk flow: kundens booking (trigger) → datablokke → CRM. Playbooks oprettes og administreres under **Admin → Playbooks** (typisk af jer sammen med &money).


**Hvordan kobler jeg en portal til en Playbook?**

Sæt portalens **CRM oprettelsesstrategi** = **Playbook**. Selve valget af en konkret Playbook sker pt. i samarbejde med &money — portalens Playbook-vælger viser stadig “Ingen playbooks tilgængelige” og åbnes snart. Playbooks oprettes under **Admin → Playbooks**.


**Logoet vises ikke.**

**Logo** skal være en **URL** til et billede (ikke en uploadet fil). **Logo højde** styrer kun størrelsen i pixels.


**Kan jeg ændre rækkefølgen på felterne?**

Ja — hvert felt har et **Rækkefølge**-tal. Lavere tal vises først på portalens formular.


**Kan et felt være både påkrævet og skjult?**

Nej — undgå det. Et skjult felt kan ikke udfyldes af kunden, så et påkrævet+skjult felt blokerer bookingen. Skjulte felter er til forudfyldte/standardværdier; påkrævede felter skal være synlige.


**Kan jeg bruge mit eget regex til validering?**

Ja. Du kan vælge en **predefineret regex** (CPR, e-mail, telefon, navn, URL) eller skrive dit eget **regulært udtryk** + en fejlbesked.


**Hvad er forskellen på Login type Azure AD og MitID?**

Azure AD bruges typisk til interne/medarbejdere; MitID til borgere (dansk ID). Vælg den, der passer til portalens målgruppe.


**Krav om ledigt mødelokale blokerer alle fysiske tider — hvor ændrer jeg det?**

Indstillingen **kræv ledigt mødelokale** sættes på den enkelte lokation under **Mødeopsætning → Lokationer** (uden for Portaler). Opret/frigør et mødelokale på lokationen, eller slå kravet fra. Kontakt din administrator, hvis du ikke har adgang.


**Hvordan kommer kunderne ind på portalen, og hvornår går ændringer live?**

Portalens kundevendte side åbnes via **Åben portal** / link-ikonet i portal-listen — det link deler du med kunderne (hjemmeside, e-mail m.m.). Ændringer gælder ved næste indlæsning/booking-søgning; oplever du forsinkelse, opdatér siden.


**Valideringen afviser gyldigt input (fx CPR).**

Tjek feltets **regulære udtryk**. De predefinerede regex har bestemte formater (fx CPR med/uden bindestreg). Vælg den rette predefinerede regex, eller tilret udtrykket — og giv en hjælpsom **Fejlbesked**.


**Hvad får kunden via iCal?**

Slår du **iCal** til, kan kunden få en kalenderfil (.ics) for det bookede møde, så det nemt lægges i kalenderen.


**Login (MitID eller Azure AD) fejler for kunden.**

Tjek, at portalens **Login type** passer til målgruppen (Azure AD = interne; MitID = borgere). Vedvarer fejlen, kontakt support — det kan være en opsætning i jeres identitetsløsning.


## CRM Konfigurationer


**Hvad er en CRM Konfiguration?**

En felt-mapning, der bestemmer, hvordan bookingens data skrives til jeres CRM — både portal-felter (**Nye portalfelter**) og systemfelter som mødedato/medarbejder (**Eksisterende Schedule mødefelter**).


**Skal jeg have en CRM Konfiguration for hver portal?**

Kun hvis portalen bruger **CRM-konfiguration (standard)**. Flere portaler kan bruge samme konfiguration. (Playbook-strategien kræver ingen konfiguration, men er endnu ikke åbnet.)


**Jeg kan ikke vælge en konfiguration på portalen.**

Opret en CRM Konfiguration først (Schedule → CRM Konfigurationer → Opret ny), så kan du vælge den på portalen.


**Kan jeg slette eller deaktivere en portal eller en CRM Konfiguration, der er i brug?**

En CRM Konfiguration kan være brugt af flere portaler — flyt portalerne over på en anden konfiguration først. Vær opmærksom på effekten på eksisterende/igangværende bookinger; kontakt din administrator/support ved tvivl.


## Adgang og roller


**Hvem kan oprette portaler og CRM Konfigurationer?**

Rollen **Configurator** eller **Admin** i Management UI. Kontakt din administrator, hvis du mangler adgang.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
