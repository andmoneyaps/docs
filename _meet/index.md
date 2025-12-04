---
layout: default
title: Meet
nav_order: 7
has_children: true
permalink: /meet
---

# Meet Documentation

Meet is an AI-powered real-time meeting assistant designed for financial advisors. It provides live transcription with speaker identification, real-time customer insights, and automatic summary generation—eliminating manual note-taking.

## Key Features

### Real-Time Transcription
- Live transcription with speaker diarization
- Multi-language support: Danish (default) and English
- Automatic speaker mapping for up to 4 participants

### Live Meeting Insights
- AI-generated insights update automatically during the meeting
- Advisor can focus on the customer, not notes
- Optional talk time tracking to help balance conversation

### Automatic Summary Generation
- Customer-facing summary generated at meeting end
- Zero manual work required
- Immediate sync to Salesforce CRM

### Session Recovery
- Automatic recovery after network disconnections
- Full context restoration (transcript, insights, participants)

## Three-Phase Workflow

Meet follows a simple three-phase workflow:

1. **Setup** — Select language, microphone, and add participants
2. **Live Meeting** — Real-time transcription and AI insights
3. **Summary** — Automatic processing and CRM sync

## Prerequisites

Before configuring Meet in Salesforce, ensure you have:

- Administrator access to your Salesforce organization
- The &money Portal component deployed to Salesforce (see [Deploying Iframe LWC to Salesforce]({{ site.baseurl }}/bookme/salesforce-iframe-lwc-deployment/))
- Access to the Meet environment URLs (provided by &money)

## Browser Requirements

| Browser | Support Level |
|---------|---------------|
| Chrome | ✅ Recommended |
| Edge | ✅ Recommended |
| Safari | ⚠️ Limited support |

## Best Practices

- **Participants**: Up to 4 participants with speaker identification
- **Duration**: Designed for standard advisory meetings (up to 2 hours)
- **Microphone**: Use laptop microphone or external microphone connected to laptop
- **During Meeting**: Keep the Meet browser tab active throughout the session. If you need Salesforce during the meeting, open a separate browser tab

## Next Steps

- [Salesforce Setup]({{ site.baseurl }}/meet/salesforce-setup/) — Configure Meet in your Salesforce organization
