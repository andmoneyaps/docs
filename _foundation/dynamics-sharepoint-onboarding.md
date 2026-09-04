---
layout: default
title: Present on Dynamics 365 and SharePoint
nav_order: 9
parent: Foundation
---

# Present on Dynamics 365 and SharePoint

Configuring **Present** where your CRM is **Microsoft Dynamics 365** and generated presentations are
stored in **SharePoint**. The architecture behind it is in
[section 5 of the Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration).

{: .important }
> This guide covers Present on Dynamics 365 with SharePoint storage, and nothing else. Other Engage
> products bring their own configuration. If your CRM is Salesforce, see
> [BookMe onboarding]({{ site.baseurl }}/bookme/onboarding/) instead.

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
| AndMoney Dynamics Access | `{DynamicsAccessAppClientId}` | `de5dd77b-f082-4895-abe5-3f5f6020cba8` | *to be provided* |

| Application | What it is | Used in |
|---|---|---|
| **AndMoney UWC** | The sign-in surface your **advisors** use to reach Present | Step 1 |
| **BookingPlatform Mgmt UI** | The sign-in surface your **administrators** use to reach the Management Portal | Step 1 |
| **BookingPlatform Mgmt API** | The API behind both, carrying the app roles | Steps 1, 2, 3, 5b |
| **AndMoney Dynamics Access** | The application identity that reads your Dataverse schema | Steps 1, 4 |

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

All four are required. Open each link as an administrator:

```text
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={UwcAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtApiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={DynamicsAccessAppClientId}
```

Review the summary Microsoft shows, then **Accept**.

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

