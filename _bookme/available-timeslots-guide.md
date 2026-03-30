---
layout: default
title: Understanding Available Timeslots
nav_order: 15
parent: BookMe
collection: bookme
---

# Understanding Available Timeslots

## What Are Available Timeslots?

BookMe calculates which timeslots to show as available for a meeting based on a combination of factors: **who** is qualified to take the meeting, **when** they are free, **where** the meeting can happen, and **how** the meeting will be conducted. This guide explains each factor and how they interact.

---

## Meeting Types

BookMe supports four meeting types. Each timeslot is tied to a specific type:

| Meeting Type | Description |
|---|---|
| **Online** | Video meeting (e.g., Microsoft Teams) |
| **Physical** | In-person meeting at a branch location |
| **Telephone** | Phone call |
| **OffSite** | In-person meeting at the customer's location |


Advisors can be configured to offer different meeting types on different days. For example, an advisor might offer Online and Physical meetings on Mondays but only Online meetings on Fridays.

Which meeting types are available in the booking flow depends on the **meeting configuration** for the selected theme and customer category.

---

## How Advisors Are Matched to a Booking Request

Not every advisor in the organization will appear as available for every booking request. BookMe narrows down the pool using several criteria.

### 1. Skills

Advisors can be assigned **skills** that define which meeting topics (themes) and customer segments (customer categories) they can handle.

**Example**: An advisor with the skills *Mortgage* and *Premium Customers* will appear as available when a premium customer requests a mortgage meeting --- but not for a savings account meeting.

### 2. Competence Groups

In addition to direct skill assignments, advisors can belong to **competence groups**. A competence group links a set of advisors to specific themes and customer categories.

Competence groups are **hierarchical** --- they can contain sub-groups. When a competence group matches a booking request, all advisors in that group *and all of its sub-groups* are included.

**Example**:

```
Financial Advisory (competence group)
  Themes: Finance, Investment
  Advisors: Alice, Bob
  |
  +-- Mortgage Specialists (sub-group)
        Advisors: Charlie
        |
        +-- First-Time Buyer Experts (sub-group)
              Advisors: Diana
```

A booking request for the *Finance* theme would match the top-level group and include all four advisors: Alice, Bob, Charlie, and Diana.

An advisor is considered **qualified** if they have either a direct skill match or belong to a matching competence group (including sub-groups).

### 3. Location

For bookings at a specific branch, BookMe looks for advisors who are **registered at that location** (via the organizational directory) or who have **workdays configured at that location**. Only advisors at the relevant branch are considered as local advisors.

### 4. Bookability Settings

Each advisor has schedule settings that control their availability:

- **Can Be Booked** --- If turned off, the advisor is completely excluded from all booking availability.
- **Only Explicitly Available** --- If turned on, the advisor does not appear in the general booking pool. They can only be booked when specifically selected by name or through explicit availability windows.

---

## Local Advisors vs. Service Group Advisors

BookMe draws from two pools of advisors when calculating available timeslots:

### Local Advisors

Local advisors are those who **work at the meeting location**. They are the primary pool for most booking requests.

To be included, a local advisor must:
1. Be registered at the branch location
2. Have the right skills or belong to a matching competence group
3. Have "Can Be Booked" enabled
4. Not be set to "Only Explicitly Available"
5. Have workdays configured at that location for the requested meeting types

### Service Group Advisors

Service groups provide a **secondary pool** of advisors who are not physically at the meeting location but can still serve customers. They are typically used for remote meeting types (Online, Telephone) and are activated based on configurable triggers.

A service group is triggered when the booking request matches its configured criteria:
- **Theme** --- the meeting topic
- **Customer category** --- the customer segment
- **Customer location** --- where the customer is located

**Example**: A "National Mortgage Team" service group might be triggered whenever a customer requests a mortgage meeting. The group contains five advisors from various branches who can serve the customer via Online or Telephone meetings.

Service groups have a **service level** that defines:
- Which meeting types the group offers (e.g., Online and Telephone only)
- Which locations the group can serve for physical meetings (if any)
- An optional maximum meeting time per day for group members

### How They Work Together

When both local and service group advisors are available for the same timeslot, BookMe uses a **priority system** to select the best advisor:

| Priority | Advisor Type | Description |
|---|---|---|
| 1 (Highest) | **Explicitly selected** | Advisors specifically chosen by the caller |
| 2 | **Local** | Qualified advisors at the meeting location |
| 3 (Lowest) | **Service Group** | Advisors from a triggered service group |

