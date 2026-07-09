---
layout: "default"
title: "Superbrugerguide – Playbooks"
parent: "Dansk"
grand_parent: "Schedule"
nav_order: 204
lang: "da"
---
# Schedule – superbrugerguide: Playbooks
_Automatiske flows fra booking til CRM · Admin → Playbooks · v1.0 · 11.06.2026_



{: .hint }
> 📄 **Hent denne guide:** [DOCX]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-playbooks.docx) · [PDF]({{ site.baseurl }}/files/business-implementation/schedule/da/superbrugerguide-playbooks.pdf)

## Formål og værdi

En **Playbook** er et automatisk flow, der kobler en begivenhed (fx en kundes booking via en portal) sammen med en række handlinger — typisk at skrive booking-data til jeres CRM, men en Playbook kan også hente og berige data, køre AI og meget mere. Playbooks er den **fremadrettede standard** for, hvordan portaler sender booking-data til CRM (de erstatter den gamle CRM-konfiguration).

{: .note }
> **Bemærk:** Playbooks er en mere **avanceret** funktion under **Admin**. De opsættes typisk i samarbejde med &money — denne guide giver overblikket, så du kan forstå og vedligeholde dem.

{: .note }
> **Bemærk:** **Hvad du selv kan / hvad &money hjælper med:** Som superbruger kan du typisk forstå flowet, omdøbe, **validere**, køre **tør-kørsel**, eksportere en backup og aflæse **Status**/**Sidst brugt**. **Selve opbygningen** — blokke, AI, CRM-feltmapning og portal-koblingen — laver I sammen med &money.

### Ordliste
- **Playbook**: Et automatisk flow: en trigger (begivenhed) → datablokke → output (fx CRM).
- **Trigger (Starter)**: Begivenheden, der sætter flowet i gang — fx ⟦PortalMeetings⟧ (en kunde booker via en portal).
- **Blok**: Et trin i flowet, der gør én ting (fx læser CRM-data, opretter en CRM-post eller kører AI).
- **Relation**: Forbindelsen mellem to blokke — den fører felter videre (⟦Kildefelt⟧ → ⟦Destinationsfelt⟧).
- **Transformation**: En justering af data undervejs (fx træk én værdi ud, eller saml en liste til tekst).


## Målgruppe og forudsætninger

- Målgruppe: administrator (rolle **Admin**) — typisk sammen med &money.
- Jeres **CRM-forbindelse** er sat op, og de relevante CRM-objekter/-felter findes.
- Den **portal**, der skal bruge playbooken, findes (eller oprettes), jf. **Portaler**-guiden.
- Playbooks tilgås under **Admin → Playbooks**.


## Dit udbytte

Efter denne guide kan du:

- Forstå, hvad en Playbook er, og hvordan den hænger sammen med en portal.
- Oprette en playbook, vælge en trigger og tilføje blokke.
- Forbinde blokke med relationer og transformationer.
- Validere, gemme og koble playbooken til en portal — og fejlfinde det mest gængse.


## Overblik (rækkefølge)

- Trin 1: Opret playbook (navn + **trigger**).
- Trin 2: Tilføj **blokke** (det flowet skal gøre).
- Trin 3: Forbind blokkene (**relationer** + evt. **transformationer**).
- Trin 4: **Valider** og **gem**.
- Trin 5: Kobl **portalen** til playbooken.


## Trin-for-trin (Management UI)


### Trin 1 · Opret en playbook

_Hvorfor: Start flowet ved at give det et navn og vælge, hvad der skal udløse det._

- Gå til **Admin** → **Playbooks** → klik **Opret**.
- Udfyld **Navn**.
- Vælg **Trigger type** — for portaler typisk **PortalMeetings** (udløses, når en kunde booker via en portal).
- Playbooken åbnes i den visuelle editor med **Starter**-blokken øverst.


![Skærmbillede 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-playbooks/sched_playbook_opret.png)

*Skærmbillede 1 (Management UI) — Admin → Playbooks → **Opret** — navn + trigger (fx PortalMeetings)*

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Playbooken er oprettet og vises i listen med antal **Blokke**, **Sidst brugt** og **Status**.


### Trin 2 · Tilføj blokke

_Hvorfor: Blokkene er de trin, flowet udfører — fx at hente CRM-data og oprette en CRM-post._

- Klik **Tilføj blok**.
- Vælg **Blok type** (se tabellen ‘Blok-typer’ nedenfor) og en **Værdi** (den konkrete ressource, fx hvilket CRM-objekt eller hvilken AI-kapabilitet), og giv blokken et **Navn**.
- Tilføj de blokke, flowet har brug for. Du kan **Flyt op**/**Flyt ned**, **Rediger blok** og **Fjern blok**.


