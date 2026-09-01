# Address Lookup for Offsite Meetings

This page describes which address service BookMe Schedule uses, what it returns, and how the travel-time calculation depends on it.

## Overview

When an advisor books an 'ude af huset'/offsite meeting, they type part of an address and pick it from a suggestion list. The chosen start and end addresses feed the travel-time calculation, which adds travel slots to the advisor's calendar.

## Provider

Address search uses **Adressevælgeren**, Klimadatastyrelsen's address API, at `https://adressevaelger.dk`.

Adressevælgeren replaced DAWA (Danmarks Adressers Web API), which closed permanently on 1 October 2026.

The lookup runs in two steps:

1. **Search** — `GET /adresser/soeg?tekst={query}&token={token}` returns candidate addresses. Each candidate has an id and a display title, but **no coordinates**. The UI shows only results of type `adresse`; street-name results are ignored.
2. **Lookup by id** — `GET /adresser/{id}?token={token}` returns the full record. The position sits in `adgangspunkt.koordinater` as **ETRS89/EPSG:25832** easting and northing in metres.

BookMe Schedule converts the EPSG:25832 position to WGS84 longitude and latitude before it enters the booking flow, because the travel-time calculation (Azure Maps) expects degrees.

## Authentication

Every call carries a `token` query parameter. Until Klimadatastyrelsen's user management arrives (expected late 2026 or early 2027), all callers use the shared token that their documentation prescribes. It is not a secret.

## Behavior notes

- Typing three or more characters produces suggestions; fewer produces none.
- A saved advisor start/end address is stored as text and re-resolved on page load. It receives a position when the search returns exactly one result, or when exactly one result's title equals the stored text. Otherwise the address keeps its text without a position, and no travel time is calculated for it.
- A failure of the address service shows an error message in the address picker. An address with no matches shows an empty list. The two cases are distinct on purpose.
- **Place-name search is no longer available.** DAWA also searched Danske Stednavne, so an advisor could find a place such as "Tivoli" by name. Adressevælgeren only offers addresses and street names, and the data supplier does not offer a replacement.
