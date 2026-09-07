---
layout: default
title: Address Lookup for Offsite Meetings
parent: BookMe
nav_order: 12.5
collection: bookme
---

# Address Lookup for Offsite Meetings

When an advisor books an out-of-office meeting ("ude af huset"), they type part of an address and pick it from a suggestion list. BookMe uses the chosen start and end addresses to calculate travel time and to add travel slots to the advisor's calendar.

This page explains which service answers those address lookups, what your organisation needs to allow, and how the feature behaves in day-to-day use.

## The address provider

Address suggestions come from **Adressevælgeren**, the national address service run by the Danish Climate Data Agency (Klimadatastyrelsen), at `https://adressevaelger.dk`.

Adressevælgeren replaces DAWA (Danmarks Adressers Web API), the provider BookMe used before. Klimadatastyrelsen retires DAWA on 1 October 2026.

The lookup runs in the advisor's browser: a search that returns matching addresses, then a lookup of the chosen address that returns its position. No BookMe configuration is needed. Your organisation may need to allow the host, see below.

## What your organisation needs to know

{: .note }
> Advisors' browsers must be able to reach `https://adressevaelger.dk`. If your organisation restricts outbound browser traffic, add this host to the allow list.

- **No credentials to manage.** BookMe accesses Adressevælgeren with a shared access key that Klimadatastyrelsen prescribes for the transition period. Klimadatastyrelsen plans per-organisation access management later (expected late 2026 or early 2027). BookMe will absorb that change; no action is needed from you now.
- **What leaves the browser.** The request to Adressevælgeren carries the address text the advisor types and the shared access key. It carries no customer name, meeting details, or other data.

## How it behaves

- **Suggestions appear after three characters.** Shorter input gives no suggestions.
- **Street names narrow the search.** The list can include a street name without a house number. Choosing it fills the field with the street and shows the addresses on that street. Only a complete address gets a position.
- **Saved advisor addresses.** An advisor's saved start and end addresses are stored as text. When the booking page opens, BookMe looks the text up again to find its position. The position is found when the search returns exactly one match, or when exactly one match reads the same as the saved text. Otherwise the address keeps its text without a position, and BookMe calculates no travel time for it until the advisor picks it from the list again.
- **Service failure and no match look different.** If Adressevælgeren cannot be reached or answers with an error, the address picker shows an error message. If the service answers but finds nothing, the list is simply empty.
- **Place-name search is no longer available.** DAWA also searched Danish place names (Danske Stednavne), so an advisor could type "Tivoli" and get a suggestion. Adressevælgeren offers addresses and street names only, and Klimadatastyrelsen offers no replacement. Advisors must type the street address of such places.