Use [`add-delegated-grant-to-service-principal.ps1`](#add-delegated-grant-to-service-principalps1), run **twice**:

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

Use [`new-dataverse-role-for-app-user.ps1`](#new-dataverse-role-for-app-userps1). Run it as a **System
Administrator** of the environment — the application user cannot modify its own role.

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

Use [`add-site-permission-for-app.ps1`](#add-site-permission-for-appps1):

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

{: .warning }
> **It does not prove the security role is right.** `WhoAmI` needs no privilege at all beyond an
> enabled application user, so the test passes whether you trimmed the role to four privileges or left
> all eighty in place. It cannot tell you that you granted too little — that surfaces later, when
> Engage first reads your schema — and it will never tell you that you granted too much.
>
> Verify the role the way [Step 4b](#4b--create-and-assign-the-security-role) describes: the script reads
> it back and prints what it carries, by name. Check that list against the four above.

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

Together, at the end:

- An advisor signs in and opens Present from an appointment.
- They see the customer data they expect — and an advisor **without** access to a given record does not
  see it.
- A generated deck lands in the SharePoint site and opens in PowerPoint on the web.
- An advisor without access to the SharePoint site fails visibly rather than silently.

## Scripts

### add-delegated-grant-to-service-principal.ps1

Used in [Step 3](#step-3--authorise-engage-to-act-as-your-advisors). Records a delegated permission
directly on a service principal in your tenant — the one thing an admin-consent link cannot do.

Requires the `Microsoft.Graph` PowerShell module:

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery
```

Save the following as `add-delegated-grant-to-service-principal.ps1`:

```powershell
param (
    [Parameter(Mandatory = $true, HelpMessage = "Entra tenant id in which to create the grant (the consuming/bank tenant).")]
    [guid]$tenantId,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) of the client application whose service principal receives the grant.")]
    [guid]$clientAppId,

    [Parameter(HelpMessage = "AppId of the resource API. Default: Dataverse (Dynamics CRM).")]
    [guid]$resourceAppId = '00000007-0000-0000-c000-000000000000',

    [Parameter(HelpMessage = "Delegated permission (scope) value to grant. Default: user_impersonation.")]
    [string]$scope = 'user_impersonation'
)

# Grants a delegated permission directly on the client app's SERVICE PRINCIPAL in
# the given tenant (an oauth2PermissionGrant), without touching the app
# registration's manifest. Use when a permission applies only to some consuming
# tenants - e.g. Dataverse user_impersonation for Dynamics banks - and must not
# appear in every tenant's consent prompt. The /adminconsent endpoint cannot do
# this (it only grants manifest-advertised permissions), hence this Graph write.
#
# Idempotent upsert: a client/resource pair holds at most one AllPrincipals grant,
# whose Scope is a space-separated list; re-running appends the scope or no-ops.
# Graph's grant list reads lag writes by seconds, so allow a moment between runs
# against the same pair - an immediate re-run can miss the new row and attempt a
# duplicate create, which Graph rejects with a key conflict.
#
# To undo, use the command printed under "Undo:" at the end of the run. It differs
# per path: a grant this script created is deleted outright, whereas a scope
# appended to a pre-existing grant is removed by writing the original Scope list
# back. Deleting a pre-existing grant would revoke every other delegated
# permission the client app holds tenant-wide.
#
# Run by an admin of the target tenant. Application Administrator is sufficient;
# so are Cloud Application
# Administrator, Directory Writers, Privileged Role Administrator and User
# Administrator. Global Administrator is not required.
#
# Signing in consents the Microsoft first-party app "Microsoft Graph Command Line
# Tools" to the scopes below, which leaves a tenant-wide grant for that app behind
# after this script exits. Revoke it under Enterprise applications > Microsoft
# Graph Command Line Tools > Permissions if tenant policy disallows standing
# admin-tooling consent.

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Applications, Microsoft.Graph.Identity.SignIns

## To run the cmdlets in this script, you need the Microsoft Graph module installed.
# Command to run in Powershell shell: Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force
# Check if installed: Get-InstalledModule -Name Microsoft.Graph

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Applications
Import-Module Microsoft.Graph.Identity.SignIns

# ContextScope Process keeps the token cache in memory, so no bank-tenant Graph
# context outlives the run on the operator's machine. The resulting context is
# then asserted against $tenantId: a cancelled or expired sign-in can otherwise
# leave an earlier tenant's context live, and the grant written below is
# tenant-wide. Get-MgContext rather than Get-MgOrganization, so the assert needs
# no user-read scope on the bank's consent prompt.
Connect-MgGraph -TenantId $tenantId -Scopes "Application.Read.All", "DelegatedPermissionGrant.ReadWrite.All" -ContextScope Process -NoWelcome -ErrorAction Stop

$context = Get-MgContext
if ($null -eq $context -or [guid]$context.TenantId -ne $tenantId) {
    Write-Host -ForegroundColor Red "Signed in to tenant '$($context.TenantId)', expected '$tenantId'."
    Write-Host -ForegroundColor Red "Sign in as an admin of the target tenant and re-run."
    exit 1
}

#################################################################################################################
# Resolve the two service principals in the target tenant
#################################################################################################################
$clientSp = Get-MgServicePrincipal -Filter "appId eq '$clientAppId'" -ErrorAction Stop
if ($null -eq $clientSp) {
    Write-Host -ForegroundColor Red "No service principal for appId $clientAppId in tenant $tenantId."
    Write-Host -ForegroundColor Red "The application must be installed (admin-consented) in this tenant first."
    exit 1
}

$resourceSp = Get-MgServicePrincipal -Filter "appId eq '$resourceAppId'" -ErrorAction Stop
if ($null -eq $resourceSp) {
    Write-Host -ForegroundColor Red "No service principal for resource appId $resourceAppId in tenant $tenantId."
    Write-Host -ForegroundColor Red "For Dataverse this means the tenant has no Dynamics/Power Platform footprint."
    exit 1
}

# Entra accepts grants for scope values the resource never published; guard against
# typos. Disabled scopes are excluded - a grant naming one is silently ignored at
# token time. Matching is case-sensitive because Entra's scope matching is too.
$publishedScopes = @($resourceSp.Oauth2PermissionScopes | Where-Object { $_.IsEnabled } | ForEach-Object { $_.Value })
if ($publishedScopes -cnotcontains $scope) {
    Write-Host -ForegroundColor Red "Resource '$($resourceSp.DisplayName)' does not publish an enabled delegated permission named '$scope'."
    Write-Host -ForegroundColor Red "Published scopes: $($publishedScopes -join ', ')"
    Write-Host -ForegroundColor Red "If the scope was published on the app registration only recently, this tenant's copy of the"
    Write-Host -ForegroundColor Red "service principal may be stale: run Update-MgServicePrincipalByAppId -AppId $resourceAppId here first."
    exit 1
}

#################################################################################################################
# Show what is about to be consented, while it is still avoidable
#################################################################################################################
Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Tenant:   "
Write-Host -ForegroundColor Yellow "$tenantId"
Write-Host -ForegroundColor Cyan -NoNewline "Client:   "
Write-Host -ForegroundColor Yellow "$($clientSp.DisplayName) ($clientAppId, SP $($clientSp.Id))"
Write-Host -ForegroundColor Cyan -NoNewline "Resource: "
Write-Host -ForegroundColor Yellow "$($resourceSp.DisplayName) ($resourceAppId)"
Write-Host

#################################################################################################################
# Upsert the AllPrincipals grant
#################################################################################################################
$grant = Get-MgOauth2PermissionGrant -Filter "clientId eq '$($clientSp.Id)' and consentType eq 'AllPrincipals'" -All -ErrorAction Stop |
    Where-Object { $_.ResourceId -eq $resourceSp.Id }

if ($null -ne $grant) {
    $grantId = $grant.Id
    $scopes = @($grant.Scope -split '\s+' | Where-Object { $_ })
    # Case-sensitive: a row differing only by casing is a different scope to Entra,
    # so treating it as a match would report success on a grant that never applies.
    if ($scopes -ccontains $scope) {
        Write-Host -ForegroundColor Green "Already granted - nothing to do."
        $finalScopes = $scopes
        $undo = $null
    } else {
        $finalScopes = $scopes + $scope
        Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId -Scope ($finalScopes -join ' ') -ErrorAction Stop
        Write-Host -ForegroundColor Green "SUCCESS >>> Appended '$scope' to the existing grant."
        # The grant pre-dates this run and carries scopes this run did not add, so
        # undo restores the captured list instead of deleting the grant.
        $undo = "Update-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId -Scope '$($scopes -join ' ')'"
    }
} else {
    $newGrant = New-MgOauth2PermissionGrant -ClientId $clientSp.Id -ConsentType 'AllPrincipals' -ResourceId $resourceSp.Id -Scope $scope -ErrorAction Stop
    if ($null -eq $newGrant -or [string]::IsNullOrWhiteSpace($newGrant.Id)) {
        Write-Host -ForegroundColor Red "The create call returned no grant id, so no grant was written."
        Write-Host -ForegroundColor Red "Check the state with Get-MgOauth2PermissionGrant before re-running."
        exit 1
    }
    $grantId = $newGrant.Id
    $finalScopes = @($scope)
    Write-Host -ForegroundColor Green "SUCCESS >>> Grant created."
    $undo = "Remove-MgOauth2PermissionGrant -OAuth2PermissionGrantId $grantId"
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Scopes:   "
Write-Host -ForegroundColor Yellow ($finalScopes -join ' ')
Write-Host -ForegroundColor Cyan -NoNewline "Consent:  "
Write-Host -ForegroundColor Yellow "AllPrincipals (tenant-wide)"
Write-Host -ForegroundColor Cyan -NoNewline "Grant id: "
Write-Host -ForegroundColor Yellow "$grantId"
if ($null -ne $undo) {
    Write-Host -ForegroundColor Cyan -NoNewline "Undo:     "
    Write-Host -ForegroundColor Yellow $undo
}

Disconnect-MgGraph | Out-Null
```

### new-dataverse-role-for-app-user.ps1

Used in [Step 4b](#4b--create-and-assign-the-security-role). Creates the Dataverse security role, trims
it to the four privileges the integration needs, and assigns it to the application user.

Needs the Azure CLI for the sign-in (`az login --tenant {YourTenantId}`), or pass a token with
`-accessToken`.

Save the following as `new-dataverse-role-for-app-user.ps1`:

```powershell
param (
    [Parameter(Mandatory = $true, HelpMessage = "Dataverse environment URL, e.g. https://org12345.crm4.dynamics.com")]
    [string]$environmentUrl,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) the Dataverse application user is bound to.")]
    [guid]$applicationId,

    [Parameter(HelpMessage = "Name of the security role to create or update.")]
    [string]$roleName = "Engage Present - schema read",

    [Parameter(HelpMessage = "Business unit for the role. Defaults to the environment's root business unit.")]
    [guid]$businessUnitId,

    [Parameter(HelpMessage = "Bearer token for the environment. Omit to acquire one interactively via Azure CLI.")]
    [string]$accessToken
)

# Creates (or re-trims) the Dataverse security role the Engage application user needs, and
# assigns it. The role carries exactly four privileges, all at Global depth:
#
#   prvReadEntity, prvReadAttribute, prvReadRelationship  - reading the schema
#   prvReadOrganization                                   - the SDK client's connect handshake
#
# No privilege on any business table: all record work runs as the signed-in advisor under
# their own role, so the application identity needs none.
#
# Why a script rather than the role editor: a role created in the modern editor arrives
# carrying ~80 privileges (and "Copy role" clones an equally large one), including workflow
# creation and SharePoint document writes. Trimming that by hand is ~80 toggles with no way
# to confirm the result. Creating the role through the Web API avoids the editor's template
# entirely, and the read-back below states what the role actually carries.
#
# Idempotent: an existing role of the same name in the same business unit is re-trimmed
# rather than duplicated, and an already-assigned role is left alone.
#
# Run as a System Administrator of the environment. The application user cannot modify its
# own role.

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$envUrl  = $environmentUrl.TrimEnd('/')
$apiRoot = "$envUrl/api/data/v9.2"

#################################################################################################################
# Token
#################################################################################################################
if ([string]::IsNullOrWhiteSpace($accessToken)) {
    # The Azure CLI's first-party client can obtain a delegated Dataverse token for the
    # signed-in admin, which avoids adding an app registration just to run this once.
    Write-Host -ForegroundColor Cyan "Acquiring a token for $envUrl via Azure CLI..."
    $accessToken = (az account get-access-token --resource $envUrl --query accessToken -o tsv)
    if ([string]::IsNullOrWhiteSpace($accessToken)) {
        Write-Host -ForegroundColor Red "Could not acquire a token. Run 'az login --tenant <tenant>' first,"
        Write-Host -ForegroundColor Red "or pass one with -accessToken."
        exit 1
    }
}

$headers = @{
    Authorization      = "Bearer $accessToken"
    'OData-MaxVersion' = '4.0'
    'OData-Version'    = '4.0'
    Accept             = 'application/json'
}

function Invoke-Dv {
    param([string]$Method, [string]$Path, $Body)
    $uri = if ($Path -match '^https?://') { $Path } else { "$apiRoot/$Path" }
    $args = @{ Method = $Method; Uri = $uri; Headers = $headers }
    if ($null -ne $Body) {
        $args.Body = ($Body | ConvertTo-Json -Depth 6)
        $args.ContentType = 'application/json'
    }
    return Invoke-RestMethod @args
}

#################################################################################################################
# Business unit
#################################################################################################################
if (-not $PSBoundParameters.ContainsKey('businessUnitId')) {
    $root = Invoke-Dv GET 'businessunits?$select=businessunitid,name&$filter=_parentbusinessunitid_value eq null'
    if ($root.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Expected exactly one root business unit, found $($root.value.Count)."
        Write-Host -ForegroundColor Red "Pass -businessUnitId explicitly."
        exit 1
    }
    $businessUnitId = $root.value[0].businessunitid
    Write-Host -ForegroundColor Cyan -NoNewline "Business unit: "
    Write-Host -ForegroundColor Yellow "$($root.value[0].name) ($businessUnitId)"
}

#################################################################################################################
# Role - find or create
#################################################################################################################
$escaped  = $roleName.Replace("'", "''")
$existing = Invoke-Dv GET "roles?`$select=roleid,name&`$filter=name eq '$escaped' and _businessunitid_value eq $businessUnitId"

if ($existing.value.Count -gt 1) {
    Write-Host -ForegroundColor Red "More than one role named '$roleName' in this business unit. Resolve by hand."
    exit 1
}

if ($existing.value.Count -eq 1) {
    $roleId = $existing.value[0].roleid
    Write-Host -ForegroundColor Yellow "Role '$roleName' already exists ($roleId) - its privileges will be replaced."
} else {
    $created = Invoke-Dv POST 'roles' @{
        name                        = $roleName
        'businessunitid@odata.bind' = "/businessunits($businessUnitId)"
    }
    # A create returns no body by default; read the role back by name rather than assume.
    $lookup = Invoke-Dv GET "roles?`$select=roleid,name&`$filter=name eq '$escaped' and _businessunitid_value eq $businessUnitId"
    if ($lookup.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Role was not created, or is ambiguous. Check the environment before re-running."
        exit 1
    }
    $roleId = $lookup.value[0].roleid
    Write-Host -ForegroundColor Green "SUCCESS >>> Role '$roleName' created ($roleId)."
}

#################################################################################################################
# Capture what the role carries now, before replacing it
#################################################################################################################
$before = Invoke-Dv GET "RetrieveRolePrivilegesRole(RoleId=$roleId)"
$beforeCount = @($before.RolePrivileges).Count
Write-Host -ForegroundColor Cyan -NoNewline "Privileges before: "
Write-Host -ForegroundColor Yellow "$beforeCount"
$backupPath = Join-Path (Get-Location) "role-$roleId-privileges-before.json"
$before | ConvertTo-Json -Depth 6 | Set-Content -Path $backupPath
Write-Host -ForegroundColor Cyan -NoNewline "Captured to:       "
Write-Host -ForegroundColor Yellow "$backupPath"

#################################################################################################################
# Replace with exactly the four the integration needs
#################################################################################################################
$wanted = @('prvReadEntity', 'prvReadAttribute', 'prvReadRelationship', 'prvReadOrganization')
$privileges = @()
foreach ($name in $wanted) {
    $p = Invoke-Dv GET "privileges?`$select=privilegeid,name&`$filter=name eq '$name'"
    if ($p.value.Count -ne 1) {
        Write-Host -ForegroundColor Red "Privilege '$name' did not resolve to exactly one row."
        exit 1
    }
    $privileges += @{ PrivilegeId = $p.value[0].privilegeid; Depth = 'Global' }
}

Invoke-Dv POST "roles($roleId)/Microsoft.Dynamics.CRM.ReplacePrivilegesRole" @{ Privileges = $privileges } | Out-Null
Write-Host -ForegroundColor Green "SUCCESS >>> Privileges replaced."

#################################################################################################################
# Read the role back, so the run ends on observed state
#################################################################################################################
$after = Invoke-Dv GET "RetrieveRolePrivilegesRole(RoleId=$roleId)"
$afterIds = @($after.RolePrivileges | ForEach-Object { $_.PrivilegeId })
Write-Host
Write-Host -ForegroundColor Cyan "Privileges now on the role ($($afterIds.Count)):"
foreach ($id in $afterIds) {
    $n = Invoke-Dv GET "privileges($id)?`$select=name"
    Write-Host -ForegroundColor Yellow "  $($n.name)"
}
Write-Host
Write-Host -ForegroundColor Cyan "Expected: the four above. Four SharePoint privileges may also appear if the"
Write-Host -ForegroundColor Cyan "environment uses server-based SharePoint document management - those are imposed"
Write-Host -ForegroundColor Cyan "by the platform, not requested here."

#################################################################################################################
# Assign to the application user
#################################################################################################################
$appUser = Invoke-Dv GET "systemusers?`$select=systemuserid,fullname,isdisabled&`$filter=applicationid eq $applicationId"
if ($appUser.value.Count -ne 1) {
    Write-Host
    Write-Host -ForegroundColor Red "No application user bound to $applicationId in this environment."
    Write-Host -ForegroundColor Red "Create it first (Power Platform admin centre > Users + permissions > Application users),"
    Write-Host -ForegroundColor Red "then re-run - the role above is already in place."
    exit 1
}
$userId = $appUser.value[0].systemuserid
Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Application user:  "
Write-Host -ForegroundColor Yellow "$($appUser.value[0].fullname) ($userId), disabled=$($appUser.value[0].isdisabled)"

$assigned = Invoke-Dv GET "systemusers($userId)/systemuserroles_association?`$select=roleid"
if (@($assigned.value | Where-Object { $_.roleid -eq $roleId }).Count -gt 0) {
    Write-Host -ForegroundColor Green "Role already assigned - nothing to do."
} else {
    Invoke-Dv POST "systemusers($userId)/systemuserroles_association/`$ref" @{ '@odata.id' = "$apiRoot/roles($roleId)" } | Out-Null
    Write-Host -ForegroundColor Green "SUCCESS >>> Role assigned to the application user."
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Role id:   "
Write-Host -ForegroundColor Yellow "$roleId"
Write-Host -ForegroundColor Cyan -NoNewline "Undo:      "
Write-Host -ForegroundColor Yellow "restore from $backupPath via ReplacePrivilegesRole, or delete the role"
```

### add-site-permission-for-app.ps1

Used in [Step 5b](#5b--grant-the-bookingplatform-mgmt-api-application-access-to-that-one-site). Grants an
application access to a single SharePoint site, which is what `Sites.Selected` needs before it reaches
any site at all.

Save the following as `add-site-permission-for-app.ps1`:

```powershell
param (
    [Parameter(Mandatory = $true, HelpMessage = "Entra tenant id in which to record the permission (the consuming/bank tenant).")]
    [guid]$tenantId,

    [Parameter(Mandatory = $true, HelpMessage = "SharePoint host name, e.g. 'bank.sharepoint.com' - bare host, no scheme or path.")]
    [string]$siteHostname,

    [Parameter(Mandatory = $true, HelpMessage = "Server-relative site path, e.g. '/sites/decks'.")]
    [string]$sitePath,

    [Parameter(Mandatory = $true, HelpMessage = "AppId (client id) of the application receiving access to the site.")]
    [guid]$clientAppId,

    [Parameter(HelpMessage = "Role to grant on the site. Default: write.")]
    [ValidateSet('read', 'write')]
    [string]$role = 'write'
)

# Grants an application access to ONE SharePoint site (a site permission), which is
# what the delegated/application Sites.Selected scope needs before it reaches any
# site at all. Sites.Selected on its own grants nothing; this is the second half.
#
# Idempotent: an application already holding the requested role on the site is left
# alone. An application holding a DIFFERENT role is reported rather than silently
# changed - dropping someone from write to read (or the reverse) is not a decision
# this script should make on its own.
#
# To undo, use the command printed under "Undo:" at the end of the run. Deleting the
# site permission is the correct way to revoke this access: removing or reinstalling
# the enterprise application does NOT, because a site permission identifies the
# application by client id rather than by service-principal object id, so a recreated
# principal inherits it.
#
# Run by an admin of the target tenant. Recording a site permission requires
# Sites.FullControl.All, which in practice means SharePoint Administrator or Global
# Administrator.
#
# Signing in consents the Microsoft first-party app "Microsoft Graph Command Line
# Tools" to the scope below, which leaves a tenant-wide grant for that app behind
# after this script exits. Revoke it under Enterprise applications > Microsoft Graph
# Command Line Tools > Permissions if tenant policy disallows standing admin-tooling
# consent.

#Requires -Modules Microsoft.Graph.Authentication, Microsoft.Graph.Sites

## To run the cmdlets in this script, you need the Microsoft Graph module installed.
# Install-Module Microsoft.Graph -Scope CurrentUser -Repository PSGallery -Force

Import-Module Microsoft.Graph.Authentication
Import-Module Microsoft.Graph.Sites

# ContextScope Process keeps the token cache in memory, so no bank-tenant Graph
# context outlives the run. The resulting context is then asserted against $tenantId:
# a cancelled or expired sign-in can otherwise leave an earlier tenant's context live,
# and this script writes a permission into whichever tenant it is connected to.
Connect-MgGraph -TenantId $tenantId -Scopes "Sites.FullControl.All" -ContextScope Process -NoWelcome -ErrorAction Stop

$context = Get-MgContext
if ($null -eq $context -or [guid]$context.TenantId -ne $tenantId) {
    Write-Host -ForegroundColor Red "Signed in to tenant '$($context.TenantId)', expected '$tenantId'."
    Write-Host -ForegroundColor Red "Sign in as an admin of the target tenant and re-run."
    exit 1
}

#################################################################################################################
# Resolve the site
#################################################################################################################
# Graph addresses a site as "{hostname}:{server-relative-path}". A ':' inside the path
# would split that address early and silently resolve a different site, so the path is
# rejected rather than normalised.
$trimmedPath = $sitePath.TrimEnd('/')
if (-not $trimmedPath.StartsWith('/') -or $trimmedPath.IndexOfAny(@(':', '#', '%', '?', ';')) -ge 0) {
    Write-Host -ForegroundColor Red "sitePath must be server-relative, start with '/', and contain none of : # % ? ;"
    exit 1
}

$siteAddress = "$($siteHostname):$trimmedPath"
$site = Get-MgSite -SiteId $siteAddress -ErrorAction SilentlyContinue
if ($null -eq $site) {
    Write-Host -ForegroundColor Red "No SharePoint site at '$siteAddress' in tenant $tenantId."
    Write-Host -ForegroundColor Red "Check the host name and the server-relative path, and that the site exists."
    exit 1
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Tenant:   "
Write-Host -ForegroundColor Yellow "$tenantId"
Write-Host -ForegroundColor Cyan -NoNewline "Site:     "
Write-Host -ForegroundColor Yellow "$($site.DisplayName) ($($site.WebUrl))"
Write-Host -ForegroundColor Cyan -NoNewline "App:      "
Write-Host -ForegroundColor Yellow "$clientAppId"
Write-Host -ForegroundColor Cyan -NoNewline "Role:     "
Write-Host -ForegroundColor Yellow "$role"
Write-Host

#################################################################################################################
# Upsert the site permission
#################################################################################################################
# A site carries at most one permission entry per application, so an existing entry is
# matched on the application's client id rather than created alongside.
$existing = Get-MgSitePermission -SiteId $site.Id -All -ErrorAction Stop |
    Where-Object { $_.GrantedToIdentitiesV2.Application.Id -contains $clientAppId.ToString() }

if ($null -ne $existing) {
    $currentRoles = @($existing.Roles)
    if ($currentRoles -contains $role) {
        Write-Host -ForegroundColor Green "Already granted '$role' - nothing to do."
        $permissionId = $existing.Id
        $undo = "Remove-MgSitePermission -SiteId '$($site.Id)' -PermissionId $permissionId"
    } else {
        Write-Host -ForegroundColor Yellow "The application already holds a different role on this site: $($currentRoles -join ', ')."
        Write-Host -ForegroundColor Yellow "Permission id: $($existing.Id)"
        Write-Host -ForegroundColor Yellow "Change it deliberately with Update-MgSitePermission, or remove it and re-run."
        Disconnect-MgGraph | Out-Null
        exit 1
    }
} else {
    $body = @{
        roles = @($role)
        grantedToIdentities = @(
            @{ application = @{ id = $clientAppId.ToString() } }
        )
    }
    $new = New-MgSitePermission -SiteId $site.Id -BodyParameter $body -ErrorAction Stop
    if ($null -eq $new -or [string]::IsNullOrWhiteSpace($new.Id)) {
        Write-Host -ForegroundColor Red "The create call returned no permission id, so no permission was written."
        Write-Host -ForegroundColor Red "Check the state with Get-MgSitePermission before re-running."
        exit 1
    }
    $permissionId = $new.Id
    Write-Host -ForegroundColor Green "SUCCESS >>> Site permission created."
    $undo = "Remove-MgSitePermission -SiteId '$($site.Id)' -PermissionId $permissionId"
}

#################################################################################################################
# Read back what the site now carries, so the run ends on observed state
#################################################################################################################
Write-Host
Write-Host -ForegroundColor Cyan "Permissions now on this site:"
Get-MgSitePermission -SiteId $site.Id -All -ErrorAction Stop | ForEach-Object {
    $apps = @($_.GrantedToIdentitiesV2.Application | Where-Object { $_ } | ForEach-Object { "$($_.DisplayName) ($($_.Id))" })
    Write-Host -ForegroundColor Yellow "  $($_.Id)  roles=$($_.Roles -join ',')  $($apps -join '; ')"
}

Write-Host
Write-Host -ForegroundColor Cyan -NoNewline "Site id:  "
Write-Host -ForegroundColor Yellow "$($site.Id)"
Write-Host -ForegroundColor Cyan -NoNewline "Perm id:  "
Write-Host -ForegroundColor Yellow "$permissionId"
Write-Host -ForegroundColor Cyan -NoNewline "Undo:     "
Write-Host -ForegroundColor Yellow $undo

Disconnect-MgGraph | Out-Null
```

## Related

- [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration) — the architecture behind this configuration
- [Identity]({{ site.baseurl }}/foundation/identity/) — the app registration and admin consent model in full
