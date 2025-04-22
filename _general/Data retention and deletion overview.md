---
layout: default
title: Data Retention and Deletion overview
nav_order: 2
parent: General
collection: general
---
# Data Retention and Deletion Overview

---

## Organizations Service

### Advisor Deletion

- **Soft deletion** is performed initially.
- After **30 days**, a **hard deletion** is automatically scheduled.
- The process uses `AdvisorDeletionJobs` to track and execute permanent deletion.



## Calendar Service

### Reserved Timeslots

- **Soft deleted timeslots** are retained for **7 days**.
- After 7 days, permanent deletion is handled by the `HardDeleteReservedTimeslotsInThePast` job.
- The job runs **daily at 20:00 UTC**.

### Busy Timeslots

- **Soft deleted busy timeslots** are retained for **7 days**.
- Permanent deletion is performed via the `HardDeleteBusyTimeSlotsInThePast` job.
- This job also runs **daily at 20:00 UTC**.

### Temporary Reservations

- Temporary timeslot reservations **expire after 5 minutes**.
- Expired reservations are automatically cleaned up by the system.
