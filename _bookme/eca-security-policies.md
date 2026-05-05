---
layout: default
title: ECA Security Policies — Post-Install
nav_order: 14
parent: BookMe
---

# External Client App Security Policies — Post-Install Configuration

After installing or upgrading the **BookMe** managed package, your Salesforce admin must configure two security policies on the `BookMe External Client App` in your org. These policies are not part of the managed package — Salesforce treats them as subscriber policies, so each customer org configures them independently.

This is required to comply with Salesforce's AppExchange partner security mandate (deadline 11 May 2026).

## What's already configured by the package

The new package version ships with these enabled — no action needed:

- Proof Key for Code Exchange (PKCE)
- Refresh Token Rotation

## What you need to configure

| Setting | Required value |
|---|---|
| Idle Refresh Token TTL | **30 days or less** |
| Refresh Token IP Range Allow List | The andmoney service egress IPs (see below) |

## Steps

1. In Salesforce Setup, search for **External Client App Manager**.
2. Find **BookMe External Client App** in the list and click **Edit Policies**.
3. Open the **OAuth Policies** section.
4. Set **Idle Refresh Token TTL** to `30` days (or lower).
5. Under **Refresh Token IP Range Allow List**, add one entry per andmoney service egress IP listed below. Use the same IP for both Start and End to add a single address.
6. Save.

## andmoney service egress IPs to allow

These are the public IPs that the BookMe CRM integration service uses to reach your Salesforce org. Add all of them.

| Environment | IP address |
|---|---|
| andmoney production | `<TBD>` |
| andmoney test | `<TBD>` |

> **Note**: This list will be kept current at this URL. If andmoney migrates infrastructure, your admin will be notified ahead of time and asked to update the allow list.

## Verifying the configuration

After saving, you can confirm the integration still works by:

1. Triggering a test booking through the BookMe portal.
2. Confirming a corresponding Event (and any configured related records) appears in your Salesforce org.

If the integration fails after these changes, the most common cause is a missing IP range in step 5 — double-check the values match exactly.

## Why these settings are not in the package

Salesforce's External Client App architecture separates *developer settings* (packageable) from *subscriber policies* (per-org). PKCE and Refresh Token Rotation are developer settings; refresh-token validity windows and IP restrictions are subscriber policies that each org's admin owns.

This split is documented by Salesforce in [Secure Your Org with External Client Apps](https://developer.salesforce.com/blogs/2025/01/secure-your-org-with-external-client-apps).
