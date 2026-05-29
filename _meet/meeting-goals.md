---
layout: default
title: Meeting Goals
nav_order: 2
parent: Meet
---

# Meeting Goals

---

## Overview

Meeting Goals let bank configurators define the objectives that an advisor should reach during a meeting. Each goal is tied to a **Topic** (and optionally a **Subtopic**). The meeting's Topic is fixed when the meeting is booked, so the matching goals load automatically when the advisor opens the meeting — there is nothing for the advisor to pick. Subtopics inherit every goal from their parent topic by default, and each inherited goal can optionally be excluded on a per-subtopic basis. During the meeting, Meet's AI uses each goal's **AI Instruction** to judge in real time whether the goal has been reached, surfacing this back to the advisor through the live insights and the post-meeting summary.

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Topic** | A top-level meeting category (for example *Investment review*, *Loan advisory*). Goals attached to a topic apply to every meeting in that topic. |
| **Subtopic** | A child of a topic (for example *First-time mortgage*, *Refinancing*). Subtopics inherit every goal from their parent topic by default. |
| **Goal** | A named objective with a description and an AI Instruction. Each goal belongs to one topic or subtopic. If its owning topic or subtopic is deleted the goal persists as an orphan — still in the system, but no longer attached to any topic until it is reassigned or removed. |
| **AI Instruction** | The natural-language rule sent to Meet's AI that tells it when the goal is considered reached. |
| **Inheritance** | Every goal defined on a topic applies to all of its subtopics by default. Any individual goal can be excluded from any specific subtopic — exclusions are per-goal and per-subtopic, never global. |
| **Orphaned goal** | A goal whose original topic was deleted. The goal still exists but no longer applies to any meeting until it is reassigned or deleted. |

---

## Accessing Meeting Goals

1. Open the Management UI
2. Navigate to **Meet** → **Meeting Goals** → **Meeting Goals**

The page lists every goal grouped by the topic it belongs to.

![Meeting Goals page with all topics expanded]({{ site.baseurl }}/assets/images/meet/meeting-goals/01-all-topics-view.png)

> **Note**: Access requires the **Configurator** role. Users without this role cannot view or modify Meeting Goals.

---

## Page Layout

### Filters

Two dropdowns at the top of the page control what is shown:

| Filter | Behavior |
|--------|----------|
| **Topic** | `All` shows one section per top-level topic. Selecting a specific topic narrows the view to that topic. The `Orphans (N)` option appears only when orphaned goals exist. |
| **Subtopic** | Available once a topic is selected. Choosing a subtopic switches the view to show both inherited goals (from the parent topic) and goals specific to that subtopic. |

### Sections

The page renders one or more sections depending on the current filter:

| Section | Shown when | Contents |
|---------|------------|----------|
| **Owned** (`{Topic name}`) | Viewing all topics, a single topic, or a subtopic | Goals defined directly on that topic or subtopic. Includes a **Create** button. |
| **Inherited from {Topic}** | A subtopic is selected | Goals inherited from the parent topic. Each row has an **Include** toggle — on by default — that can be flipped off to exclude that single goal from the selected subtopic. |
| **Orphaned goals** | Orphans exist and the `Orphans` filter is selected | Goals whose original topic has been deleted. |

### Goal Table Columns

| Column | Description |
|--------|-------------|
| **Name** | The goal's display name. |
| **Description** | A short description of the goal. Shown to advisors and also fed to the AI together with the **Name** when generating the AI Instruction via **Create instructions**. |
| **AI Instruction** | Shows **Configured** (green check) when an AI Instruction is set or **Missing** (red cross) when it is not. If a goal is **Missing** at meeting time, Meet falls back to using the **Description** as the AI Instruction — the goal is still evaluated, but with materially lower quality. Always configure an explicit AI Instruction in production. |
| **Include** *(inherited only)* | Toggle that controls whether the inherited goal applies to the selected subtopic. On by default; switching it off creates an exclusion for that goal on that subtopic. |
| **Actions** *(owned only)* | Edit and delete buttons. |

Selecting a specific topic narrows the view to the goals defined on that topic:

![Single topic selected]({{ site.baseurl }}/assets/images/meet/meeting-goals/02-topic-selected.png)

