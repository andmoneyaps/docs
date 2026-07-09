---
layout: "default"
title: "Logs og synkroniseringsfejl"
parent: "Dansk"
grand_parent: "Admin"
nav_order: 203
lang: "da"
---
# Admin – Logs & synkroniseringsfejl
_Fejl-katalog (besked → kode) · hvad de betyder · hvad du gør · hvem gør hvad · v1.2 · 12.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/admin/da/logs-og-synkroniseringsfejl.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/admin/da/logs-og-synkroniseringsfejl.pdf)

## Formål og værdi

Loggene viser, om bookinger og kalendere **synkroniserer** korrekt mellem Schedule og Microsoft 365 / CRM. Når noget driller, vises en dansk **besked** i loggen (og bag den ligger en teknisk **statuskode**, CAL-ERR-xx, du kan oplyse til support). Denne guide forklarer log-fanerne, **hvad hver besked betyder**, hvad du gør, og — vigtigst i jeres situation — **hvem der har ansvaret**.

{: .note }
> **Bemærk:** **Loggene er ALARMER** til jer (kunden) og jeres administrator — ikke en kø, &money eller jeres driftspartner overvåger på jeres vegne. En alarm betyder, at **noget kræver handling** — og handlingen ligger meget ofte i jeres **egen Entra/Microsoft 365**. Brug beslutningstræet og fejl-kataloget nedenfor til at sende fejlen det rigtige sted hen.

{: .important }
> **Husk:** **Udfyld for jeres bank (én gang):** Entra styres hos os af **______** (jeres eget Entra-team / jeres driftspartner). Kontakter — Entra/IT: **______** · jeres driftspartner (1st-level): **______** · &money: info@andmoney.dk. Så bliver ‘Entra (jer/jeres driftspartner)’ i kataloget til **ét** navn.


## Din rolle som admin (og hvad du sender videre)

Din opgave er **ikke** at lave de tekniske rettelser, men at **aflæse og videresende**. De tekniske tjek (app-tilladelser, REST API, delegering) udfører **fixeren** (jeres Entra/IT, jeres driftspartner eller &money).

- **Du kan selv:** klikke **Fjern synkroniserings timeout** ved timeout/forbindelse (CAL-ERR-13/14).
- **Du sender videre:** altid **Fejlkode** · **Tidspunkt** · **Medarbejder/lokale** · **Log-fane** + evt. den fulde besked.
- **Du lukker:** når fejlen er **ryddet** (CAL-INFO-18), og en ny synkronisering **lykkes**.


## Log-fanerne — hvad du reelt ser

- **Møder** — oprettelse/opdatering/sletning af møder i Outlook (status + besked pr. møde).
- **Medarbejdere** — kalender-sync pr. medarbejder: en opsummering (delta/fuld, succes/fejl), seneste succes og seneste fejl, og en knap **Fjern synkroniserings timeout**.
- **Lokaler** — kalender-sync for mødelokaler (samme opbygning som Medarbejdere).
- **Present** — log for slide-/PDF-generering.
- **Audit** — hvem ændrede hvad og hvornår (compliance).
- **Reports** — aggregerede data.

Hver post har en **status** (**Information**, **Advarsel**, **Fejl** eller **Succes**), en **besked** og en **statuskode** (CAL-xx). Det er posterne med status **Fejl** (CAL-ERR-xx), du skal handle på.


## Beslutningstræ — hvem skal handle?

Ifølge jeres aftalte ansvarsfordeling (RACI) ejer **jeres driftspartner** opsætningen og synkroniseringen i jeres tenant (de er operatør for jer), **jeres egen Entra/IT** ejer det, kun I selv kan styre, og **&money** ejer platformen. Send fejlen rigtigt:

