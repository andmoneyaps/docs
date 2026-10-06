---
layout: default
title: Present on Dynamics 365 and SharePoint
nav_order: 1
parent: Onboarding
grand_parent: Present
permalink: /present/onboarding/present-on-dynamics/
---

# Present on Dynamics 365 and SharePoint

Configuring **Present** where your CRM is **Microsoft Dynamics 365** and generated presentations are
stored in **SharePoint**. The architecture behind it is in
[section 5 of the Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration).

{: .important }
> This guide covers Present on Dynamics 365 with SharePoint storage, and nothing else. Other Engage
> products bring their own configuration. If your CRM is Salesforce, see
> [Customer Onboarding]({{ site.baseurl }}/present/Onboarding-of-new-customer/) instead.

## What this is

Engage Present lets your advisors generate a customer presentation from a Dynamics appointment. The
deck is written to your own SharePoint as an ordinary Microsoft 365 file that opens and auto-saves in
PowerPoint on the web.

{: .note }
> **Nothing is deployed in your Azure subscription, and no solution is installed in your Dataverse
> environment.** Engage is hosted by &money and reaches your estate through Microsoft's own APIs. What
> you provide is authorisation and configuration.

## How access works, and why

Two identities reach your environment:

| Identity | Used for | Bounded by |
|---|---|---|
| **Your advisor** | Every read and write of customer records, and every write to SharePoint | Their own Dynamics security roles and SharePoint access |
| **An application identity** | Dataverse schema and metadata, and connection tests | A Dataverse security role you create and control |

Record work runs as the signed-in advisor, so their own roles decide what they can see and actions
appear in your Dynamics audit trail under their name. **An advisor can never retrieve through Engage a
record they could not open in Dynamics themselves.** There is no fallback from the user to a service
account — if the exchange fails, the operation fails.

{: .note }
> **No credentials are exchanged in either direction.** The application registrations are owned by
> &money and their credentials never leave &money. You are never asked to hold or rotate a secret for
> this integration. Your approvals in Step 1 create service principals in your directory; the
> applications then authenticate against *your* tenant using their own credentials, and reach only as
> far as Steps 3 to 5 allow.

## Who needs to be involved

| Role | Steps | Permissions needed |
|---|---|---|
| Microsoft Entra administrator | 1, 2, 3 | *Application Administrator* or *Cloud Application Administrator*. Global Administrator is **not** required |
| Dynamics 365 / Power Platform administrator | 4 | Create application users and assign security roles |
| SharePoint administrator | 5 | Create a site, manage its membership, record a per-site application permission |
| An Engage `Admin` from your organisation | 6, 7 | The `Admin` app role from Step 2, and access to the Dynamics environment |
| Dynamics customisation | 8 | Add a web resource or PCF component to the appointment form |

## Before you start

- A Microsoft Entra tenant, and your **tenant ID** (Directory ID). **Send this to your &money contact
  before Step 1** — nothing can be prepared on our side until we have it.
- A Dynamics 365 environment on Dataverse Web API v9.2 — a sandbox for the integration phase, plus
  production.

## The order things happen in

Steps 1 to 5 are yours and can largely run in parallel. Steps 6 and 7 are also yours, but happen in the
Engage Management Portal and only work once &money has registered your organisation:

```text
You:      Steps 1-5   Entra, Dataverse, SharePoint
              |
&money:   registers your organisation, links your tenant, enables Present
              |
You:      Steps 6-7   Management Portal: connect Dynamics, set SharePoint destination
              |
You:      Step 8      embed Present in the Dynamics form
              |
Together: verification
```

You are not expected to report each step as you finish it. Tell us when Steps 1 to 5 are done so we can
open the Management Portal to you, and raise anything that does not behave as described here.

---

## Application IDs you will need

Four &money applications are involved. Their client IDs appear throughout the steps below.

**These are identifiers, not secrets** — safe to paste into scripts, tickets and change records.

**Every step is performed once per environment.** If you are onboarding both test and production, Steps 1
to 8 run twice, each time using that environment's column below. The two are independent: consent, app
roles, grants, the Dataverse application user, the SharePoint permission and the Management Portal
configuration are all per-environment. Nothing carries across.

