---
layout: default
title: Employee Identity Matching
parent: Embeddable UI
nav_order: 2.5
---

# Employee Identity Matching

The &money Portal component identifies the logged-in employee using two Salesforce user fields passed to the embedded application. These fields serve different purposes: one for authentication (SSO), and one for matching the employee to their booking platform profile.

---

## Fields passed from Salesforce

| Salesforce User Field | URL Parameter | Purpose |
|----------------------|---------------|---------|
| `FederationIdentifier` | `federation_id` | Primary login hint for SSO — used to silently authenticate the correct Entra ID user |
| `Email` | `user_email` | Fallback login hint for SSO, and the basis for employee pre-selection |

---

## Authentication (SSO)

The component uses the `FederationIdentifier` (if populated) as the MSAL login hint to silently authenticate the employee via Entra ID. If `FederationIdentifier` is empty, it falls back to `Email`. This determines *which Entra user is signed in*.

The authentication flow is:
1. Attempt silent SSO using the login hint
2. If silent authentication fails, fall back to a popup login

---

## Employee pre-selection

After authentication, the component takes the signed-in user's **Entra ID UPN** (User Principal Name, from the token's `preferred_username` claim) and matches it against SCIM-provisioned employees to pre-select the logged-in employee in the booking form.

The matching logic is:
1. **Email match** (case-insensitive): compare the UPN against each employee's `email` field
2. **ExternalId fallback** (case-insensitive): if no email match, compare the UPN against each employee's `externalId` field
3. **No match**: the employee must manually select themselves from the dropdown

{: .warning }
> The `FederationIdentifier` and the Entra UPN can be different values. If `FederationIdentifier` authenticates user A but user A's UPN doesn't match any SCIM-synced employee email, the employee won't be pre-selected. Ensure the Salesforce user's `FederationIdentifier` corresponds to an Entra user whose UPN matches the SCIM-synced employee email.

---

## Troubleshooting

### Employee not pre-selected

**Symptom**: The booking form opens but the employee field is empty instead of pre-selecting the logged-in employee.

**Check these in order**:

1. **UPN / email mismatch**: Verify the employee's Entra ID UPN matches the email synced via SCIM. Check the employee record in **BookMe → Advisors → Manage Availability** in the Management UI to confirm the SCIM-synced email.

2. **Employee not provisioned via SCIM**: Verify SCIM provisioning has synced the employee from Entra ID.

3. **ExternalId fallback**: Check that the employee's `externalId` in the booking platform matches their Entra ID UPN.

---

## Related Documentation

- [SCIM Provisioning Setup]({{ site.baseurl }}/bookme/scim-provisioning-setup/) — how employees are synced from Entra ID
- [Microsoft Entra Integration]({{ site.baseurl }}/bookme/entra-integration/) — user access and role configuration
- [Meeting Overview]({{ site.baseurl }}/embeddable-ui/meeting-overview/) — landing page behavior and button states
