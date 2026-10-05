---
layout: default
title: Tag Mapping (Dynamics)
nav_order: 6
parent: Present
collection: present
---

# Tag Mapping (Dynamics)

A tag mapping tells Present where a tag in your templates gets its value: which field in your CRM,
reached from the meeting the deck is created for. Tags nobody has mapped are left for the advisor to
fill in, apart from the [reserved tags](#reserved-tags), which are filled in automatically.

This page is for banks whose advisors create decks in **Engage**. If your advisors create decks inside
Salesforce with the **Present package**, see [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/)
instead.

Tags are mapped under **Management UI → Present → Setup → Tags**. Ask your &money contact if you are
not sure where your advisors create decks.

![The Tags page]({{ site.baseurl }}/assets/images/present/platform_tags_overview.png)

Each row shows a mapped tag, the path its value is read from, and the templates the tag appears in.

{: .note }
> **Mapping is for administrators.** On Dynamics 365 the page reads the CRM as you, so you also need
> administrator rights in the Dynamics environment itself.

## Map a tag

1. Click **Create**.
2. **Which tag are you mapping?** Choose a tag. The list holds every tag in your uploaded templates,
   except the [reserved tags](#reserved-tags).
3. **Where does its value come from?** Every mapping starts on the meeting. Pick a field to finish, or
   pick a linked record to keep going. The list offers the meeting's fields, the records it points to,
   and the records that point back to it — such as the people invited to the meeting.
4. Check **The mapping** on the right. It shows each step of the path and, when you have set an example
   meeting, the value each step holds.
5. Click **Create**, or **Save** when you are editing a mapping.

![Editing a tag mapping]({{ site.baseurl }}/assets/images/present/platform_tag_edit_dialog.png)

In this example, `customer_name` is filled in from the meeting's account: the path starts on the
appointment, follows *regardingobjectid* to the account, and reads its *name*.

The path is what gets saved. It runs on every meeting, not only on the example.

## See real values while you map

**Set an example meeting** to check a mapping before advisors rely on it. Find a meeting by name, or
paste its record id. Every field list and the mapping then show what that meeting holds. The example is
optional: you can save without one.

**Try it out** shows what every saved mapping gives for one meeting.

![Try it out]({{ site.baseurl }}/assets/images/present/platform_tags_try_it_out.png)

| You see | It means |
|---|---|
| A value | The path finds this value for this meeting. Decks read it separately, so treat this as a strong check, not a guarantee. |
| *— empty on this record* | The mapping works, but the field is empty on this meeting's record. |
| *No record on this example* | A step in the path found no record — for example, the meeting has no account. |
| *Not verified* | The value could not be checked. |

## When a mapping cannot be saved

**Create** and **Save** stay disabled until the mapping is complete and valid. The message under the
mapping tells you why.

| Message | What to do |
|---|---|
| *The path isn't finished yet.* | You ended on a linked record. Pick a field on it. |
| *Loading this bank's CRM objects — saving waits until they have all answered.* | Wait a moment. |
| *Checking whether the CRM will return this column…* | Wait a moment. |
| *The CRM will not return this field. Choose another one.* | Pick a different field. On Salesforce, a field the CRM refuses stops decks from being generated at all until the mapping is fixed. On Dynamics 365, it leaves the tags that go through that record blank — all of them, if the field is on the meeting. |
| *Fix '…' first. Saving one mapping rewrites them all.* | Another mapping is broken. Open it and fix it, or delete it. |
| *…points at more than one kind of record, so the walk must say which* | Pick the option for the kind of record you mean. |
| *…is too deep to store* | The path has too many steps. Choose a shorter route to the same field. |
| *'…' starts with '_', which is reserved* | Rename the tag in the template. |
| *'…' and '…' cannot both read …, because field names there ignore capitalisation* | Two tags differ only in capitalisation. Rename one of them in the template. |
| *These mappings could not be resolved, so nothing was saved: …* | A field or record type in a named mapping no longer exists, or you cannot read it. Fix or delete that mapping. |
| *The CRM could not describe '…', so its fields cannot be offered.* | Usually you cannot read that record type in your CRM. If it still fails after a reload, check your access or contact &money support. |

## Why a tag can come out blank

- **The tag is not mapped.** The advisor fills it in when creating the deck.
- **The field is empty** on that meeting's record.
- **A step in the path is missing** for that meeting — for example, a meeting without an account leaves
  every tag that goes through the account blank.
- **It is a form of address or the agenda under another name.** Only the
  [reserved names](#reserved-tags) are filled in automatically.

If every mapped tag is suddenly blank, contact &money support and say which tags are affected.

## Several people on a meeting

A mapping that goes through the people invited to a meeting has one value per person. Engage joins them
into one text, in Danish: *Anna, Bo og Carl*.

## Reserved tags

Seven tag names are reserved. When a slide uses one of them, the value is filled in automatically when
the advisor builds the presentation. A reserved tag is not mapped to a CRM field on the Tags page. The
advisor can still change the value in the step where the tag values are filled in.

Five of them are the Danish forms of address, so a slide can say *din opsparing* to one customer and
*jeres opsparing* to a couple. The other two, `agenda` and `dagsorden`, both stand for the meeting
agenda, which the advisor writes in the first step of the presentation. A template may use either.

### The reserved tags

| Tag | Én person | Flere personer |
|---|---|---|
| `[tag:du_i]` | du | I |
| `[tag:dig_jer]` | dig | jer |
| `[tag:din_jeres]` | din | jeres |
| `[tag:dit_jeres]` | dit | jeres |
| `[tag:dine_jeres]` | dine | jeres |
| `[tag:agenda]` | the agenda the advisor wrote | |
| `[tag:dagsorden]` | the agenda the advisor wrote | |

The words are lowercase, except *I*, which is always a capital. For a form of address at the start
of a sentence, add the `capitalize` modifier: `[tag:din_jeres:capitalize]` gives *Din* or *Jeres*.

### When you build templates

- Use the names as spelled above. Capital letters do not matter: `Dagsorden` works like `dagsorden`.
  Any other spelling is an ordinary tag and comes out blank.
- If your templates use other names for the forms of address, rename those tags to the five above.
  Present does not translate one name into another.
- You do not need to do anything else. The tags work as soon as a template with them is uploaded.
- Put `agenda` or `dagsorden` in a bulleted text box. The agenda is written as bullet points, and each point
  becomes a bullet on the slide.

### When you build presentations

In step 3, **Kundepræsentation**, the reserved tags are already filled in based on the meeting. At the
top of the step, under **Præsentationen henvender sig til**, two buttons choose who the presentation
addresses:

![Præsentationen henvender sig til: Én person / Flere personer]({{ site.baseurl }}/assets/images/present/reserved_tags_number_toggle.png)

- **Én person** gives the singular forms, **Flere personer** the plural ones. The choice applies to
  every form of address at once, and you can change it at any time.
- To begin with, the choice follows the number of accounts on the meeting: one account gives
  **Én person**, more than one gives **Flere personer**. Your own colleagues on the meeting are not
  counted.
- A contact on the meeting counts as its account, so several contacts from one account count once. A
  contact without an account counts on its own.
- If you are addressing several people from one account, such as a household, choose
  **Flere personer**.
- If the number of accounts could not be fetched, the line *Antallet af kunder kunne ikke hentes
  — vælg selv.* appears under the buttons and **Én person** is chosen to begin with.
- Every field can also be edited by hand, like any other tag. A field you have typed into keeps your
  text when you change the choice.

The two buttons are shown on every presentation, also one whose slides use none of these tags.

### When you set up tags in the Management UI

There is nothing to set up for the reserved tags. On **Present → Setup → Tags** they are simply not
in the list of tags you can map, because there is no CRM field to point them at. An info icon next
to the tag field names the ones your templates use and says they are filled out automatically.

The table still shows each reserved tag your templates use, with the templates that use it and the
text **Filled out automatically** where other tags show a CRM field. It has no edit or delete
buttons, and needs none.

## Good to know

- **Saving one mapping rewrites all of them.** If two administrators save at the same time, the last
  save wins.
- **A broken mapping blocks every save** — for example after a field is removed from your CRM — until
  it is fixed or deleted.
- **Tag names that differ only in capitalisation** (`Advisor` and `advisor`) count as the same tag here.
  Only one of them can be mapped.
- **Tag modifiers** such as `[tag:name:uppercase]` work the same way as with the Present package — see
  [Tag Modifiers]({{ site.baseurl }}/present/tag-mapping/#tag-modifiers-new-feature).

## Related

- [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) — mappings for the Present package, tag modifiers
  and unmapped tags
- [Template Creation Guide]({{ site.baseurl }}/present/Present-Usage/) — how tags are written in a
  template
- [Reporting]({{ site.baseurl }}/present/trouble-shooting/) — how to report a problem
