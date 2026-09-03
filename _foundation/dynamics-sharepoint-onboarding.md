---
layout: default
title: Present on Dynamics 365 and SharePoint
nav_order: 9
parent: Foundation
---

# Present on Dynamics 365 and SharePoint

The step-by-step configuration for using **Present** where your CRM is **Microsoft Dynamics 365** and
generated presentations are stored in **SharePoint**. It expands on
[section 5 of the Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration),
which covers the architecture and the reasoning behind it.

{: .important }
> **This guide is specific to Present on Dynamics 365 with SharePoint storage.** It is not a general
> Dynamics 365 setup guide, and it does not cover the other Engage products. If you are also adopting
> BookMe, Meet or Insights, those bring their own configuration and your &money contact will sequence
> them with this work.
>
> If your CRM is Salesforce, see [BookMe onboarding]({{ site.baseurl }}/bookme/onboarding/) instead.

## What this is

Engage Present lets your advisors generate a customer presentation from a Dynamics appointment. The
deck is written to your own SharePoint as an ordinary Microsoft 365 file that opens and auto-saves in
PowerPoint on the web.

{: .note }
> **Nothing is deployed in your Azure subscription, and no solution is installed in your Dataverse
> environment.** Engage is hosted by &money and talks to your Microsoft 365 and Dynamics estates through
> Microsoft's own APIs. What you provide is authorisation and configuration.

## How access works, and why

Two distinct identities reach your environment, and the difference matters to a security review:

| Identity | Used for | Bounded by |
|---|---|---|
| **Your advisor** | Everything that reads or writes customer records, and every write to SharePoint | Their own Dynamics security roles, and their own SharePoint access |
| **An application identity** | Reading Dataverse schema and metadata, testing the connection, resolving which Dynamics user an advisor corresponds to | A Dataverse security role you create and control |

Record work runs as the signed-in advisor through a standard OAuth token exchange, so their own roles
decide what they can see and actions appear in your Dynamics audit trail under their name. **An advisor
can never retrieve through Engage a record they could not open in Dynamics themselves.** There is no
fallback from the user to a service account — if the exchange fails, the operation fails.

The application identity reads no customer records on an advisor's behalf.

{: .note }
> **No credentials are exchanged in either direction.** The application registrations are owned by
> &money and their credentials never leave &money. Your tenant is not asked to hold, store or rotate a
> secret for this integration, and &money is not given one of yours. Your approvals in Step 1 create
> service principals in your directory; the applications then authenticate against *your* tenant using
> their own credentials, and reach only as far as the permissions in Steps 3 to 5 allow. The
> application ID you need in Step 4 is an identifier, not a secret.

## Who needs to be involved

| Role | Steps | Permissions needed |
|---|---|---|
| Microsoft Entra administrator | 1, 2, 3 | *Application Administrator* or *Cloud Application Administrator*. Global Administrator is **not** required |
| Dynamics 365 / Power Platform administrator | 4 | Create application users and assign security roles |
| SharePoint administrator | 5 | Create a site, manage its membership, and record a per-site application permission |
| An Engage `Admin` from your organisation | 6, 7 | The `Admin` app role assigned in Step 2, and access to the Dynamics environment |
| Dynamics customisation | 8 | Edit the appointment form |

## Before you start

- A Microsoft Entra tenant, and your **tenant ID** (Directory ID).
- A Dynamics 365 environment on Dataverse Web API v9.2 — a sandbox for the integration phase, plus
  production.
- Someone who knows your Dataverse schema. You choose which tables and columns Engage sees, so the
  field mapping is a conversation rather than a default.