- **Forbindelse / Graph-proxy / sync-drift** (CAL-ERR-13/14): **jeres driftspartner** drifter proxy/provisionering og kan rydde en sync-timeout (Graph-proxy/SCIM via specialister); ved netværk, jeres IT.
- **Tilladelser / samtykke / app-opsætning** (CAL-ERR-06/08/10): den, der håndterer jeres **Entra** — **jeres eget Entra-team**, hvis I selv styrer Entra; ellers **jeres driftspartner** (via specialister). Mangler en **licens eller admin-samtykke**, kan kun banken selv give det.
- **Brugerkonti / postkasser** (CAL-ERR-09/11): kun den, der ejer jeres Microsoft-tenant — typisk **jeres eget Entra-team** (deaktiveret bruger, forkert UPN, postkasse uden REST).
- **Platform-/intern fejl** (CAL-ERR-12/15/16): **&money**.
- Som **kunde-admin** ser du alarmen — aflæs **koden** + **tidspunktet**, og send den til rette part.


## Fejl-katalog — slå op på beskeden (eller koden)

Slå op på den **besked**, du ser i loggen. De fleste kalender-fejl starter med ‘**Kunne ikke synkronisere kalender for rådgiver:** …’ — tabellen viser den **distinktive del** efter kolon; CAL-ERR-16 er undtagelsen. Bag hver post ligger også en teknisk **statuskode** (CAL-ERR-xx), som du kan oplyse til jeres driftspartner/&money.


| Besked i loggen (efter ‘… rådgiver:’) | Kode | Betydning, konsekvens & hvad du gør | Ejer |
|---|---|---|---|
| Adgang nægtet for bruger. Kunne være en manglende tilladelse | CAL-ERR-06 | Kalenderen synkroniseres ikke → ingen/forkerte tider. Tjek at app-registreringen har Calendars.ReadWrite + en kalender-licens. | Entra (jer/jeres driftspartner) |
| For mange forsøg | CAL-ERR-07 | Sync opgivet efter gentagne fejl. Find den FØRSTE underliggende 06/14 i loggen, og rut efter den. | Følg 06/14 |
| Kunne ikke læse begivenhed. Kunne være en manglende tilladelse. | CAL-ERR-08 | Begivenhed kunne ikke læses. Tjek tilladelse på kalenderen; kør en fuld synkronisering. | Entra (jer/jeres driftspartner) |
| Ugyldig bruger | CAL-ERR-09 | Kontoen findes ikke / er deaktiveret. Tjek at brugeren er aktiv, og at UPN matcher det, Schedule kender. | Jeres Entra |
| Delegeret kalenderadgang nægtet. | CAL-ERR-10 | Tjek app-tilladelse + admin-samtykke; tjek postkassens delegerings-regler. | Entra (jer/jeres driftspartner) |
| Postkassen er ikke aktiveret til REST API | CAL-ERR-11 | Ældre postkasse-opsætning. Aktivér REST API på brugerens Exchange-postkasse. | Jeres Entra |
| Adgangstoken er ugyldig. Prøv igen med en ny | CAL-ERR-12 | Token udløbet/ugyldigt. Kør en ny synkronisering (token fornyes). Bliver ved? Tjek app-credentials. | &money |
| Synkroniseringen fik timeout. Kunne være relateret til netværksproblemer eller gamle tilbagevendende begivenheder | CAL-ERR-13 | Tjek netværk/M365-status; brug ‘Fjern synkroniserings timeout’; evt. kalender-oprydning. | jeres driftspartner |
| Kunne ikke oprette forbindelse til Graph API | CAL-ERR-14 | Rammer typisk ALLE medarbejdere. Tjek at Graph-proxy kører + at Proxy URL er korrekt (Admin → Microsoft); tjek firewall. | jeres driftspartner |
| Ukendt fejl | CAL-ERR-15 | Uventet fejl fra Graph. Kontakt &money med koden og tidspunktet. | &money |
| (ingen ‘rådgiver:’-prefix) Kunne ikke opdatere delta link for rådgiveren | CAL-ERR-16 | Intern sync-tilstand. Kør en fuld synkronisering. Bliver ved? &money undersøger. | &money |

{: .note }
> **Bemærk:** **Ikke alle koder er fejl** — kode-familierne: **CAL-FS** (01–03) = fuld synkronisering kører/gennemført; **CAL-DS** (01–02) = delta-synkronisering; **CAL-TS** (22–25) = tidsslots oprettes/opdateres/slettes; **CAL-INFO-17** = tidsslots slettet ved fuld sync; **CAL-INFO-18** = ‘Synkroniseringsfejl ryddet for rådgiver’ (fejlen er væk); **CAL-INFO-19/20** = nye/alle medarbejdere sat i kø. Kun **CAL-INFO-21** (‘Fejl ved hentning af synkroniseringsindstillinger for bank’) er reelt en fejl — ejes af &money.


