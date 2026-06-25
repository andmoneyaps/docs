---
layout: default
title: Salesforce Connection Setup
nav_order: 10
parent: Onboarding
grand_parent: BookMe
---

# Salesforce Connection Setup

## Overview

This guide describes how to establish a secure connection between BookMe and your Salesforce organization through the Management UI. The automated provisioning process creates the authentication providers, named credentials, and remote site settings for you — no manual metadata editing required.

## How the connection works

BookMe authenticates to your Salesforce org as a dedicated **integration (run-as) user**, through the **BookMe External Client App** using OAuth 2.0 (Client Credentials flow).

A one-time **Provision** step (run from the Management UI) creates the Salesforce-side authentication infrastructure so your org can call the BookMe backend:

- an **Auth Provider** (`BookingAuthProvider`)
- a **Named Credential** (`BookingEngine`)
- **Remote Site Settings** (`BookingEngine`, `BookingMiddleware`)
- a **Custom Metadata** record holding the connection settings

Because provisioning *creates Salesforce setup records*, it runs with the **integration user's permissions** — so that user temporarily needs setup-level permissions during provisioning (see [The integration user and its permissions](#the-integration-user-and-its-permissions)).

## Prerequisites

- BookMe managed package installed in your Salesforce org (the External Client App connection flow requires a recent package version — check with &money if unsure).
- Administrator access to **both** Salesforce and the BookMe Management UI.
- An integration user account in Salesforce. A dedicated service account is recommended.

## The integration user and its permissions

The integration user has **two distinct permission needs**. They are easy to confuse — and getting them wrong is the most common cause of provisioning failures.

### 1. Runtime permissions (ongoing) — keep these assigned

For day-to-day operation (reading and writing meetings, contacts, etc.), assign the **`BookingPlatformIntegration`** permission set that ships with the BookMe package. It grants the object/field access BookMe needs plus **API Enabled**.

> The `BookingPlatformIntegration` permission set is intentionally least-privilege: it grants **data access only**. It does **not** include the setup permissions required to provision the connection (see below). Assigning it alone is **not** enough to run the Provision step.

### 2. Provisioning permissions (one-time) — needed only to connect

The Provision and Verify steps create and read Salesforce **setup** objects, so the integration user must additionally have:

- **Manage Auth. Providers**
- **Manage Named Credentials**
- **Manage Certificates**
- **Modify Metadata Through Metadata API Functions**
- **API Enabled**

Because *Manage Auth. Providers* depends on a broad set of administrative permissions, the **simplest reliable option is to give the integration user a System Administrator profile** while you set up the connection.

> **These permissions are needed only for provisioning and verification — not for runtime.** If your security policy prefers least privilege, you may **remove them again after the connection is established and verified**. Re-grant them only if you need to re-provision (for example, after a credential rotation).

