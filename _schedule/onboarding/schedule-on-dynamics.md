---
layout: default
title: Schedule on Dynamics 365
nav_order: 1
parent: Onboarding
grand_parent: Schedule
permalink: /schedule/onboarding/schedule-on-dynamics/
---

# Schedule on Dynamics 365

Configuring **Schedule** where your CRM is **Microsoft Dynamics 365**. Advisors book customer meetings
from a Dynamics account; the meeting lands in their Outlook calendar and as an appointment in Dynamics.

{: .important }
> Already onboarded to [Present on Dynamics 365]({{ site.baseurl }}/present/onboarding/present-on-dynamics/)?
> Steps 2, 3, 4a and 6 are already done. In Step 1, only AndMoney Graph Access is new.

## Who needs to be involved

| Role | Steps |
|---|---|
| Microsoft Entra administrator (*Application Administrator*) | 1, 2, 3, 5 |
| Dynamics 365 / Power Platform administrator | 4 |
| An Engage `Admin` from your organisation, with access to the Dynamics environment | 6, 7 |
| Dynamics customisation | 8 |

## Before you start

- Send your **tenant ID** to your &money contact.
- A Dynamics 365 environment on Dataverse Web API v9.2 — sandbox and production.
- Each advisor has the **same email address in Entra and in Dynamics**.

## The order things happen in

```text
You:      Steps 1-5   Entra, Dataverse, SCIM
              |
&money:   registers your organisation and enables Schedule
              |
You:      Steps 6-7   Management Portal
              |
You:      Step 8      embed Schedule in the Dynamics form
              |
Together: verification
```

Tell your &money contact when Steps 1 to 5 are done.

---

## Application IDs you will need

**Every step is performed once per environment**, using that environment's column.

<!-- TODO: AndMoney Graph Access does not exist yet. Fill in its client ids once provisioned. -->

| Application | Written as | Test | Production |
|---|---|---|---|
| AndMoney UWC | `{UwcAppClientId}` | `ea486ddc-1a1e-4837-967b-f975fdcf1ed7` | `cbac67da-6529-4411-821c-746888abee84` |
| BookingPlatform Mgmt UI | `{MgmtUiAppClientId}` | `8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b` | `261ae34b-4de9-4c4a-9d70-1df1c024c91e` |
| BookingPlatform Mgmt API | `{MgmtApiAppClientId}` | `f100d6c7-bbee-405b-9231-7e1c05c4b944` | `642f0f04-31f9-4641-a1cb-793f31496bd3` |
| AndMoney Dynamics Access | `{DynamicsAccessAppClientId}` | `de5dd77b-f082-4895-abe5-3f5f6020cba8` | `e9059d5a-7aeb-4f1a-a98d-7d8e1d4d23f3` |
| AndMoney Graph Access | `{GraphAccessAppClientId}` | *to follow* | *to follow* |

Your tenant ID is written as `{YourTenantId}`.

| Management Portal | URL |
|---|---|
| Test | `https://management.test-env.andmoney.dk` |
| Production | `https://management.andmoney.dk` |

## Step 1 — Approve the Engage applications

Open each link as an administrator and press **Accept**, in this order:

```text
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtApiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={MgmtUiAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={UwcAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={DynamicsAccessAppClientId}
https://login.microsoftonline.com/{YourTenantId}/adminconsent?client_id={GraphAccessAppClientId}
```

A "trouble signing you in" page afterwards is expected. Confirm all five appear under
**Enterprise applications**.

