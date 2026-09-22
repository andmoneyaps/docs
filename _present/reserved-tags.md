---
layout: default
title: Reserved Tags
nav_order: 6
parent: Present
collection: present
---

# Reserved Tags

Six tag names belong to Present itself. Put one of them on a slide and Present fills it in when the
advisor builds the presentation. Nobody maps them, and nobody types them.

Five of them are the Danish forms of address, so a slide can say *din opsparing* to one customer and
*jeres opsparing* to a couple. The sixth is the meeting agenda, which the advisor writes in the first
step of the presentation.

{: .note }
> This page is about the new Present experience that opens from the meeting in your CRM (UWC Present),
> on Dynamics and on Salesforce. The Present component inside Salesforce (the managed package) is not
> changed: there, forms of address are still mapped as **Object type = Specific**, as described in the
> [super-user guide]({{ site.baseurl }}/business-implementation/present/en/superbrugerguide/).

## The six tags

| Tag | One customer | Several customers |
|---|---|---|
| `[tag:du_i]` | du | I |
| `[tag:dig_jer]` | dig | jer |
| `[tag:din_jeres]` | din | jeres |
| `[tag:dit_jeres]` | dit | jeres |
| `[tag:dine_jeres]` | dine | jeres |
| `[tag:agenda]` | the agenda the advisor wrote | |

The words are lowercase, except *I*, which is always a capital. For a form of address at the start
of a sentence, add the `capitalize` modifier: `[tag:din_jeres:capitalize]` gives *Din* or *Jeres*.

## If you build templates

- Use the names exactly as spelled above, in lowercase. `[tag:du_eller_i]` is an ordinary tag and
  comes out blank.
- If your templates use other names for the forms of address, rename those tags to the six above.
  Present does not translate one name into another.
- You do not need to do anything else. The tags work as soon as a template with them is uploaded.
- The agenda tag still has to stand as bullet points on the slide, as before.

## If you build presentations

In the tags step you will see the forms of address already filled in, marked **Bydeform**.

- Above the tags there is a switch, **Præsentationen henvender sig til**, with two positions:
  **Én person** and **Flere personer**. It decides every form of address at once. Flip it and all of
  them change.
- On a Dynamics bank the switch is set for you from the number of customers on the meeting: one
  customer gives **Én person**, more than one gives **Flere personer**. Your own colleagues on the
  meeting are not counted.
- A company or a household on the meeting counts as one customer. If you are addressing several
  people from it, flip the switch to **Flere personer**.
- You can still edit any single field. A field you have typed into keeps your text when the switch
  is flipped.
- If Present could not fetch the number of customers, the line *Antallet af kunder kunne ikke hentes
  — vælg selv.* appears under the switch, and it starts on **Én person**. Set it yourself. This is
  always the case on a Salesforce bank for now.

Nothing changes for a presentation whose slides do not use these tags, apart from the switch being
shown.

## If you set up tags in the Management UI

On **Present → Setup → Tags**:

- The six names are not offered when you create or edit a tag mapping. An info icon next to the tag
  field lists the ones your templates use and says they are filled out automatically.
- Each reserved tag your templates use is shown in the table with the templates that use it and the
  text **Filled out automatically** instead of a CRM field. It has no edit or delete buttons.
- If one of these names was mapped to a CRM field before this change, that mapping still shows in the
  table and can be deleted. It is not used any more. Delete it to keep the table tidy.
