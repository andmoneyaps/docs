---
layout: "default"
title: "FAQ – typiske spørgsmål og fejl"
parent: "Dansk"
grand_parent: "Present"
nav_order: 403
lang: "da"
---
# Present – FAQ
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/present/da/faq-typiske-spoergsmaal-og-fejl.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/present/da/faq-typiske-spoergsmaal-og-fejl.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Present. Find dit spørgsmål nedenfor. Uddybende trin findes i **Present – medarbejderguide** og **Present – superbrugerguide**.


## For medarbejdere (generér præsentation i Salesforce)


**Der vises ingen skabeloner, når jeg vil generere.**

Kunden mangler en kundetype på sin konto, eller du mangler en Present-licens. Kontrollér kundetypen, og kontakt ellers din superbruger.


**Knappen “Generér” er grå.**

Vælg mindst ét slide først — så aktiveres knappen.


**Der står [tag:...] som tekst i præsentationen.**

Feltet manglede data eller er ikke mappet. Udfyld det i felt-vinduet (“Tekst der indsættes”), eller bed din superbruger tjekke tag-mapningen.


**Hvad er felt-vinduet “Tekst der indsættes”?**

Vinduet, der åbner, når du genererer. Her er felter med data fra Salesforce forudfyldt (fx dato/kunde), og tomme felter (“Ingen værdi”) udfylder du selv. Klik “Generér præsentation” nederst for at danne filen.


**Hvor finder jeg den færdige præsentation?**

På selve mødet (Event) i Salesforce, under Filer (Files). Den kan deles, og du kan lave en PDF med “Konverter til PDF”.


**Præsentationen ser forkert ud i forhåndsvisningen.**

Download PowerPoint-filen — den ser korrekt ud i PowerPoint. Forhåndsvisningen i Salesforce viser ikke alt (grafer, grafiske elementer, billedtyper, aktive/interaktive links og fonte).


**Links eller interaktive elementer virker ikke.**

Du er i forhåndsvisningen — brug den downloadede PowerPoint-fil (ikke PDF’en). Aktive links virker kun, når præsentationen åbnes i PowerPoint.


**Hvordan deler jeg præsentationen med kunden?**

Send PDF’en (Konverter til PDF), eller præsentér direkte fra PowerPoint-filen (fysisk møde eller Teams-skærmdeling).


**Genereringen hænger, eller jeg klikkede flere gange.**

Generering tager typisk 10–60 sekunder. Vent et øjeblik; hænger den, så luk vinduet og prøv igen. Tjek under Filer (Files), om der allerede er dannet en præsentation (dublet).


## For superbrugere (Management UI)


**Skabelonen kan ikke uploades.**

Tjek feltet Validering i upload-dialogen — ret de viste fejl i PowerPoint, og upload igen.


**Hvor uploader jeg en master-skabelon?**

Gå til Present → Opsætning → Præsentationer → Upload. Vælg .pptx-filen og den rette kundetype.


**Hvordan deaktiverer jeg en gammel skabelon?**

Klik slet-ikonet i Præsentationer og bekræft i “Deaktiver præsentation”. Skabelonen skjules for medarbejderne, men data bevares til rapportering (status “Inaktiv”).


**Kundetypen findes ikke, når jeg uploader.**

Opret kundetypen i Schedule (Mødeopsætning → Kundetyper) først, og prøv så igen.


**Medarbejderen kan ikke se Present.**

Kontrollér, at brugeren har en Present-licens, og at Present er aktiveret i Management UI.


**Hvor mapper jeg tags til CRM-felter?**

Present → Opsætning → CRM Konfiguration → Opret. Vælg tag, objekttype og objektfelt.


**Jeg kan ikke se Opsætning eller CRM Konfiguration.**

Det kræver de rette rettigheder i Management UI. Kontakt din administrator for at få adgang.


**Hvad sker der med tag-mapningerne, når jeg uploader en rettet skabelon?**

Tag-mapningerne (CRM Konfiguration) gælder pr. tag og bevares på tværs af skabeloner. Har du tilføjet nye tags i den rettede skabelon, skal de mappes.


## Masterslides og PowerPoint


**Generering fejler, eller slides bliver forkerte.**

Den hyppigste årsag er, at slidestørrelsen ikke er sat til “Brugerdefineret” i PowerPoint (Design → Slidestørrelse → Brugerdefineret slidestørrelse). Importerede/Templafy-layouts kan også give fejl.


**Min upload fejler pga. layout (Templafy/importeret).**

Undgå layouts med tal i navnet, brug entydige layout-navne, og brug layoutet “Tom”, hvis du er i tvivl.


**Hvad er den maksimale filstørrelse?**

Den samlede PowerPoint-fil må ikke overstige 10 MB (ellers fejler upload). Pr. billede er ca. 1 MB anbefalet.


**Hvordan komprimerer jeg billeder?**

Marker et billede → fanen Billedformat → Komprimer billeder → vælg lavere opløsning og “Slet beskårne områder”; fjern fluebenet “Anvend kun på dette billede” for hele filen. Komprimér også videoer (Filer → Oplysninger → Komprimer medie).