## Sådan ser de typiske fejl ud i loggen (genkend dem)

- CAL-ERR-06: ‘Kunne ikke synkronisere kalender for rådgiver: Adgang nægtet for bruger. Kunne være en manglende tilladelse’.
- CAL-ERR-09: ‘…: Ugyldig bruger’.
- CAL-ERR-11: ‘…: Postkassen er ikke aktiveret til REST API’.
- CAL-ERR-13: ‘…: Synkroniseringen fik timeout. Kunne være relateret til netværksproblemer eller gamle tilbagevendende begivenheder’.
- CAL-ERR-14: ‘…: Kunne ikke oprette forbindelse til Graph API’.


## Sådan handler du på en sync-fejl

- Åbn **Logs → Medarbejdere** (eller Lokaler), og vælg den ramte medarbejder.
- Aflæs **koden** og den seneste **fejl**-besked; slå koden op i kataloget.
- Er det en **timeout/forbindelse**, kan du klikke **Fjern synkroniserings timeout** for at fremtvinge en ny sync.
- Er det **identitet/tilladelse**, send koden + tidspunkt + medarbejder til jeres **Entra/IT**.
- Bliver fejlen ved efter handling, eskalér til **jeres driftspartner** (drift) eller **&money** (platform) med koden.
- Til sidst: bekræft, at fejlen er **ryddet** (CAL-INFO-18) og at en ny **synkronisering lykkes** (CAL-FS/DS), før sagen lukkes.


## Hyppigste support-tickets i praksis

Mønstre fra jeres faktiske support-tickets (anonymiseret). Brug dem som genvej til ‘hvad tjekker jeg — og hvem ejer det’.


| Mønster (det kunden melder) | Sandsynlig årsag | Tjek / hvem |
|---|---|---|
| Online møde oprettet uden Teams-link | Teams-/M365-mødeoprettelse fejlede (policy/licens/skabelon) | Rammer det ÉN bruger → licens/policy (jeres Entra); rammer det MANGE/systemisk → skabelon/back-office (&money/jeres driftspartner). Tjek Admin → Microsoft → Teams. |
| ‘Kunne ikke oprette forbindelse til Graph API’ — mange/alle rådgivere | CAL-ERR-14 — Graph-proxy nede/forkert | Graph-proxy + ⟦Proxy URL⟧ (Admin → Microsoft) → jeres driftspartner. Rammer det alle banker, er det platform → &money. |
| Møde booket, selvom rådgiver har fri / ikke er ledig | Kalender-sync forsinket eller regel-opsætning | Kalender-sync (Logs → Medarbejdere) + mødekonfiguration/arbejdstid. Vedvarer → &money. |
| Dobbeltbooking / møde booket oven i en anden aftale | Kalender-sync forsinket — den nye optagethed er ikke nået ind endnu | Tjek kalender-sync (Logs → Medarbejdere); rammer det mange, er det ofte sync/platform → &money. |
| ‘Max. timer pr. dag’ fejler | Grænse-beregning | Standardværdier + medarbejder-/servicegruppe-grænse. Vedvarer → &money. |
| Rådgiver får ikke møder i kalender / møde flyttes ikke i Outlook | M365-skrivning fejler | Tilladelser/forbindelse (CAL-ERR-06/14). M365 → jeres Entra / jeres driftspartner. |
| Interne møder virker ikke | Opsætning eller platform | Mødekonfiguration (intern). Vedvarer → &money. |
| Mødelokaler ikke synket / bookes oveni hinanden | Lokale-sync (SCIM/M365) | Logs → Lokaler + lokationsnavn (SCIM-match) → jeres driftspartner / jeres Entra. |
| Bruger kan ikke ses/redigeres i Medarbejdere | Provisionering (SCIM) | SCIM-provisionering → jeres driftspartner / jeres Entra (bruger aktiv/UPN). |

