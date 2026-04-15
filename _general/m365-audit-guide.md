---
layout: default
title: Auditing M365 Integration
nav_order: 7
parent: General
collection: general
---

# Auditing the &money M365 Integration

## Document metadata

| Field | Value |
|---|---|
| Document name | M365 Integration Audit Guide |
| Audience | Customer IT administrators, security assessors, compliance officers |
| Scope | Microsoft Graph API access by &money products (BookMe, Meet) |
| Last updated | 2026-04-15 |
| Owner | &money |

## 1. Purpose

&money products integrate with Microsoft 365 via the Microsoft Graph API to manage calendar events, online meetings, and meeting transcripts on behalf of your advisors. This guide explains how your organization can independently audit and verify that our application only accesses the data it is intended to access.

This guide covers two categories of controls:
- **Preventive controls** — restrict what our application *can* access
- **Detective controls** — monitor and verify what our application *actually* accesses

## 2. What Our Application Accesses

The &money service principal in your tenant uses **app-only authentication** (OAuth 2.0 client credentials) to access the following Microsoft Graph resources:

| Resource | Operations | Purpose |
|----------|------------|---------|
| Calendar events | Read, create, update, delete (via webhook notifications) | Synchronize advisor calendar availability |
| Online meetings | Read, update | Manage Teams meetings created through the booking platform |
| Meeting transcripts | Read | Retrieve transcripts for meetings managed by the platform |
| Subscriptions | Create, renew | Receive real-time change notifications for the above resources |

The application **cannot** access mailbox contents, Teams chat messages, files, or any resources beyond those listed above — it does not hold the Graph API permissions required to do so.

## 3. Preventive Controls

### 3.1 Teams Application Access Policy

The Teams Application Access Policy controls which users' online meetings and transcripts our application can access. This policy is **required** — without it, Microsoft Graph rejects our API calls with a 403 error.

**What it does:** Restricts our application to only access meetings and transcripts for users explicitly granted the policy. Even though the application holds tenant-wide meeting permissions, it cannot access meetings for users outside the policy scope.

**How to review the current policy:**

```powershell
# Connect to Microsoft Teams PowerShell
Connect-MicrosoftTeams

# List all application access policies
Get-CsApplicationAccessPolicy

# Check which users/groups have the policy assigned
# (Policy name follows the pattern: Bookme-OnlineMeetingAccess-Policy-{Environment})
Get-CsOnlineUser -Filter "ApplicationAccessPolicy -eq 'Bookme-OnlineMeetingAccess-Policy-Production'" | Select DisplayName, UserPrincipalName
```

**How to modify scope:** Add or remove users from the policy to control which advisors' meetings are accessible. See [Add-Teams-Access-Policy.ps1]({{ site.baseurl }}/bookme/add-teams-access-policy/) for the setup script used during onboarding.

{: .important }
> The Teams Application Access Policy controls access at the **user level** — it determines which users' meetings the application can access. It does not distinguish between meetings a user organized themselves and meetings created by our platform. To verify that our application only accesses platform-created meetings, use the detective controls described in section 4.