| Application | Written in this guide as | Test | Production |
|---|---|---|---|
| AndMoney UWC | `{UwcAppClientId}` | `ea486ddc-1a1e-4837-967b-f975fdcf1ed7` | `cbac67da-6529-4411-821c-746888abee84` |
| BookingPlatform Mgmt UI | `{MgmtUiAppClientId}` | `8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b` | `261ae34b-4de9-4c4a-9d70-1df1c024c91e` |
| BookingPlatform Mgmt API | `{MgmtApiAppClientId}` | `f100d6c7-bbee-405b-9231-7e1c05c4b944` | `642f0f04-31f9-4641-a1cb-793f31496bd3` |
| AndMoney Dynamics Access | `{DynamicsAccessAppClientId}` | `de5dd77b-f082-4895-abe5-3f5f6020cba8` | `e9059d5a-7aeb-4f1a-a98d-7d8e1d4d23f3` |

| Application | What it is | Used in | Entra API permissions |
|---|---|---|---|
| **AndMoney UWC** | The sign-in surface your **advisors** use to reach Present | Step 1 | Microsoft Graph delegated: `openid`, `profile`, `User.Read`, `offline_access`<br>BookingPlatform Mgmt API: `access_as_user` *(our own scope)* |
| **BookingPlatform Mgmt UI** | The sign-in surface your **administrators** use to reach the Management Portal | Step 1 | Microsoft Graph delegated: `openid`, `profile`, `email`, `User.Read`, `offline_access`<br>BookingPlatform Mgmt API: `access_as_user` *(our own scope)* |
| **BookingPlatform Mgmt API** | The API behind both, carrying the app roles | Steps 1, 2, 3, 5b | **At consent** — Microsoft Graph delegated: `openid`, `profile`, `email`, `User.Read`<br>**Added by script in Step 3** — Dataverse delegated: `user_impersonation` · Microsoft Graph delegated: `Sites.Selected` |
| **AndMoney Dynamics Access** | The application identity that reads your Dataverse schema | Steps 1, 4 | Dataverse delegated: `user_impersonation` |

