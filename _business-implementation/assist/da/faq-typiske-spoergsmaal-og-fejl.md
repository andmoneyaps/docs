---
layout: "default"
title: "FAQ – typiske spørgsmål og fejl"
parent: "Dansk"
grand_parent: "Assist"
nav_order: 403
lang: "da"
---
# Assist – FAQ
_Typiske spørgsmål, fejl og svar · v1.0 · 11.06.2026_


{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/assist/da/faq-typiske-spoergsmaal-og-fejl.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/assist/da/faq-typiske-spoergsmaal-og-fejl.pdf)

Hurtige svar på de mest almindelige spørgsmål og fejl ved Assist. Find dit spørgsmål nedenfor. Uddybende trin findes i **Assist – medarbejderguide** og **Assist – superbrugerguide**.


## For medarbejdere (brug på mødet)


**Hvad hedder Assist-fanen i Salesforce?**

Den kan hedde Assist, Assist Lite, Transskriber eller et navn, jeres organisation selv har valgt. Den ligger på selve mødet (Event).


**Assist-fanen mangler på mødet — hvad gør jeg?**

Kontrollér, at du har en Assist-licens/adgang, og at du har åbnet et møde (Event). Mangler den stadig, kontakt din superbruger (komponenten skal være lagt på Event-siden).


**Mikrofonen virker ikke / der kommer ingen transskription.**

Giv browseren tilladelse til mikrofonen (Chrome eller Edge), og vælg den rigtige mikrofon under Mikrofonindstillinger. Tjek også internetforbindelsen, og start mødet igen. Fortsætter det, kontakt support.


**Knappen “Start møde” er grå — hvorfor?**

Den er grå, indtil deltagere er indlæst, og en mikrofon er valgt (typisk få sekunder). Bliver den ved med at være grå, så vælg en mikrofon manuelt og opdatér siden.


**Hvad hedder knappen, der afslutter mødet?**

“Afslut & dan referat”. Når du klikker den, danner Assist automatisk referatet.


**Jeg kan ikke se transskription eller taletidsfordeling under mødet.**

Scroll i panelet — transskription og taletid vises der. Opmærksomhedspunkter og aftaler udfyldes først efter et par minutter (du ser fx “X beskeder til næste opdatering”). Det er ikke en fejl.


**Der står “Ingen aftaler indgået endnu” på referatet.**

Det er normalt — Assist fandt blot ingen konkrete aftaler i samtalen.


**Hvor lang tid tager det at danne referatet?**

Typisk under et minut efter du har klikket “Afslut & dan referat”.


**Hvor finder jeg referatet?**

I Salesforce — enten på selve mødet (Event) eller i en dedikeret fane (flere organisationer kalder den fx “Referat”). Er du i tvivl, så spørg din superbruger.


**Hvad er forskellen på “Live møde” og “Upload transskription”?**

Live møde optager og transskriberer mødet live. Upload transskription er kun til at uploade en allerede eksisterende optagelse/tekst.


**Jeg kan ikke finde mit referat.**

Referatet gemmes i jeres CRM, når det er dannet — tjek mødet (Event) eller “Referat”-fanen i Salesforce (se “Hvor finder jeg referatet”). Transskriptionen findes kun i op til 48 timer; er referatet ikke endt i CRM, så kontakt support inden for 48 timer. Husk: referatet dannes kun, hvis du har klikket “Afslut & dan referat” — gør du ikke det, slettes transskriptionen efter 48 timer, og der er intet referat.


**Forbindelsen blev afbrudt, eller browseren lukkede midt i mødet.**

Ved kortvarige afbrydelser kan sessionen genoptages, hvis du vender hurtigt tilbage. Ved længere afbrydelser kan det optagne være tabt — afslut og dan referat af det, der er optaget, eller start mødet forfra. Er du i tvivl, kontakt support.


**Transskriptionen er på det forkerte sprog.**

Sproget vælges, før du starter (under indstillinger/tandhjulet). Er transskriptionen på det forkerte sprog, så afslut mødet og start forfra med det rigtige sprog valgt.


**Deltagere indlæses ikke, eller en rolle er forkert.**

Tjek deltagere og roller (kunde/medarbejder) på klargøringsskærmen, før du starter — det er dem, der navngiver transskriptionen. Vent et øjeblik, hvis de stadig indlæser, og ret rollen før start. Bliver de ved med ikke at indlæse, opdatér siden eller kontakt support.


**Virker Assist i Safari eller Firefox?**

Assist understøttes i Chrome og Edge. I Safari eller Firefox kan optagelsen fejle (nogle gange uden tydelig besked) — skift til Chrome eller Edge.


