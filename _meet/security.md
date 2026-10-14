---
layout: default
title: Security
nav_order: 4
parent: Assist
---

# Assist Security Documentation

| Field | Value |
|---|---|
| Document name | Assist Security Documentation |
| Audience | Customer security, privacy and compliance assessors |
| Scope | Assist web application, transcription and AI services, online-meeting and transcript-upload sources, and the CRM (Salesforce) integration boundary |
| Version | 2.0 |
| Last updated | 2026-10-XX  |
| Owner | &money |

> This document gives a general overview for information only. It is not part of any agreement. Binding commitments are set out in the customer agreement and the data processing agreement (DPA). Details may change; the current version applies.

## 1. Overview

Assist is &money's meeting assistant for advisors. It transcribes the meeting, generates a summary (minutes) and evaluates meeting goals with AI, and writes the summary to the customer's CRM automatically when the meeting ends.

**Key facts**

- **No audio recordings are stored.** Audio is streamed for transcription and handled in-session.
- **Transcripts are kept for up to 30 days and then deleted automatically.**
- **The CRM is the system of record.** The summary is stored in the customer's CRM under the customer's access controls and retention.
- **The advisor stays in control.** The summary is a draft in the CRM that the advisor reviews before it is sent to the customer. &money never sends anything to the customer; sending is part of the customer's own CRM processes.
- **Data is processed in the EU**, in Microsoft Azure datacenters.
- **Personal identifiers are masked when the transcript is received**, before it is displayed, stored or sent to AI: the last four digits of CPR numbers, and all but the last four digits of payment card numbers. Masking is pattern-based.

**Security at a glance**

- **Encryption**: TLS in transit; data stores are encrypted at rest.
- **Sign-in**: Advisors sign in with the customer's own identity provider (Microsoft Entra ID single sign-on).
- **Access**: &money's access to production is restricted and granted on a least-privilege basis.
- **Logs**: Logs and traces hold operational metadata only; transcript text is not written to them.
- **Environments**: Production data is not copied into test environments.
- **Changes**: Code is reviewed and checked automatically before deployment. Changes to the AI are reviewed before release and tested in proportion to their expected impact.

**The customer's part**

- Who can see the summary is governed by the customer's CRM permissions.
- Sign-in policies, devices and Microsoft 365 / Teams settings are configured by the customer.
- Sending the summary to the end customer is part of the customer's own CRM processes.

**More information**

&money's detailed security documentation for Assist, covering data flows, a full data inventory with retention periods, and security controls, is shared with customers on request. Contractual commitments, including sub-processors, are set out in the data processing agreement (DPA).

