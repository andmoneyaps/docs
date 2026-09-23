---
layout: default
title: Reserved Tags
nav_order: 6
parent: Present
collection: present
---

# Reserved Tags

Six tag names are reserved. When a slide uses one of them, the value is filled in automatically when
the advisor builds the presentation. A reserved tag is not mapped to a CRM field on the Tags page. The
advisor can still change the value in the step where the tag values are filled in.

Five of them are the Danish forms of address, so a slide can say *din opsparing* to one customer and
*jeres opsparing* to a couple. The sixth is the meeting agenda, which the advisor writes in the first
step of the presentation.

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

## When you build templates

- Use the names exactly as spelled above, in lowercase. Any other spelling is an ordinary tag and
  comes out blank.
- If your templates use other names for the forms of address, rename those tags to the six above.
  Present does not translate one name into another.
- You do not need to do anything else. The tags work as soon as a template with them is uploaded.
- Put the agenda tag in a bulleted text box. The agenda is written as bullet points, and each point
  becomes a bullet on the slide.

## When you build presentations

In step 3, **Kundepræsentation**, the forms of address are already filled in and marked
**Bydeform**. At the top of the step, under **Præsentationen henvender sig til**, two buttons choose
who the presentation addresses:

![Præsentationen henvender sig til: Én person / Flere personer]({{ site.baseurl }}/assets/images/present/reserved_tags_number_toggle.png)

- **Én person** gives the singular forms, **Flere personer** the plural ones. The choice applies to
  every form of address at once, and you can change it at any time.
- To begin with, the choice follows the number of customers on the meeting: one customer gives
  **Én person**, more than one gives **Flere personer**. Your own colleagues on the meeting are not
  counted.
- A company or a household on the meeting counts as one customer. If you are addressing several
  people from it, choose **Flere personer**.
- If the number of customers could not be fetched, the line *Antallet af kunder kunne ikke hentes
  — vælg selv.* appears under the buttons and **Én person** is chosen to begin with.
- Every field can also be edited by hand, like any other tag. A field you have typed into keeps your
  text when you change the choice.

The two buttons are shown on every presentation, also one whose slides use none of these tags.

## When you set up tags in the Management UI

There is nothing to set up for the reserved tags. On **Present → Setup → Tags** they are simply not
in the list of tags you can map, because there is no CRM field to point them at. An info icon next
to the tag field names the ones your templates use and says they are filled out automatically.

The table still shows each reserved tag your templates use, with the templates that use it and the
text **Filled out automatically** where other tags show a CRM field. It has no edit or delete
buttons, and needs none.