**Hvad er “Upload transskription”, og kan jeg bruge det?**

Det er en mulighed for at uploade en allerede eksisterende transskription i stedet for at optage live — fx en Teams-transskription (.vtt-fil), så Assist danner et referat ud fra den. Er den ikke aktiveret hos jer, vises den måske ikke — kontakt &money.


**Hvad er “Mødemål”?**

Mål, Assist følger og vurderer på mødet. Funktionen kommer snart og er endnu ikke åbnet for kunder.


**Hvad får jeg den bedste optagelse på et fysisk møde?**

Brug en ekstern mikrofon eller headset (ikke kun den indbyggede laptop-mik), placér mikrofonen midt på bordet, hold den fri, og vælg et roligt lokale. Test mikrofonen før mødet.


**Må jeg lukke laptoppen, når mødet starter?**

Nej — lad laptoppen stå åben under hele mødet. Lukker du den sammen ved mødestart, kan optagelsen blive afbrudt.


**Kan jeg skifte til andre faner eller programmer under optagelsen?**

Ja. Du kan trygt skifte mellem faner og programmer — fx Present/Mødepræsentation-fanen, PowerPoint, netbank (I*Net) eller andre faner — og vende tilbage, uden at optagelsen mistes.


**Skal jeg huske at afslutte mødet?**

Ja. Klik altid “Afslut & dan referat”, så referatet dannes. (Automatisk dannelse, hvis du glemmer det, er på vej.)


**Hvordan holder jeg et hybridmøde (både fysiske og online deltagere)?**

Hybridmøder — hvor der både er fysiske og online deltagere — afholdes i Teams.


**Hvordan får jeg referatet over i en netbankbesked?**

Afhængigt af jeres opsætning kan du enten kopiere referatet direkte fra referat-fanen til en netbankbesked, eller finde referatet via en kort proces. Spørg din superbruger, hvis du er i tvivl.


## For superbrugere (Management UI)


**Skal jeg vælge Assist-version eller variant?**

Nej. &money sætter selve Assist-versionen og skabelonen op for jer.


**Kan jeg oprette mødemål?**

Ikke endnu — mødemål er udviklet, men ikke åbnet for kunder (“kommer snart”). Forhåndsvisningen i guiden viser, hvad funktionen kommer til at kunne.


**Hvorfor står rapporteringstallene på 0?**

Fordi mødemål ikke er åbnet endnu. “Møder med mødemål”, “Antal mødemål” og “%-vis fuldførte” står på 0, indtil mødemål åbnes — “Assist møder” er det primære tal i dag.


**Hvad betyder Fuldført / Berørt / Ikke påbegyndt?**

Fuldført = målet er nået. Berørt = berørt undervejs, men ikke nået. Ikke påbegyndt = ikke berørt.


**Hvor ofte bør jeg tjekke rapporteringen?**

Fx månedligt. Ser du markant lav brug, så tag fat i &money.


**Hvordan bekræfter jeg, at en bruger har Assist-licens/adgang?**

Licenser og adgang tildeles af &money / jeres Entra-administrator. Kan en bruger ikke se Assist, så bekræft hos jeres Entra-admin eller &money, at brugeren har adgang, og at Assist-komponenten er lagt på Event-siden.


**Hvor styres det, om referatet lander på mødet eller i en fane?**

Det konfigureres pr. organisation (ikke i Assist-skærmen). Du skal ikke opsætte det som superbruger — bekræft jeres opsætning med &money, hvis du er i tvivl.


## Data, samtykke og adgang


**Skal medarbejderen informere kunden om optagelsen?**

Ja. Sig fx: “Til mødet bruger jeg en AI-assistent, der optager og laver en tekst af samtalen, så jeg kan skrive et referat — er det i orden med dig?” Assists egen AI-note erstatter ikke din egen information.


**Hvor længe gemmes optagelsen/transskriptionen?**

Transskriptionen opbevares i op til 48 timer og slettes derefter automatisk. Referatet i jeres CRM er den blivende kopi — du behøver ikke gøre noget for at slette transskriptionen.


**Bruges vores mødedata til at træne AI-modeller?**

Nej. Behandlingen (transskription og AI) sker i EU (Microsoft Azure), og indholdet bruges ikke til modeltræning.


**Assist-fanen hænger i en spinner / loader ikke.**

Klik refresh (genindlæs siden), og tjek, at du er logget ind i Microsoft 365 (brug Chrome eller Edge). Er spinneren der stadig, så send en sag ind med møde-ID til support — der er et kendt forhold med login i den indlejrede komponent, som &money arbejder på.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
