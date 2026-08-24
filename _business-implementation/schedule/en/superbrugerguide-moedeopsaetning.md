---
layout: "default"
title: "Super-user guide – Meeting setup"
parent: "English"
grand_parent: "Schedule"
nav_order: 208
lang: "en"
---
# Schedule – super-user guide: Meeting setup
_The six tabs, the settings and the four booking flows · v1.0 · 12.06.2026_



{: .note }
> **Note:** The screenshots below show the Danish Management UI; English-interface screenshots are being added.

## Purpose and value

**Meeting setup** is the hub of Schedule: here you decide **when** and **how** meetings can be booked. The area has six tabs that are closely connected — and the **same** setting can take effect differently depending on how the meeting is booked. This guide gives you both the **overview** (order + booking flows) and the **detail** (what each field actually does).


## The four booking flows — and the most important distinction

A meeting can come about in four ways. The most important distinction is **internal vs. customer-facing**:

- **Internal meetings (case handling):** an employee books internally. This flow **skips almost all the rules** (see the matrix).
- **Advisor-booked:** an employee books a meeting for/with a customer.
- **Customer-booked:** the customer books themselves (e.g. via a direct link).
- **Portal meeting:** the customer books via a portal.

{: .note }
> **Note:** The **three customer-facing flows** (advisor, customer, portal) use the **same rules engine**. They differ only in where you start, and where the context (customer type/topic/location) comes from: the advisor selects it manually · the customer via their link · the portal pre-selects it. **Rule of thumb: learn the rules once (customer-facing) — internal skips them.**


## Booking-flow matrix — which settings apply where?

An overview of when the most important settings are in play (Yes = applies, No = skipped):


| Setting | Internal | Advisor | Customer | Portal |
|---|---|---|---|---|
| Buffers (calendar/working time, time between meetings, travel time, pre-/post-processing) | No | Yes | Yes | Yes |
| Max. hours per day (per employee) | No (unlimited) | Yes | Yes | Yes |
| Operating level (priority/choice of employee) | No (chooses themselves) | Yes | Yes | Yes |
| Customer type filtering | No | Yes | Yes | Yes |
| Meeting types (limited by configuration) | No (all) | Yes | Yes | Yes |
| Meeting duration | Yes (30 min default) | Yes | Yes | Yes |
| Closing days | Yes | Yes | Yes | Yes |
| Offer fixed employee | — | Yes | Yes | Yes |
| Context (customer type/topic/location) comes from | employee | employee | customer's link | portal's pre-selection |

{: .note }
> **Note:** **Closing days** are the one big exception: they block **all** flows — including internal meetings (the organisation is closed). Internally, meetings still get a **duration**, because the meeting has to take up time in the calendar.

{: .note }
> **Note:** **The matrix's ‘Buffers’ = these fields in Meeting configuration (Tab 5):** Calendar time, Working time, Time between meetings, Travel time and Pre-/Post-processing. If the customer sees no times while internal meetings can be booked, it is almost always one of these customer-facing rules — see **Troubleshooting**.


## Example — a meeting through the engine

**A Private customer books a physical advisory meeting themselves:** 1) **Customer type** = Private → that meeting configuration applies; 2) **Meeting types** must include **Physical**; 3) the **buffers** (calendar/working time, time between meetings) push the nearest times away; 4) **Max. hours per day** can remove a busy day; 5) **Operating level** chooses the employee; 6) for a physical meeting an **available room** is checked (if required); 7) **Closing days** block public holidays. Had the same meeting been **internal**, steps 3–5 would have been skipped.

### Glossary
- **Default values**: The organisation's basic settings (opening hours, max hours/day, closing days, etc.) — defaults that the other tabs inherit from.
- **Meeting configuration**: The rules per ⟦customer type⟧ and ⟦meeting topic⟧ (duration, meeting types, buffers, who can book) — overrides the default values.
- **Customer type**: A customer category (e.g. Private, Business) you can set special rules for.
- **Meeting topic**: A meeting theme (with optional sub-topics) that bookings can be about.
- **Buffer**: Time that is reserved (notice before the meeting can be booked, break between meetings, travel time, pre-/post-processing).
- **Closing days**: Days when nothing can be booked (public holidays, etc.) — applies to all flows.


