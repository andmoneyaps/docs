---
layout: default
title: Tag Mapping (Platform)
nav_order: 6
parent: Present
collection: present
---

# Tag Mapping on the Engage Platform

Tag mapping works the same way for everyone: you connect a tag in your templates to a field in
your CRM, and the value is filled in when a deck is generated. This page covers what is different
when your bank runs Present **on the Engage platform** rather than through the Salesforce package.

{: .note }
> **Which one applies to you?**
>
> If advisors create decks inside Salesforce with the Present component, follow
> [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) instead — everything there still applies.
> If they create decks in Engage, this page applies as well. Ask your &money contact if you are
> not sure which setup your bank has.

You still map tags in the same place: **Management UI → Present → Tags**. Each row shows the tag,
the CRM path its value is read from, and the templates the tag appears in.

![Tags overview]({{ site.baseurl }}/assets/images/present/platform_tags_overview.png)

## What is different

On the platform, Engage does not look up your CRM fields while the deck is being built.
Instead, it prepares the lookup **when you save the mapping**, and reuses it for every deck
afterwards.

Two things follow from that:

- **Your mapping is checked against the CRM as you save it.** A field that does not exist, or a
  path that cannot be followed, is caught immediately instead of showing up as an empty line on a
  slide weeks later.
- **A mapping that cannot be checked is not saved.** If the CRM cannot be reached at that
  moment, the save fails and nothing is changed. Try again in a few minutes.

## What you can map from

Three starting points, the same three as before:

| Start from | What it is |
|---|---|
| **Meeting** | The meeting record the deck is created from. |
| **Account** | The account on that meeting. |
| **Contact** | The contacts invited to that meeting — see [Several contacts](#several-contacts). |

From any of those you can follow a **lookup field** to another record and pick a field there. In the
field list, lookups are the ones marked `(reference)` — choosing one adds a step to the path shown
above the pickers and lets you continue on the record it points at. There is no limit on how many
steps you take, as long as every step is a lookup.

![Creating a tag mapping]({{ site.baseurl }}/assets/images/present/platform_tag_create_dialog.png)

The example above maps `preferred_name` to the full name of the account's owner: the path starts at
**Account**, follows `OwnerId` to the **User** record, and reads *Full Name* there. The same path
appears in the list afterwards, one step per chip.

The built-in **Specifik** object works as it always has: those values are filled in by Engage
itself and are not looked up in the CRM.

## When a mapping is refused

Some mappings cannot be turned into a working lookup. The Tags page will not save them.

| Situation | What to do |
|---|---|
| The object or field no longer exists in the CRM | Check the spelling, or pick the field again from the list. |
| You followed a field that is not a lookup | Only lookup fields lead to another record. Pick a lookup, or stop at that field. |
| You followed a field that can point at several kinds of record | Fields like *Related To* may hold an account, an opportunity or something else. Engage cannot tell which, so choose a path that names one object. |
| Two tags whose names differ only in capitalisation | `Advisor` and `advisor` cannot both be mapped to the same record. Rename one in the template. |
| A tag name starting with an underscore | Names beginning with `_` are reserved. Rename the tag in the template. |

{: .important }
> The Tags page currently shows a general error when a mapping is refused, without the reason. Use
> the table above to work out which case you are in — and contact support if none of them fits.

## Why a tag can still come out blank

A blank tag on a slide is almost always one of these:

- **The tag is not mapped.** Unmapped tags are filled in by the advisor in the validation step
  before the deck is generated. That is intentional — see
  [Unmapped tags]({{ site.baseurl }}/present/tag-mapping/#unmapped-tags).
- **The record has no value.** The mapping is fine, the field is simply empty on that account or
  contact.
- **A step in the path is missing.** If the meeting has no account, every tag that starts from the
  account is blank for that deck. The rest of the deck is unaffected.
- **The mapping was saved but not yet activated.** Rare, and worth reporting — see below.

## Several contacts

A meeting can have more than one contact. Tags that start from **Contact** therefore have more than
one value, and how they appear depends on the tag: a tag meant for one person shows the first
contact, while a tag meant for a household can show all of them, separated by commas.

If you need a specific person rather than "the contacts on the meeting", map through the account
instead.

## When tags stop updating

If mapped tags suddenly render blank, or an object was renamed in the CRM, the stored lookup can
fall out of step with your CRM setup. That is not something you can fix from the Tags page —
contact &money support, and mention which tags are affected. Rebuilding the lookup for your bank
takes a moment and does not change your mappings.

## Related

- [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) — mapping tags in the Salesforce package,
  including tag modifiers and unmapped tags
- [Template Creation Guide]({{ site.baseurl }}/present/Present-Usage/) — how tags are written in a
  template
- [Reporting]({{ site.baseurl }}/present/trouble-shooting/) — how to report a problem
