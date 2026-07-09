---
layout: "default"
title: "Superbrugerguide"
parent: "Dansk"
grand_parent: "Assist"
nav_order: 201
lang: "da"
---
# Assist – superbrugerguide
_Rapportering i Management UI · v1.1 · 10.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/assist/da/superbrugerguide.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/assist/da/superbrugerguide.pdf)

## Formål og værdi

Assist er &moneys AI-mødeassistent. Den transskriberer kundemødet, følger jeres mødemål og danner automatisk et referat. &money sætter selve Assist-versionen og skabelonen op for jer — som superbruger følger du brugen via rapportering i Management UI (og kan snart også definere jeres mødemål).

### Ordliste
- **Assist**: &moneys AI-mødeassistent i Salesforce — transskription, mødemål og automatisk referat.
- **Management UI**: &moneys administrationsside, hvor du som superbruger opsætter produkterne.
- **Mødemål**: Mål for et møde (oprettes pr. mødeemne), som Assist følger og vurderer undervejs.
- **Mødeemne**: Den kategori et møde hører under (fx Bank, Wealth Management) — mødemål oprettes pr. emne.
- **AI-instruktion**: Den instruktion, du giver Assist for, hvornår et mødemål er nået.
- **Rapportering**: Overblik over brugen af Assist — antal møder, mødemål og hvor mange der fuldføres.


## Målgruppe og forudsætninger

- Målgruppe: superbruger/administrator, der følger rapportering for Assist (og snart opsætter mødemål).
- Assist er aktiveret for organisationen, og de medarbejdere, der skal bruge Assist, har licens/adgang (sættes op af &money / jeres admin).
- Microsoft 365 / Entra ID er på plads (login og identitet).
- I Salesforce er **Trusted URL** + mikrofon-tilladelse sat op (Salesforce-admin), så Assist må optage lyd i browseren.
- Du har adgang til Management UI med de nødvendige rettigheder.

{: .note }
> **Bemærk:** Assist optager og transskriberer møder. Medarbejderen skal altid informere kunden om, at mødet optages og transskriberes med AI — sørg for, at det er en fast del af jeres mødepraksis.


## Dit udbytte

Efter denne guide kan du:

- Følge brugen af Assist via rapportering.
- Forstå mødemål (**kommer snart**), og hvad de gør.
- Kende forudsætningerne og fejlfinde de mest gængse problemer.


## Overblik

- Trin 1: Følg brugen af Assist via rapportering.
- Mødemål: **kommer snart** — forklares nedenfor.


## Det sætter &money op for jer

Du skal ikke vælge eller opsætte selve Assist-versionen — det gør &money:

- **Assist-version og skabelon**: &money konfigurerer, hvilken version af Assist I bruger, og opsætter skabelonen.
- **Hvor referatet lander**: om referatet gemmes på selve mødet eller i en dedikeret fane konfigureres pr. organisation (flere kunder navngiver endda fanen selv, fx “Referat”). Det skal du ikke opsætte som superbruger.


## Trin-for-trin (Management UI)


### Trin 1 · Følg brugen via rapportering

_Hvorfor: Rapporteringen viser, hvor meget Assist bruges på tværs af organisationen._

- Gå til **Assist** → **Rapportering** i Management UI.
- Filtrér på **Periode** og **Kundetype**.
- Se nøgletal: **Assist møder**, **Møder med mødemål**, **Antal mødemål** og **%-vis fuldførte mødemål**.
- Brug graferne (**Fuldført** / **Berørt** / **Ikke påbegyndt**) til at se resultater over tid, pr. mødemål og pr. emne.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/assist/superbrugerguide/assist_rapportering.png)

*Skærmbillede 1 (Management UI) — Assist → Rapportering — nøgletal og mødemål-resultater (Fuldført / Berørt / Ikke påbegyndt)*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Du ser nøgletal og grafer for den valgte periode og kundetype.

{: .note }
> **Bemærk:** Eksemplet viser testdata. I din visning vil **Møder med mødemål**, **Antal mødemål** og **%-vis fuldførte mødemål** stå på 0, indtil mødemål åbnes — **Assist møder** er det primære tal i dag.