## Audience and prerequisites

- Audience: super-user/administrator (role **Configurator** or **Admin**; **Manager** can do some parts).
- Locations/rooms are synchronised from **SCIM**/M365; employees from Entra.
- The Managed BookMe package is installed.


## Setup order (and what inherits from what)

Set up the tabs in this order — each builds on the previous:

- 1. **Default values** — the organisation's defaults (opening hours, max hours/day, closing days, naming).
- 2. **Customer types** — the customer categories you want to be able to set special rules for.
- 3. **Meeting topics** — topics and sub-topics.
- 4. **Locations** — physical places and rooms (requirement of an available room).
- 5. **Meeting configuration** — the rules per customer type/topic (overrides the default values).
- 6. **Operating level** (Tab 6) — priority when several employees are available.
- Related areas (separate guides): **Service groups** (pools) and **Portals** (the customer-facing side).

{: .note }
> **Note:** **Inheritance:** Default values are defaults; in Meeting configuration you can **override** per customer type and per meeting topic with **Set up special rules**.


## Tab 1 — Default values

The organisation's basic settings that everything else inherits from.


| Field | What you actually set |
|---|---|
| Standard opening hours (From/To time) | The general time window that can be booked within. |
| Maximum time from booking to meeting | How far into the future bookings can be made (e.g. 30 days). |
| Max. hours per day (per employee) | Cap on customer meetings per day per employee. ★ Does not apply to internal meetings. |
| Time zone | Basis for all time calculations. |
| Show only times the customer sees | In the employee-facing booking: show only the times the customer would see (otherwise all). |
| Closing days | Days without booking (public holidays, etc.) — applies to all flows. |
| Naming of meeting types | What Physical/Online/Phone/Off site is called to the customer. |
| Naming of employee types | What ‘fixed employee’ and ‘all available’ are called to the customer. |
| iCal (meeting title/description) | Text in the .ics calendar file the customer can download. |


![Screenshot 1]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-moedeopsaetning/msetup_standardvaerdier.png)

*Screenshot 1 (Management UI) — Meeting setup → **Default values** — opening hours, max. hours/day, closing days and naming*


## Tab 2 — Customer types

The customer categories (e.g. Private, Business) you can later set **special rules** for in Meeting configuration. Create them with **Create customer types** → **Name**.


## Tab 3 — Meeting topics

The meeting themes that bookings can be about. Create a **meeting topic** (Name) and optionally add **sub-topics** (Add sub-topic). The topics are used as an axis in Meeting configuration and on portals/service groups.


![Screenshot 2]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-moedeopsaetning/msetup_modeemner.png)

*Screenshot 2 (Management UI) — Meeting setup → **Meeting topics** — topics and sub-topics*


## Tab 4 — Locations

Physical places and their rooms.


| Field | What you actually set |
|---|---|
| Name | Internal name — must match the ⟦SCIM⟧ location ⟦exactly⟧ (case-sensitive!), otherwise no employees are found. |
| Display name (Name in meeting booking) | The name the customer sees when booking. |
| Require an available meeting room to book a physical meeting | ★ Only times with an available room are shown for physical meetings. |
| Add room to the booked meeting | A room picker is shown, and the room is set on the booking. |
| Rooms at the location | Read-only — synchronised from SCIM/M365. |


![Screenshot 3]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-moedeopsaetning/msetup_lokationer.png)

*Screenshot 3 (Management UI) — Meeting setup → **Locations** — Name/Display name + requirement of an available room*


## Tab 5 — Meeting configuration (the core)

Here you set the rules — generally or per **customer type** and per **meeting topic** (Set up special rules). Most fields apply only to the **customer-facing** flows (cf. the matrix). The **most specific** configuration wins: a configuration for **both meeting topic and customer type** beats one for customer type only, which beats the **general** one, which beats the **default values**.


