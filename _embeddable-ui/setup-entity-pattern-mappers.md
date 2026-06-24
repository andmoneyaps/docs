---
layout: default
title: Setup Entity Pattern Mappers
parent: Embeddable UI
nav_order: 4
---

# Setup Entity Pattern Mappers

This guide walks through setting up entity pattern mappers for a new bank.

## Prerequisites

- Access to a bank that already has entity pattern mappers configured (the "source" bank)
- Access to the bank that needs the new entity pattern mappers (the "target" bank)

## Step 1: Export and import entity patterns

Before creating the mappers, four entity patterns need to be imported into the target bank.

1. In the **source** bank, navigate to **Admin** > **Entities** > **Entity patterns**
2. Find **Internal BookMe Meeting** and click the export icon (first icon in the list)
3. In the modal that opens, click **Copy**, then close the modal
4. Switch to the **target** bank and navigate to **Admin** > **Entities** > **Entity patterns**
5. Click **Import** in the top right corner of the page
6. Paste the copied content into the textarea and confirm the import

Repeat this process for the remaining three entity patterns:

- **AccountId Resolver**
- **Bookme meeting**
- **Salesforce meeting id resolver**

## Step 2: Create entity pattern mappers

Once all four entity patterns have been imported, navigate to **Entity pattern mapper** and click **Create** in the top right corner.

Add the following four mappers:

### 1. BookMeMeeting

| Field          | Value              |
| -------------- | ------------------ |
| Use case       | BookMeMeeting      |
| Entity pattern | Bookme meeting     |

### 2. InternalBookMeMeeting

| Field          | Value                    |
| -------------- | ------------------------ |
| Use case       | InternalBookMeMeeting    |
| Entity pattern | Internal BookMe Meeting  |

### 3. CustomerOverviewAccountIdResolver

| Field          | Value              |
| -------------- | ------------------ |
| Use case       | CustomerOverviewAccountIdResolver |
| Entity pattern | AccountId Resolver |

This mapper also requires a field mapping:

1. Click **Add Field mapping**
2. Set **Pattern part** to `business-account`
3. Set **Entity field** to `Id`

### 4. SummaryMeetingIdResolver

| Field          | Value                            |
| -------------- | -------------------------------- |
| Use case       | SummaryMeetingIdResolver         |
| Entity pattern | Salesforce meeting id resolver   |

This mapper also requires a field mapping:

1. Click **Add Field mapping**
2. Set **Pattern part** to `bookme-event-detail`
3. Set **Entity field** to `BookingFlowId`
