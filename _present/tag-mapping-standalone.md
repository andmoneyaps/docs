---
layout: default
title: Tag Mapping (Standalone)
nav_order: 6
parent: Present
collection: present
---

# Tag Mapping (Standalone)

A tag mapping tells Present where a tag in your templates gets its value: which field in your CRM,
reached from the meeting the deck is created for. Tags nobody has mapped are left for the advisor to
fill in.

This page is for banks that use Present **standalone**, where advisors create decks in Engage. If your
advisors create decks inside Salesforce with the Present package, your mappings are **legacy** mappings
— see [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) instead.

| | Standalone | Legacy |
|---|---|---|
| Advisors create decks in | Engage | Salesforce, with the Present package |
| CRM | Salesforce or Dynamics 365 | Salesforce |
| Who can map tags | Administrators | Configurators and administrators |
| The Tags page shows | **Try it out**, and a mapping that starts on the meeting | An *Object type* choice: Account, Contact, Event or Specifik |
| `Specifik` tags | Not supported yet — they cannot be mapped at all | Supported |
| Guide | This page | [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) |

Both kinds are mapped under **Management UI → Present → Setup → Tags**, and the page shows the one that
matches your bank. Ask your &money contact if you are not sure which your bank has.

![The Tags page for a standalone bank]({{ site.baseurl }}/assets/images/present/platform_tags_overview.png)

Each row shows a mapped tag, the path its value is read from, and the templates the tag appears in.

## Map a tag

1. Click **Create**.
2. **Which tag are you mapping?** Choose a tag. The list holds every tag in your uploaded templates.
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
- **It is a `Specifik` tag.** These are not supported yet: they cannot be mapped at all, so the advisor
  fills them in when creating the deck. The one exception is the `agenda` tag, which Engage fills from
  the agenda you build there.

If every mapped tag is suddenly blank, contact &money support and say which tags are affected.

## Several people on a meeting

A mapping that goes through the people invited to a meeting has one value per person. Engage joins them
into one text, in Danish: *Anna, Bo og Carl*.

## Salesforce and Dynamics 365

Mapping works the same way on both CRMs. The differences you will notice:

| | Salesforce | Dynamics 365 |
|---|---|---|
| The meeting | Event | Appointment |
| The people invited | Event Relation | Activity Party |
| A path that ends on a linked record | Shows that record's name | Most record types have no name field, so pick a field on the linked record |
| Pasting a meeting's record id | The 15- or 18-character Salesforce id | The appointment's GUID |
| What the Tags page can show you | What your bank's Salesforce connection can read | Only what your own Dynamics security role allows |

## Good to know

- **Saving one mapping rewrites all of them.** If two administrators save at the same time, the last
  save wins.
- **A broken mapping blocks every save** — for example after a field is removed from your CRM — until
  it is fixed or deleted.
- **Tag names that differ only in capitalisation** (`Advisor` and `advisor`) count as the same tag here.
  Only one of them can be mapped.
- **Tag modifiers** such as `[tag:name:uppercase]` work the same way as with legacy mappings — see
  [Tag Modifiers]({{ site.baseurl }}/present/tag-mapping/#tag-modifiers-new-feature).

## Related

- [Tag Mapping]({{ site.baseurl }}/present/tag-mapping/) — legacy mappings, tag modifiers and unmapped
  tags
- [Template Creation Guide]({{ site.baseurl }}/present/Present-Usage/) — how tags are written in a
  template
- [Reporting]({{ site.baseurl }}/present/trouble-shooting/) — how to report a problem