---

## Creating a Goal

1. Open the section for the topic or subtopic you want the goal to belong to
2. Click **Create goal**
3. Fill in the form:

| Field | Required | Notes |
|-------|----------|-------|
| **Topic** | Yes | Pre-selected based on the section you opened the dialog from. Change to move the goal to a different topic. |
| **Subtopic** | No | Leave empty to apply the goal to *all* subtopics of the selected topic. Selecting a subtopic restricts the goal to only that subtopic. |
| **Name** | Yes | Must be unique within the topic hierarchy. |
| **Description** | Yes | Max 500 characters. Shown to advisors in the meeting UI, and also fed to the AI together with the **Name** as the source material for the auto-generated AI Instruction (**Create instructions**). |
| **AI Instruction** | Yes | The instruction Meet's AI uses to judge whether the goal has been reached. |

4. (Recommended) Click **Create instructions** to auto-generate the AI Instruction from the Name and Description. The button is enabled once both fields are filled.
5. Click **Create**

![Create goal dialog]({{ site.baseurl }}/assets/images/meet/meeting-goals/04-create-modal.png)

### Inheritance Confirmation

When a goal is created on a topic that has subtopics (i.e. **Subtopic** is left empty), a confirmation dialog lists every subtopic the goal will be inherited by. Tick the acknowledgement checkbox to continue.