**Hvordan navngiver jeg slides?**

I notefeltet på hvert slide: [slide:slide_navn] — små bogstaver, ingen mellemrum, underscore som ordadskiller.


**Hvordan laver jeg sektioner og undersektioner?**

Brug PowerPoints sektionsfunktion (højreklik mellem slides → Tilføj sektion). Undersektion laves ved at navngive sektionen “Sektionsnavn -- Undersektionsnavn”.


**Hvordan indsætter jeg et hyperlink (fx logo → agenda)?**

Marker elementet → Indsæt → Link → “Placer i dette dokument” → vælg destinations-slidet (fx agenda). Aktive/eksterne links virker, når filen åbnes i PowerPoint — ikke i forhåndsvisningen.


## Tags og felter


**Jeg kan ikke finde mit tag i listen “Vælg et tag”.**

Kontrollér, at tagget er stavet korrekt i PowerPoint, og at filen er uploadet.


**Hvilket CRM-felt skal et tag pege på?**

Se referencetabellen “Mest anvendte tags” i superbrugerguiden. Er du i tvivl, kontakt jeres CRM-/superbruger-ansvarlige eller &money-support.


**Hvordan mapper jeg agenda og bydeformer?**

Mod Objekttype “Specifik”: agenda → feltet “Møde dagsorden”; bydeformer (Dine/Jeres, Du/I, Dig/Jer, Din/Jeres, Dit/Jeres) → de tilsvarende Specifik-felter.


**Hvad er tag-modifiers?**

De formaterer data fra Salesforce før indsættelse: capitalize (stort begyndelsesbogstav), uppercase, lowercase, title, trim. Kædes med kolon, fx [tag:firmanavn:trim:uppercase].


**Hvordan erstatter jeg et billede dynamisk?**

Navngiv billedet i PowerPoint (via Markeringsruden) med [image:image_name]. Ved generering erstattes billedet med det billede, der er knyttet til image-tagget.


**Præsentationen mangler data.**

Kontrollér, at de relevante tags er mappet under CRM Konfiguration, og at CRM-felterne faktisk indeholder data.


**Mit billede blev ikke erstattet ([image:...] virker ikke).**

Tjek, at billedet er navngivet præcis [image:image_name] (via Markeringsruden i PowerPoint), og at navnet matcher det image-tag, billedet skal hente.


**Agendaen/dagsordenen kommer ikke med på slidet.**

Agenda-tagget skal stå som bullet-points på slidet for at virke. Tjek også, at agenda er mappet (Objekttype Specifik → “Møde dagsorden”), og at dagsordenen er udfyldt på mødet.


**Der kommer forkerte data ind (fx forkert dato).**

Tagget er sandsynligvis mappet til et andet felt end forventet — fx henter [tag:dato] Event → Slutdato (mødets sluttidspunkt). Tjek mapningen under CRM Konfiguration.


**Hvilke regler gælder for slide- og tag-navne?**

Kun små bogstaver, cifre, underscore (_) og bindestreg (-) — ingen mellemrum, store bogstaver eller specialtegn. Tag-navne skal matche præcist mellem PowerPoint og mapningen i CRM Konfiguration.


## Valideringsbeskeder ved upload (hvad betyder de?)

Når du uploader en skabelon, vises Info, Advarsel og Fejl. Kun **Fejl** blokerer upload — advarsler kan du ofte leve med.


| Besked (uddrag) | Betydning | Hvad du gør |
|---|---|---|
| Diasnavn mangler på dias | Et slide har intet navn i notefeltet | Tilføj [slide:navn] i notefeltet. |
| Slidenavn/tag indeholder ugyldige tegn | Kun små bogstaver, cifre, _ og - er tilladt | Fjern mellemrum, store bogstaver og specialtegn. |
| Diasnavnet bruges flere gange | To slides har samme navn | Gør slide-navnene unikke. |
| Ugyldig layoutreference | Slidet bruger et layout, Present ikke kan læse (ofte Templafy/importeret) | Undgå tal i layout-navne; brug layoutet “Tom”. |
| Ikke-understøttet modifikator | Et tag bruger en ukendt modifier | Brug kun: capitalize, uppercase, lowercase, title, trim. |
| Ugyldigt diagram | Et diagram kan ikke håndteres korrekt | Forenkl diagrammet, eller indsæt det som billede. |
| Billedet er stort (maks. 1 MB anbefalet) | Et billede fylder meget (advarsel) | Komprimér billedet (Billedformat → Komprimer billeder). |
| Skrifttyper fundet | Special-/brugerdefinerede fonte vises ikke i forhåndsvisningen (advarsel) | Brug standard-fonte, eller præsentér fra PowerPoint-filen. |
| Links mellem slides fundet | Interne links virker kun, hvis destinations-slidet er med (advarsel) | Medtag de slides, dine links peger på. |
| Overgange fundet | Slide-overgange vises måske ikke som forventet (advarsel) | Undgå overgange mellem slides, der ikke altid er med. |
| Skabelonen indeholder valideringsfejl og kan derfor ikke uploades | Mindst én blokerende fejl | Ret fejlene ovenfor, og upload igen. |


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
