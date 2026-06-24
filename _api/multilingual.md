---
layout: default
title: Multilingual Support (V3)
parent: Public API
nav_order: 6
---

# Multilingual Support (V3)

API V3 supports multilingual content for five customer-facing field groups in a fully **additive** way. Every existing V3 integration keeps working with **zero code changes** — the legacy single-language fields are still present, still populated, and still hold a plain string. Integrations that *want* to serve customers in multiple languages can opt into the new `localized*` sibling fields and the `?lang=` query parameter at their own pace.

{: .note }
> This change is additive on **V3** — there is no V4 and no breaking change. If you do nothing, your integration is unaffected. See [Why no version bump?](#why-no-version-bump).

## Translatable field groups

| Field group | Legacy field | New sibling field |
|---|---|---|
| Meeting topic name | `name` | `localizedName` |
| Meeting type label | `label` | `localizedLabel` |
| Employee option label | `label` | `localizedLabel` |
| iCal meeting title | `iCalMeetingTitle` | `localizedICalMeetingTitle` |
| iCal meeting description | `iCalMeetingDescription` | `localizedICalMeetingDescription` |

The legacy fields and the new `localized*` siblings are kept in sync automatically by the platform — see [Writing translations](#writing-translations).

## Why no version bump?

The breaking alternative would have been to change all five fields from `string` to a locale map in a new V4, forcing every consumer into a coordinated cutover — including integrations that read the fields as plain strings.

The additive approach wins on coexistence: legacy consumers see the legacy shapes unchanged, while multilingual-aware consumers use the new siblings. If a future cleanup ever deprecates the legacy fields, you will have a full adoption window before anything changes.

## The `LocalizedString` shape

`LocalizedString` is a plain JSON object whose keys are canonical [BCP 47](https://www.rfc-editor.org/info/bcp47) locale tags and whose values are the translated text:

```json
{
  "da-DK": "Boligrådgivning",
  "en-GB": "Housing advisory",
  "kl-GL": "Illumi siunnersuineq"
}
```

- Keys are case-insensitive on write; the server canonicalises them to the form above.
- Each bank has a set of **enabled locales** configured by the bank admin in the Management UI. Writing a key outside that set returns `400` (see [Write validation](#write-validation)).
- `da-DK` (Danish) is always enabled, cannot be removed, and is always the fallback (see [Supported locales](#supported-locales)).

## The `?lang=` query parameter

Every read endpoint that returns a translatable field accepts an optional `?lang=<tag>` query parameter:

| `?lang=` value | Response on each translatable field |
|---|---|
| *(omitted)* | Full locale map — every **enabled** locale that has an authored translation |
| `all` | Same as omitted — full locale map |
| A specific tag (`da-DK`, `en-GB`, `kl-GL`, …) | Single-entry map keyed by the requested tag. If no translation is authored for that tag, the value is the **Danish fallback** |
| A tag not enabled for this bank (e.g. `fr-FR`) | Single-entry map keyed by the requested tag, value is the **Danish fallback** |

{: .important }
> A translatable field is **never** `null` or empty on read. If a requested locale has no authored translation, the Danish (`da-DK`) value is returned in its place — so your integration never needs its own fallback logic.

{: .warning }
> **Disabled locales are never returned.** If a bank enabled `en-GB`, authored translations, then later disabled `en-GB`, the authored text is preserved in storage (not deleted) but is filtered out of responses until the locale is re-enabled.

## Affected surfaces

Both read and write (`POST` / `PATCH`):

- `GET` / `POST` / `PATCH /api/v3/bookme/meeting-topics` — `name` / `localizedName`
- `GET` / `PATCH /api/v3/bookme/config/organization-settings` — the iCal title/description and label fields

## Reading translations

### Full locale map

```http
GET /api/v3/bookme/meeting-topics?isCustomer=false&lang=all
```

```json
[
  {
    "id": "e9c7…",
    "name": "Boligrådgivning",
    "localizedName": {
      "da-DK": "Boligrådgivning",
      "en-GB": "Housing advisory",
      "kl-GL": "Illumi siunnersuineq"
    },
    "uniqueTopicId": "housing-advisory",
    "parentId": null,
    "order": 1
  }
]
```

### Single locale

```http
GET /api/v3/bookme/meeting-topics?isCustomer=false&lang=en-GB
```

```json
[
  {
    "id": "e9c7…",
    "name": "Boligrådgivning",
    "localizedName": { "en-GB": "Housing advisory" },
    "uniqueTopicId": "housing-advisory",
    "parentId": null,
    "order": 1
  }
]
```

The legacy `name` field is unchanged at `"Boligrådgivning"` regardless of `?lang=` — it always carries the Danish string for non-multilingual consumers.

### Danish fallback

```http
GET /api/v3/bookme/meeting-topics?isCustomer=false&lang=fr-FR
```

```json
[
  { "localizedName": { "fr-FR": "Boligrådgivning" } }
]
```

`fr-FR` is not an enabled locale, so the response carries the Danish value in the `fr-FR` slot.

## Writing translations

Either write shape is accepted.

**Shape A — legacy only (no code change required):**

```json
{
  "name": "Boligrådgivning",
  "uniqueTopicId": "housing-advisory"
}
```

The server mirrors `name` into `localizedName = { "da-DK": "Boligrådgivning" }` automatically.

**Shape B — locale map:**

```json
{
  "name": "Boligrådgivning",
  "localizedName": {
    "da-DK": "Boligrådgivning",
    "en-GB": "Housing advisory",
    "kl-GL": "Illumi siunnersuineq"
  },
  "uniqueTopicId": "housing-advisory"
}
```

When `localizedName` is present, its `da-DK` entry wins: the server mirrors `localizedName["da-DK"]` into the legacy `name` field.

### PATCH semantics

`PATCH` **merges** your incoming locale map with the stored state:

```json
[
  { "op": "replace", "path": "/localizedName", "value": { "en-GB": "Housing advisory" } }
]
```

This adds or updates the `en-GB` entry **without touching** authored `da-DK` or `kl-GL` entries already in storage — so a client that only knows about one locale can patch in its own language without replaying the full map.

### Write validation

- Every key in the submitted locale map must be in the bank's **enabled-locales** set. A key that is not enabled returns `400 Bad Request` (standard `{ code, message }` error envelope).
- The Danish (`da-DK`) entry is required for the final stored state (either incoming, or merged from storage). Submitting only `en-GB` for a topic that has no stored `da-DK` fails validation.

## Opting in from an existing V3 integration

No migration steps, no URL changes, no header changes. Your existing requests continue to work unchanged. To surface translations to your end users:

1. **On reads**, add `?lang=<user-locale>` — or `?lang=all` to fetch everything up front and switch language client-side. Danish fallback is automatic.
2. **On writes**, populate `localizedName` / `localizedLabel` / `localizedICalMeeting*` alongside (or instead of) the legacy string field.

{: .note }
> If your SDK is generated from an older OpenAPI snapshot that doesn't know about the `localized*` fields, the server still accepts and returns them — the additive shape means unknown fields are tolerated on both sides.

## Supported locales

The initial delivery supports:

| Tag | Language |
|---|---|
| `da-DK` | Danish — always enabled, always the fallback |
| `en-GB` | English |
| `kl-GL` | Kalaallisut (Greenlandic) |

Additional European locales (`sv-SE`, `nb-NO`, `de-DE`, `de-AT`, `fr-FR`, `fr-BE`, `fi-FI`, `fo-FO`) are accepted by the schema and can be enabled per bank without a code or contract change.

## Related

- [BookMe API Documentation]({{ site.baseurl }}/api/bookme)
- [V2 to V3 Migration Guide]({{ site.baseurl }}/api/migration-guide-v3)
