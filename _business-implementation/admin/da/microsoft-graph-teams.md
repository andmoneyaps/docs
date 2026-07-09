---
layout: "default"
title: "Microsoft (Graph + Teams)"
parent: "Dansk"
grand_parent: "Admin"
nav_order: 204
lang: "da"
---
# Admin – Microsoft (Graph API + Teams) (deep-dive)
_Kalender-sync + Teams-møder · hvad du reelt ser · konsekvensen af ændringer · v1.0 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/admin/da/microsoft-graph-teams.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/admin/da/microsoft-graph-teams.pdf)

## Formål og værdi

**Microsoft**-fanen styrer to ting: forbindelsen til **Microsoft Graph** via en **Proxy URL** — rygraden i **al kalender-sync** — og standard-indstillingerne for de **Teams-møder**, Schedule opretter automatisk. Graph-forbindelsen sikrer, at møder oprettes, opdateres, læses og slettes i medarbejdernes kalendere.

{: .important }
> **Husk:** **Proxy URL er den enkeltvis vigtigste indstilling i hele Admin.** En forkert eller utilgængelig værdi stopper **AL** kalender-sync for **alle** medarbejdere på én gang. Rør den kun efter aftale med jeres IT/jeres driftspartner — og klik **Test forbindelse** FØR du gemmer.


## Hvem ændrer hvad (og risikoen)


| Indstilling | Hvem | Risiko |
|---|---|---|
| Proxy URL (Graph) | jeres driftspartner / IT (efter aftale) | KRITISK — stopper al kalender-sync. |
| Test forbindelse | Du | Ingen — vejledende test. |
| Teams: optagelse / transskription / auto-optag | Du | Middel — gælder ALLE nye møder. |
| Teams-mødeskabelon-ID | Du / IT | Middel — tilsidesætter de tre toggles; kræver Teams Premium. |


## Hvad du reelt ser


**Microsoft Graph API (Proxy URL)**

**Hvad du reelt ser:** ét felt — **Proxy URL** — en knap **Test forbindelse** og **Gem**. Test rammer proxyens **/healthz** og viser enten grønt ‘Forbindelse til Microsoft Graph API er oprettet’ eller rødt ‘Fejl ved oprettelse af forbindelse …’ (med statuskode).

- **Vigtigt:** testen er kun **vejledende** — du KAN gemme en URL, der fejler testen. Der er **ingen bekræftelse** og **ingen fortryd**.
- **/healthz** tester kun, at proxyen **svarer** — ikke at rettigheder/scopes er på plads. En grøn test er derfor ikke en garanti for, at sync virker.
- **Konsekvens:** en forkert/utilgængelig URL = ingen medarbejder synkroniseres, og nye møder oprettes ikke i Teams/Exchange.

{: .note }
> **Bemærk:** Fejlen vises i Logs som ‘Kunne ikke synkronisere kalender for rådgiver: Kunne ikke oprette forbindelse til Graph API’ — i Logs-guiden **CAL-ERR-14**. Rammer den ALLE medarbejdere på én gang, er årsagen næsten altid proxy/platform — ikke den enkelte.


**Teams – mødeindstillinger**

**Hvad du reelt ser:** tre til/fra-indstillinger + et felt til skabelon-ID. De gælder **alle** Teams-møder, Schedule opretter fremover (ikke eksisterende):


| Indstilling | Hvad den gør | Bemærk |
|---|---|---|
| Tillad optagelse | Deltagere kan optage mødet | Optagelser lander i Teams/SharePoint. |
| Tillad transskription | Slår auto-transskription til | Microsoft understøtter IKKE dansk endnu — hold SLUKKET, ellers fejler det tavst. |
| Start optagelse automatisk | Optager fra mødets start | Gælder alle nye møder. |
| Teams-mødeskabelon-ID | Bruger en fast Teams-skabelon | Tilsidesætter de tre ovenfor; kræver Teams Premium; oprettes i Teams Admin Center. |

**Konsekvens:** sættes et **skabelon-ID**, har de tre toggles **ingen effekt** — skabelonen bestemmer alt. Slås **transskription** til på dansk, forsøges transskription, men den fejler (dansk ikke understøttet).


## Relaterede log-fejl

- **CAL-ERR-14** — ‘Kunne ikke oprette forbindelse til Graph API’ (proxy nede/forkert).
- **Delegeret kalenderadgang nægtet** — rettigheds-/delegerings-problem (ikke proxy).
- **Adgang nægtet** / **ugyldig adgangstoken** / **timeout** — se fejlkataloget i Logs-guiden.


## Før du ændrer noget

- **Notér den gamle Proxy URL** før du ændrer — så kan du sætte den tilbage.
- **Test forbindelse FØR Gem** — men husk: grøn test = proxyen svarer, ikke at sync virker.
- **Rammer det alle på én gang?** Mistænk Proxy URL/platform, ikke den enkelte medarbejder.
- **Lad transskription være slukket**, indtil dansk understøttes.
- **Skabelon-ID:** husk, at det tilsidesætter de tre toggles — fjern det, hvis du vil styre via dem.

### Se også / forudsætninger
- **Admin – Logs & synkroniseringsfejl** — fejlkatalog (CAL-ERR-14 m.fl.) + ansvarsfordeling.
- **Admin – CRM Opsætning (deep-dive)** — den anden halvdel af integrationen.
- **Admin – overblik over undermenuerne** — alle faner kort.


## Seneste opdatering

- 12.06.2026 (v1.0) — Første version (Microsoft deep-dive).


{: .warning }
> ⚠️ **Husk** — Proxy URL stopper AL sync ved fejl; test før Gem; dansk transskription = slukket.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