By default, a local advisor is preferred over a service group advisor. If no local advisor is available at a given time, a service group advisor will be offered instead. This priority order can be customized.

---

## Advisor Schedules and Workdays

Each advisor has a **weekly schedule** that defines when they are available for meetings.

### Workday Settings

For each day of the week, an advisor's workday specifies:

- **Available** --- Whether the advisor is available at all on that day
- **Working hours** --- Start and end time (e.g., 08:00 -- 16:00)
- **Location** --- Which branch they work at on that day
- **Meeting types** --- Which meeting types they offer on that day

**Example**: An advisor might work at the Oslo branch Monday through Wednesday (offering Physical and Online meetings) and at the Bergen branch Thursday and Friday (offering Online meetings only).

### Internal vs. Customer-Initiated Bookings

When a booking is made **internally** (by a bank employee rather than a customer), the maximum meeting time per day limit is bypassed. This gives internal staff more flexibility when scheduling meetings, even if the advisor's customer-facing daily cap would otherwise be reached.

---

## What Blocks a Timeslot

Even when an advisor is qualified and has working hours configured, several factors can block specific timeslots from appearing.

### Existing Meetings and Calendar Events

- **Booked meetings** --- Confirmed BookMe meetings block the advisor for their duration.
- **Reserved timeslots** --- Temporary holds (e.g., while a customer is completing a booking) also block availability.
- **External calendar events** --- Busy events from the advisor's Outlook/Microsoft 365 calendar are respected. If an advisor has a "Busy" event from 10:00 to 11:00, no BookMe timeslots will be offered during that time.
- **Non-blocking internal meetings** --- Some internal meetings are marked as non-blocking and do *not* prevent the advisor from being booked.

### Buffer Between Meetings

BookMe adds a configurable **buffer** before and after each booked or reserved meeting. This gives advisors preparation and wrap-up time.

**Example**: With a 15-minute buffer and a meeting booked at 10:00--10:30, the advisor is blocked from 09:45 to 10:45:

```
[15 min buffer] [-- 30 min meeting --] [15 min buffer]
     09:45             10:00-10:30           10:45
```

### Bank Closing Days

Dates configured as **bank closing days** (holidays, special closures) block all timeslots for the entire day, for all advisors.

### Working Time Buffer

This is a minimum lead time requirement measured in **working hours** (not calendar hours). It ensures advisors have enough preparation time before a meeting.

**Example**: With a 2-hour working time buffer, if it is currently Monday at 15:00 and the advisor works until 16:00, only 1 working hour remains on Monday. The buffer continues counting into Tuesday morning. The earliest bookable time would be Tuesday at 09:00 (assuming the advisor starts at 08:00 --- 1 remaining hour Monday + 1 hour Tuesday morning = 2 hours).

### Working From Elsewhere

If an advisor is marked as **working from a different location** on a given day, they are blocked from **physical meetings** at the original location. They remain available for Online and Telephone meetings.

### Maximum Meeting Time Per Day

BookMe can enforce a **daily cap** on how much meeting time an advisor handles. If an advisor's existing bookings for a day plus the requested meeting duration would exceed this limit, the entire day is blocked.

The limit is resolved in order of specificity:
1. **Advisor-level setting** --- Takes precedence if configured
2. **Service group setting** --- Used if the advisor belongs to a service group with a limit. If the advisor belongs to multiple service groups, the highest (most permissive) limit is used.
3. **Organization-wide default** --- The fallback if no specific limit is set
4. **No limit** --- If none of the above are configured, there is no cap

### Room Availability

For physical meetings, room availability can affect which timeslots are shown:

- **Room required** --- Only timeslots where a meeting room is available are shown. A room is automatically assigned.
- **Room optional** --- Timeslots are shown regardless of room availability. If a room happens to be free, it may be assigned automatically.
- **No room needed** --- Room availability is not considered.

This behavior is controlled by the location's configuration and can be overridden per booking request.

---

## How Timeslots Are Generated

Once BookMe determines each advisor's available windows (after applying all the factors above), it generates bookable timeslots.

### 30-Minute Intervals

By default, timeslots are offered at **30-minute intervals**. The start of each timeslot is rounded up to the nearest half hour.

**Example**: If an advisor becomes available at 09:07, the first offered timeslot starts at 09:30.

### Overlapping Options

Timeslots overlap --- they represent booking *options*, not sequential blocks. For a 45-minute meeting with availability from 09:30 to 12:00, the offered timeslots would be:

```
09:30 - 10:15
10:00 - 10:45
10:30 - 11:15
11:00 - 11:45
```

The customer selects one of these options.

### Best Advisor Selection

By default, when multiple advisors are available at the same time for the same meeting type, BookMe selects **one advisor** per timeslot based on the priority system (Explicitly selected > Local > Service Group). If multiple advisors share the same priority level, one is chosen at random to distribute workload evenly.

This means the booking page shows clean, non-duplicated timeslots --- one option per time and meeting type --- rather than listing every available advisor.

---

## Multi-Advisor Meetings

When a meeting requires **multiple specific advisors** to attend, BookMe finds timeslots where **all** of them are simultaneously free.

Each advisor's availability is calculated independently (using all the same rules described above), and then the results are **intersected** --- only the overlapping windows where every advisor is available are returned as bookable timeslots.

If any one of the required advisors has no availability for a given meeting type, that meeting type will have no timeslots at all.

---

## Extra Availability Windows

Advisors can extend their availability beyond their regular schedule using **extra availability windows**. These are one-off time ranges where the advisor makes themselves available for Online and Telephone meetings.

**Example**: An advisor whose regular hours end at 16:00 might open an extra window from 16:00 to 18:00 on a specific Tuesday for online meetings.

Extra availability windows only apply to **Online** and **Telephone** meetings --- they cannot be used to extend physical meeting availability.

---

## Dynamic Service Group Availability

Some service groups use **dynamic availability**, where advisors actively sign in and out of a service queue. When an advisor is signed in, they become available for that service group's meeting types during their signed-in period.

This is useful for scenarios like call centers or shared advisory pools where staffing is flexible and changes throughout the day.

---

## Advisor Priority Rules

When multiple advisors are available at the same time, BookMe uses a **priority rule configuration** to decide which advisor is assigned to the timeslot. Each organization has one active priority configuration with numbered levels (lower number = higher priority).

### Default Priority

If no custom configuration has been set up, the default order is:

| Priority | Advisor Type |
|---|---|
| 1 (Highest) | **Explicitly selected** --- advisors specifically chosen by the caller |
| 2 | **Local** --- qualified advisors at the branch |
| 3 (Lowest) | **Service Group** --- advisors from a triggered service group |

This means local advisors are preferred over service group advisors, and explicitly requested advisors always take precedence.

### Custom Priority with Service Group Labels

The default order can be customized. The most powerful feature is the ability to promote specific service groups to a higher priority using **labels**. Service groups can be tagged with labels, and a priority level can reference a label to include only matching groups.

**Example**: A bank has local advisors in Oslo, a "VIP Advisory" service group (labeled `VIP`), and a "National Support" service group (no special label). They configure:

| Priority | Rule |
|---|---|
| 1 | Explicitly selected advisors |
| 2 | Service groups labeled **VIP** |
| 3 | Local advisors |
| 4 | All remaining service groups |

With this configuration, a VIP Advisory advisor is preferred over a local advisor for any timeslot where both are available. The National Support group, which has no `VIP` label, falls to priority 4 --- below local advisors.

Without this custom rule, the default would apply and the local advisor would always be preferred over any service group advisor.

### When Priority Rules Take Effect

Priority rules only affect the result when **best advisor selection** is active (which is the default for customer-facing bookings). When best advisor selection is active, each timeslot shows exactly **one advisor** --- the one from the highest priority level that has availability. If multiple advisors share the same priority level, one is picked at random to distribute workload evenly.

When best advisor selection is turned off (e.g., for admin views), timeslots for **all** available advisors are returned and priority rules have no effect.

---

## Summary: What Determines Whether a Timeslot Appears

A timeslot is shown to the customer when **all** of the following are true:

1. At least one **qualified advisor** exists (matching skills, competence groups, and location)
2. The advisor has **working hours** on that day for the requested meeting type
3. The advisor **can be booked** and is not set to "only explicitly available"
4. The timeslot is **not on a bank closing day**
5. Enough **working time buffer** has passed since now
6. The advisor has **no conflicting meetings or calendar events** at that time
7. The **buffer between meetings** does not overlap with the timeslot
8. The advisor is **not working from a different location** (for physical meetings)
9. The advisor has **not exceeded their daily meeting time limit**
10. A **meeting room is available** (if required for physical meetings)
11. The timeslot falls on a **30-minute interval** (by default) and fits the meeting duration

If any one of these conditions is not met, the timeslot will not appear in the booking options.