{: .note }
> If your policy requires it, you can limit AndMoney Graph Access to specific mailboxes with
> [Exchange RBAC for Applications](https://learn.microsoft.com/exchange/permissions-exo/application-rbac).

## Step 2 — Assign people to roles

In **Enterprise applications → BookingPlatform Mgmt API → Users and groups**, assign:

| Role | Who |
|---|---|
| `Admin` | At least one person with access to the Dynamics environment — needed for Steps 6 and 7 |
| `Configurator` | Meeting configuration |
| `Manager` | Service and competence groups |
| `Employee` | Every advisor who books |

## Step 3 — Authorise Engage to act as your advisors in Dynamics

This lets Engage read and write Dynamics records as the signed-in advisor, limited by their own
Dynamics security roles.

Run [`add-delegated-grant-to-service-principal.ps1`]({{ site.baseurl }}/foundation/scripts/dynamics/add-delegated-grant-to-service-principal/)
after installing [its modules]({{ site.baseurl }}/foundation/scripts/dynamics/add-delegated-grant-to-service-principal/#before-you-run-it):

```powershell
./add-delegated-grant-to-service-principal.ps1 `
  -tenantId    {YourTenantId} `
  -clientAppId {MgmtApiAppClientId}
```

Keep the **Undo** command it prints.

## Step 4 — Create the application user in Dataverse

### 4a — Create the application user

**Power Platform admin centre → Environments → {your environment} → Settings → Users + permissions →
Application users → New app user.** Select `{DynamicsAccessAppClientId}` and a business unit.

### 4b — Create and assign the security role

<!-- TODO: add the Schedule privilege set to the script and show the matching invocation here. -->

As a **System Administrator** of the environment, run
[`new-dataverse-role-for-app-user.ps1`]({{ site.baseurl }}/foundation/scripts/dynamics/new-dataverse-role-for-app-user/):

```powershell
az login --tenant {YourTenantId}

./new-dataverse-role-for-app-user.ps1 `
  -environmentUrl https://yourorg.crm4.dynamics.com `
  -applicationId  {DynamicsAccessAppClientId}
```

<!-- TODO: the record privileges are derived from the crm-integration code, not yet measured. Confirm
     them once attendee sync runs end to end on Dynamics, then drop the warning below. -->

{: .warning }
> **Work in progress.** The privileges below are provisional and subject to change.

The role ends up with these privileges, all at **Organization** level:

| Privilege | For |
|---|---|
| `prvReadEntity`, `prvReadAttribute`, `prvReadRelationship` | Reading your schema |
| `prvReadOrganization` | Connecting |
| `prvReadUser` | Matching advisors to their Dynamics users |
| `prvReadActivity` | Finding a booking's appointment |
| `prvReadContact` | Resolving customer attendees |
| `prvWriteActivity`, `prvAppendActivity`, `prvAppendToContact`, `prvAppendToUser` | Adding attendees to the appointment |

With server-based SharePoint document management, four `SharePoint` privileges are added by Dataverse
as well.

## Step 5 — Provision employees and rooms with SCIM

### 5a — Create the SCIM applications

Get your **SCIM token** from your &money contact, then run
[`enable-scim-provisioning.ps1`]({{ site.baseurl }}/foundation/scripts/scim/enable-scim-provisioning/) after installing
[its module]({{ site.baseurl }}/foundation/scripts/scim/enable-scim-provisioning/#before-you-run-it). It asks for the token:

```powershell
./enable-scim-provisioning.ps1 `
  -tenantId    {YourTenantId} `
  -environment test
```

Use `-environment prod` for production. The script creates the **Advisors** and **Rooms** applications,
sets their attribute mappings and starts provisioning. Keep the **Undo** commands it prints.

### 5b — Assign advisors and rooms

In **Enterprise applications**, assign your advisors to **AndMoney SCIM - Advisors** and your meeting
rooms to **AndMoney SCIM - Rooms**, under **Users and groups**. Only assigned users and rooms are
provisioned.

---

{: .important }
> Steps 6 and 7 need &money to have registered your organisation first.

## Step 6 — Connect your Dynamics environment

In the Management Portal, go to **Admin → CRM Settings**.

1. Select **Dynamics 365** and press **Continue**.

   ![Choosing the CRM system under Admin → CRM Settings]({{ site.baseurl }}/assets/images/foundation/dynamics/crm-settings-choose-system.png)

2. Choose the environment — the sandbox during the integration phase, production at go-live.

   ![Choosing the Dataverse environment]({{ site.baseurl }}/assets/images/foundation/dynamics/crm-settings-choose-environment.png)

3. Press **Test**. It should turn green.

## Step 7 — Configure Schedule

<!-- TODO: confirm the Management Portal screens once direct Graph access and the Dynamics schedule
     playbooks ship; add screenshots. -->

1. **Admin → Microsoft:** press **Test connection** with an advisor's address.
2. Set up meeting themes, customer types and advisors, as described in the super-user guides for
   [meeting setup]({{ site.baseurl }}/business-implementation/schedule/en/superbrugerguide-moedeopsaetning/),
   [employees]({{ site.baseurl }}/business-implementation/schedule/en/superbrugerguide-medarbejdere/) and
   [service groups]({{ site.baseurl }}/business-implementation/schedule/en/superbrugerguide-servicegrupper/).

## Step 8 — Embed Schedule in Dynamics

Add a **web resource or PCF component** to the **account** form that opens Schedule with these
parameters:

<!-- TODO: confirm the contract and URL once the advisor route accepts Dynamics parameters. -->

| Parameter | Value |
|---|---|
| `id` | The account record GUID |
| `typename` | `account` |
| `user_email` | The signed-in advisor's email — the login hint |
| `type`, `orgname`, `userlcid`, `orglcid` | Standard Dynamics values (optional) |

A standard IFRAME control cannot pass `user_email`, and advisors then get a sign-in pop-up every time.
A component built for Present's appointment form can be reused.

**Test the embedding** against the identity endpoint, which reports each parameter as pass or fail,
**then point it at Schedule**:

| Environment | Identity endpoint | Schedule |
|---|---|---|
| Test | `https://engage.test-env.andmoney.dk/identity` | `https://engage.test-env.andmoney.dk/advisor` |
| Production | `https://engage.andmoney.dk/identity` | `https://engage.andmoney.dk/advisor` |

## What &money does

- Issues your SCIM token (before Step 5).
- Registers your organisation and enables Schedule (before Step 6).

## Verifying it works

<!-- TODO: add screenshots once the Dynamics booking flow ships. -->

Use an advisor who has completed SCIM provisioning and has the `Employee` role.

1. **Book an online meeting.** Open an account in Dynamics, open Schedule, and book. Check that the
   meeting is in the advisor's Outlook calendar with a Teams link, and that Dynamics has an appointment
   with the account under **Regarding**.
2. **Book a physical meeting with a room.** Check that the room's calendar shows it.
3. **Move the meeting in Outlook.** Within a few minutes, the appointment in Dynamics shows the new time.

| If | Check |
|---|---|
| The advisor or room is missing in Schedule | Step 5 |
| The meeting is in Outlook but not in Dynamics | Step 3, and the advisor's Dynamics role |
| The new time from Outlook does not reach Dynamics | Step 4b |

## Scripts

The scripts used in this guide are kept on the [Scripts]({{ site.baseurl }}/foundation/scripts/) page, with download links and the
modules each one needs.

## Related

- [Present on Dynamics 365 and SharePoint]({{ site.baseurl }}/present/onboarding/present-on-dynamics/)
- [Integration Onboarding Guide]({{ site.baseurl }}/foundation/integration-onboarding/#5-dynamics-365-crm-integration)
- [SCIM Provisioning]({{ site.baseurl }}/foundation/scim/)
