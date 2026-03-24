---
layout: default
title: Entity Configuration Management
nav_order: 7.6
parent: BookMe
---

# Entity Configuration Management

Entity definitions and patterns need to be consistent across all banks that use the same features. Rather than manually recreating them in each bank, you should maintain a **single source of truth** and distribute configurations from there.

This page covers:
- [Source of truth](#source-of-truth) — where to maintain the master configuration
- [Exporting configurations](#exporting-configurations) — how to extract JSON from the source bank
- [Source tracking](#source-tracking-the-json) — storing exports in version control
- [Importing to target banks](#importing-to-target-banks) — distributing configurations as part of onboarding

For a conceptual overview of entity definitions and patterns, see [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/).

---

## Source of truth

Designate one bank as the master for entity configurations — typically your **test environment**. All entity definitions and patterns should be created and validated in this bank first. Changes are made here, exported, and then distributed to customer banks.

---

## Exporting configurations

Entity patterns and definitions are exported as JSON from the Management UI:

1. Navigate to **Admin → Entities → Entity Patterns** in the source bank
2. Find the pattern you want to export
3. Click the **export icon** on the pattern row
4. In the modal that opens, click **Copy** to copy the JSON to your clipboard

{: .hint }
> Entity pattern exports **automatically include all referenced entity definitions**. You do not need to export entity definitions separately when they are part of a pattern.

Each exported entity has a **semantic ID** — a stable identifier that persists across environments. When the same JSON is imported into a different bank, the platform uses the semantic ID to determine whether to create a new entity or update an existing one.

You can also export individual entity definitions from **Admin → Entities → Entity Definitions** if needed (e.g., for definitions that are not part of any pattern).

---

## Source tracking the JSON

Store the exported JSON files in version control alongside your deployment scripts or onboarding documentation. A recommended structure:

```
entity-configurations/
├── patterns/
│   ├── internal-bookme-meeting.json
│   ├── bookme-meeting.json
│   └── accountid-resolver.json
└── definitions/
    ├── case.json
    ├── lead-fsc.json
    └── custom-object.json
```

This gives you:
- A versioned history of configuration changes
- A reviewable diff when entity definitions are modified
- A reliable source for automated or manual onboarding

---

## Importing to target banks

When onboarding a new bank:

1. Navigate to **Admin → Entities → Entity Patterns** in the target bank
2. Click **Import** in the top right corner
3. Paste the JSON from your source-tracked file into the textarea
4. Confirm the import

The import is **atomic** — if any part fails (e.g., a field type mismatch), the entire import is rolled back. Referenced entity definitions are imported automatically as part of the pattern import.

For definitions that are not part of a pattern, import them individually via **Admin → Entities → Entity Definitions → Import**.

{: .warning }
> **Mappers are bank-specific and cannot be exported.** After importing patterns into a new bank, you must manually create the entity pattern mappers that link patterns to use cases. See [Setup Entity Pattern Mappers]({{ site.baseurl }}/embeddable-ui/setup-entity-pattern-mappers/) for step-by-step instructions.

---

## Related Documentation

- [Entities and Entity Patterns]({{ site.baseurl }}/bookme/entities-and-entity-patterns/) — conceptual overview of the entity abstraction layer
- [Setup Entity Pattern Mappers]({{ site.baseurl }}/embeddable-ui/setup-entity-pattern-mappers/) — step-by-step mapper creation guide
- [Internal Meetings Deployment Guide]({{ site.baseurl }}/bookme/internal-meetings-deployment-guide/) — entity configuration specific to internal meetings