{: .important }
> **Every permission above is delegated. None of the four applications holds an application permission**
> — nothing runs without a signed-in user, and nothing acts beyond what that user can already do.
>
> The one exception to "delegated" is not an Entra permission at all: the application identity's
> **app-only** access to Dataverse is authorised by the **application user and its security role** you
> create in [Step 4](#step-4--create-the-application-user-in-dataverse), inside your own environment.
> Entra grants it nothing.

The two permissions marked **Added in Step 3** are the ones the authorisation script records, and the
only ones that are not part of an admin-consent prompt. They are recorded against the
**BookingPlatform Mgmt API** service principal in your tenant, tenant-wide (`AllPrincipals`), and are
revocable independently of the Step 1 consents — see
[Step 3](#step-3--authorise-engage-to-act-as-your-advisors).

Microsoft resource IDs, for cross-checking against what you see in Entra:

| Resource | Application ID |
|---|---|
| Microsoft Graph | `00000003-0000-0000-c000-000000000000` |
| Dataverse (Dynamics CRM) | `00000007-0000-0000-c000-000000000000` |

{: .note }
> **The two sign-in surfaces are separate applications and both are required.** Approving only one
> leaves either your advisors or your administrators locked out, and it shows at first use rather than
> at consent.

Your own tenant ID is written below as `{YourTenantId}`.

### The Management Portal

Used in Steps 6 and 7, and by your staff afterwards:

| Environment | URL |
|---|---|
| Test | `https://management.test-env.andmoney.dk` |
| Production | `https://management.andmoney.dk` |

Sign in with a Microsoft work account holding the `Admin` app role from Step 2.

## Step 1 — Approve the Engage applications

Engage publishes its applications as multi-tenant apps; you approve them rather than creating any.
Approving creates a **service principal** in your directory, which is what lets each application
authenticate against your tenant.

All four are required, **in this order** — the sign-in surfaces cannot be installed before the API they
depend on:

```text
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtApiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={UwcAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={DynamicsAccessAppClientId}
```

Open each link as an administrator, review the summary Microsoft shows, then **Accept**.

{: .note }
> **You may see "Sorry, but we're having trouble signing you in" afterwards.** That is expected — the
> consent link is not a sign-in page, and the approval has been recorded. Confirm by checking that all
> four applications appear under **Enterprise applications**.

{: .warning }
> **Do not delete and re-add these enterprise applications later.** The delegated permissions in Step 3
> bind to the service principal object, so reinstalling an application silently discards them and they
> have to be recorded again.
>
> The SharePoint permission in Step 5b behaves the *opposite* way: it identifies the application by
> client ID, so it survives — a recreated service principal inherits the site access. **Deleting the
> application is therefore not a way to revoke SharePoint access.** Remove the site permission itself,
> as in [Step 5b](#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site).

## Step 2 — Assign people to roles

Open the **BookingPlatform Mgmt API** enterprise application → **Users and groups**, and assign your security
groups or users to the roles they need:

| Role | What it grants |
|---|---|
| `Admin` | Everything a Configurator can do, plus logs — **and the Management Portal screens in Steps 6 and 7** |
| `Configurator` | Meeting and portal configuration, and presentation templates |
| `Manager` | Service and competence group configuration |
| `Employee` | Standard advisor access — the role most of your users need |
| `Customer` | Reserved for end-customer scenarios; not used for staff |

{: .important }
> **At least one person needs `Admin`, and that person also needs access to the Dynamics environment.**
> Steps 6 and 7 both require it, and Step 6 lists only the environments that person can reach in
> Dynamics. A `Configurator` cannot complete either step.

Engage applies the highest assigned role, so assigning several to one person adds nothing. Changes take effect at next sign-in. Repeat for every environment you
are onboarded to — the test and production applications are separate.

## Step 3 — Authorise Engage to act as your advisors

Two delegated permissions, both recorded against the **BookingPlatform Mgmt API** service principal in your tenant.
They let Engage act *as the signed-in advisor*, never beyond:

| Permission | Resource | Enables |
|---|---|---|
| `user_impersonation` | Dataverse — `00000007-0000-0000-c000-000000000000` | Reading and writing Dynamics records as the advisor |
| `Sites.Selected` | Microsoft Graph — `00000003-0000-0000-c000-000000000000` | Writing generated decks to SharePoint as the advisor |

{: .note }
> `Sites.Selected` grants access to **no SharePoint site at all** by itself. It becomes usable for one
> site only once that site is named in Step 5b.

Neither can be granted through a consent link: Microsoft's consent endpoint only grants permissions an
application advertises in its manifest, and Engage advertises neither — so customers using neither
Dynamics nor SharePoint are never asked to approve them.

Use [`add-delegated-grant-to-service-principal.ps1`]({{ site.baseurl }}/foundation/scripts/#add-delegated-grant-to-service-principalps1), run
**twice**. Install [its modules]({{ site.baseurl }}/foundation/scripts/#before-you-run-any-of-them) first, or it stops at startup:

```powershell
# Dataverse - the script's defaults
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId    {YourTenantId} `
  -clientAppId {MgmtApiAppClientId}

# Microsoft Graph - for SharePoint
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId      {YourTenantId} `
  -clientAppId   {MgmtApiAppClientId} `
  -resourceAppId 00000003-0000-0000-c000-000000000000 `
  -scope         Sites.Selected
```

**Application Administrator** is sufficient; Global Administrator is not needed. Both take effect within
seconds.

{: .important }
> **Both grants are tenant-wide (`AllPrincipals`).** They apply to every user in your directory rather
> than to a named set. They do not by themselves give anyone access to anything: each still runs as the
> signed-in advisor and is bounded by that person's own Dynamics and SharePoint permissions. But the
> grant itself is not scoped to a group, and your security review should record it that way.
>
> Signing the script in also leaves a standing consent for Microsoft's own *Microsoft Graph Command Line
> Tools* application, which requests `Application.Read.All` and `DelegatedPermissionGrant.ReadWrite.All`.
> Revoke it afterwards under **Enterprise applications → Microsoft Graph Command Line Tools →
> Permissions** if your policy does not allow standing admin-tooling consent.

- **It is idempotent**, but allow a few seconds between the two runs — Microsoft's read of the
  permission list lags writes, and an immediate second run can attempt a duplicate.
- **It prints an Undo command each time. Keep both.** Deleting the permission record by hand would
  revoke every other delegated permission that application holds in your tenant.

## Step 4 — Create the application user in Dataverse

The application identity needs a Dataverse user in your environment, bound to the **AndMoney Dynamics
Access** client ID, and a security role that bounds what it can reach.

### 4a — Create the application user

**Power Platform admin centre → Environments → {your environment} → Settings → Users + permissions →
Application users → New app user.** Select the application by its client ID —
`{DynamicsAccessAppClientId}` — and choose a business unit.

Leave it without a role for now; Step 4b creates and assigns one.

### 4b — Create and assign the security role

Use [`new-dataverse-role-for-app-user.ps1`]({{ site.baseurl }}/foundation/scripts/#new-dataverse-role-for-app-userps1). It needs the
[Azure CLI]({{ site.baseurl }}/foundation/scripts/#before-you-run-any-of-them), and must run as a **System Administrator** of the environment
— the application user cannot modify its own role.

```powershell
az login --tenant {YourTenantId}

./new-dataverse-role-for-app-user.ps1 `
  -environmentUrl https://yourorg.crm4.dynamics.com `
  -applicationId  {DynamicsAccessAppClientId}
```

It creates the role, captures its existing privileges to a file, replaces them with the four below,
reads the role back and prints what it carries by name, then assigns it to the application user. It is
idempotent: re-running re-trims rather than duplicating.

{: .note }
> **Create the role with the script rather than the role editor.** A role created in the editor arrives
> carrying around eighty privileges — including creating and activating workflows, and creating,
> changing and deleting business process flows — and *Copy role* clones an equally large one. Trimming
> that by hand is about eighty toggles with no way to confirm the result. A role created over the Web
> API does not get that template: it starts with nine privileges, and the script replaces them.

### The privileges the role ends up with

Four, all at **Organization** level (`Global` in the API), and nothing else:

| Privilege | What it is for |
|---|---|
| `prvReadEntity` | Reading your schema — which tables exist |
| `prvReadAttribute` | Reading your schema — which columns exist |
| `prvReadRelationship` | Reading your schema — how they relate |
| `prvReadOrganization` | The Dataverse client's connection handshake. Without it the integration fails when it connects, before it reads anything |

These are metadata reads: they expose the *shape* of your data, not its contents.

{: .important }
> **No access to customer records is required, and none should be granted.** No `account`, `contact`,
> `appointment` or `annotation` privileges belong on this role. All record work runs as the advisor
> under their own role, so anything added here would widen the integration's reach without enabling any
> feature. If Engage ever appears to need record privileges here, ask &money before granting them.

{: .note }
> **If your environment uses server-based SharePoint document management, the role will read back with
> eight privileges, not four.** Dataverse re-attaches `prvReadSharePointDocument`,
> `prvReadSharePointData`, `prvCreateSharePointData` and `prvWriteSharePointData` on any privilege
> write — removing them does not stick. They are imposed by the platform, not requested by Engage, and
> they govern Dataverse's own document-location records rather than the contents of your SharePoint
> sites; access to those is granted separately, per site, in Step 5.
>
> So **four** privileges without that feature, **eight** with it. Either is correct; anything more is
> not. If you are unsure which applies, send your &money contact what the script printed.

### Doing it by hand instead

If you would rather not run the script, the same result over the Web API. Capture first —
`ReplacePrivilegesRole` discards everything not listed, and that capture is the only way back:

```http
GET  {EnvironmentUrl}/api/data/v9.2/roles?$select=roleid,name&$filter=name eq 'YOUR ROLE NAME'
GET  {EnvironmentUrl}/api/data/v9.2/RetrieveRolePrivilegesRole(RoleId={roleid})
GET  {EnvironmentUrl}/api/data/v9.2/privileges?$select=privilegeid,name&$filter=name eq 'prvReadEntity'

POST {EnvironmentUrl}/api/data/v9.2/roles({roleid})/Microsoft.Dynamics.CRM.ReplacePrivilegesRole
{ "Privileges": [ { "PrivilegeId": "…", "Depth": "Global" } ] }
```

Then read the role back with `RetrieveRolePrivilegesRole` and confirm it carries what you intended.

If a step fails with a privilege error, send the error to &money rather than broadening the role.

## Step 5 — Prepare the SharePoint site and grant access to it

### 5a — Create or nominate the site

Create or nominate a site and add the advisors who will use Present as members. Note the **host name**,
the **server-relative site path**, and the **document library** if it should not be the site's default —
for example `bank.sharepoint.com`, `/sites/present`, default library. You enter these yourself in
Step 7.

Site paths containing `:`, `#`, `%`, `?` or `;` cannot be used; they collide with the way Microsoft
Graph addresses sites.

### 5b — Grant the BookingPlatform Mgmt API application access to that one site

`Sites.Selected` from Step 3 reaches no site until that site is named explicitly — which is why Engage
cannot reach any other SharePoint site in your tenant. The permission goes to the same application you
granted `Sites.Selected` to: **BookingPlatform Mgmt API** (`{MgmtApiAppClientId}`), not the Dynamics one.

Use [`add-site-permission-for-app.ps1`]({{ site.baseurl }}/foundation/scripts/#add-site-permission-for-appps1). Install
[its modules]({{ site.baseurl }}/foundation/scripts/#before-you-run-any-of-them) first, or it stops at startup:

```powershell
./add-site-permission-for-app.ps1 `
  -tenantId     {YourTenantId} `
  -siteHostname bank.sharepoint.com `
  -sitePath     /sites/present `
  -clientAppId  {MgmtApiAppClientId}
```

The role defaults to **`write`** — not `fullcontrol`. Engage writes and reads deck files; `fullcontrol`
would let it change permissions, including its own.

Recording a site permission requires `Sites.FullControl.All`, so run it as a SharePoint or Global
administrator.

The script prints the permissions the site now carries, the permission id, and the **Undo** command.
Keep the output: that listing is the complete statement of what Engage can reach in your SharePoint, and
the permission id is what you need to revoke it.

**To revoke later**, run the printed Undo command. Access stops immediately; Present will fail to save
decks, and nothing else is affected. Note that removing the enterprise application does *not* revoke
this — a site permission identifies the application by client id, so a recreated principal inherits it.

### 5c — Housekeeping

Pruning old decks is yours to run on whatever schedule suits you. Engage does not archive or prune, and
tolerates files being removed.

---

{: .important }
> **Steps 6 and 7 need &money to have registered your organisation first.** Confirm with your &money
> contact before starting them. Both require the `Admin` role from Step 2.

## Step 6 — Connect your Dynamics environment

In the [Management Portal](#the-management-portal), go to **Admin → CRM Settings**. This is two choices:
which CRM system your organisation runs on, and which environment within it.

### 6a — Choose Dynamics 365

![Choosing the CRM system under Admin → CRM Settings]({{ site.baseurl }}/assets/images/foundation/dynamics/crm-settings-choose-system.png)

Select **Dynamics 365** and press **Continue**.

Only the integrations enabled for your organisation are listed, so if Dynamics 365 does not appear,
tell your &money contact — it means Present has not been enabled against your organisation yet.

{: .warning }
> **Choose the system your organisation actually runs on.** Changing the CRM system later stops the
> current connection being used. This is not a preference you toggle while exploring.

### 6b — Choose the environment

![Choosing the Dataverse environment]({{ site.baseurl }}/assets/images/foundation/dynamics/crm-settings-choose-environment.png)

The **Environment** list is populated live by asking Microsoft which Dataverse environments *you* can
reach — so sign in as someone with access to the intended one. Each entry shows its name and region.
Pick the sandbox during the integration phase, production at go-live.

The environment's URL appears under the heading once selected, so you can confirm you picked the right
one before going further.

### 6c — Test the connection

Press **Test**. The status badge next to the environment name goes from **Not tested** to a result.

The test authenticates as the **application identity** from Step 4 — a freshly minted token, so a
cached one cannot report a stale success — and calls `WhoAmI` against the environment you selected.
Because that credential never leaves &money, this button is how you exercise it; there is nothing for
you to run yourself.

**A green result proves three things:** the environment is reachable, the application's credentials are
valid against your tenant, and the Dataverse application user exists and is enabled. A failure is
almost always one of those — most often an application user that is missing, disabled, or bound to the
wrong client ID.

- **The list shows only environments your signed-in account can reach.** A short or empty list is a
  statement about your own access, not a fault in Engage.
- **Changing the environment later is possible but not free.** The Portal warns you when you try, and
  configuration already made against the old environment does not follow. Plan the sandbox-to-production
  switch with your &money contact rather than treating it as a toggle.

## Step 7 — Configure your SharePoint destination

In the [Management Portal](#the-management-portal), go to **Admin → Microsoft** and open the
**SharePoint** tab.

![The SharePoint destinations list]({{ site.baseurl }}/assets/images/foundation/dynamics/microsoft-sharepoint-destinations.png)

Press **Create**, and fill in the values from Step 5a:

![The Create SharePoint destination dialog]({{ site.baseurl }}/assets/images/foundation/dynamics/microsoft-sharepoint-create-destination.png)

| Field | Value | Notes |
|---|---|---|
| Key | **`present`** | Must be exactly this — see below |
| Site address | `bank.sharepoint.com` | Host name only — no `https://`, no path, no port |
| Site path | `/sites/present` | Server-relative, starting with `/` |
| Document library | *(leave empty)* | Empty uses the site's default document library |

{: .warning }
> **The key must be exactly `present`** — lower-case, and **it cannot be changed after creation**. It is
> not a label you choose. Present selects its destination by this key, so a destination saved under any
> other name fails at the upload step with a destination-not-found error rather than anything that
> mentions naming. Getting it wrong means deleting the destination and creating it again.

{: .note }
> **There is no default destination.** Until one exists here, Present cannot write to SharePoint at all.
> Saving a destination does not grant access either — the per-site permission from
> [Step 5b](#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site) does that, and
> the two are checked at different moments. If a deck fails to save, confirm both.

## Step 8 — Embed Present in Dynamics

Present opens from a **Dynamics appointment record**, so one must exist before Present is opened.

{: .important }
> **Your Dynamics environment needs SharePoint document management enabled, on the Appointment table.**
> Two settings, both in Dynamics rather than in Engage:
>
> - **Server-based SharePoint integration** configured for the environment, pointed at your SharePoint.
> - **Document management enabled for the Appointment table**, so `sharepointdocumentlocation` records
>   can be created against an appointment.
>
> Without them the deck still reaches SharePoint — that path is Steps 5 and 7 and does not depend on
> this — but nothing links it back to the appointment, so the advisor never sees it on the record.
>
> You may already know the answer: if the security role in [Step 4b](#4b--create-and-assign-the-security-role)
> read back with **eight** privileges rather than four, server-based SharePoint integration is on. Four
> means it is not, and this needs setting up before the flow completes end to end.

You build the embedding as a **web resource or PCF component** on the appointment form.

{: .warning }
> **A standard IFRAME control is not sufficient.** Its URL is fixed when the form is designed, so it
> cannot carry the login hint, which is per-advisor and only known at runtime. Without the hint the
> embedding still works, but every advisor gets a sign-in pop-up each time they open Present.

### The data contract

| Parameter | Value | Purpose |
|---|---|---|
| `id` | The appointment record GUID | Which appointment the deck is for |
| `typename` | `appointment` | The table the record belongs to |
| `user_email` | The signed-in advisor's email | **The login hint** |
| `type`, `orgname`, `userlcid`, `orglcid` | Standard Dynamics values | Context; optional |

These are values a Dynamics form already has to hand — the component reads them at runtime and passes
them on, which is what a static control cannot do. `federation_id` is also accepted where your setup
uses one.

{: .note }
> **&money does not currently supply a reference web resource or PCF component**, so the implementation
> is yours to write and to estimate. What we provide is the contract above and the identity endpoint
> below to test it against. If that is a problem for your timeline, raise it early with your &money
> contact rather than at build time.

{: .important }
> **The login hint is what makes sign-in invisible.** With it, Present completes SSO silently against
> the advisor's existing session.
>
> It is **not** how Present identifies the advisor. Identity always comes from the SSO token; the hint
> only tells Microsoft which account to resolve silently, and Present cross-checks the two and reports a
> mismatch. Sending a hint grants nothing, and spoofing it achieves nothing.

### Validate the embedding first

Point your component at the **identity endpoint** before pointing it at Present:

| Environment | URL |
|---|---|
| Test | `https://engage.test-env.andmoney.dk/identity` |
| Production | `https://engage.andmoney.dk/identity` |

It states the expected contract and reports what your embedding actually sent — each parameter with a
pass or fail, the SSO result, and whether the login hint matches the signed-in user. It is the same
handshake and identity resolution the live integration uses, so a green result means the embedding is
correct.

Missing parameters report as *not provided* rather than failures, so a partial embedding is still worth
testing.

### Then switch to Present

| Environment | URL |
|---|---|
| Test | `https://engage.test-env.andmoney.dk/present` |
| Production | `https://engage.andmoney.dk/present` |

Nothing else changes — same component, same parameters, same login hint.

## What &money does

Before your Step 6: registers your organisation, links your Entra tenant to it and enables Present.

Throughout the onboarding, your &money contact is available to help with any step here.

## Verifying it works

Both tests below use a **starter &money template** — a small set of slides we can add to your
environment on request, so verification does not wait on your own slide design. Ask your &money contact
for it before you start.

Each test needs an advisor account, an appointment record in Dynamics, and the embedding from
[Step 8](#step-8--embed-present-in-dynamics).

### Smoke test — generate an empty presentation

No tag mapping is involved, so nothing on the slides comes from Dynamics. What this exercises is the
plumbing: sign-in, the appointment reaching Present, the deck being built, and the files arriving where
they belong.

Open an appointment in Dynamics and open Present from the form. It opens on **Trin 01 — Dagsorden**:

![Present open on an appointment, on the agenda step]({{ site.baseurl }}/assets/images/foundation/dynamics/present-agenda-empty.png)

Name an agenda item — anything will do — and press **Videre**:

![An agenda item named on the agenda step]({{ site.baseurl }}/assets/images/foundation/dynamics/present-agenda-item.png)

On **Trin 02 — Slides**, press **Tilføj slides** under the agenda item and pick the *dagsorden* slide
from the starter &money template. Then press **Videre**:

![A slide added under the agenda item]({{ site.baseurl }}/assets/images/foundation/dynamics/present-slides-selected.png)

**Trin 03 — Kundepræsentation** reports that the selected slides use no tags, so there is nothing to fill
in. Leave both **PowerPoint** and **PDF** ticked and press **Generér**:

![The generate step, with PowerPoint and PDF selected]({{ site.baseurl }}/assets/images/foundation/dynamics/present-generate.png)

Both files are uploaded to your SharePoint site, and a `sharepointdocumentlocation` record is created
against the appointment for each of them — which is what puts them on the appointment's document view.
You should see two: a `.pptx` and a `.pdf`, named by an identifier rather than a title, each with the
appointment under **Regarding** and an absolute URL into your site:

![The generated files listed against the appointment]({{ site.baseurl }}/assets/images/foundation/dynamics/appointment-related-documents.png)

Open one and check it contains the slide you chose, with your agenda text on it.

The upload and the document location are separate mechanisms. Writing the file is Engage; creating the
`sharepointdocumentlocation` depends on server-based SharePoint integration and document management
being enabled on the `appointment` table, as described in
[Step 8](#step-8--embed-present-in-dynamics). If the files are in SharePoint but the appointment lists
nothing, that is where to look.

### Advisor test — generate a presentation with your own data

This is the flow an advisor will actually use: a tag mapped once by a configurator, then filled from the
Dynamics record every time a presentation is generated.

#### Upload a template

A `Configurator` or `Admin` uploads the presentation the advisors will build from, under
**Present → Setup → Templates → Upload**. How a template is built — sections, slide names, and the tags
that get filled in — is covered in the
[Present super-user guide]({{ site.baseurl }}/business-implementation/present/en/superbrugerguide/#prepare-your-master-template-powerpoint).

The starter &money template already contains tags, so it can be used here instead.

#### Map a tag to a Dynamics field

In the [Management Portal](#the-management-portal), go to **Present → Setup → Tags** and press
**Create**. The dialog asks two things: which tag you are filling, and where its value comes from.

![The Create tag configuration dialog]({{ site.baseurl }}/assets/images/foundation/dynamics/present-tag-create-dialog.png)

Choose the tag, then build the path to the value. The path starts on the **Appointment** and you either
pick a field on it to finish, or step out to a linked record and keep going. The list names each hop —
`account` *via regardingobjectid*, for example — and gives each field its Dataverse type:

![Choosing where the tag's value comes from]({{ site.baseurl }}/assets/images/foundation/dynamics/present-tag-choose-source.png)

**The mapping** panel on the right shows the path as it stands, and it is the path that is saved — it
runs against every appointment, not only the one you are looking at. Press **Create** when it reads the
way you intend:

![The finished mapping path, from Appointment to account name]({{ site.baseurl }}/assets/images/foundation/dynamics/present-tag-mapping-path.png)

**Find a meeting** at the top is worth using while you map: it sets an example appointment, and every
field list then shows the value that record actually holds. This is the quickest way to confirm you have
picked the right field before saving.

#### Generate as an advisor

Work through the same three steps as the smoke test, this time choosing a slide that uses the tag you
mapped. Pick an appointment where the mapped field holds a value, and note what it is — a blank slide
otherwise leaves you unable to tell an empty field from a mapping that does not resolve.

**Trin 03** now separates the two kinds of tag:

![Trin 03 showing filled and unfilled tags]({{ site.baseurl }}/assets/images/foundation/dynamics/present-filled-tags.png)

- **Udfyldte tags** — expand it and the mapped tag shows the value read from Dynamics, marked
  **FRA CRM**, with a thumbnail of the slide it appears on.
- Anything still unmapped is listed as **IKKE UDFYLDT** with *tom — indsættes blank*, and the step header
  counts them. These never block generation; the advisor can type a value or let the tag come out blank.

Generate, and confirm the slide in the finished deck carries the value you noted.

A value arriving here proves the data path in one go: the advisor's own permissions were used to read
Dataverse, the path resolved from the appointment to the field, and the value reached the slide. An
advisor who cannot open that record in Dynamics cannot produce it here either.

## Scripts

The scripts used in this guide are kept on the [Scripts]({{ site.baseurl }}/foundation/scripts/) page, with download links and the
modules each one needs.

### Before you run any of them

See [Before you run any of them]({{ site.baseurl }}/foundation/scripts/#before-you-run-any-of-them).

### add-delegated-grant-to-service-principal.ps1

Used in [Step 3](#step-3--authorise-engage-to-act-as-your-advisors). See
[add-delegated-grant-to-service-principal.ps1]({{ site.baseurl }}/foundation/scripts/#add-delegated-grant-to-service-principalps1).

### new-dataverse-role-for-app-user.ps1

Used in [Step 4b](#4b--create-and-assign-the-security-role). See
[new-dataverse-role-for-app-user.ps1]({{ site.baseurl }}/foundation/scripts/#new-dataverse-role-for-app-userps1).

### add-site-permission-for-app.ps1

Used in [Step 5b](#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site). See
[add-site-permission-for-app.ps1]({{ site.baseurl }}/foundation/scripts/#add-site-permission-for-appps1).

## Related

- [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration) — the architecture behind this configuration
- [Identity]({{ site.baseurl }}/foundation/identity/) — the app registration and admin consent model in full