![Skærmbillede 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-playbooks/sched_playbook_editor.png)

*Skærmbillede 2 (Management UI) — Playbook-editor — blokke på lærredet (Starter → datablokke → CRM)*

{: .important }
> **Husk:** En playbook skal have **mindst én blok** ud over starteren — ellers kan den ikke gemmes (‘Du skal have mindst 1 blok i playbooken’).


### Trin 3 · Forbind blokkene (relationer + transformationer)

_Hvorfor: Relationerne fører data fra én blok til den næste — og kan justere data undervejs._

- Træk en **relation** fra en blok til den næste.
- På relationen mapper du **Kildefelt** (fra forrige blok) til **Destinationsfelt** (på næste blok), fx mødedato → et CRM-felt.
- Tilføj evt. en **Transformation**, hvis data skal justeres (se tabellen ‘Transformationer’).


![Skærmbillede 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-playbooks/sched_playbook_blok.png)

*Skærmbillede 3 (Management UI) — Blok-konfiguration — **Blok type**, **Værdi** og felt-mapning (Kildefelt → Destinationsfelt)*


### Trin 4 · Valider og gem

_Hvorfor: Tjek flowet for fejl, før du gemmer._

- Klik **Tør-kørsel** for at teste flowet med eksempeldata, uden at skrive til CRM.
- Klik **Valider** — ret eventuelle markerede fejl (manglende felter, ugyldige relationer).
- Klik **Gem** (du kan også bruge Ctrl/Cmd+S). Kvittering: **Playbook oprettet** / **Playbook opdateret**.
- Du kan **Eksporter**/**Importer** en playbook som JSON for at genbruge den.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Playbooken er valideret og gemt — klar til at kobles på en portal.


### Trin 5 · Kobl portalen til playbooken

_Hvorfor: Til sidst skal portalen bruge playbooken til at sende data til CRM._

- Åbn portalen (**Schedule → Portaler**).
- Sæt **CRM oprettelsesstrategi** = **Playbook**.
- Selve valget af den konkrete playbook sker pt. i samarbejde med &money — portalens Playbook-vælger viser stadig ‘Ingen playbooks tilgængelige’ og åbnes snart.

{: .hint }
> ✓ **Sådan ved du, det lykkedes:** Portalen sender nu booking-data til CRM via playbooken.

**Eksempel (som demo-playbooken ‘Portal meeting’):** Trigger **PortalMeetings** → **Læs CRM-data** (find kunde, rådgiver og tema) → **Filtrer resultater** → **Opret CRM-post** (selve mødet), evt. **Formatér med skabelon**. Hver pil er en relation, der mapper felter videre.


## Bekræft, at playbooken kører

På playbook-listen ser du, om en playbook er **Aktiv** eller **Deaktiveret** (**Status**), og hvornår den sidst kørte (**Sidst brugt**). Til at teste et flow har editoren **Tør-kørsel**. Ved mistanke om en fejlet kørsel kan du se **Admin → Logs** — eller kontakte &money.


![Skærmbillede 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/superbrugerguide-playbooks/sched_playbooks_liste.png)

*Skærmbillede 4 (Management UI) — Admin → Playbooks — listen med **Status** (Aktiv/Deaktiveret) og **Sidst brugt***


## Blok-typer


| Blok (tilføj-handling) | Hvad den gør |
|---|---|
| Starter (trigger) | Startbegivenheden, der sætter flowet i gang (fx en portal-booking). |
| Kør AI | Behandl data med en AI-kapabilitet — fx indsigter, opsummeringer eller beslutninger. |
| Formatér med skabelon | Strukturér data i et konsistent, læsevenligt format. |
| Læs CRM-data | Hent poster fra CRM til brug videre i flowet. |
| Filtrer resultater | Indsnævr CRM-poster ved at sætte betingelser. |
| Opret CRM-post | Opret en ny post i CRM ud fra data i flowet. |
| Opdater CRM-data | Opdater en eksisterende CRM-post med data fra flowet. |
| Generér fil / Switch / m.fl. | Generér en fil, styr flowet med regler, eller lever/udsend data. |

{: .note }
> **Bemærk:** De almindelige CRM-/AI-blokke (Læs CRM-data, Opret/Opdater CRM-post, Filtrer resultater, Kør AI, Formatér med skabelon) dækker langt de fleste portal-flows. **Switch**, **Generér fil** og avancerede transformationer (Serialize/Base64Decode) er til mere komplekse flows — typisk sammen med &money.


## Transformationer


| Transformation | Hvad den gør |
|---|---|
| Identity | Sender data uændret videre. |
| Extract | Plukker én værdi via en sti (fx Meeting.Title). |
| Project | Beholder kun udvalgte felter. |
| Join | Samler en liste til én tekst (fx A, B, C). |
| Split | Deler en tekst op i en liste. |
| Serialize | Konverterer til JSON-tekst. |
| Base64Decode | Afkoder Base64 til almindelig tekst. |


## Triggere (begivenheder)

- **PortalMeetings** — en kunde booker et møde via en portal (det almindelige for portaler).
- **PortalMeetingCancelled** — en portal-booking afbestilles.
- Øvrige findes (fx kundeoverblik, transskription klar, møde afsluttet) til andre flows.


## Fejlfinding

- ‘Du skal have mindst 1 blok i playbooken’: tilføj mindst én blok ud over starteren.
- ‘Cannot save … validation errors’: klik **Valider**, og ret alle markerede fejl (manglende felter, ugyldige relationer), før du gemmer.
- Transformationen virker ikke: typerne skal passe sammen (fx **Join** kræver en liste som input). Valideringen fanger uoverensstemmelser.
- Data lander ikke i CRM: tjek, at en **Opret/Opdater entitet**-blok er forbundet, at felterne er mappet (Kildefelt → Destinationsfelt), og at portalen bruger **Playbook** som strategi.
- Jeg kan ikke vælge playbooken på portalen: portalens Playbook-vælger åbnes snart — koblingen sker pt. sammen med &money.
- Jeg kan ikke se **Playbooks** under Admin: din rolle er ikke **Admin**, eller CRM-forbindelsen er ikke sat op → kontakt din administrator/&money.
- ‘Blokken har ingen værdi’ / et påkrævet CRM-felt er tomt ved **Opret CRM-post**: fordi et kildefelt mangler eller ikke er mappet → tilføj/ret mapningen (Kildefelt → Destinationsfelt).
- **Import** af JSON afvises: fordi JSON'en er ugyldig eller fra en anden version → eksportér en frisk JSON, eller kontakt &money.

### Se også / forudsætninger
- **Schedule – FAQ (Playbooks)** — typiske spørgsmål og fejl om Playbooks.
- **Schedule – superbrugerguide: Portaler** — den kundevendte booking-side, der bruger playbooken.
- **Schedule – FAQ (Portaler)** — typiske spørgsmål om portaler og CRM-strategi.


## Seneste opdatering

- 11.06.2026 (v1.0) — Første version (Playbooks).


{: .hint }
> ✅ **Færdig!** Playbooken er bygget, valideret, gemt og koblet til portalen.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
