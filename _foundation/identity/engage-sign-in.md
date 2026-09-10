---
layout: default
title: Engage Sign-In and Identity
nav_order: 3
parent: Identity
grand_parent: Foundation
---

# Engage Sign-In and Identity

Engage is the &money web application your staff and your customers reach at
`https://engage.andmoney.dk`. This page explains **how sign-in works**, **which
enterprise applications must be approved in Microsoft Entra**, and **which
callback (redirect) URLs** the platform uses.

{: .note }
> &money owns and manages all the enterprise applications described here. You do
> not create app registrations on your side — you only grant admin consent so
> that your people can sign in. See
> [Approving Engage in Your Microsoft Entra]({{ site.baseurl }}/foundation/identity/engage-admin-consent/)
> for the one-time approval walkthrough.

---

## The three sign-in paths

Engage supports three distinct identity paths, depending on who is signing in:

| Who | How they sign in | Where it runs |
|---|---|---|
| **Your staff** (Management Portal) | Their normal Microsoft work account (Microsoft Entra) | In the browser |
| **Your customers** (Customer Portal) | Either **Microsoft Entra SSO** or **MitID**, depending on how the portal is configured | On the Engage server (back-end for front-end) |
| **System-to-system** | OAuth service tokens (client credentials) | Back-end only — no user involved |

---

## Enterprise applications to approve

All the applications below are published by &money as multi-tenant apps in the
&money Entra tenant. Approving one grants **admin consent** in your tenant; it
does not copy any secret or password to &money.

### 1. Engage — staff sign-in (requires admin consent)

This is the application your colleagues sign in to. Approving it lets Microsoft
sign your staff in with their normal work account and lets Engage act on their
behalf while they are signed in.

- **Approval:** one-time admin consent, performed by a *Cloud Application
  Administrator* or *Application Administrator*.
- **Client ID:** `cbac67da-6529-4411-821c-746888abee84`
- After approval, an entry named **Engage** appears under **Enterprise
  applications** in your Entra admin center.

See the [step-by-step walkthrough]({{ site.baseurl }}/foundation/identity/engage-admin-consent/).

### 2. Customer Portal SSO — Microsoft Entra (shared app)

For customer portals configured to authenticate with **Microsoft Entra**, a
**single, shared** &money Entra application handles the sign-in for *all* such
portals — there is no separate registration per portal.

- Requests only the `openid` and `profile` scopes (used to identify the signed-in
  user; no mailbox, files, or directory access).
- Requires admin consent in the customer's tenant, the same as the Engage app
  above.

{: .note }
> If a customer portal uses **MitID** instead of Microsoft Entra, there is
> nothing to approve in Entra — MitID is a separate identity provider configured
> per portal by &money.

### 3. Bank System Integration — service tokens (per customer)

For back-end, system-to-system calls, each bank customer has its own single-tenant
application in the &money tenant that uses the OAuth **client-credentials** flow.
No user is involved, and the bank identity is derived from the token itself.

{: .warning }
> Client secrets for these integrations **expire after two years** and must be
> rotated before they lapse. &money coordinates rotation with you in advance.
> See [Microsoft Entra Integration]({{ site.baseurl }}/foundation/identity/entra-integration/#security-considerations).

---

## How it works

### Staff sign-in (Microsoft Entra)

1. A staff member opens Engage. They are redirected to Microsoft to sign in with
   their normal work account.
2. Engage runs entirely in the browser as a single-page application. After a
   successful sign-in, Microsoft returns the user to a dedicated callback route,
   and Engage sends them on to the page they were originally heading to.
3. No password or secret is ever shared with &money.

### Customer portal sign-in

1. A customer opens a portal link. The Engage server starts the sign-in with the
   provider configured for that portal — **Microsoft Entra** or **MitID**.
2. The provider returns the customer to a single, fixed callback URL. The Engage
   server completes the exchange and establishes the session.
3. The portal's identity travels in a secure, short-lived login cookie — **not**
   in the URL — so the same callback URL serves every portal.

### System-to-system

The Engage back-end mints short-lived service tokens using the client-credentials
flow and attaches them when calling platform APIs. The customer (bank) identity is
resolved from the token, so no per-request configuration is needed.

---

## Callback (redirect) URL patterns

Microsoft Entra requires every redirect (reply) URL to be **registered exactly**.
Wildcards and query strings are **not supported**. Because of this, Engage uses a
small, fixed set of canonical callback paths rather than per-portal or per-user
URLs.

| Purpose | URL pattern | Notes |
|---|---|---|
| Staff sign-in callback | `https://<engage-origin>/auth/aad/callback` | Single-page application (SPA) redirect URI. Exact match — no wildcards, no query strings. |
| Customer portal callback | `https://<engage-origin>/api/auth/callback` | "Web" reply URL. **One per environment**, not one per portal — the portal id travels in a secure cookie. |

`<engage-origin>` is the address of your Engage environment — for production this
is `https://engage.andmoney.dk`.

{: .important }
> After sign-in, Engage only ever returns a user to a **same-origin path inside
> Engage**. Any external or cross-origin return address is ignored and replaced
> with the Engage home page. This prevents open-redirect attacks.

### Common errors

| Message | What it usually means |
|---|---|
| `AADSTS50011` — redirect URI mismatch | The callback URL above is not registered on the app registration for this environment. |
| `AADSTS900144` — missing `client_id` | The sign-in request was incomplete — usually a configuration issue on the Engage side. |
| "Sorry, but we're having trouble signing you in" *after* admin consent | Expected — the admin-consent link is not a normal sign-in page. The approval still succeeds. |

If you hit any of these, contact your &money representative.

---

## Related

- [Approving Engage in Your Microsoft Entra]({{ site.baseurl }}/foundation/identity/engage-admin-consent/) — the one-time admin-consent walkthrough.
- [Microsoft Entra Integration]({{ site.baseurl }}/foundation/identity/entra-integration/) — the full app-registration and token architecture.
- [App Registration Installation]({{ site.baseurl }}/foundation/identity/app-registration-installation/) — installing the Engage-owned registrations into your tenant.
- [Integration Onboarding]({{ site.baseurl }}/foundation/integration-onboarding/#2-identity-and-portal-authentication) — section 2 covers all three identity paths in architectural detail.