| Field | What you actually set | Flow |
|---|---|---|
| Who can book (All meetings can be booked by) | Only internally in the bank, or the Customer in self-service. | All |
| Offer fixed employee | Whether the customer is offered their fixed employee or all available. | Customer-facing |
| Meeting duration (All meetings have a duration of) | Meeting length (internal defaults to 30 min if not set). | All |
| Meeting types (All meetings can be held as) | Physical/Online/Phone/Off site offered to the customer. | Customer-facing |
| Calendar time from booking to meeting | Minimum notice in ⟦calendar hours⟧ before a meeting can be booked. | Customer-facing |
| Working time from booking to meeting | Minimum notice in ⟦working hours⟧ (crosses days). | Customer-facing |
| Time between meetings | Required break between two meetings. | Customer-facing |
| Travel-time buffer | Extra time on top of the calculated travel time (multiple locations). | Customer-facing |
| Preparation / Post-processing time | ⟦Duration⟧ (not a time of day!) the employee is blocked before/after the meeting — unless **Show as** is set to **free**. | Customer-facing |
| Show as (per buffer: preparation, post-processing, travel time) | How the buffer appears in the employee's calendar — and whether it blocks. **Busy** and **tentative** block; **free** does not. | Customer-facing |
| Set up special rules / specific per meeting topic | Override the above per customer type and per meeting topic. | — |

{: .important }
> **Remember:** **Preparation** and **Post-processing time** are a **duration** (e.g. 15 min), not a time of day — a classic pitfall.

{: .note }
> **Show as:** Choose **free** when the employee should see the time in their calendar but the buffer should not block. **Free** removes only that buffer's blocking effect — the other rules (time between meetings, max. hours per day, closing days and so on) still apply. **Tentative** looks softer in the calendar but blocks exactly like **busy**. Buffers with no setting of their own count as **busy**.


![Screenshot 4]({{ site.baseurl }}/assets/images/business-implementation/schedule/en/superbrugerguide-moedeopsaetning/msetup_modekonfiguration.png)

*Screenshot 4 (Management UI) — Meeting setup → **Meeting configuration** — Who can book, meeting duration, meeting types and buffers*


## Tab 6 — Operating level

Determines the prioritisation when several employees are available (Explicitly selected → Local → Service group via label). **Applies only to customer-facing flows** — internally the employee chooses themselves. Elaborated in **Schedule – super-user guide: Service groups**.


## Pitfalls and good to know

- **Internal skips the rules:** buffers, daily cap, priority and customer type do **not** apply to internal meetings — only closing days and duration.
- **Location name = SCIM:** the name must match the SCIM location exactly (case-sensitive), otherwise no employees are shown.
- **Duration, not a time of day:** pre-/post-processing time is given as a duration.
- **Inheritance:** Default values are defaults; Meeting configuration overrides per customer type/topic.
- **Closing days apply to all:** even internal meetings cannot be booked on closing days.


## Troubleshooting

- The customer sees no times, but internal meetings can be booked: this is usually a **customer-facing** rule — **max. hours per day** reached, a **buffer**, or a missing **meeting configuration** for the customer type/topic.
- No times at all for a combination: there is no **meeting configuration** for that customer type/meeting topic — create a general or specific configuration.
- There is a meeting configuration, but still no times: a **specific** configuration (per topic/customer type) may be incomplete — check meeting types/buffers on that exact one, otherwise it does not fall back to the general one.
- **Fewer** times than expected (not zero): something is trimming the list — check in order **max. hours per day** → **buffers** → **travel time** → **available room**.
- No employees at a location: the **location name** does not match SCIM (check capitalisation).
- Room picker missing for a physical meeting: turn on **Require an available meeting room**/**Add room** at the location, and check that rooms are synchronised.
- A change does not take effect: changes apply at the next booking search — run a new search for that customer type/topic to confirm. On a customer link/portal there may be a short delay.


## Latest update

- 12.06.2026 (v1.0) — First version (all tabs + booking-flow matrix).


{: .hint }
> ✅ **Done!** The meeting setup is in place.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 12.06.2026_
