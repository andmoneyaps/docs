---
layout: default
title: Managed Playbooks
parent: Playbooks
nav_order: 14
---

# Managed Playbooks

Some playbooks in your environment are **managed by &Money** — we build them, test them, and keep them up to date so you don't have to. This page explains how to recognise a managed playbook, what you can do with one, and what to do if you want to customise it for your bank.

## What is a managed playbook?

A managed playbook is a playbook that &Money deploys and maintains for you. We build the playbook once in our environment, then push it out to all the customer banks that have opted in. When we improve the playbook — fix a bug, add a feature, or adapt to a Salesforce change — every bank receives the updated version automatically.

You'll see a **blue "Managed" badge** with a lock icon next to managed playbooks in your playbook list:

<!-- screenshot: playbook list showing managed badge and lock icon -->

The lock icon means the playbook is read-only for you. You can see how it's built, run it, and (if it's marked as Open) export it — but you can't edit the blocks or delete it. We keep it consistent across banks on purpose, so the same playbook always behaves the same way.

{: .note }
Managed playbooks usually represent &Money's recommended way of doing something — for example, the standard "Book Meeting" or "Customer Overview" workflow. You always have the option to **fork** the playbook (see below) if you need behaviour that doesn't fit the standard.

## What can I do with a managed playbook?

| Action | Available? |
|--------|-----------|
| View the playbook | ✅ Yes |
| Use the playbook (let it run when triggered) | ✅ Yes |
| Export the playbook (if visibility is "Open") | ✅ Yes |
| Edit blocks, relations, or settings | ❌ No — fork to customise |
| Delete the playbook | ❌ No — &Money manages its lifecycle |
| See version information | ✅ Yes |

A small number of managed playbooks are marked **Proprietary** — for those, the inner block configuration is hidden but you can still use the playbook. Most managed playbooks are Open, meaning you can see exactly what the playbook does.

## When you need to customise — Forking

If a managed playbook doesn't quite fit your bank's setup — for example, your Salesforce uses different objects, or your business has a step the standard playbook doesn't include — you can **fork** the playbook. Forking creates a fully editable copy that belongs to you.

### How forking works

1. Open the managed playbook from your playbook list
2. Click the **Fork** button in the top-right
3. **Name your copy** — by default it's named after the original, but you can rename it (e.g. "Book Meeting — FSC version")
4. Choose what happens to the original:
   - **Disable the original** (default) — your fork takes over. The managed original stays in the system but is hidden from your day-to-day playbook list. You can re-enable it later if needed.
   - **Keep the original active** — both run in parallel. Use this if you want different triggers or audiences to use different playbooks.
5. Click **Confirm**

<!-- screenshot: fork modal with name field and disable-original toggle -->

Your fork appears in your playbook list immediately. It's marked as a **forked playbook** (a different badge from "Managed") and is fully editable like any playbook you'd create yourself.

{: .important }
Once you fork, your copy is **independent** of &Money's managed version. We won't push automatic updates to your fork. That's by design — you've customised it, so we shouldn't change it without your knowledge. See [Update notifications](#update-notifications) below for how you'll know when a newer version of the original is available.

### What gets copied to your fork

Forking creates a complete, independent copy:

- All blocks and their settings
- All connections between blocks
- The playbook's trigger and runtime configuration

Your fork starts at the same version as the original at the moment of forking — but from then on, the two are separate. Editing your fork doesn't change the original; updates to the original don't change your fork.

### What if I want to "un-fork"?

If you decide the standard managed playbook is fine after all, contact &Money support. We can disable your fork and re-enable the managed original for you. There's no in-app "un-fork" action because we want to make sure you don't accidentally lose customisations.

## Update notifications

When &Money releases a new version of a managed playbook, two things happen:

1. **Banks still using the managed version** receive the update automatically. Nothing for you to do.
2. **Banks that have forked** see an **"Update Available" banner** on the fork in the playbook editor. The banner shows the version your fork is based on (e.g. v2) and the latest available version (e.g. v4):

<!-- screenshot: update available banner in editor -->

The banner is informational — your fork keeps working exactly as it did. We're letting you know that the standard version has moved on so you can decide:

- **Stay on your fork** — your customisations are important; you don't need anything &Money added in the new version
- **Switch back to the managed version** — &Money's improvements are valuable enough to give up your customisations
- **Reapply your customisations on top of the new version** — you want both. This is a manual process today; contact &Money support and we'll help you plan it.

There's no in-app "accept update" button on a fork. Forks are deliberately independent so updates can never accidentally overwrite your work.

## Frequently asked questions

### Why can't I edit this playbook?

It's a managed playbook — &Money builds and maintains it. To customise, click **Fork** to create your own editable copy.

### What happens when I fork?

A new playbook is created in your bank as a fully editable copy of the managed one. By default, the managed original is disabled (hidden from your playbook list); you can keep both active if you prefer. The fork is yours — &Money won't push automatic updates to it.

### Will my fork get automatic updates?

No. Forks are independent — that's the point of forking. When &Money updates the managed original, your fork shows an "Update Available" banner so you know there's a newer version, but it keeps running your customised version until you decide otherwise.

### Can I un-fork or go back to the managed version?

Not directly in the app. Contact &Money support — we can disable your fork and re-enable the managed original. We treat this carefully so you don't lose customisations by accident.

### Why is this playbook marked Proprietary?

A small number of managed playbooks contain logic &Money doesn't make publicly visible — for example, a proprietary AI prompt or a shared scoring algorithm. You can still use the playbook normally; only the inner block configuration is hidden. Proprietary playbooks can't be forked.

### Who decides which playbooks are managed?

&Money curates the managed catalog based on what most banks need. If you'd like to see a particular workflow standardised across all customers, talk to your &Money contact — we're always looking for patterns to lift into the managed catalog.

## Where to next

- [Playbooks User Guide]({{ site.baseurl }}/bookme/playbooks/playbooks-user-guide/) — how to build and edit a playbook (applies to your forked copies and to playbooks you create from scratch)
- [Introduction to Playbooks]({{ site.baseurl }}/bookme/playbooks/introduction-to-playbooks/) — what playbooks are and how blocks fit together
- [Playbooks Integrations]({{ site.baseurl }}/bookme/playbooks/playbooks-integration-guide/) — how playbooks connect to your AI capabilities, CRM, and templates