> **Tip**: To restrict a goal to a single subtopic, select that subtopic in the **Subtopic** field. To restrict a goal to a few subtopics, create it on the parent topic and then exclude it on the subtopics where it should not apply (see [Excluding Inherited Goals](#excluding-inherited-goals)).

### Name Conflicts

If a goal with the same name already exists in the topic hierarchy, the form rejects the create with an error. Pick a unique name and try again.

---

## Editing a Goal

1. Click the **Edit** icon on the goal's row
2. Update any of the fields (Topic, Subtopic, Name, Description, AI Instruction)
3. **Create instructions** can also be used in edit mode. If an existing AI Instruction is present, a confirmation prompts before it is overwritten.
4. Click **Save**

Moving a goal to a different topic by changing the **Topic** field will, on save, re-evaluate inheritance for the new owner topic and its subtopics.

---

## Excluding Inherited Goals

By default, every goal defined on a topic is inherited by all of its subtopics. Each inherited goal can optionally be excluded from any individual subtopic — the rest of the inheritance stays intact.

To exclude a single inherited goal from one subtopic:

1. Select the topic in the **Topic** filter
2. Select the relevant subtopic in the **Subtopic** filter
3. In the **Inherited from {Topic}** section, toggle **Include** off for the goal

The exclusion is scoped to that one goal on that one subtopic. The same goal remains active on every other subtopic of the parent topic and on the parent topic itself, and every other inherited goal continues to apply to the subtopic. Toggle **Include** back on to remove the exclusion.

![Subtopic view with Inherited goals and Include toggle]({{ site.baseurl }}/assets/images/meet/meeting-goals/03-subtopic-inherited.png)

---

## Deleting a Goal

1. Click the **Delete** icon on the goal's row
2. Confirm in the dialog

Deleting a goal removes it from all meetings going forward and clears any exclusions associated with it.

---

## Orphaned Goals

A goal becomes orphaned when its owning topic is deleted from the [Meeting Taxonomy]({{ site.baseurl }}/bookme/). Orphaned goals are not surfaced to advisors and are not evaluated by the AI.

To resolve orphaned goals:

1. Select **Orphans (N)** in the **Topic** filter
2. For each orphan, either:
   - **Edit** the goal and assign a new Topic, or
   - **Delete** the goal

The Orphans option disappears from the filter automatically once the last orphan is resolved.

![Orphaned goals view]({{ site.baseurl }}/assets/images/meet/meeting-goals/05-orphans-view.png)

---

## In the Meeting

Once the goals are configured, the advisor never has to fetch or assign them manually — the meeting's Topic is fixed at booking time and the matching goals are derived from it. The advisor's only action is turning the feature on for the meeting.

### Enabling Meeting Goals for a meeting

Meeting Goals is an opt-in feature on each meeting. Before starting the meeting, the advisor opens **Settings** on the Meet setup screen and toggles **Meeting Goals** on. Until it is enabled, no preview is shown, no goals are tracked during the meeting, and the live Goal Tracker does not appear.

![Settings panel with Meeting Goals toggle]({{ site.baseurl }}/assets/images/meet/meeting-goals/06-settings-toggle.png)
<!-- TODO(screenshot): drop the Settings panel screenshot in as
     assets/images/meet/meeting-goals/06-settings-toggle.png -->


### Setup: previewing the goals

As soon as the advisor enables **Meeting Goals** in the settings, Meet resolves the applicable goal list for the meeting's booked Topic — every goal defined directly on that Topic (or its Subtopic, if one was booked), plus every inherited goal from the parent Topic that has *not* been excluded for the booked Subtopic. The result is shown in a **Your goals for: {Topic name}** preview card so the advisor can see what will be tracked before the meeting starts.

If the booked Topic has no goals configured, the preview card shows an informational message ("No goals are set for this meeting yet.") and the live Goal Tracker is hidden during the meeting.

![Goal preview card before the meeting starts]({{ site.baseurl }}/assets/images/meet/meeting-goals/07-preview-card.png)
<!-- TODO(screenshot): drop the pre-meeting preview card screenshot in as
     assets/images/meet/meeting-goals/07-preview-card.png -->


### Live: the Goal Tracker

During the meeting, a **Meeting Goals** tracker card appears in the live insights panel. It contains:

- A **progress summary** — for example *2/5 completed · 1 addressed* — together with a progress bar that fills as goals advance.
- A **goal list**, one row per goal, each with a status badge.

The list and progress bar update on their own while the conversation unfolds; the advisor does not interact with the card.

![Live Goal Tracker during a meeting]({{ site.baseurl }}/assets/images/meet/meeting-goals/08-live-tracker.png)
<!-- TODO(screenshot): drop the live Goal Tracker screenshot in as
     assets/images/meet/meeting-goals/08-live-tracker.png -->


### Goal statuses

Every goal moves through three states. The AI assigns the state based on what it hears in the transcript, and the assignment is **forward-only** — a goal that has reached *Addressed* will never drop back to *Not started*, and a *Completed* goal will never regress.

| Status | When it applies |
|--------|-----------------|
| **Not started** | The conversation has not touched on the goal yet. This is the initial state for every goal. |
| **Addressed** | The topic of the goal has been brought up and discussed, but the AI has not heard enough to consider it concluded. |
| **Completed** | The AI has heard enough evidence in the transcript to consider the goal reached. |

### How the AI evaluates goals

Meet evaluates goals in the background while the meeting runs. The advisor does not need to trigger anything.

- **Evaluation cadence** — The AI re-evaluates the goal list roughly every 10 transcript messages, using a sliding window of the most recent ~20 messages as context. Quiet stretches in the conversation don't trigger an evaluation.
- **Per-goal prompt** — For each goal, the AI is given the goal's **Name**, **Description**, and the **AI Instruction** configured in the Management UI. The AI Instruction is the authoritative rule for when the goal counts as reached. (If a goal's AI Instruction is **Missing**, Meet falls back to using its Description — the goal is still evaluated but with materially lower quality.)
- **Evidence** — Each time the AI judges that a goal has moved forward, it cites the conversational moments that drove the decision. These citations are preserved across the meeting and carry through into the post-meeting summary.
- **Stops when complete** — Once every goal has reached *Completed*, evaluation stops for the rest of the meeting; there is nothing left to assess.

### Session recovery

If the advisor's connection drops or the page is reloaded mid-meeting, the live Goal Tracker rehydrates with the most recent committed state when the session reconnects. The advisor sees the same statuses they had before the disconnect; no progress is lost, and the AI resumes evaluation from the next window.

### After the meeting

The final goal states — including the AI's evidence for each one — are included in the automatically generated post-meeting summary and synced to Salesforce alongside the rest of the meeting record. There is no separate "save goals" step.

### Edge cases

- **No goals configured for the topic.** The Meeting Goals card is hidden. The meeting still runs normally; everything else (transcription, summary, other insights) is unaffected.
- **Uploaded transcripts.** Goal tracking is a live-only feature. Meetings created from an uploaded transcript do not show the tracker.
- **Goals without an AI Instruction.** Meet falls back to the Description in place of the AI Instruction. The goal still appears in the tracker and is still evaluated, but accuracy is materially lower — always configure an explicit AI Instruction before going to production.

---

## Reporting

The final goal states recorded during each meeting roll up into a dashboard so configurators and team leads can see how the goal configuration is performing across the organisation. There is nothing extra to enable — every Meet session with goals turned on automatically contributes to this dashboard.

### Accessing the dashboard

1. Open the Management UI
2. Navigate to **Meet** → **Reporting** → **Reporting**

![Standard reporting dashboard with goal data]({{ site.baseurl }}/assets/images/meet/meeting-goals/09-reporting-dashboard.png)

### Filters

Two filters at the top of the page narrow the data:

| Filter | Behavior |
|--------|----------|
| **Period** | Rolling window of the last *N* days (default: 30). Every metric and chart on the page is restricted to meetings that ended within this window. |
| **Customer type** | Limits the data to a single customer category, or **All** for everything. Useful when goal configurations differ by segment. |

### KPI tiles

A row of four tiles sits at the top of the dashboard:

| Tile | Meaning |
|------|---------|
| **Assist meetings** | Total number of Meet sessions in the period (whether or not goals were enabled). The baseline everything else is measured against. |
| **Meetings with goals** | Share of those sessions where the advisor turned **Meeting Goals** on, shown as a percentage with the underlying numerator/denominator (e.g. *2 of 37 meetings*). A low number here usually means goals weren't enabled, not that goals failed. |
| **Goal count** | Total number of goal *evaluations* across every goal-tracked meeting in the period. A single meeting with 5 goals contributes 5 to this number. |
| **Goal completion rate** | Share of those evaluations that ended in **Done**, shown as a percentage with the underlying *done / total* counts. |

### Charts

| Chart | What it shows |
|-------|---------------|
| **Goal outcomes over the period** | Stacked bar of goal-evaluation outcomes (Done · Addressed · Not started) bucketed by ISO week of the meeting end. Lets you spot trends or sudden drops over time. |
| **Outcomes overall** | Donut of the same Done/Addressed/Not started split for the entire period. The Done slice always matches the **Goal completion rate** KPI tile. |
| **Outcomes by goal** | Horizontal stacked bar — one row per individual goal — showing how each goal performs across all meetings. Useful for spotting goals that are consistently *Not started* (poorly worded, irrelevant to the topic) or rarely *Done* (AI Instruction too strict). |
| **Outcomes by topic** | Stacked bar grouped by **Topic** rather than by individual goal. Useful for comparing how well goal sets perform across different meeting topics. |

![Outcomes by goal and Outcomes by topic charts]({{ site.baseurl }}/assets/images/meet/meeting-goals/10-reporting-by-goal-and-topic.png)

Across every chart and tile, **Done**, **Addressed**, and **Not started** carry the same meaning as the live Goal Tracker statuses — the dashboard simply aggregates the final state each goal reached at the end of its meeting.

### How the dashboard relates to configuration

- A goal that never moves out of **Not started** across many meetings usually means it is not surfacing in the conversation. Consider whether the goal really belongs on that Topic, or whether the AI Instruction is too narrow.
- A goal that reaches **Addressed** but rarely **Done** is being touched on but the AI is not seeing enough evidence to commit. Tightening the Description or relaxing the AI Instruction often helps.
- A low **Meetings with goals** percentage is a roll-out signal: advisors aren't turning the feature on. The dashboard surfaces this but does not enforce anything; the toggle stays per-meeting.

---

## Recommended Configuration

- **Keep goals focused.** One clear objective per goal works better than a single goal that tries to cover multiple outcomes — the AI evaluates each goal independently.
- **Use the AI Instruction generator.** It produces consistent, well-structured prompts from the Name and Description; tweak the result rather than starting from scratch.
- **Prefer topic-level goals.** Define goals on the parent topic when they apply broadly, then exclude on the few subtopics where they do not. This is easier to maintain than duplicating goals across subtopics.
- **Review orphans after taxonomy changes.** Whenever topics are removed or restructured, check the Orphans view to reassign or clean up affected goals.
