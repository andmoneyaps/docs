---
layout: default
title: Salesforce Auth Migration
nav_order: 11
parent: BookMe
---

# Salesforce Auth Migration

This guide covers migrating your Salesforce org's BookMe connection from the old authentication model to the new model using External Credentials and Named Credentials with Microsoft Entra ID.

{: .note }
> The API base URL, token endpoint, and scope remain the same. Only the **client credentials** and the **Salesforce auth model** change.

## Prerequisites

- Administrator access to your Salesforce org
- New **Client ID** and **Client Secret** provided by &money (contact &money support if you haven't received these)
- The token endpoint and scope values listed below

## Migration Steps

### Step 1: Create an External Credential

1. In Salesforce, go to **Setup → Security → Named Credentials**
2. Click the **External Credentials** tab
3. Click **New**
4. Fill in the fields:

| Field | Value |
|-------|-------|
| **Label** | `BookMe Entra` |
| **Name** | `BookMe_Entra` |
| **Authentication Protocol** | `OAuth 2.0` |
| **Authentication Flow Type** | `Client Credentials with Client Secret` |
| **Identity Provider URL** | `https://login.microsoftonline.com/0ad7f8fb-5c30-4e65-bad7-febd7821a15b/oauth2/v2.0/token` |
| **Scope** | `https://andmoney.onmicrosoft.com/43312b1f-8606-439d-b4b4-4783c991d561/.default` |

5. Click **Save**

### Step 2: Create a Principal on the External Credential

1. On the External Credential you just created, scroll down to the **Principals** section
2. Click **New**
3. Fill in the fields:

| Field | Value |
|-------|-------|
| **Parameter Name** | `BookMeServicePrincipal` |
| **Sequence Number** | `1` |
| **Identity Type** | `Named Principal` |
| **Client ID** | The **Client ID** provided by &money |
| **Client Secret** | The **Client Secret** provided by &money |

4. Click **Save**

### Step 3: Assign the Principal to a Permission Set

Users who interact with BookMe need access to the External Credential Principal.

1. Go to **Setup → Users → Permission Sets**
2. Open the Permission Set used by your advisors (or create a new one)
3. Click **External Credential Principal Access**
4. Move **BookMe_Entra - BookMeServicePrincipal** from "Available" to "Enabled"
5. Click **Save**
6. Ensure the Permission Set is assigned to all relevant users (typically all advisors)

### Step 4: Create a New Named Credential

1. Go to **Setup → Security → Named Credentials**
2. On the **Named Credentials** tab, click **New**
3. Fill in the fields:

| Field | Value |
|-------|-------|
| **Label** | `BookingEngineNew` |
| **Name** | `BookingEngineNew` |
| **URL** | The same API base URL you are currently using |
| **Enabled for Callouts** | Checked |
| **External Credential** | Select `BookMe Entra` (created in Step 1) |
| **Allowed Namespaces** | `andmoney` |
| **Generate Authorization Header** | Checked |

4. Click **Save**

{: .important }
> **Allowed Namespaces** must include `andmoney` so the BookMe managed package can make API callouts using this Named Credential. If you are not currently using the managed package this is still required.

### Step 5: Verify the New Named Credential

Before cutting over, verify the new credential works. Run the following Apex in **Developer Console → Execute Anonymous**:

```apex
HttpRequest req = new HttpRequest();
req.setEndpoint('callout:BookingEngineNew/booking/taxonomies');
req.setMethod('GET');
Http http = new Http();
HttpResponse res = http.send(req);
System.debug('Status: ' + res.getStatusCode());
System.debug('Body: ' + res.getBody());
```

{: .note }
> The user running this must have the Permission Set from Step 3 assigned. A `200` response confirms everything is working.

### Step 6: Cut Over to the New Named Credential

Schedule a service window (off-hours recommended) for this step.

{: .warning }
> **This step activates the new auth method.** The BookMe package references the Named Credential by the name `BookingEngine`, so the rename is what makes the switch.

1. Rename the **old** Named Credential from `BookingEngine` to `BookingEngineOld`
2. Rename the **new** Named Credential from `BookingEngineNew` to `BookingEngine`

**Rollback:** If something goes wrong, reverse the rename — rename `BookingEngine` back to `BookingEngineNew` and `BookingEngineOld` back to `BookingEngine`. This immediately restores the old auth flow.

{: .note }
> Keep the old Named Credential (`BookingEngineOld`) for at least a few weeks to ensure a quick rollback path is available.

## Troubleshooting

### Apex test returns 401 Unauthorized
- Verify the Client ID and Client Secret on the Principal are correct
- Check that the External Credential has the correct token endpoint URL and scope
- Confirm "Generate Authorization Header" is checked on the Named Credential

### "No applicable principal found" error
- The External Credential Principal is not assigned to a Permission Set, or the Permission Set is not assigned to the user making the callout

### Managed package callouts fail after cutover
- Verify **Allowed Namespaces** on the Named Credential includes `andmoney`
- Confirm the Named Credential name is exactly `BookingEngine` (case-sensitive)

### Client secret expired
- Client secrets have an expiry date. Contact &money support to receive a new secret
- Update the secret on the Principal in your External Credential

## Support

If you encounter issues during migration:
- Contact &money support with:
  - The error message received
  - Which step you are on
