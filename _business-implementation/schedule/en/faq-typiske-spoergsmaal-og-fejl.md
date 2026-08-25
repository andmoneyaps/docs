---
layout: "default"
title: "FAQ – Typical questions & errors"
parent: "English"
grand_parent: "Schedule"
nav_order: 409
lang: "en"
---
# Schedule – FAQ
_Typical questions, errors and answers · v1.0 · 11.06.2026_

Quick answers to the most common questions and errors with service groups in Schedule. More detailed steps are in the **Schedule – super-user guide: Service groups**.


## Service groups


**The service group is never activated for bookings.**

Check the activation rules (customer type/location/meeting topic), and that the members have availability/working hours on the matching days and locations. The group is activated when at least one activation rule is met.


**I can't set activation rules or service level.**

They can only be set once the service group has been created. Save the group first (General + members), then edit it to add activation rules and service level.


**Employees are missing from the selection list.**

Check that the employees are synchronised and can be booked (see Employees → Availability).


**What does an empty activation rule mean?**

An empty list means “all”: if, for example, no location is selected, the group can service all locations that meet the other rules. Set the rules deliberately, so that the group is not activated too broadly.


**“Max. hours per day” doesn't take effect.**

An individual limit on the employee overrides the service group's. If the employee is in several service groups, the highest limit applies.


**What is the difference between a service group and a competence group?**

Competence group = what the employees can do (meeting topics + customer types). Service group = who is offered (members), when (activation rules) and what (service level).


**What is the “Email for the service group”?**

An optional email that internal employees can use to book meetings themselves via the group.


**Which meeting types can a service group offer?**

Online, Physical, Phone and Off site — chosen under Service level. If Physical is chosen, the customer can choose from the service group's locations.


**The service group is active, but the customer sees no times.**

Activation does not automatically mean that times are shown. Check the service level: are **meeting types** selected, and — for Physical — **locations**? An empty service level yields no times. Also check that the members have availability on the matching days.


**My change doesn't take effect for the customer.**

Changes apply from the next booking search. Refresh the page and try a new search; if it persists, contact support.


**Can I deactivate or delete a service group?**

If you want to take the group temporarily out of play, remove its members or use the explicit deactivate/disable action, if one exists. For permanent deletion, contact your administrator/support — be aware of the effect on existing bookings.


**Is it called Schedule or Schedule?**

It is the same product. The brand name is Schedule; in the system/menu you may still encounter the former name Schedule.


## Competence groups


**What does a competence group control?**

Which meeting topics and customer types the employees in the group can hold meetings about. It can be added to a service group as a whole, so that all its employees are attached.


**Do sub-groups inherit competences?**

Yes. Employees in sub-groups also take on competences from the parent group, and members from sub-groups are shown on the group.


## Service level / priority


**The customer only gets local employees — not the service group.**

Adjust the service level so that the service group's label is prioritised. The order is typically: Explicitly selected → Local adviser → Service group(s) via label.


**The label doesn't work in the service level.**

Make sure at least one service group has the selected label. Labels are set on service/competence groups.


**Can I have several service-group levels?**

Yes. “Service group” can appear several times (one per label) — for example primary and secondary. “Explicitly selected” and “Local adviser” can each appear only once.


**Is the “Description” shown to the customer?**

No — the description on a service level is internal and helps you identify the level.


**What happens if no one in the service group has an available time?**

The system then moves on to the next service level and offers times from there.


## Access and roles


**I can't see Service groups in the menu.**

Service groups require the Manager or Admin role. Competence groups and service level can be accessed by a Configurator or Admin. Contact your administrator.


**I am a Configurator and can't create the service group.**

Service groups require the Manager or Admin role. As a Configurator you can create competence groups and service level, but not service groups — contact your administrator.


**Where do I create labels?**

Labels are set on the individual service/competence group (the “Labels” field) and are then used in the service level to prioritise.


---
_&money · support: info@andmoney.dk · andmoney.dk · v1.0 · 11.06.2026_
