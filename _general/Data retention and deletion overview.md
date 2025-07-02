---
---
layout: default
title: Data Retention and Deletion Overview
nav_order: 2
parent: General
collection: general
---

# Data Retention and Deletion Overview

---

## Organizations Service

### Advisor Deletion

- Advisors are **soft deleted** initially.
- After **30 days**, a **hard deletion** is automatically triggered.
- The `AdvisorDeletionJobs` process manages and executes permanent deletions.

## Calendar Service

### Reserved Timeslots

- **Soft deleted timeslots** are kept for **7 days**.
- After 7 days, the `HardDeleteReservedTimeslotsInThePast` job permanently deletes them.
- This job runs **daily at 20:00 UTC**.

### Busy Timeslots

- **Soft deleted busy timeslots** are retained for **7 days**.
- Permanent deletion is handled by the `HardDeleteBusyTimeSlotsInThePast` job.
- This job also runs **daily at 20:00 UTC**.

### Temporary Reservations

- Temporary timeslot reservations **expire after 5 minutes**.
- Expired reservations are automatically cleaned up by the system.

### Meeting Title Cleanup

- Meeting titles are removed from the database when meetings are over a month old.
- This is managed by a nightly job that checks for and cleans up old meetings.