**Verify the integration user has the provisioning permissions** (run as that user, or have an admin run it in the user's context):

```sql
SELECT PermissionsManageAuthProviders, PermissionsManageNamedCredentials,
       PermissionsManageCertificates, PermissionsModifyMetadata, PermissionsApiEnabled
FROM UserPermissionAccess
```

All five must return `true`.

## Connection setup process

### Step 1: Configure the BookMe External Client App in Salesforce

The BookMe package includes an External Client App that enables secure communication between BookMe and Salesforce.

1. In Salesforce Setup, open **External Client App Manager**.
2. Find **`BookMe External Client App`** in the list.
3. Click **Edit Policies**.
4. In the **OAuth Policies** section:
   - Enable **Client Credentials Flow**.
   - Set the **Run As** user to your integration user.

![External Client App]({{ site.baseurl }}/assets/images/external-client-app.png)

{: .warning }
> **Make sure the run-as user is correctly permissioned before continuing.** See [The integration user and its permissions](#the-integration-user-and-its-permissions) — it needs the runtime permission set **and** (for this setup) the provisioning permissions.

### Step 2: Configure your Salesforce domain in the Management UI

1. In the BookMe Management UI, go to **Admin → CRM → Configuration**.
2. In the Salesforce section, enter your Salesforce **domain** (subdomain only, e.g. `yourcompany`). The system formats it as `https://yourcompany.my.salesforce.com`.
3. **Save** the configuration.

![CRM Configuration]({{ site.baseurl }}/assets/images/mgmt-ui-crm-configuration.png)

{: .note }
> Only users with the &money admin role can edit the domain name. If the field is read-only, contact the service desk for assistance.

### Step 3: Test the connection

Before provisioning, confirm BookMe can reach your Salesforce org and obtain a token.

1. In the **Test CRM connection** section, click **Test**.
2. A successful test shows a green success message.
3. If the test fails, verify:
   - the domain name is correct (subdomain only — no `https://` or `.my.salesforce.com`);
   - the External Client App has Client Credentials Flow enabled with the integration user set as run-as;
   - the integration user is **active** and has **API Enabled**.

### Step 4: Provision the connection

Once the test succeeds, create the Salesforce-side authentication infrastructure.

1. In the **Schedule connection** section, click **Provision**.
2. Provisioning automatically creates, in your Salesforce org:
   - Remote Site Settings (`BookingEngine`, `BookingMiddleware`)
   - the Auth Provider (`BookingAuthProvider`)
   - the Named Credential (`BookingEngine`)
   - the Custom Metadata record holding the connection settings
3. Watch the status indicator:
   - ✅ **Success** — connection established.
   - ⚠️ **Warning** — partial success or a configuration issue (often a missing permission — see [Troubleshooting](#troubleshooting)).
   - ❌ **Error** — provisioning failed (read the message).

{: .note }
> If the Provision button shows a warning about missing **backend** credentials, contact &money support to provision backend credentials for your organization.

> Using **Present** as well? Provision the Present connection from its own section once the Schedule connection succeeds.

### Step 5: Finish the Named Credential in Salesforce

1. In Salesforce, go to **Setup → Named Credentials** and open **`BookingEngine`**.
2. (Optional) Check **Start Authentication Flow on Save** and **Save** to force an immediate token, then confirm authentication completes.

When the Management UI status shows ✅ Success and authentication completes, your Salesforce org is connected to BookMe.

### After setup

If you tightened permissions for provisioning (for example, by temporarily using a System Administrator profile), you can now **remove the provisioning permissions** from the integration user and keep only the `BookingPlatformIntegration` permission set for runtime. See [The integration user and its permissions](#the-integration-user-and-its-permissions).

## Connection status indicators

The Management UI shows visual status indicators for the connection:

- ✅ **Green checkmark**: connection successful and active.
- ⚠️ **Yellow warning**: connection pending or requires attention.
- ❌ **Red error**: connection failed — check the error message for details.

## Troubleshooting

### Provisioning fails with a "not supported" or "No such column" error

This is the most common — and most misleading — provisioning error. When the integration user lacks a setup permission, Salesforce reports it as a **schema error rather than a permission error** — for example `sObject type 'AuthProvider' is not supported`, or a "No such column" error on an Auth Provider or Named Credential field.

These look like a missing object or field, but they actually mean the **integration (run-as) user can't see that setup object or field** — it is **missing a provisioning permission** (such as *Manage Auth. Providers*, *Manage Named Credentials*, or *Manage Certificates*).

**Fix:** grant the [provisioning permissions](#2-provisioning-permissions-one-time--needed-only-to-connect) to the integration user (or temporarily give it a System Administrator profile), then re-run Provision. Confirm with the `UserPermissionAccess` query above.

### Test connection fails

- **Possible causes:** incorrect domain name; External Client App not configured (Client Credentials Flow / run-as user); integration user inactive or missing **API Enabled**.
- **Fix:** verify the domain (subdomain only), the External Client App configuration, and the integration user's status and API access.

### Named Credential authentication fails

- **Cause:** the OAuth flow can't complete.
- **Fix:** confirm the Remote Site Settings were created, check the Auth Provider configuration, ensure the integration user is active, and try re-provisioning.

### "Missing Credentials" warning

- **Cause:** backend credentials are not yet configured for your organization.
- **Fix:** contact &money support to provision backend credentials.

## Security considerations

- All connections use OAuth 2.0 with the Client Credentials flow.
- Credentials are encrypted in transit and at rest; no passwords are stored or transmitted.
- Day-to-day access is governed by the integration user's runtime permission set (`BookingPlatformIntegration`).
- The elevated **provisioning permissions are required only during setup and can be removed afterward**, keeping the standing integration user least-privileged.
- All communication occurs over HTTPS.

## Next steps

Once the connection is established:

1. [Deploy the iframe LWC component]({{ site.baseurl }}/bookme/salesforce-iframe-lwc-deployment/) to enable embedded booking.
2. [Configure the component]({{ site.baseurl }}/bookme/salesforce-iframe-lwc/) for your use cases.
3. Push your customer types and meeting topics to Salesforce from **Admin → CRM → Configuration**.

## Support

If you encounter issues during setup:

- Check the Salesforce Setup Audit Trail for detailed logs.
- Review the Management UI status messages for connection errors.
- Contact &money support with your Salesforce org ID, the error message received, and the steps attempted.
