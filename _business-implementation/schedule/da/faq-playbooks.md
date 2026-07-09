---
layout: "default"
title: "FAQ – Playbooks"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 411
lang: "da"
---
# Schedule – FAQ: Playbooks
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-playbooks.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/faq-playbooks.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Playbooks i Schedule. Uddybende trin findes i **Schedule – superbrugerguide: Playbooks**.


## Playbooks


**Hvad er en Playbook?**

Et automatisk flow: en **trigger** (begivenhed, fx en kundes portal-booking) → **blokke** (trin) → output (typisk en post i CRM). Playbooks er den fremadrettede standard for, hvordan portaler sender booking-data til CRM.


**Hvor opretter og administrerer jeg Playbooks?**

Under **Admin → Playbooks**. De opsættes typisk i samarbejde med &money, da det er en mere avanceret funktion.


**Hvad er en trigger?**

Den begivenhed, der starter flowet. For portaler er det typisk **PortalMeetings** (en kunde booker via en portal). Der findes også fx **PortalMeetingCancelled** (afbud).


**Hvad er en blok?**

Et trin, der gør én ting — fx **Læs CRM-data**, **Opret CRM-post**, **Opdater CRM-data**, **Filtrer resultater** eller **Kør AI**. En playbook skal have mindst én blok ud over starteren.


**Hvad er en relation og en transformation?**

En **relation** forbinder to blokke og fører data videre ved at mappe **Kildefelt** → **Destinationsfelt**. En **transformation** justerer data undervejs (fx Extract = træk én værdi ud; Join = saml en liste til tekst).


**Jeg kan ikke gemme playbooken.**

Mest almindeligt: ‘Du skal have mindst 1 blok i playbooken’ — tilføj mindst én blok ud over starteren. Ellers: klik **Valider**, og ret alle markerede fejl (manglende felter, ugyldige relationer), før du gemmer.


**Data lander ikke i CRM.**

Tjek, at der er en **Opret CRM-post**/**Opdater CRM-data**-blok, der er forbundet, at felterne er mappet (Kildefelt → Destinationsfelt), og at portalen bruger **Playbook** som CRM-strategi.


**Hvordan kobler jeg playbooken til en portal?**

På portalen: sæt **CRM oprettelsesstrategi** = **Playbook**. Selve valget af den konkrete playbook sker pt. i samarbejde med &money — portalens Playbook-vælger viser stadig ‘Ingen playbooks tilgængelige’ og åbnes snart.


**Erstatter Playbooks den gamle CRM-konfiguration?**

Ja. Playbooks er den fremadrettede standard; den gamle **CRM-konfiguration (standard)** udfases og bruges kun af enkelte kunder i en overgangsperiode.


**Kan jeg genbruge en playbook?**

Ja — du kan **Eksporter**/**Importer** en playbook som JSON, og den samme playbook kan bruges på flere portaler.


**Hvordan ser jeg, at en booking kørte playbooken?**

På playbook-listen viser **Status** (Aktiv/Deaktiveret) og **Sidst brugt**, hvornår den sidst kørte. Til at teste kan du bruge **Tør-kørsel** i editoren. Ved mistanke om en fejlet kørsel: se **Admin → Logs** eller kontakt &money.


**Jeg kan ikke se Playbooks under Admin.**

Din rolle er sandsynligvis ikke **Admin**, eller CRM-forbindelsen er ikke sat op endnu. Kontakt din administrator/&money.


**Hvad skal en afbuds-playbook (PortalMeetingCancelled) gøre?**

Typisk **opdatere** eller **slette** den CRM-post, den oprindelige booking lavede, så CRM holdes opdateret. Opsættes typisk med &money.


**Hvordan undgår jeg dubletter i CRM?**

Brug **Læs CRM-data** + **Filtrer resultater** til at finde en eksisterende post, før du opretter en ny (‘find-før-opret’) — eller brug **Opdater CRM-data** i stedet for **Opret CRM-post**.


## Adgang og roller


**Hvem kan opsætte Playbooks?**

Rollen **Admin** — og typisk i samarbejde med &money. Kontakt din administrator/&money, hvis du mangler adgang eller hjælp.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
