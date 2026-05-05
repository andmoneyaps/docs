---
layout: default
title: Salesforce App Security Policies — Post-Install
nav_order: 14
parent: BookMe
---

# Salesforce App Security Policies — Post-Install Configuration

After installing or upgrading the **BookMe** managed package — and during onboarding for **Present** — your Salesforce admin must configure security policies on up to three Salesforce apps used by the andmoney integration:

| App | Type | Used by |
|---|---|---|
| **BookMe External Client App** | External Client App (ECA) | BookMe CRM integration |
| **AMB_INTEGRATION** | Connected App | BookMe meeting/attendee sync |
| **PresentBackendConnected** | Connected App | Present (only customers using Present need this section) |

These policies are not part of the managed package — Salesforce treats them as subscriber policies, so each customer org configures them independently. This is required to comply with Salesforce's AppExchange partner security mandate (deadline 11 May 2026).

## andmoney service egress IPs

All three apps need the same set of allowed IPs — the public IPs that the andmoney integration services use to reach your Salesforce org. These are not published here for security reasons; they will be supplied as part of your onboarding handoff. If you need them re-sent, ask your andmoney contact.

## 1. BookMe External Client App

The BookMe ECA ships with **PKCE** and **Refresh Token Rotation** already enabled in the new package version — no admin action needed for those.

### What you need to configure

| Setting | Required value |
|---|---|
| Client Credentials Flow | **Enabled**, with a dedicated integration user assigned as **Run As** |
| Idle Refresh Token TTL | **30 days or less** |
| Refresh Token IP Range Allow List | The andmoney IPs supplied during onboarding |

> **Note**: Client Credentials Flow is the OAuth flow the andmoney CRM integration uses to authenticate to your org. The flow is only allowed for the user you select as Run As — that user's permissions become the integration's permissions. Use the dedicated BookMe integration user, not a person's account.

### Steps

1. In Salesforce Setup, search for **External Client App Manager**.
2. Find **BookMe External Client App** in the list and click **Edit Policies**.
3. Open the **OAuth Policies** section.
4. Tick **Enable Client Credentials Flow** and select your dedicated BookMe integration user under **Run As**.
5. Set **Idle Refresh Token TTL** to `30` days (or lower).
6. Under **Refresh Token IP Range Allow List**, add one entry per andmoney service egress IP (supplied during onboarding). Use the same IP for both Start and End to add a single address.
7. Save.

## 2. AMB_INTEGRATION Connected App

This Connected App is created in your org during BookMe onboarding (not via the managed package). It's used by the andmoney meeting sync service via the JWT Bearer flow.

### What you need to configure

| Setting | Required value | Notes |
|---|---|---|
| Permitted Users | **Admin approved users are pre-authorized** | Restricts who can use the app |
| IP Relaxation | **Enforce IP restrictions** | Required for the IP allow list to take effect |
| Trusted IP Range / Login IP Ranges | The andmoney IPs supplied during onboarding | Same list as the ECA section |
| Refresh Token Policy | Refresh token is valid for 30 days or less | Mostly informational — JWT Bearer flow doesn't issue refresh tokens, but Salesforce requires the policy to be set |

### Steps

1. In Salesforce Setup, search for **Manage Connected Apps**.
2. Click **AMB_INTEGRATION**.
3. Click **Edit Policies**.
4. Under **OAuth Policies**, set Permitted Users and IP Relaxation as above.
5. Under **Trusted IP Ranges** (or **Login IP Ranges** depending on your org), add one entry per andmoney IP (supplied during onboarding). Use the same IP for both Start and End.
6. Set **Refresh Token Policy** to expire after 30 days of inactivity.
7. Save.

## 3. PresentBackendConnected Connected App

**Skip this section if your org does not use Present.**

This Connected App is created in your org during Present onboarding. It's used by the andmoney Present service via the JWT Bearer flow.

### What you need to configure

The same settings as AMB_INTEGRATION above — Permitted Users (Admin approved), IP Relaxation (Enforce), Trusted IP Range (the andmoney IPs supplied during onboarding), and Refresh Token Policy (≤30 days).

### Steps

Identical to AMB_INTEGRATION, but click **PresentBackendConnected** in the Manage Connected Apps list.

## Verifying the configuration

After saving, confirm each integration still works:

- **BookMe**: trigger a test booking through the BookMe portal and confirm a corresponding Event (and any configured related records) appears in your Salesforce org.
- **Present**: open a Present-enabled session and confirm meeting/attendee data flows as expected.

If an integration fails after these changes, the most common cause is a missing or mistyped IP range — double-check the values match exactly.

## Why these settings are not in the package

Salesforce's app architecture separates *developer settings* (packageable, e.g. PKCE and Refresh Token Rotation on the BookMe ECA) from *subscriber policies* (per-org, e.g. refresh-token validity, IP restrictions, permitted users). The Connected Apps `AMB_INTEGRATION` and `PresentBackendConnected` are not packaged at all — they're created in your org during onboarding — so all of their settings are subscriber-owned.

This split is documented by Salesforce in [Secure Your Org with External Client Apps](https://developer.salesforce.com/blogs/2025/01/secure-your-org-with-external-client-apps).