{: .note }
> **Bemærk:** **Teams-link** og **Graph-proxy-forbindelse** er de to hyppigste temaer i praksis. Når en fejl rammer **mange/alle** rådgivere på én gang, er det næsten altid en **fælles** årsag (proxy/platform) — ikke den enkelte medarbejder.


## Ansvarsfordeling (RACI)

Baseret på jeres aftalte RACI (&money ↔ jeres driftspartner, v2). **Grundprincip:** &money ejer **infrastrukturen/platformen**; jeres driftspartner ejer **opsætningen** — også når den kører inde i &money's infrastruktur. To faser: **Hypercare** (lige efter en ændring, hvor &money læner sig ind) og **Drift** (daglig drift).


| Part | Ejer (kerne) | Ift. sync-fejl |
|---|---|---|
| jeres driftspartner (operatør for jer) | Opsætning i jeres tenant: Graph-proxy, Entra-app, SCIM-provisionering, M365-adgang, datakvalitet; 1st-level support; synkronisering + sync-alarmer. (Entra/Graph-proxy/SCIM: jeres driftspartner trækker på specialister i deres moderorganisation.) | A/R — driver de fleste sync-fejl; rydder timeout; eskalerer. |
| Jeres egen Entra/IT | Det kun I kan styre i jeres Microsoft-tenant: brugerkonti (aktiv/UPN), licenser, admin-samtykke, postkasser. Flere kunder håndterer Entra ⟦helt selv⟧. | Handler på CAL-ERR-09/11 + giver samtykke/licens ved 06/10. |
| &money | Platform/hosting, sync-orkestrering, backend, token, fejl-definitioner, managed playbooks/AI; 2nd-level support. | CAL-ERR-12/15/16; konsulteres på resten. |
| Kunde-admin | Ser alarmen, aflæser koden, giver adgang/info, sender videre. | First responder på selve alarmen. |

{: .note }
> **Bemærk:** Jeres RACI markerer **A6 (synkronisering + sync-alarmer)** som et punkt, der færdig-aftales mellem **jeres driftspartner, &money og bankens Entra-ekspert** — netop ‘hvem handler på hvilken fejltype’. Fejl-kataloget ovenfor er et konkret første bud. **Indtil A6 er afklaret:** default **jeres driftspartner 1st-level → &money 2nd-level**, så ingen sag står stille.

{: .note }
> **Bemærk:** **Vigtigt i praksis:** jeres driftspartner har ikke selv **Entra/Graph-proxy/SCIM**-kompetencer — de trækker på **specialister i deres moderorganisation**, eller også håndterer kunden **Entra selv** (det gælder flere af de større banker). Så ‘hvem retter Entra-fejlen’ afhænger af jeres setup: styrer I selv Entra, er det **jeres eget Entra-team**.


## Fejlfindings-værktøjer (Admin → Fejlfinding)

- **Møde-sync-fejlfinding** — undersøg, hvorfor et bestemt møde ikke er synkroniseret.
- **Tilgængeligheds-fejlfinding** — undersøg, hvorfor en medarbejder ikke viser ledige tider.

### Se også / forudsætninger
- **Admin – overblik over undermenuerne** — hvad de øvrige Admin-faner gør.
- **Schedule – superbrugerguide: Medarbejdere** — tilgængelighed (kalender-sync fødes herfra).
- **Schedule – superbrugerguide: Mødeopsætning** — møde-reglerne.


## Seneste opdatering

- 12.06.2026 (v1.2) — Fejl-katalog vendt om: den danske log-besked er nu primær opslagsnøgle, statuskoden (CAL-ERR-xx) er sekundær reference. Tabelceller ryddet.
- 12.06.2026 (v1.1) — Persona-løft: ‘Din rolle som admin’ (DU vs. fixer) + handoff-skabelon, kontakt/setup-boks, A6-default (jeres driftspartner 1st→&money 2nd), close-the-loop, dobbeltbooking-række.
- 12.06.2026 (v1.0) — Første version: fejl-katalog + ansvarsfordeling (jeres RACI, &money↔jeres driftspartner v2) + hyppigste support-tickets (anonymiseret fra jeres Atlassian/AMFM).


{: .important }
> 📣 **Husk** — en log-alarm betyder, at noget kræver handling, ofte i jeres egen Entra/M365.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.2 · 12.06.2026_