**Microsoft documentation:** [Configure application access policy for online meetings](https://learn.microsoft.com/en-us/graph/cloud-communication-online-meeting-application-access-policy)

### 3.2 Exchange Online RBAC for Applications

Exchange Online Role-Based Access Control (RBAC) for Applications scopes calendar access to specific mailboxes.

**What it does:** Restricts which users' calendars our application can read and write. You define a Management Scope (based on user attributes, group membership, or administrative units) and assign calendar permissions only within that scope.

**How to configure:**

1. Create a service principal pointer in Exchange Online for our application
2. Define a Management Scope that includes only the relevant advisors
3. Assign the `Application Calendars.ReadWrite` role scoped to that Management Scope
4. Remove the unscoped `Calendars.ReadWrite` permission from Entra ID (the RBAC assignment replaces it)

{: .warning }
> The RBAC scope only takes effect if the broad Entra ID permission grant (`Calendars.ReadWrite`) is removed. If both exist, the unscoped Entra ID grant takes precedence.

**Microsoft documentation:** [RBAC for Applications in Exchange Online](https://learn.microsoft.com/en-us/exchange/permissions-exo/application-rbac)

### 3.3 Entra ID Permission Review

You can review exactly which Microsoft Graph permissions have been granted to our application at any time.

**How to review:**

1. Open the [Microsoft Entra admin center](https://entra.microsoft.com)
2. Navigate to **Enterprise Applications** and locate the &money application
3. Select **Permissions** to see all granted Graph API permissions
4. Verify that only the expected permissions are listed

**Periodic reviews:** Entra ID Access Reviews can automate this as a recurring governance workflow, ensuring permissions are re-certified on a schedule.

**Microsoft documentation:** [Review permissions granted to enterprise applications](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-application-permissions)

## 4. Detective Controls

### 4.1 Microsoft Graph Activity Logs

Graph Activity Logs are the primary tool for auditing our application's data access. They capture **every HTTP request** to the Microsoft Graph API for your tenant.

**What is logged for each API call:**

| Field | Description |
|---|---|
| `AppId` | The application making the request (filter to our app ID) |
| `RequestUri` | The full API path, including user IDs and resource IDs |
| `RequestMethod` | GET, POST, PATCH, or DELETE |
| `ResponseStatusCode` | Whether the call succeeded (200) or was denied (403) |
| `IPAddress` | Source IP address of the calling service |
| `TimeGenerated` | Timestamp of the request |
| `Roles` | The permissions present in the access token |

**What this means in practice:** The `RequestUri` field contains the specific user ID and resource ID for every call. For example, a transcript fetch appears as:

```http
GET /users/{userId}/onlineMeetings/{meetingId}/transcripts/{transcriptId}/content
```

This allows you to see exactly which user's meeting and which transcript were accessed, and cross-reference against expected activity.

{: .note }
> Graph Activity Logs capture the request URL and metadata, but **not** the request or response body. You can see *which* transcript was fetched, but not the transcript content itself.

**Setup requirements:**
1. Configure diagnostic settings in the Entra admin center to route `MicrosoftGraphActivityLogs` to a Log Analytics workspace, Storage Account, or Event Hub
2. Requires Entra ID P1 or P2 (included in Microsoft 365 E3/E5)

**Microsoft documentation:**
- [Microsoft Graph activity logs overview](https://learn.microsoft.com/en-us/graph/microsoft-graph-activity-logs-overview)
- [MicrosoftGraphActivityLogs table schema](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/microsoftgraphactivitylogs)

### 4.2 App Governance (Microsoft Defender for Cloud Apps)

App Governance provides aggregate-level monitoring of OAuth applications accessing your Microsoft 365 data.

**What it shows:**
- Total data uploaded and downloaded by the application, broken down by service (Exchange, Teams, etc.)
- Which granted permissions are actually being used vs. unused
- Trend analysis and anomaly detection for data access patterns

**Alerting:** You can create policies that automatically flag or alert when an application's data usage exceeds a threshold or shows unusual patterns (e.g., a sudden spike in data downloaded from Teams).

App Governance is less granular than Graph Activity Logs (it shows aggregate volumes, not individual API calls), but is useful for continuous monitoring and anomaly detection.

**Licensing:** Included in Microsoft 365 E5 or as part of the Microsoft Defender for Cloud Apps add-on.

**Microsoft documentation:** [App governance in Microsoft Defender for Cloud Apps](https://learn.microsoft.com/en-us/defender-cloud-apps/app-governance-manage-app-governance)

### 4.3 Entra ID Service Principal Sign-In Logs

Service principal sign-in logs capture each time our application authenticates to obtain an access token.

**What is logged:**
- Authentication timestamp and status (success/failure)
- Source IP address
- Authentication method (certificate or client secret)
- Target resource (Microsoft Graph)

These logs show **authentication events**, not individual API calls. They are useful for verifying that our application only authenticates from expected IP addresses and at expected frequencies.

**Microsoft documentation:** [Service principal sign-in logs in Entra ID](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-service-principal-sign-ins)

## 5. Example Audit Queries

The following KQL queries can be run against the `MicrosoftGraphActivityLogs` table in your Log Analytics workspace. Replace `<app-id>` with the &money application's client ID.

### 5.1 All API calls by the &money application

```kusto
MicrosoftGraphActivityLogs
| where AppId == "<app-id>"
| summarize CallCount = count() by RequestMethod, 
    Endpoint = extract(@"^/[^/]+/[^/]+/[^/]+/([^/\?]+)", 1, RequestUri)
| order by CallCount desc
```

### 5.2 All transcript fetches

```kusto
MicrosoftGraphActivityLogs
| where AppId == "<app-id>"
| where RequestUri has "transcripts" and RequestUri has "content"
| extend UserId = extract(@"/users/([^/]+)/", 1, RequestUri)
| extend MeetingId = extract(@"/onlineMeetings/([^/]+)/", 1, RequestUri)
| extend TranscriptId = extract(@"/transcripts/([^/]+)/", 1, RequestUri)
| project TimeGenerated, UserId, MeetingId, TranscriptId, ResponseStatusCode, IPAddress
| order by TimeGenerated desc
```

### 5.3 Subscription creation requests

```kusto
MicrosoftGraphActivityLogs
| where AppId == "<app-id>"
| where RequestUri has "subscriptions" and RequestMethod == "POST"
| project TimeGenerated, RequestUri, ResponseStatusCode, IPAddress
| order by TimeGenerated desc
```

{: .note }
> This query shows when the application created or renewed webhook subscriptions. The subscribed resource path (e.g., which user's calendar) is part of the request body, which is **not** captured in Graph Activity Logs. To see which users have active subscriptions, review the Teams Application Access Policy (section 3.1) or request the subscription list from &money.

### 5.4 Detect transcript access for users outside an expected list

```kusto
// Define the user IDs that should be in scope
let allowedUserIds = dynamic(["<user-id-1>", "<user-id-2>"]);
MicrosoftGraphActivityLogs
| where AppId == "<app-id>"
| where RequestUri has "transcripts"
| extend UserId = extract(@"/users/([^/]+)/", 1, RequestUri)
| where UserId !in (allowedUserIds)
| project TimeGenerated, UserId, RequestUri, ResponseStatusCode
```

If this query returns any rows, the application accessed a transcript for a user outside the expected scope.

### 5.5 Cross-reference transcript access against platform-created meetings

Graph Activity Logs do not capture response bodies, so the meeting ID assigned by Microsoft Graph when a meeting is created is not directly available in the logs. To cross-reference transcript access against platform-created meetings, populate the `platformMeetings` list with meeting IDs from your own records or from data provided by &money.

```kusto
let appId = "<app-id>";
// Populate from platform records (&money can provide this list on request)
let platformMeetings = datatable(MeetingId:string)
[
    "<meeting-id-1>",
    "<meeting-id-2>"
];
// Transcript fetches for meetings NOT in the platform-created list
MicrosoftGraphActivityLogs
| where AppId == appId
| where RequestUri has "transcripts" and RequestUri has "content"
| extend MeetingId = extract(@"/onlineMeetings/([^/]+)/", 1, RequestUri)
| where MeetingId !in (platformMeetings)
| project TimeGenerated, MeetingId, RequestUri, ResponseStatusCode
```

If this query returns any rows, a transcript was fetched for a meeting not in the platform-created list. &money can provide meeting identifiers for reconciliation upon request.

### 5.6 Set up an alert for unexpected transcript access

You can create an Azure Monitor alert rule based on any of the queries above. For example, to be alerted whenever a transcript is fetched for a user outside the allowed list:

1. In the Azure portal, navigate to your Log Analytics workspace
2. Open **Alerts** and create a new alert rule
3. Use the KQL query from section 5.4 as the condition
4. Set the threshold to "Greater than 0"
5. Configure the notification action (email, Teams channel, webhook, etc.)

**Microsoft documentation:** [Create a log search alert rule](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-log-alert-rule)

## 6. Licensing Requirements

| Tool | Minimum license | Included in E5 |
|------|----------------|-----------------|
| Microsoft Graph Activity Logs | Entra ID P1 + Log Analytics workspace | Yes |
| Teams Application Access Policy | Teams license (no additional cost) | Yes |
| Exchange RBAC for Applications | Exchange Online (no additional cost) | Yes |
| Entra ID Permission Review | Entra ID Free (portal) / P2 (Access Reviews) | Yes |
| App Governance | Defender for Cloud Apps | Yes |
| Service Principal Sign-In Logs | Entra ID P1 | Yes |
| Azure Monitor Alerts | Azure subscription (pay-per-use for alerts) | Separate |

## 7. Microsoft Documentation References

| Topic | Link |
|-------|------|
| Graph Activity Logs overview | [learn.microsoft.com/en-us/graph/microsoft-graph-activity-logs-overview](https://learn.microsoft.com/en-us/graph/microsoft-graph-activity-logs-overview) |
| Graph Activity Logs table schema | [learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/microsoftgraphactivitylogs](https://learn.microsoft.com/en-us/azure/azure-monitor/reference/tables/microsoftgraphactivitylogs) |
| Teams Application Access Policy | [learn.microsoft.com/en-us/graph/cloud-communication-online-meeting-application-access-policy](https://learn.microsoft.com/en-us/graph/cloud-communication-online-meeting-application-access-policy) |
| Exchange RBAC for Applications | [learn.microsoft.com/en-us/exchange/permissions-exo/application-rbac](https://learn.microsoft.com/en-us/exchange/permissions-exo/application-rbac) |
| App Governance | [learn.microsoft.com/en-us/defender-cloud-apps/app-governance-manage-app-governance](https://learn.microsoft.com/en-us/defender-cloud-apps/app-governance-manage-app-governance) |
| Service Principal Sign-In Logs | [learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-sign-ins-service-principal](https://learn.microsoft.com/en-us/entra/identity/monitoring-health/concept-service-principal-sign-ins) |
| Enterprise App Permission Review | [learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-application-permissions](https://learn.microsoft.com/en-us/entra/identity/enterprise-apps/manage-application-permissions) |
| Log Search Alert Rules | [learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-log-alert-rule](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-create-log-alert-rule) |