- From &money, provided before you begin: the client IDs for your environment (see
  [Application IDs](#application-ids-you-will-need)), the authorisation commands for Step 3, the starter
  field mappings, and your Management Portal URL.

## The order things happen in

Steps 1 to 5 are yours and can largely run in parallel. **Steps 6 and 7 are also yours, but they happen
in the Engage Management Portal and only work once &money has registered your organisation** — so there
is a handover in the middle:

```text
You:      Steps 1-5   Entra, Dataverse, SharePoint
              |
&money:   registers your organisation, links your tenant, enables Present
              |
You:      Steps 6-7   Management Portal: choose environment, set SharePoint destination
              |
You:      Step 8      the launch point on the appointment form
              |
Together: verification
```

Tell your &money contact when Steps 1 to 5 are done; they will confirm when the Management Portal is
ready for you.

---

## Application IDs you will need

Four &money applications are involved, and their client IDs appear repeatedly in the steps below —
in the consent links in Step 1, in the authorisation commands in Step 3, in the Dataverse application
user in Step 4, and in the SharePoint permission in Step 5b. They are collected here so you can fill
them in once and refer back.

**These are identifiers, not secrets.** They are safe to paste into scripts, tickets and change
records.

| Application | Written in this guide as | Test | Production |
|---|---|---|---|
| AndMoney Present UI | `{PresentUiAppClientId}` | `ea486ddc-1a1e-4837-967b-f975fdcf1ed7` | `cbac67da-6529-4411-821c-746888abee84` |
| AndMoney Management UI | `{ManagementUiAppClientId}` | `8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b` | `261ae34b-4de9-4c4a-9d70-1df1c024c91e` |
| AndMoney API | `{AndMoneyApiAppClientId}` | `f100d6c7-bbee-405b-9231-7e1c05c4b944` | `642f0f04-31f9-4641-a1cb-793f31496bd3` |
| AndMoney Dynamics Access | `{DynamicsAccessAppClientId}` | *to be provided* | *to be provided* |

Where each one is used:

| Application | Used in |
|---|---|
| **AndMoney Present UI** | Step 1 only — but it is the one your **advisors** sign in through to use Present. Without it they cannot open Present at all |
| **AndMoney Management UI** | Step 1 only — the sign-in surface for the **Management Portal**, which your administrators need for Steps 6 and 7 |
| **AndMoney API** | Step 1 (consent), Step 2 (the enterprise application you assign roles in), Step 3 (**both** authorisation commands are recorded against this one), Step 5b (the application named in the SharePoint permission) |
| **Dynamics Access** | Step 1 (consent), Step 4 (the application your Dataverse application user is bound to) |

{: .note }
> **AndMoney Present UI and AndMoney Management UI are two different sign-in surfaces, and both are
> needed.**
> Advisors sign in to *AndMoney Present UI* to use Present; administrators sign in to the *Management Portal* to complete Steps
> 6 and 7. They are separate applications with separate consents. Approving only one leaves either your
> advisors or your administrators locked out, and the symptom appears late — at first use, not at consent.

{: .note }
> **Confirm the values with your &money contact before you start**, and make sure you are working from
> the column for the environment you are onboarding. Running a step against the wrong environment's
> application succeeds without any warning — it simply grants access that the environment in question
> never uses, and leaves the one you meant to configure still broken.

You will also need **your own Entra tenant ID** (Directory ID) throughout, written here as
`{YourTenantId}`.


## Step 1 — Approve the Engage applications

Engage publishes its applications from its own Entra tenant as multi-tenant apps. You approve them; you
do not create app registrations for this. Approving creates a **service principal** for each in your
directory — that is what lets the applications authenticate against your tenant at all.

There are **four**, and all four are required:

| Application | Why it is needed |
|---|---|
| **AndMoney Present UI** | The sign-in surface your **advisors** use to reach Present |
| **AndMoney Management UI** | The sign-in surface your **administrators** use to reach the Management Portal in Steps 6 and 7 |
| **AndMoney API** | The API behind both, carrying the app roles from Step 2. It is also the application that performs the token exchange authorised in Step 3 |
| **AndMoney Dynamics Access** | The application identity that reads your Dataverse schema. Step 4 binds a Dataverse application user to this one |

Open each link as an administrator, replacing `{YourTenantId}`:

```text
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={PresentUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={ManagementUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={AndMoneyApiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={DynamicsAccessAppClientId}
```

Take the client IDs from the [table above](#application-ids-you-will-need). The Management Portal pair
is also listed in
[App Registration Installation]({{ site.baseurl }}/foundation/identity/app-registration-installation/), and
the Present UI consent has its own walkthrough in
[Approving Engage in Your Microsoft Entra]({{ site.baseurl }}/foundation/identity/engage-admin-consent/).

Review the summary Microsoft shows, then **Accept**.

{: .warning }
> **You may see "Sorry, but we're having trouble signing you in" afterwards.** That is expected and
> harmless — the consent link is not a sign-in page, and the approval has still been recorded. Confirm
> by checking that all four applications appear under **Enterprise applications**.

{: .warning }
> **Do not delete and re-add these enterprise applications later.** Permissions bind to the service
> principal object, so removing and reinstalling an application silently discards every grant made
> against it, including those in Step 3 and Step 5b. If one has to be reinstalled, treat Steps 3 and 5b
> as needing to be redone.

No passwords or secrets are shared with &money by this step.

## Step 2 — Assign people to roles

Open the **AndMoney API** enterprise application, go to **Users and groups**, and assign
your security groups (or individual users) to the roles they need:

| Role | What it grants |
|---|---|
| `Admin` | Everything a Configurator can do, plus access to logs — **and the Management Portal screens in Steps 6 and 7** |
| `Configurator` | Meeting and portal configuration, field mappings, presentation templates |
| `Manager` | Service and competence group configuration |
| `Employee` | Standard advisor access — the role most of your users need |
| `Customer` | Reserved for end-customer scenarios; not used for staff |

{: .important }
> **At least one person needs `Admin`, and that person also needs access to the Dynamics environment.**
> Steps 6 and 7 both require the `Admin` role, and Step 6 additionally lists only the environments the
> signed-in person can reach in Dynamics. A `Configurator` cannot complete either step.

Assigning several roles to one person has no additive effect — the highest applies. Changes take effect
at next sign-in, and groups are easier to live with than individual assignments.

Repeat for every environment you are onboarded to; the test and production applications are separate.

## Step 3 — Authorise Engage to act as your advisors

Two permissions are recorded here, both against the **AndMoney API** service principal in
your tenant, and both delegated — they let Engage act *as the signed-in advisor*, never beyond them:

| Permission | Resource | Enables |
|---|---|---|
| `user_impersonation` | Dataverse — `00000007-0000-0000-c000-000000000000` | Reading and writing Dynamics records as the advisor |
| `Sites.Selected` | Microsoft Graph — `00000003-0000-0000-c000-000000000000` | Writing generated decks to SharePoint as the advisor |

{: .note }
> `Sites.Selected` grants access to **no SharePoint site at all** by itself. It becomes usable for one
> specific site only once that site is named in Step 5b. Granting it here is not granting access to your
> SharePoint.

Neither can be done through a consent link. They are recorded directly against the service principal,
which Microsoft's consent endpoint cannot do — that endpoint only grants permissions an application
advertises in its manifest. Engage deliberately advertises neither, so that customers who use neither
Dynamics nor SharePoint are never asked to approve a permission for them.

&money provides `add-delegated-grant-to-service-principal.ps1`, which your administrator runs **twice**:

```powershell
# Dataverse - the script's defaults
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId    {YourTenantId} `
  -clientAppId {AndMoneyApiAppClientId}

# Microsoft Graph - for SharePoint
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId      {YourTenantId} `
  -clientAppId   {AndMoneyApiAppClientId} `
  -resourceAppId 00000003-0000-0000-c000-000000000000 `
  -scope         Sites.Selected
```

**Application Administrator** is sufficient (Cloud Application Administrator, Directory Writers,
Privileged Role Administrator and User Administrator also work). Global Administrator is not needed.

What to know about it:

- **It is idempotent.** Re-running appends the permission or does nothing. Allow a few seconds between
  the two runs — Microsoft's read of the permission list lags writes, and an immediate second run can
  attempt a duplicate.
- **It prints an Undo command each time. Keep both.** The command differs depending on what the script
  found: a permission it created is deleted outright, while one appended to a pre-existing record is
  removed by restoring the original list. Deleting the whole record by hand would revoke every other
  delegated permission that application holds in your tenant.
- **Signing in leaves a trace.** The script authenticates through Microsoft's own *Microsoft Graph
  Command Line Tools* application, which leaves a consent for that Microsoft application in your tenant.
  If your policy does not allow standing admin-tooling consent, revoke it afterwards under **Enterprise
  applications → Microsoft Graph Command Line Tools → Permissions**.

Both take effect within seconds.

## Step 4 — Create the application user in Dataverse

The application identity needs a Dataverse user in your environment, bound to the **AndMoney Dynamics
Access** client ID from Step 1.

1. **Power Platform admin centre → Environments → {your environment} → Settings → Users + permissions
   → Application users → New app user.**
2. Select the application by its client ID — `{DynamicsAccessAppClientId}` from the table above — and choose a business unit.
3. Create a **custom security role** and assign it — then trim it. Dataverse has no empty role: a new
   custom role arrives carrying around 80 privileges, and *Copy role* clones an equally large one.
   See [Trimming the new role](#trimming-the-new-role) below, which is not an optional tidy-up.

### The exact privileges

Five, all at **Organization** level, and nothing else:

| Group in the role editor | Privilege | Level |
|---|---|---|
| Business Management | **User** | Read — Organization |
| Business Management | **Organization** | Read — Organization |
| Customization | **Entity** | Read |
| Customization | **Attribute** | Read |
| Customization | **Relationship** | Read |

What each is for:

- **User (Read, Organization)** — resolving which Dynamics user a signed-in advisor corresponds to.
  Organization level because any advisor in your directory may sign in, not only those in one business
  unit.
- **Organization (Read)** — the Dataverse client's own connection handshake. Without it the
  integration fails when it connects, before it reads anything.
- **Entity, Attribute, Relationship (Read)** — reading your schema so the field mapping can offer your
  real tables and columns. These are metadata reads: they expose the *shape* of your data, not its
  contents.

Privileges that look like they belong here and do **not**: *Option Set* (Engage reads an attribute's
type but never its option values), *Business Unit* and *User Settings*. All three are in the default
set and all three can go.

{: .important }
> **No access to customer records is required, and none should be granted.** No `account`, `contact`,
> `appointment` or `annotation` privileges belong on this role. All record work runs as the advisor
> under their own role, so anything added here would widen the integration's reach without enabling any
> feature. If Engage ever appears to need record privileges on this role, ask &money before granting
> them.

### Trimming the new role

The privileges your new role starts with are not a safe default. They include, at organization level,
the ability to **create and activate workflows**, **create, change and delete business process flows**,
and **write SharePoint document data** — none of which this integration uses. Reading down the tabs
they look like harmless reference entries; it is the privilege names that give it away.

So the role has to be reduced to the five above. In the role editor that means setting every other
privilege back to none, which is roughly eighty toggles with no way to confirm the result. If you would
rather do it precisely, two Dataverse Web API calls against your own environment do the same thing and
can be verified:

```
POST {EnvironmentUrl}/api/data/v9.2/roles({roleid})/Microsoft.Dynamics.CRM.ReplacePrivilegesRole
{"Privileges": [{"PrivilegeId": "...", "Depth": "Global"}, ...]}

GET  {EnvironmentUrl}/api/data/v9.2/RetrieveRolePrivilegesRole(RoleId={roleid})
```

Resolve each privilege id by name first — `GET /api/data/v9.2/privileges?$filter=name eq 'prvReadEntity'`
— for `prvReadEntity`, `prvReadAttribute`, `prvReadRelationship`, `prvReadUser` and
`prvReadOrganization`. The second call reads the role back so you can see exactly what it carries.
Capture the original set before you replace it; restoring is the same call with the captured list.

{: .note }
> **Four SharePoint privileges will reappear and that is expected.** Because your environment has
> server-based SharePoint document management enabled, Dataverse attaches `prvReadSharePointDocument`,
> `prvReadSharePointData`, `prvCreateSharePointData` and `prvWriteSharePointData` to the role. You can
> delete them, but the next time the role is saved in the editor they come back. They are imposed by
> the platform, not requested by Engage, and they govern Dataverse's own document-location records
> rather than the contents of your SharePoint sites — access to those is granted separately, per site,
> in Step 5. So a correctly trimmed role shows **nine** privileges: the five above plus those four.

If a step fails with a privilege error, send the error to &money rather than broadening the role.

**Verify:** the application user can call `{EnvironmentUrl}/api/data/v9.2/WhoAmI` and receives a
`UserId` in response. Confirm the user shows as **Enabled**.

## Step 5 — Prepare the SharePoint site and grant access to it

One SharePoint site is the destination for generated decks.

### 5a — Create or nominate the site

Create or nominate a site, and add the advisors who will use Present as members. Note the **host name**,
the **server-relative site path**, and the **document library** if it should not be the site's default —
for example `bank.sharepoint.com`, `/sites/decks`, default library. You will enter these yourself in
Step 7.

Site paths containing `:`, `#`, `%`, `?` or `;` cannot be used; they collide with the way Microsoft
Graph addresses sites.

### 5b — Grant the AndMoney API application access to that one site

The `Sites.Selected` permission from Step 3 reaches no site until that site is named explicitly. This is
why Engage cannot reach any other SharePoint site in your tenant, and it is worth recording in your
security review alongside Step 1.

The permission is granted to the **same application you granted `Sites.Selected` to in Step 3** — the
AndMoney API application (`{AndMoneyApiAppClientId}`), not the Dynamics one.

Running these calls requires `Sites.FullControl.All`, which is why this is yours to do and not ours. The
easiest place to run them is [Graph Explorer](https://developer.microsoft.com/graph/graph-explorer),
signed in as a SharePoint or Global administrator; any Graph client works equally well.

#### 1. Find the site ID

```http
GET https://graph.microsoft.com/v1.0/sites/{hostname}:{site-path}
```

For the example in 5a that is `.../sites/bank.sharepoint.com:/sites/decks`.

The response's `id` is a composite of three comma-separated parts, something like
`bank.sharepoint.com,8f9c…,3a21…`. Use the whole string, commas included, as `{siteId}` below.

#### 2. Record the permission

```http
POST https://graph.microsoft.com/v1.0/sites/{siteId}/permissions
Content-Type: application/json

{
  "roles": ["write"],
  "grantedToIdentities": [
    {
      "application": {
        "id": "{AndMoneyApiAppClientId}",
        "displayName": "AndMoney API"
      }
    }
  ]
}
```

**`write`, not `fullcontrol`.** Engage writes and reads deck files; it has no reason to manage the site
itself, and `fullcontrol` would let it change permissions — including its own.

**Record the `id` returned in the response.** It identifies this specific permission and is what you
need in order to revoke it later. It is not the same as the application ID.

#### 3. Verify

```http
GET https://graph.microsoft.com/v1.0/sites/{siteId}/permissions
```

Confirm that **exactly one** application is listed, that it is `{AndMoneyApiAppClientId}`, and that its role
is `write`. This listing is the complete statement of what Engage can reach in your
SharePoint — keep it for your audit record.

#### 4. To revoke, later

```http
DELETE https://graph.microsoft.com/v1.0/sites/{siteId}/permissions/{permissionId}
```

Access stops immediately, and nothing else in the integration is affected. Present will fail to save
decks; everything else continues working.

{: .note }
> If your team prefers PnP PowerShell, it offers equivalent cmdlets for granting and listing site
> permissions. The Graph calls above are the underlying operation either way, and are what the
> verification in step 3 should be read against.

### 5c — Housekeeping

Housekeeping of old decks is yours to run on whatever schedule suits you. Engage does not archive or
prune, and tolerates files being removed.

---

{: .important }
> **Steps 6 and 7 need &money to have registered your organisation first.** Confirm with your &money
> contact that the Management Portal is ready for you before starting them. Both require the `Admin`
> role from Step 2.

## Step 6 — Select your Dynamics environment

Engage does not hardcode your environment URL, and &money does not enter it on your behalf. You choose
it yourself, and Engage discovers the options by asking Microsoft which Dataverse environments **you**
can see — so sign in as someone with access to the intended environment.

1. Sign in to the Management Portal with an account holding the `Admin` role.
2. Go to **Admin → CRM**.
3. The environment list is populated live from Microsoft's Global Discovery Service. Choose the intended
   environment — the sandbox during the integration phase, production at go-live.
4. Save.

{: .note }
> *Screenshots pending: the Admin → CRM screen, the environment list, and the saved state.*

Two things worth knowing:

- **The list shows only environments your signed-in account can reach.** An empty or short list is a
  statement about your own access, not a fault in Engage. If the intended environment is missing, check
  that your account has access to it in Dynamics.
- **Changing the environment later is possible but not free.** Configured CRM users and field mappings
  do not follow the move, and the Portal warns you when you attempt it. Plan the sandbox-to-production
  switch with your &money contact rather than treating it as a toggle.

## Step 7 — Configure your SharePoint destination

The destination is also yours to enter, using the values from Step 5a.

1. In the Management Portal, go to **Admin → Microsoft → SharePoint**.
2. Add a destination with:

| Field | Value | Rule |
|---|---|---|
| Key | **`present`** | Must be exactly this — see below |
| Site hostname | `bank.sharepoint.com` | A bare host name — no `https://`, no path, no port |
| Site path | `/sites/decks` | Server-relative, starting with `/`, containing none of `: # % ? ;` |
| Document library | *(leave empty)* | Empty selects the site's default document library |

{: .warning }
> **The key must be exactly `present`** — lower-case, no spaces. It is not a label you choose. The
> Present workflow &money deploys to your organisation selects its destination *by this key*, and the
> key travels verbatim with the workflow. A destination saved under any other name leaves the workflow
> pointing at a site that does not exist, and deck generation fails at the upload step with a
> destination-not-found error rather than anything that mentions naming.

The remaining fields are the values you noted in Step 5a.

{: .note }
> *Screenshots pending: the Microsoft → SharePoint screen, the add-destination dialog, and a saved
> destination.*

{: .warning }
> **There is no default destination.** Until one exists here, Present cannot write to SharePoint at all.
> Saving a destination does not by itself grant access — the per-site permission from Step 5b is what
> does that, and the two are checked at different moments. If a deck fails to save, confirm both.

Your &money contact is happy to do Steps 6 and 7 with you on a call the first time.

## Step 8 — Add the launch point to the appointment form

Engage Present opens from a **Dynamics appointment record** — the deck is generated for a specific
appointment, so one must exist before Present is opened.

You add the button or IFRAME control to the appointment form in your own environment. &money owns and
documents the URL and parameter contract; the form customisation is yours. The contract uses the
standard Dynamics IFRAME parameters, and the signed-in advisor is resolved from their Entra token rather
than passed in the URL.

&money provides a small validation page you can point the control at first. It echoes back the
parameters it received and reports whether sign-in resolved correctly, so you can get the launch point
right before the full integration is live.

---

## What to send back

**One thing: your Entra tenant ID.** Send it before Step 1, by email.

Everything else is a confirmation that a step is done — no artefacts, no identifiers, and nothing
sensitive. Your Dataverse environment URL and SharePoint destination are **not** on this list: you enter
those yourself in Steps 6 and 7, and &money never needs to be told them.

Tell your &money contact when you have completed:

- [ ] Steps 1 to 5 — including all four consents — so they can register your organisation and open the Management Portal to you
- [ ] Steps 6 and 7 — so they can finish the field mapping and deploy the Present workflow

Also useful, whenever you know it: a named contact for schema and field-mapping questions.

{: .note }
> This integration involves **no credential handover in either direction**. If you are ever asked to
> email a client secret, certificate or password for it, treat that as a red flag and contact your
> &money representative.

## What &money does

Between your Step 5 and your Step 6: registers your organisation, links your Entra tenant to it, enables
Present, and prepares the starter field mappings. After Step 7: works through the mapping with you,
deploys the presentation workflows, and runs the verification below.

## Verifying it works

Together, at the end:

- An advisor signs in and opens Present from an appointment.
- They see the customer data they expect — and an advisor **without** access to a given record does not
  see it.
- A generated deck lands in the SharePoint site and opens in PowerPoint on the web.
- An advisor without access to the SharePoint site fails visibly rather than silently.

## Still being confirmed

Listed so that nothing is promised before it is real.

| Item | Status |
|---|---|
| The security role in Step 4 | Derived from the operations Engage performs; being validated against a live environment before we ask you to finalise it |
| The exact commands for the per-site grant in Step 5b | The model is settled — a `write` permission for the Engage application on your nominated site, recorded and revocable by you. The precise administrator commands are being confirmed against a real tenant before they are handed over, rather than published from a generic example |
| Screenshots for Steps 6 and 7 | Being produced |
| Starter field mappings and the tag baseline | Being prepared; both are needed before the mapping session |
| The validation page in Step 8 | Being built |
| Directory synchronisation (SCIM) | Not currently proposed. Advisors are created directly, which suits a pilot-sized group. Whether that remains right at your scale is under review, and [SCIM provisioning]({{ site.baseurl }}/foundation/scim/) is available if not |

## Related

- [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration) — the architecture and reasoning behind this configuration
- [Identity]({{ site.baseurl }}/foundation/identity/) — the app registration and admin consent model in full
- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) — the field-mapping model you will work through with &money
