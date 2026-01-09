---
layout: default
title: Timezone Configuration
nav_order: 10
parent: BookMe
---

# Timezone Configuration

---

## Overview

Timezone configuration allows you to set the timezone for your bank. This determines how meeting times are displayed in Outlook calendar invites sent to customers and advisors.

---

## Supported Timezones

Currently, the following timezones are supported:

| Timezone | Display Name | UTC Offset |
|----------|--------------|------------|
| Romance Standard Time | Brussels, Copenhagen, Madrid, Paris | UTC+01:00 |
| Greenland Standard Time | Greenland | UTC-02:00 |

---

## How to Configure

1. Go to **Management UI** and select **BookMe -> Meeting setup**
2. Locate the **Timezone** dropdown in the **General** zone
3. Select the appropriate timezone for your bank
4. Save your changes

---

## How It Works

When a meeting is created, the Calendar Service uses your bank's configured timezone to set the timezone on the Outlook calendar event. This ensures that:

- Meeting times display correctly in the recipient's Outlook calendar
- The timezone label shown in Outlook matches your bank's location
- Daylight saving time adjustments are handled automatically

---

## Default Behavior

If no timezone is configured, the system defaults to **Romance Standard Time** (Copenhagen/Paris timezone, UTC+01:00).
