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
- Someone who knows your Dataverse schema.

## The order things happen in

Steps 1 to 5 are yours and can largely run in parallel. Steps 6 and 7 are also yours, but happen in the
Engage Management Portal and only work once &money has registered your organisation:

```text
You:      Steps 1-5   Entra, Dataverse, SharePoint
              |
&money:   registers your organisation, links your tenant, enables Present
              |
You:      Steps 6-7   Management Portal: choose environment, set SharePoint destination
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

| Application | Written in this guide as | Test | Production |
|---|---|---|---|
| AndMoney Present UI | `{PresentUiAppClientId}` | `ea486ddc-1a1e-4837-967b-f975fdcf1ed7` | `cbac67da-6529-4411-821c-746888abee84` |
| AndMoney Management UI | `{ManagementUiAppClientId}` | `8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b` | `261ae34b-4de9-4c4a-9d70-1df1c024c91e` |
| AndMoney API | `{AndMoneyApiAppClientId}` | `f100d6c7-bbee-405b-9231-7e1c05c4b944` | `642f0f04-31f9-4641-a1cb-793f31496bd3` |
| AndMoney Dynamics Access | `{DynamicsAccessAppClientId}` | *to be provided* | *to be provided* |

| Application | What it is | Used in |
|---|---|---|
| **AndMoney Present UI** | The sign-in surface your **advisors** use to reach Present | Step 1 |
| **AndMoney Management UI** | The sign-in surface your **administrators** use to reach the Management Portal | Step 1 |
| **AndMoney API** | The API behind both, carrying the app roles | Steps 1, 2, 3, 5b |
| **AndMoney Dynamics Access** | The application identity that reads your Dataverse schema | Steps 1, 4 |

{: .note }
> **The two sign-in surfaces are separate applications and both are required.** Approving only one
> leaves either your advisors or your administrators locked out, and it shows at first use rather than
> at consent.

Your own tenant ID is written below as `{YourTenantId}`.

## Step 1 — Approve the Engage applications

Engage publishes its applications as multi-tenant apps; you approve them rather than creating any.
Approving creates a **service principal** in your directory, which is what lets each application
authenticate against your tenant.

All four are required. Open each link as an administrator:

```text
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={PresentUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={ManagementUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={AndMoneyApiAppClientId}
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
> as in [Step 5b](#4-to-revoke-later).

## Step 2 — Assign people to roles

Open the **AndMoney API** enterprise application → **Users and groups**, and assign your security
groups or users to the roles they need:

| Role | What it grants |
|---|---|
| `Admin` | Everything a Configurator can do, plus logs — **and the Management Portal screens in Steps 6 and 7** |
| `Configurator` | Meeting and portal configuration, field mappings, presentation templates |
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

Two delegated permissions, both recorded against the **AndMoney API** service principal in your tenant.
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
  -clientAppId {AndMoneyApiAppClientId}

# Microsoft Graph - for SharePoint
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId      {YourTenantId} `
  -clientAppId   {AndMoneyApiAppClientId} `
  -resourceAppId 00000003-0000-0000-c000-000000000000 `
  -scope         Sites.Selected
```

**Application Administrator** is sufficient; Global Administrator is not needed. Both take effect within
seconds.

- **It is idempotent**, but allow a few seconds between the two runs — Microsoft's read of the
  permission list lags writes, and an immediate second run can attempt a duplicate.
- **It prints an Undo command each time. Keep both.** Deleting the permission record by hand would
  revoke every other delegated permission that application holds in your tenant.

## Step 4 — Create the application user in Dataverse

The application identity needs a Dataverse user in your environment, bound to the **AndMoney Dynamics
Access** client ID.

1. **Power Platform admin centre → Environments → {your environment} → Settings → Users + permissions
   → Application users → New app user.**
2. Select the application by its client ID — `{DynamicsAccessAppClientId}` — and choose a business unit.
3. Create a **custom security role** and assign it — then trim it. Dataverse has no empty role: a new
   custom role arrives carrying around 80 privileges, and *Copy role* clones an equally large one.
   See [Trimming the new role](#trimming-the-new-role), which is not an optional tidy-up.

### The exact privileges

Four, and nothing else:

| Group in the role editor | Privilege | Level |
|---|---|---|
| Business Management | **Organization** | Read — Organization |
| Customization | **Entity** | Read |
| Customization | **Attribute** | Read |
| Customization | **Relationship** | Read |

- **Organization** — the Dataverse client's connection handshake. Without it the integration fails when
  it connects, before it reads anything.
- **Entity, Attribute, Relationship** — reading your schema. These are metadata reads: they expose the
  *shape* of your data, not its contents.

Privileges that look like they belong here and do **not**: *User*, *Option Set* (Engage reads an
attribute's type but never its option values), *Business Unit* and *User Settings*. All are in the
default set and all can go.

{: .important }
> **No access to customer records is required, and none should be granted.** No `account`, `contact`,
> `appointment` or `annotation` privileges belong on this role. All record work runs as the advisor
> under their own role. If Engage ever appears to need record privileges here, ask &money before
> granting them.

### Trimming the new role

The privileges a new role starts with are not a safe default. They include, at organization level, the
ability to **create and activate workflows**, **create, change and delete business process flows**, and
**write SharePoint document data** — none of which this integration uses.

Reducing it in the role editor means setting roughly eighty privileges back to none with no way to
confirm the result. Two Dataverse Web API calls do the same thing and can be verified:

```
POST {EnvironmentUrl}/api/data/v9.2/roles({roleid})/Microsoft.Dynamics.CRM.ReplacePrivilegesRole
{"Privileges": [{"PrivilegeId": "...", "Depth": "Global"}, ...]}

GET  {EnvironmentUrl}/api/data/v9.2/RetrieveRolePrivilegesRole(RoleId={roleid})
```

Resolve each privilege id by name first — `GET /api/data/v9.2/privileges?$filter=name eq 'prvReadEntity'`
— for `prvReadEntity`, `prvReadAttribute`, `prvReadRelationship` and `prvReadOrganization`. The second call reads the role back. Capture the original set before you replace
it; restoring is the same call with the captured list.

{: .note }
> **Four SharePoint privileges will reappear and that is expected.** Because your environment has
> server-based SharePoint document management enabled, Dataverse attaches `prvReadSharePointDocument`,
> `prvReadSharePointData`, `prvCreateSharePointData` and `prvWriteSharePointData` to the role. Deleting
> them only lasts until the role is next saved in the editor. They are imposed by the platform, not
> requested by Engage, and govern Dataverse's own document-location records rather than the contents of
> your SharePoint sites. A correctly trimmed role therefore shows **eight** privileges: the four above
> plus those four.

If a step fails with a privilege error, send the error to &money rather than broadening the role.

**Verify:** the application user can call `{EnvironmentUrl}/api/data/v9.2/WhoAmI` and receives a
`UserId`. Confirm the user shows as **Enabled**.

## Step 5 — Prepare the SharePoint site and grant access to it

### 5a — Create or nominate the site

Create or nominate a site and add the advisors who will use Present as members. Note the **host name**,
the **server-relative site path**, and the **document library** if it should not be the site's default —
for example `bank.sharepoint.com`, `/sites/decks`, default library. You enter these yourself in Step 7.

Site paths containing `:`, `#`, `%`, `?` or `;` cannot be used; they collide with the way Microsoft
Graph addresses sites.

### 5b — Grant the AndMoney API application access to that one site

`Sites.Selected` from Step 3 reaches no site until that site is named explicitly — which is why Engage
cannot reach any other SharePoint site in your tenant. The permission goes to the same application you
granted `Sites.Selected` to: **AndMoney API** (`{AndMoneyApiAppClientId}`), not the Dynamics one.

These calls require `Sites.FullControl.All`, which is why they are yours to run.
[Graph Explorer](https://developer.microsoft.com/graph/graph-explorer) is the easiest place; any Graph
client works.

#### 1. Find the site ID

```http
GET https://graph.microsoft.com/v1.0/sites/{hostname}:{site-path}
```

For the 5a example: `.../sites/bank.sharepoint.com:/sites/decks`.

The response's `id` is a composite of three comma-separated parts — `bank.sharepoint.com,8f9c…,3a21…`.
Use the whole string, commas included, as `{siteId}`.

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

**`write`, not `fullcontrol`.** Engage writes and reads deck files; `fullcontrol` would let it change
permissions, including its own.

**Record the `id` returned in the response** — it identifies this permission and is what you need to
revoke it. It is not the application ID.

#### 3. Verify

```http
GET https://graph.microsoft.com/v1.0/sites/{siteId}/permissions
```

Confirm that `{AndMoneyApiAppClientId}` is listed with the `write` role. The response is a collection
and may legitimately contain permissions for other applications of your own — those are not a problem,
and the check is that ours is present and correct, not that it is alone. Keep the listing for your audit
record: it is the complete statement of what Engage can reach in your SharePoint.

#### 4. To revoke, later

```http
DELETE https://graph.microsoft.com/v1.0/sites/{siteId}/permissions/{permissionId}
```

Access stops immediately. Present will fail to save decks; nothing else is affected.

{: .note }
> PnP PowerShell offers equivalent cmdlets. The Graph calls above are the underlying operation either
> way, and are what the verification should be read against.

### 5c — Housekeeping

Pruning old decks is yours to run on whatever schedule suits you. Engage does not archive or prune, and
tolerates files being removed.

---

{: .important }
> **Steps 6 and 7 need &money to have registered your organisation first.** Confirm with your &money
> contact before starting them. Both require the `Admin` role from Step 2.

## Step 6 — Select your Dynamics environment

Engage does not hardcode your environment URL. You choose it, and Engage lists the options by asking
Microsoft which Dataverse environments **you** can see — so sign in as someone with access to the
intended environment.

1. Sign in to the Management Portal with an account holding the `Admin` role.
2. Go to **Admin → CRM**.
3. Choose the environment — the sandbox during the integration phase, production at go-live.
4. Save.

{: .note }
> *Screenshots pending: the Admin → CRM screen, the environment list, and the saved state.*

- **The list shows only environments your signed-in account can reach.** A short or empty list is a
  statement about your own access, not a fault in Engage.
- **Changing the environment later is possible but not free.** Configured CRM users and field mappings
  do not follow the move, and the Portal warns you. Plan the sandbox-to-production switch with your
  &money contact.

## Step 7 — Configure your SharePoint destination

Using the values from Step 5a:

1. In the Management Portal, go to **Admin → Microsoft → SharePoint**.
2. Add a destination with:

| Field | Value | Rule |
|---|---|---|
| Key | **`present`** | Must be exactly this — see below |
| Site hostname | `bank.sharepoint.com` | A bare host name — no `https://`, no path, no port |
| Site path | `/sites/decks` | Server-relative, starting with `/`, containing none of `: # % ? ;` |
| Document library | *(leave empty)* | Empty selects the site's default document library |

{: .warning }
> **The key must be exactly `present`** — lower-case, no spaces. It is not a label you choose. Present
> selects its destination by this key. A destination saved under any other name fails at the upload step
> with a destination-not-found error rather than anything that mentions naming.

{: .note }
> *Screenshots pending: the Microsoft → SharePoint screen, the add-destination dialog, and a saved
> destination.*

{: .warning }
> **There is no default destination.** Until one exists here, Present cannot write to SharePoint at all.
> Saving a destination does not grant access — the per-site permission from Step 5b does that, and the
> two are checked at different moments. If a deck fails to save, confirm both.

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

## Related

- [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration) — the architecture behind this configuration
- [Identity]({{ site.baseurl }}/foundation/identity/) — the app registration and admin consent model in full
- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) — how tables and columns are mapped
