---
layout: default
title: Customer Meeting Booking
nav_order: 12
parent: BookMe
collection: bookme
---

# Customer Meeting Booking in Public API

This guide explains how to book a meeting through the Public API, allowing customers to search for available time slots, reserve a slot, and create a meeting.

![Customer Meeting Booking Sequence Diagram]({{ site.baseurl }}/assets/images/bookme_customer_meeting_sequence_diagram.png)

Link to Postman-collection: [&money Public API](https://trifork-aalborg.postman.co/workspace/%26Bookme~d45e345c-7669-4d2c-bb90-7523fa8cd866/collection/22545708-52b2c6cb-d1bd-4ceb-9f30-60cbd5af1b53?action=share&creator=22545708&active-environment=37701968-0a0bd7e6-0852-48cd-a587-2586a1bf6f43)

## 1. Fetching Configuration Details

Before customers can book a meeting, you need to retrieve relevant configuration details:

### Fetch Meeting Themes

```http
GET /bookme/meeting-topics
```

**Parameters:**

- `customerCategoryId` - Optional filter for customer category ID
- `isCustomer` - Flag indicating if the request is for a customer (required)

**Response:** Returns a list of available meeting topics.

### Fetch Customer Types

```http
GET /config/customer-types
```

**Response:** Returns available customer types.

### Fetch Employees

```http
GET /config/employees
```

**Response:** Returns a list of employees who can be booked.

### Fetch Rooms

```http
GET /config/rooms
```

**Response:** Returns available rooms for meetings.

## 2. Fetching Available Time Slots

Once the customer has selected meeting parameters, retrieve the available time slots:

```http
GET /bookme/time-slots/available?requireEmployeeParticipation=true&lookForwardTime=7.00:00:00&...
```

**Key Query Parameters:**

| Parameter | Required | Description | Example Value |
|-----------|----------|-------------|---------------|
| `requireEmployeeParticipation` | Yes | If `true`: all specified employees must be available. If `false`: at least one must be available | `true` |
| `explicitEmployeeIds` | No | Specific employee IDs. Omit for Local/ServiceGroup employees | `[]` or `["uuid1"]` |
| `employeeTypes` | No | Employee pool types (V2). At least one required. Only used when `requireEmployeeParticipation=false` | `["Local", "ServiceGroup"]` |
| `startDate` | No | Search start date/time | `2025-10-09T08:00:00Z` |
| `lookForwardTime` | No | How far ahead to search | `"7.00:00:00"` (7 days) |
| `topic` | No | Meeting theme ID | `"theme-uuid"` |
| `customerTypeId` | No | Customer category ID | `"category-uuid"` |
| `meetingTypes` | No | Types of meetings | `["physical", "online"]` |
| `customerLocation` | No | Customer's location | `"Copenhagen"` |
| `meetingLocation` | No | Meeting location | `"Branch-North"` |
| `requireRoom` | No | Must have room available | `true` |
| `specificRooms` | No | Specific room IDs | `["room-uuid"]` |

**Common Use Cases:**

### Example 1: Find any available employee for the next 7 days
```javascript
GET /bookme/time-slots/available?
  requireEmployeeParticipation=true&
  lookForwardTime=7.00:00:00&
  topic=theme-uuid&
  customerTypeId=category-uuid&
  meetingTypes=physical&
  customerLocation=Copenhagen
```

### Example 2: Find specific employee with fallback
```javascript
GET /bookme/time-slots/available?
  requireEmployeeParticipation=true&
  explicitEmployeeIds=preferred-advisor-uuid&
  employeeTypes=Explicit&employeeTypes=Local&employeeTypes=ServiceGroup&
  lookForwardTime=14.00:00:00&
  topic=theme-uuid
```

**Note about employeeTypes:** This parameter is only used when `requireEmployeeParticipation=false`. It allows searching across different employee pools:
- `Explicit`: Only the employees specified in `explicitEmployeeIds`
- `Local`: Employees at the customer's location
- `ServiceGroup`: Employees from configured Service & Competence Groups

At least one value must be provided when using this parameter.

For more information about Service Groups, see [Service & Competence Groups]({{ site.baseurl }}/bookme/service-competence-groups).

### Example 3: Online meeting, no room needed
```javascript
GET /bookme/time-slots/available?
  requireEmployeeParticipation=true&
  meetingTypes=online&
  requireRoom=false&
  lookForwardTime=30.00:00:00
```

**Response:** Returns a list of available time slots based on the search filters.

### How Time Slots Are Generated

Time slots are automatically generated based on employee availability:
- Generated at **30-minute intervals** (starting at `:00` and `:30` minutes)
- Each slot includes the employee ID and meeting type
- Multiple slots may be returned for the same employee if they support different meeting types

**Example response:**
```json
[
  {
    "startDate": "2025-10-10T08:00:00.000Z",
    "endDate": "2025-10-10T09:00:00.000Z",
    "meetingType": "Physical",
    "employeeId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  },
  {
    "startDate": "2025-10-10T08:30:00.000Z",
    "endDate": "2025-10-10T09:30:00.000Z",
    "meetingType": "Physical",
    "employeeId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  },
  {
    "startDate": "2025-10-10T09:00:00.000Z",
    "endDate": "2025-10-10T10:00:00.000Z",
    "meetingType": "Online",
    "employeeId": "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  }
]
```

## 3. Reserving a Time Slot

After choosing an available time slot, the customer must reserve it. **Reservations expire after exactly 5 minutes** if not confirmed by creating a meeting.

```http
POST /bookme/time-slots/reserve
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body:**

```json
{
  "timeSlot": {
    "startDate": "2025-03-15T10:00:00Z",
    "endDate": "2025-03-15T11:00:00Z",
    "status": "Reserved",
    "employeeId": "employee-uuid",
    "roomId": "room-uuid"  // Optional, if room is required
  },
  "token": "session-token-uuid"  // Unique UUID for this customer session
}
```

**Response:** Confirms the reservation of the selected time slot.

### Important: Token Management

The `token` parameter is critical for managing reservations during the booking flow:

**🔑 Key Rule: Use the SAME token for the entire customer session**

When a customer changes their time slot selection, **reuse the same token**. The system will:
1. Automatically delete the old reservation
2. Create the new reservation
3. Free up the old slot immediately for other customers

**Example Flow:**

```javascript
// Step 1: Customer's first choice
POST /bookme/time-slots/reserve
{
  "timeSlot": { "startDate": "2025-10-09T10:00:00Z", "endDate": "2025-10-09T11:00:00Z", ... },
  "token": "abc-123-customer-session"
}
// ✓ 10:00 slot reserved

// Step 2: Customer changes their mind
POST /bookme/time-slots/reserve
{
  "timeSlot": { "startDate": "2025-10-09T14:00:00Z", "endDate": "2025-10-09T15:00:00Z", ... },
  "token": "abc-123-customer-session"  // ← SAME token
}
// ✓ 10:00 slot automatically released
// ✓ 14:00 slot reserved

// Step 3: Customer confirms booking
POST /bookme/meetings
{
  "timeSlotId": "14:00-slot-id",
  ...
}
// ✓ Meeting created, reservation converted
```

**Best Practices:**
- Generate one unique token per customer booking session (e.g., when they land on the booking page)
- Store the token in the customer's browser session
- Reuse the token for all reservation attempts during that session
- If the customer abandons the booking, the reservation expires after 5 minutes automatically

## 4. Creating a Meeting

Once the time slot is reserved, finalize the meeting by creating a meeting record:

```http
POST /bookme/meetings
Content-Type: application/json
Authorization: Bearer <access_token>
```

**Request Body:**

```json
{
  "bookedBy": "customer",
  "customerCategoryId": "123",
  "timeSlotId": "12345",
  "type": "physical",
  "themeId": "111",
  "roomId": "222",
  "employeeId": "333",
  "customerId": "67890",
  "description": "Meeting description"
}
```

**Response:** Returns confirmation of the created meeting.

### Downloading an ICS File

To download the meeting details in iCal format, use the following endpoint:

```http
POST /bookme/meetings/{meetingId}/ical
Accept: text/calendar
Authorization: Bearer <access_token>
```

**Request Body:**
All properties are optional in the request body. If a property is not provided, the default value will be used.

```json
{
  "title": "Meeting title",
  "description": "Meeting description"
}
```

**Response:** Returns the meeting details in iCal format.

## Security and Authentication

- All API requests require **OAuth2 authentication**
- Include a valid **Bearer token** in the `Authorization` header

## Error Handling

| Status Code               | Description                                        |
| ------------------------- | -------------------------------------------------- |
| 401 Unauthorized          | Missing or invalid authentication token            |
| 403 Forbidden             | Access is forbidden                                |
| 404 Not Found             | Invalid resource (theme, employee, room, etc.)     |
| 409 Conflict              | Resource conflict (e.g., time slot already booked) |
| 500 Internal Server Error | Server-side error                                  |