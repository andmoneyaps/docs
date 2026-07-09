---
layout: "default"
title: "Employee guide"
parent: "English"
grand_parent: "Assist"
nav_order: 302
lang: "en"
---
# Assist – employee guide
_How to use Assist during the meeting in Salesforce · v1.0 · 10.06.2026_


## Purpose and value

With Assist you get an AI meeting assistant in your customer meeting. Assist transcribes the conversation, follows your meeting goals and captures key points and agreements as you go — and produces a finished summary after the meeting. That way you can be present with the customer instead of taking notes.

### Glossary
- **Assist**: &money's AI meeting assistant in Salesforce — transcription, insights, meeting goals and summary.
- **Meeting (Event)**: The meeting record itself in Salesforce, where you open Assist (the “Assist” tab).
- **Transcription**: The running text of what is said during the meeting (speech-to-text).
- **Meeting goals**: Goals for the meeting that Assist follows and assesses as you go. (Coming soon — not yet available.)
- **Key points & agreements**: Important points and agreements that Assist captures automatically from the conversation.
- **Summary**: The meeting summary that Assist produces after the meeting — a customer summary (for the customer) and a base summary (internal).


## Audience and prerequisites

- Audience: an employee who holds customer meetings and wants to use Assist.
- You have an **Assist licence/access** (otherwise contact your super-user).
- You are working on a **meeting (Event)** in Salesforce — that is where the **Assist** tab lives.
- A **microphone** is connected, and the browser (Chrome/Edge) is allowed to use it.
- You have **informed the customer** that the meeting is recorded and transcribed with AI (see “Consent” below).

{: .note }
> **Note:** Assist records and transcribes the meeting. Always tell the customer, and make sure you have a valid basis before you start — that is your responsibility as an employee.


## What you get out of it

After this guide you can:

- Open and prepare Assist on a meeting.
- Start a meeting with transcription and meeting goals.
- Follow insights, key points and agreements as you go.
- End the meeting and get a finished summary.
- Find, review and share the summary (depending on your setup).


## Overview

- Open the meeting → the **Assist** tab.
- Prepare: language, microphone, participants, meeting goals.
- **Start meeting** → hold the meeting → **End & generate summary**.
- Review, save and share the summary.


## Consent — before you start

Assist records and transcribes the conversation. Before you start:

- Tell the customer that the meeting is recorded and transcribed with AI, and why (e.g. to produce a summary).
- Make sure you have a valid basis in line with your guidelines.
- Assist shows a note about AI transcription — but it does not replace your own information to the customer.

**For example, say to the customer:** “For this meeting I use an AI assistant that records and produces a text of the conversation, so I can write a summary — is that all right with you?”


## Checklist before the meeting

- ☐ Event opened, and the **Assist** tab is open.
- ☐ **Microphone** selected and tested — choose the meeting room's primary microphone, as the audio recording is best here. If there isn't one, choose your laptop's “System default” microphone.
- ☐ **Participants** are loaded with the correct role (customer/employee).
- ☐ The **laptop** is open — and stays open throughout the whole meeting.
- ☐ The customer is **informed**, and consent is in place.


## Step-by-step (Salesforce)


### Step 1 · Open Assist on the meeting

_Why: Assist lives on the meeting (Event) itself in Salesforce._

- Open (or create) the **meeting** on the customer's account in Salesforce.
- Click the **Assist** tab. The tab may be called something else at your organisation — e.g. **Assist Lite**, **Transcribe** or a name your organisation has chosen itself.


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/assist/en/medarbejderguide/assist_sf_fane.png)

*Screenshot 1 (Salesforce · Assist) — The meeting (Event) with the Assist tab open (here “Assist Lite”) — the preparation screen*

{: .hint }
> ✓ **How you know it worked:** Assist opens and is ready to be prepared.


### Step 2 · Prepare the meeting

_Why: This is where you make sure Assist records correctly and follows the right goals._

- Check the **participants** and their role (customer/employee) — they can take a moment to load.
- Leave **Live meeting** selected (**Upload transcription** is only for uploading an existing recording).
- Select and test the **microphone** under **Microphone settings** (grant the browser permission if it asks).
- **Meeting goals** (goals that Assist follows during the meeting) are **coming soon** and are not yet available.


### Step 3 · Start the meeting

_Why: When you start, recording and live transcription begin._

- Click **Start meeting**. The button is greyed out until participants are loaded and a microphone is selected (typically a few seconds) — if it stays greyed out, select a microphone manually and refresh the page.
- Hold the meeting as normal — Assist transcribes and analyses in the background.

{: .hint }
> ✓ **How you know it worked:** You see the live transcription running, with the text appearing continuously.


### Step 4 · Follow along as you go

_Why: Assist helps you in real time, so you can be present._

- **Transcription**: the conversation as text, labelled per speaker.
- **Meeting goals**: marked off as they are reached.
- **Key points & agreements**: important points and agreements are captured automatically.
- **Speaking-time split**: how much you and the customer each speak.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/assist/en/medarbejderguide/assist_sf_live.png)

