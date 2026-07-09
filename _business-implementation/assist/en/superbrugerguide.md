---
layout: "default"
title: "Super-user guide"
parent: "English"
grand_parent: "Assist"
nav_order: 201
lang: "en"
---
# Assist – super-user guide
_Reporting in the Management UI · v1.1 · 10.06.2026_


## Purpose and value

Assist is &money's AI meeting assistant. It transcribes the customer meeting, tracks your meeting goals and automatically produces a summary. &money sets up the Assist version and the template for you — as a super-user you follow usage via reporting in the Management UI (and will soon also be able to define your meeting goals).

### Glossary
- **Assist**: &money's AI meeting assistant in Salesforce — transcription, meeting goals and automatic summary.
- **Management UI**: &money's administration site, where you as super-user set up the products.
- **Meeting goal**: A goal for a meeting (created per meeting topic), which Assist tracks and assesses as the meeting progresses.
- **Meeting topic**: The category a meeting belongs to (e.g. Bank, Wealth Management) — meeting goals are created per topic.
- **AI-instruction**: The instruction you give Assist for when a meeting goal has been reached.
- **Reporting**: An overview of Assist usage — number of meetings, meeting goals and how many are completed.


## Audience and prerequisites

- Audience: super-user/administrator who follows reporting for Assist (and will soon set up meeting goals).
- Assist is enabled for the organisation, and the employees who will use Assist have a licence/access (set up by &money / your admin).
- Microsoft 365 / Entra ID is in place (login and identity).
- In Salesforce, a **Trusted URL** + microphone permission is set up (Salesforce admin), so Assist may record audio in the browser.
- You have access to the Management UI with the necessary permissions.

{: .note }
> **Note:** Assist records and transcribes meetings. The employee must always inform the customer that the meeting is being recorded and transcribed with AI — make sure this is a fixed part of your meeting practice.


## What you get out of it

After this guide you can:

- Follow Assist usage via reporting.
- Understand meeting goals (**coming soon**) and what they do.
- Know the prerequisites and troubleshoot the most common problems.


## Overview

- Step 1: Follow Assist usage via reporting.
- Meeting goals: **coming soon** — explained below.


## What &money sets up for you

You do not need to choose or set up the Assist version itself — &money does that:

- **Assist version and template**: &money configures which version of Assist you use, and sets up the template.
- **Where the summary lands**: whether the summary is saved on the meeting itself or in a dedicated tab is configured per organisation (several customers even name the tab themselves, e.g. “Summary”). You do not need to set this up as a super-user.


## Step-by-step (Management UI)


### Step 1 · Follow usage via reporting

_Why: Reporting shows how much Assist is used across the organisation._

- Go to **Assist** → **Reporting** in the Management UI.
- Filter by **Period** and **Customer type**.
- View the key figures: **Assist meetings**, **Meetings with goals**, **Goal count** and **Goal completion rate**.
- Use the charts (**Done** / **Addressed** / **Not started**) to see outcomes over time, by goal and by topic.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/assist/en/superbrugerguide/assist_rapportering.png)

*Screenshot 1 (Management UI) — Assist → Reporting — key figures and meeting-goal outcomes (Done / Addressed / Not started)*

{: .hint }
> ✓ **How you know it worked:** You see key figures and charts for the selected period and customer type.

{: .note }
> **Note:** The example shows test data. In your view, **Meetings with goals**, **Goal count** and **Goal completion rate** will read 0 until meeting goals are opened — **Assist meetings** is the primary figure today.

Outcomes are shown in three categories: **Done** (the goal was reached), **Addressed** (touched on during the meeting, but not reached) and **Not started** (not touched on).

{: .hint }
> **Recommended:** Check reporting, for example, monthly. If you notice markedly low usage, get in touch with &money.


## Meeting goals (coming soon)

{: .note }
> **Note:** **Coming soon:** Meeting goals have been developed, but are not yet open to customers. The preview below shows what the feature will be able to do — buttons such as **Create** are not yet active for you.

When meeting goals are opened, you can, under **Assist → Meeting goals**, define standard goals per meeting topic, which Assist tracks and assesses during meetings. Each goal has a **Name**, a **Description** and an **AI-instruction** (what Assist assesses the goal against), and is grouped per meeting topic (e.g. Bank, Wealth Management, Insurance).


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/assist/en/superbrugerguide/assist_modemaal.png)

*Screenshot 2 (Management UI) — Preview — Assist → Meeting goals (coming soon): goals per meeting topic with **Name**, **Description** and **AI-instruction***


## What do the fields mean?


| Field | What it controls | Meaning |
|---|---|---|
| Period (reporting) | Time range | Limits the data in reporting. |
| Customer type (reporting) | Segment (e.g. Private/Business) | Limits reporting to a particular customer type. |
| Meeting topic / Subtopic (meeting goals, coming soon) | Where the goal belongs | Groups meeting goals per topic; the employee gets the goals for the relevant topic. |
| Name (meeting goals, coming soon) | The goal's title | Shown to the employee as a meeting goal. |
| AI-instruction (meeting goals, coming soon) | When the goal is reached | Controls how Assist assesses whether the goal has been met in the meeting. |


## Automatic summary and storage

- When the employee ends the meeting, Assist automatically produces a **summary** (customer summary and base summary) from the transcription.
- The summary is saved in your **CRM** (Salesforce) — on the meeting or in a tab (depending on your setup). The CRM is the permanent copy.
- The **transcription itself is stored temporarily for up to 48 hours** and is then deleted **automatically** — you do not need to do anything. The summary in the CRM remains.
- Processing (transcription and AI) takes place in the **EU** (Microsoft Azure); the content is not used to train AI models.


## Consent

- The employee must **inform the customer** that the meeting is being recorded and transcribed with AI, and ensure a valid basis.
- Assist shows a note about AI transcription — but it does not replace your own information to the customer.
- The **business owner** ensures that employees approve the microphone pop-up in the browser, so Assist can record.


## Troubleshooting

- The microphone does not work: check the browser permission and that a **Trusted URL** is set up in Salesforce; use Chrome or Edge.
- The Assist tab is missing on the meeting: check the licence/access and that the Assist component has been placed on the Event page (your admin / &money).
- Reporting is empty: adjust the **Period** and **Customer type**.

More typical questions and errors: see **Assist – FAQ**.

### See also / prerequisites
- **Assist – employee guide** (using Assist in the meeting in Salesforce) — companion guide.
- **Assist – FAQ** (typical questions, errors and answers).


## Latest update

- 10.06.2026 (v1.1) — Focus on reporting; meeting goals marked “coming soon”; Assist version/template set up by &money; auto-summary and 48-hour storage added.
- 10.06.2026 (v1.0) — First version.


{: .hint }
> ✅ **Done!** You can now follow Assist usage via reporting.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.1 · 10.06.2026_
