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

**Response:** Returns a list of available time slots based on the search filters.


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