*Screenshot 2 (Salesforce · Assist) — Live, shortly after the start — the **End & generate summary** button and the **Key points**/**Agreements** cards (still empty). Transcription and speaking time are seen by scrolling in the panel.*

{: .note }
> **Note:** You see the **transcription** and **speaking-time split** by scrolling in the panel. **Key points** and **agreements** are only filled in after a few minutes (you may see e.g. “X messages until next update”) — this is not an error.


### Step 5 · End the meeting

_Why: When the meeting is over, Assist generates the summary automatically._

- Click **End & generate summary**.
- **Wait a moment** (typically under a minute) while the base summary and customer summary are generated.

{: .hint }
> ✓ **How you know it worked:** The summary is ready for review.

{: .important }
> **Remember:** Always click **End & generate summary** — otherwise the summary is not generated, and the transcription is deleted after 48 hours. (Automatic generation, if you forget, is on the way.)


### Step 6 · Review, save and share the summary

_Why: You have the final say — review and correct before you save and share._

- Read through the **customer summary**, and correct it if necessary.
- Save the summary in Salesforce (see “Where do I find the summary?” below).
- Share it with the customer in line with your guidelines.


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/assist/en/medarbejderguide/assist_sf_referat.png)

*Screenshot 3 (Salesforce · Assist) — Summary view: the customer summary ready for review and saving*

{: .important }
> **Remember:** The summary is AI-generated — always read it through and correct any errors before you save it or send it to the customer.

{: .note }
> **Note:** If it says e.g. “No agreements made yet”, that is normal — Assist simply found no concrete agreements in the conversation.


## Getting the best recording at in-person meetings

Assist transcribes from the microphone. At an in-person meeting you get the best recording — and the best separation of your voices — like this:

- Preferably use an **external microphone** rather than the built-in laptop microphone — select it explicitly under **Microphone settings**.
- Place the laptop **in the middle of the table** between you and the customer, so both voices are captured equally well, if you are using your laptop's microphone.
- Keep the microphone **clear** — avoid covering it with paper, folders or hands.
- Choose a **quiet room** without background noise (ventilation, corridor, other conversations) — this improves both transcription and separation of speakers.
- Avoid **duplicate audio devices** (e.g. a Bluetooth headset + dock + laptop microphone all at once) — select a single device.
- Speak at a **normal pace**, and avoid talking over each other — this helps Assist tell apart who says what.
- **Test the microphone** briefly before the meeting (select the device and check that the level responds).
- **Do not close the laptop** at the start of the meeting — it can interrupt the recording; leave it open throughout the whole meeting.
- You can safely **switch to other tabs or applications** (Present, PowerPoint, online banking, other tabs) and return — the recording continues.
- **Hybrid meetings** (both in-person and online participants) are held in Teams.


## What do the fields mean?

Here is what each choice controls — so you know what you are choosing:


| Field / choice | What it controls | Effect on the presentation |
|---|---|---|
| Language | The meeting's language | Controls transcription and summary — choose the language the meeting is held in. |
| Microphone | Audio source | Determines which microphone records; crucial for quality. |
| Participants + role | Labelling of speech | Links voices to names/roles, so the transcription is easy to read. |
| Meeting goals (coming soon) | What Assist follows | Assist assesses whether the goals are reached. The feature is not yet available. |
| Start meeting / End & generate summary | Recording on/off | Starts recording/transcription, and ends the meeting + generates the summary. |
| Customer summary | Summary for the customer | The customer-facing version — review and correct before you send it. |
| Base summary | Internal summary | The full, internal summary from the meeting. |
| Save in Salesforce | Saves the summary | Places the summary on the meeting (location depends on your setup). |


## Automatic summary and storage

- When you end the meeting, Assist generates a **summary automatically** (a customer summary and a base summary) from the transcription — you do not have to write it yourself.
- The summary is saved in **Salesforce** and is the permanent copy (see “Where do I find the summary?” below).
- The **transcription itself is stored for up to 48 hours** and is then deleted — so remember to review and save the summary.
- Processing takes place in the **EU**, and the content is not used to train AI models.


## Where do I find the summary?

The summary is saved in Salesforce. Depending on your setup, it lives either on the meeting (Event) itself or in a dedicated tab — several organisations name the tab themselves, e.g. “Summary”.

{: .note }
> **Note:** If you are unsure where the summary lands at your organisation, ask your super-user.


## Troubleshooting

- The microphone doesn't work: grant the browser permission (Chrome/Edge), and check that the right microphone is selected.
- No **Assist** tab on the meeting: check that you have opened a **meeting (Event)** and have an Assist licence — otherwise contact your super-user.
- The transcription doesn't appear: check the microphone and internet connection, and start the meeting again.
- I can't find the summary: see “Where do I find the summary?” — it depends on your setup (on the meeting vs. a “Summary” tab).

More common questions and errors: see **Assist – FAQ**.

### See also
- **Assist – super-user guide (Management UI)** — reporting and meeting goals — companion guide.
- **Assist – FAQ** (typical questions, errors and answers).


## Latest update

- 10.06.2026 (v1.0) — First version (using Assist during the meeting in Salesforce).


{: .hint }
> ✅ **Done!** You have held a meeting with Assist and received a summary.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 10.06.2026_