Resultaterne vises i tre kategorier: **Fuldført** (målet er nået), **Berørt** (berørt undervejs, men ikke nået) og **Ikke påbegyndt** (ikke berørt).

{: .hint }
> **Anbefalet:** Tjek rapporteringen fx månedligt. Ser du markant lav brug, så tag fat i &money.


## Mødemål (kommer snart)

{: .note }
> **Bemærk:** **Kommer snart:** Mødemål er udviklet, men endnu ikke åbnet for kunder. Forhåndsvisningen nedenfor viser, hvad funktionen kommer til at kunne — knapper som **Opret** er endnu ikke aktive for jer.

Når mødemål åbnes, kan du under **Assist → Mødemål** definere standard-mål pr. mødeemne, som Assist følger og vurderer på møderne. Hvert mål har et **Navn**, en **Beskrivelse** og en **AI-instruktion** (det, Assist vurderer målet ud fra), og grupperes pr. mødeemne (fx Bank, Wealth Management, Insurance).


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/assist/superbrugerguide/assist_modemaal.png)

*Skærmbillede 2 (Management UI) — Forhåndsvisning — Assist → Mødemål (kommer snart): mål pr. mødeemne med **Navn**, **Beskrivelse** og **AI-instruktion***


## Hvad betyder felterne?


| Felt | Hvad det styrer | Betydning |
|---|---|---|
| Periode (rapportering) | Tidsrum | Afgrænser data i rapporteringen. |
| Kundetype (rapportering) | Segment (fx Privat/Erhverv) | Afgrænser rapporteringen til en bestemt kundetype. |
| Mødeemne / Underemne (mødemål, kommer snart) | Hvor målet hører til | Grupperer mødemål pr. emne; medarbejderen får målene for det relevante emne. |
| Navn (mødemål, kommer snart) | Målets titel | Vises til medarbejderen som mødemål. |
| AI-instruktion (mødemål, kommer snart) | Hvornår målet er nået | Styrer, hvordan Assist vurderer, om målet er opfyldt på mødet. |


## Automatisk referat og opbevaring

- Når medarbejderen afslutter mødet, danner Assist **automatisk et referat** (kunde- og grundreferat) ud fra transskriptionen.
- Referatet gemmes i jeres **CRM** (Salesforce) — på mødet eller i en fane (afhænger af jeres opsætning). CRM er den blivende kopi.
- Selve **transskriptionen opbevares midlertidigt i op til 48 timer** og slettes derefter **automatisk** — I behøver ikke gøre noget. Referatet i CRM forbliver.
- Behandling (transskription og AI) sker i **EU** (Microsoft Azure); indholdet bruges ikke til at træne AI-modeller.


## Samtykke

- Medarbejderen skal **informere kunden** om, at mødet optages og transskriberes med AI, og sikre et gyldigt grundlag.
- Assist viser en note om AI-transskription — men den erstatter ikke jeres egen information til kunden.
- Den **forretningsansvarlige** sikrer, at medarbejderne godkender mikrofon-pop-up'en i browseren, så Assist kan optage.


## Fejlfinding

- Mikrofonen virker ikke: kontrollér browser-tilladelsen, og at **Trusted URL** er sat op i Salesforce; brug Chrome eller Edge.
- Assist-fanen mangler på mødet: kontrollér licens/adgang, og at Assist-komponenten er lagt på Event-siden (jeres admin / &money).
- Rapporteringen er tom: justér **Periode** og **Kundetype**.

Flere typiske spørgsmål og fejl: se **Assist – FAQ**.

### Se også / forudsætninger
- **Assist – medarbejderguide** (brug af Assist på mødet i Salesforce) — ledsagende guide.
- **Assist – FAQ** (typiske spørgsmål, fejl og svar).


## Seneste opdatering

- 10.06.2026 (v1.1) — Fokus på rapportering; mødemål markeret “kommer snart”; Assist-version/skabelon sættes op af &money; auto-referat og 48-timers opbevaring tilføjet.
- 10.06.2026 (v1.0) — Første version.


{: .hint }
> ✅ **Færdig!** Du kan nu følge brugen af Assist via rapportering.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.1 · 10.06.2026_
