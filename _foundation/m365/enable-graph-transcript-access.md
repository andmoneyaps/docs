---
layout: default
title: Enable-Graph-Transcript-Access.ps1
nav_order: 8
parent: Microsoft 365
grand_parent: Foundation
---

# Enable-Graph-Transcript-Access.ps1

Microsoft Graph API access to Teams meeting transcripts is governed by a tenant-level setting that is **off by default**. While it is off, Engage cannot create or renew a transcript change-notification subscription — Graph returns `403 Forbidden` with the `GraphAccessToTranscriptsDisabled` inner-error code — and meeting summaries stop being produced. The app registration's Graph permissions and its Teams application access policy have no bearing on this; the tenant setting overrides both.

Two settings are required. `EnableGraphTranscriptAccess` lifts the block. `EnableAttributedTranscripts` permits the speaker-attributed transcript format, which Engage requests; without it transcript content requests fail with `SpeakerAttributionNotAllowed` even once access is enabled.

The setting is tenant-wide, and worth reviewing with your security team before enabling. It admits **every application and agent that already holds the relevant Graph permissions** — not only Engage — so permissions granted previously but never effective become effective. Each caller remains bounded by its own Graph permissions and its Teams application access policy, and the setting does not widen which *users* any application may read; per-application control remains in the Microsoft Entra admin center.

Teams administrators can apply the same change without PowerShell in the Teams admin center under **Meetings → Meeting settings → Transcript API access**.

Background: [MC1393806](https://mc.merill.net/message/MC1393806) and [Manage transcript API access for Teams meetings](https://learn.microsoft.com/en-us/microsoftteams/meeting-transcript-api-access).

Run [`Enable-Graph-Transcript-Access.ps1`]({{ site.baseurl }}/foundation/scripts/#enable-graph-transcript-accessps1) as a *Teams Administrator*.
