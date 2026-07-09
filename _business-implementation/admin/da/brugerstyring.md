---
layout: "default"
title: "Brugerstyring"
parent: "Dansk"
grand_parent: "Admin"
nav_order: 201
lang: "da"
---
# Admin – Brugerstyring (deep-dive)
_Brugere, lokaler & automatisk licensstyring · hvad du reelt ser · konsekvensen af ændringer · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/admin/da/brugerstyring.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/admin/da/brugerstyring.pdf)

## Formål og værdi

**Brugerstyring** dækker medarbejdere (**Brugere**), mødelokaler (**Lokaler**) og — vigtigst og mest risikofyldt — **automatisk licensstyring**. Her kan licenser og adgang tildeles eller **fjernes automatisk** på tværs af **alle** medarbejdere, og brugere kan komme både fra **Entra/SCIM** og oprettes **manuelt**.

{: .warning }
> **Husk:** **Auto-fjern licenser** fjerner licens/adgang **automatisk**, når en medarbejder slettes — uden en ekstra advarsel i selve slette-dialogen. Test auto-reglerne på **få brugere** først, og kør **Validér brugere**, før du slår auto-licens til.


## Hvem ændrer hvad (og risikoen)


| Område | Hvem | Risiko |
|---|---|---|
| Brugere / Lokaler (opret/rediger) | Du / IT | Lav–middel. |
| Redigér en SCIM-bruger | Du (forsigtigt) | Middel — kan overskrives ved næste SCIM-sync. |
| Auto-licens: master-toggle | Du / &money | Høj — gælder alle nye medarbejdere. |
| Auto-tildel | Du | Høj — alle får licensen/rettigheden. |
| Auto-fjern | Du | Høj — fjernes ved sletning, ingen ekstra advarsel. |
| Auto-Opdage Mappings | Du | Lav — kun navne, ikke-destruktiv. |
| Nulstil til Standard | Du | Høj — sletter al auto-opsætning, kan ikke fortrydes. |
| Validér brugere | Du | — diagnostik (e-mail-match). |


## Hvad du reelt ser


**Brugere**

**Hvad du reelt ser:** en tabel med **Navn**, **Initialer**, **Email**, **SCIM** (kommer brugeren fra Entra?), **Rettigheder**, **Grupper**, **Licenser** og **Labels**. Du kan **Opret**e, redigere og bruge bund-handlinger: **Redigér rettigheder/grupper/licenser** og **Slet/Genopret bruger(e)**.


**Lokaler**

**Hvad du reelt ser:** **Navn**, **Lokation**, **Kan bookes**, **SCIM** og **Labels** — opret/rediger/slet på samme måde som brugere.


**SCIM kontra manuelt oprettede brugere**

**Hvad du reelt ser:** redigerer du en **SCIM-bruger**, kommer en **rød advarsel** + en bekræftelse: ‘Ret kun … hvis du er helt sikker på, hvad du laver!’. **Konsekvens:** manuelle ændringer på en SCIM-bruger kan blive **overskrevet** ved næste Entra-sync. Manuelt oprettede brugere synkroniseres **ikke** af SCIM. **Opstår en dublet** (samme person manuelt + via SCIM), så behold **SCIM**-brugeren og fjern den manuelle.


**Automatisk licensstyring**

**Hvad du reelt ser:** en master-knap **Aktivér Automatisk Licensstyring** og tre sektioner — **Pakkelicenser**, **Rettighedssæt** og **Rettighedsgrupper** — hver med **Auto-tildel** og **Auto-fjern**. Desuden **Auto-Opdage Mappings** (sætter læsbare navne på licens-ID’er) og **Nulstil til Standard**.

- **Auto-tildel** = alle medarbejdere får automatisk den valgte licens/rettighed.
- **Auto-fjern** = licensen/rettigheden fjernes, når en medarbejder **slettes** fra systemet.
- **Auto-Opdage Mappings** er **ikke-destruktiv** — den rører kun navne, ikke faktiske tildelinger.
- **Nulstil til Standard** sletter **al** auto-opsætning (kræver bekræftelse, **kan ikke fortrydes**) — men rører ikke licenser, der allerede er tildelt.


## Konsekvens af de farlige handlinger


| Handling | Konsekvens | Advarsel i UI? |
|---|---|---|
| Auto-tildel slået TIL | Alle (nuværende + nye) får licensen/rettigheden | Nej |
| Auto-fjern TIL + slet medarbejder | Licens/adgang fjernes i CRM ved sletning | NEJ — ingen ekstra advarsel ved sletning |
| Redigér en SCIM-bruger | Ændringen kan overskrives ved næste sync | Ja — rød advarsel + bekræft |
| Nulstil til Standard | Al auto-opsætning slettes (ikke allerede tildelte) | Ja — bekræft, kan ikke fortrydes |
| Auto-Opdage Mappings | Kun læsbare navne på licens-ID'er | Ikke-destruktiv |


## Før du ændrer noget

- **Kør Validér brugere FØRST:** der skal være 1-til-1 e-mail-match — dubletter/manglende får auto-licens til at fejle. (Se CRM Opsætning.)
- **Test auto-tildel/-fjern på få brugere**, før du slår det til for alle.
- **Husk auto-fjern** udløses ved sletning **uden ekstra advarsel** — vær sikker, før du sletter en medarbejder.
- **Redigér kun SCIM-brugere**, hvis du ved, hvad du laver — ellers håndtér dem i Entra.
- **Nulstil til Standard** kan ikke fortrydes; eksportér/notér din opsætning først.

### Se også / forudsætninger
- **Admin – CRM Opsætning (deep-dive)** — Validér brugere + selve licens-grundlaget.
- **Admin – Logs & synkroniseringsfejl** — sync-fejl + ansvarsfordeling.
- **Admin – overblik over undermenuerne** — alle faner kort.


## Seneste opdatering

- 12.06.2026 (v1.0) — Første version (Brugerstyring deep-dive).


{: .warning }
> ⚠️ **Husk** — Auto-fjern fjerner ved sletning uden ekstra advarsel; validér brugere først; SCIM kan overskrive manuelle rettelser.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
