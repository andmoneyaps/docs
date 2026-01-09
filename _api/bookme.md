---
layout: default
title: BookMe API
parent: Public API
nav_order: 1
---

# BookMe API Documentation

The BookMe API provides comprehensive access to meeting booking and scheduling functionality. This documentation covers API Version 3.0.0 (latest) and includes V2 features. For migration from V2 to V3, see the [V2 to V3 Migration Guide]({{ site.baseurl }}/api/migration-guide-v3).

## Base URL

```
Production (V3): https://apim-public-api-prod.azure-api.net/api/v3/bookme
Production (V2): https://apim-public-api-prod.azure-api.net/api/v2/bookme
Test (V3): https://apim-public-api-test.azure-api.net/api/v3/bookme
Test (V2): https://apim-public-api-test.azure-api.net/api/v2/bookme
```

## Authentication

All API requests require OAuth2 authentication using Azure AD:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

## Endpoints

### Meetings

#### List Meetings
Retrieve a list of meetings based on filter criteria.

```http
GET /meetings
```

**Query Parameters:**
- `timeSlotId` (string, optional): Filter by time slot ID
- `employeeId` (uuid, optional): Filter by employee ID
- `startDateModified` (datetime, optional): Filter by modified start date
- `endDateModified` (datetime, optional): Filter by modified end date

**Response:** Array of Meeting objects

#### Get Meeting
Retrieve a specific meeting by ID.

```http
GET /meetings/{id}
```

**Response:** Meeting object

#### Create Meeting
Create a new meeting booking.

```http
POST /meetings
```

**Request Body:**
```json
{
  "bookedBy": "Employee|Customer|PortalPartner|PortalCustomer",
  "salesforceId": "string",  // Required in V2
  "customerTypeId": "uuid",  // Optional in V2
  "timeSlotId": "uuid",      // Optional in V2
  "portalId": "uuid",        // V2 only
  "cpr": "string",           // V2 only
  "customFields": [          // V2 only
    {
      "key": "string",
      "value": "string"
    }
  ],
  "externalAttendees": [     // V2 only
    {
      "name": "string",
      "email": "string"
    }
  ],
  "title": "string",
  "description": "string",
  "videoLink": "string",     // V2 only
  "additionalEmployees": ["uuid"],
  "roomId": "uuid",
  "type": "Physical|Online|Telephone|Offsite",
  "topicId": "uuid",         // Optional in V2
  "employeeId": "uuid",      // Required
  "customerId": "string"     // Required
}
```

Note that the fields related to portal meetings "portalId, customFields and externalAttendees" are only used during portal meeting bookings and are not used during booking of a normal BookMe meeting.

**Response:** Created Meeting object with ID

#### Update Meeting
Update an existing meeting using JSON Patch operations.

```http
PATCH /meetings/{id}
```

**Request Body:** Array of JSON Patch operations
```json
[
  { "op": "replace", "path": "/title", "value": "Updated Meeting Title" },
  { "op": "replace", "path": "/description", "value": "Updated description" }
]
```

**Response:** Updated Meeting object

#### Delete Meeting
Cancel a meeting booking.

```http
DELETE /meetings/{id}
```

**Response:** 204 No Content

#### Generate iCal (V2 Only)
Generate an iCal file for a meeting.

```http
POST /meetings/{id}/ical
```

**Request Body:**
```json
{
  "title": "string",
  "description": "string", 
  "location": "string"
}
```

**Response:** iCal file content

### Time Slots

#### List Time Slots
Retrieve available time slots.

```http
GET /time-slots
```

**Query Parameters:**
- `employeeId` (uuid, optional): Filter by employee
- `roomId` (uuid, optional): Filter by room
- `startDate` (datetime): Start of date range
- `endDate` (datetime): End of date range
- `status` (array, optional): Filter by status

**Response:** Array of TimeSlot objects

#### List Available Time Slots
Get available time slots for booking with advanced filtering.

```http
GET /time-slots/available
```

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `explicitEmployeeIds` | array of uuid | No | Specific employee IDs. Pass empty array or omit for all employees |
| `startDate` | datetime | No | Start date for time slot search (ISO 8601 format) |
| `lookForwardTime` | string | No | Duration to search ahead (format: `"days.hours:minutes:seconds"`, e.g., `"7.00:00:00"` for 7 days) |
| `topic` | uuid | No | Meeting topic/theme ID |
| `customerTypeId` | uuid | No | Customer type/category ID |
| `employeeTypes` | array | No | V2 only: Employee selection types. At least one value required. Only relevant when `requireEmployeeParticipation` is `false` (see [Employee Types](#employee-types-v2)) |
| `meetingTypes` | array | No | Types of meetings: `["physical", "online", "telephone", "offsite"]` |
| `customerLocation` | string | No | Customer's location (free text, used to filter local employees) |
| `meetingLocation` | string | No | Meeting location (free text, defaults to customerLocation if omitted) |
| `requireRoom` | boolean | No | If `true`, only return slots with available rooms |
| `requireEmployeeParticipation` | boolean | Yes | If `true`, requires all explicitly specified employees are available for the entire meeting duration. If `false`, returns slots where at least one specified employee is available |

**Response:** Array of available TimeSlot objects

**employeeTypes:** The `employeeTypes` parameter is only relevant when `requireEmployeeParticipation` is set to `false`. At least one value must be provided.

This parameter controls which pools of employees to search. Multiple types can be combined:

- **`Explicit`**: Use only employees specified in `explicitEmployeeIds`
- **`Local`**: Include employees qualified to serve the customer's location
- **`ServiceGroup`**: Include employees from configured service groups

**Note:**
- When `requireEmployeeParticipation` is `true`, all explicitly specified employees must be available
- When `requireEmployeeParticipation` is `false`, at least one employee from the specified types must be available
- Employee types are combined (union), not mutually exclusive

##### How Time Slots Are Generated

Available time slots are generated automatically based on employee availability and configuration:

- **Interval**: Time slots start at 30-minute intervals (`:00` and `:30` minutes)
- **Duration**: Default meeting duration is typically 1 hour (configurable via `meetingDuration` parameter)
- **Multiple slots**: For each available employee, slots are generated for each available meeting type they support
- **Daily capacity limits**: Time slots are filtered based on each advisor's remaining daily meeting capacity (see below)

##### Daily Meeting Time Limits

The system enforces duration-based daily meeting time limits to prevent advisor overbooking:

**How It Works:**
1. Each advisor has a `MaxMeetingTimePerDay` limit (configured at bank, service group, or advisor level)
2. The system calculates total booked meeting time per advisor per day
3. Advisors are excluded from time slot results when: `existingMeetingDuration + requestedMeetingDuration > dailyLimit`
4. If the requested meeting duration alone exceeds the daily limit, the advisor is excluded for all days in the search range

**Example Scenarios:**

```javascript
// Scenario 1: Normal booking
// Advisor limit: 04:00:00 (4 hours/day)
// Already booked: 2 hours
// Requested meeting: 1 hour
// Result: ✅ Advisor appears in time slots (2h + 1h = 3h < 4h limit)

// Scenario 2: Near capacity
// Advisor limit: 04:00:00 (4 hours/day)
// Already booked: 3.5 hours
// Requested meeting: 1 hour
// Result: ❌ Advisor excluded (3.5h + 1h = 4.5h > 4h limit)

// Scenario 3: Meeting too long
// Advisor limit: 04:00:00 (4 hours/day)
// Already booked: 0 hours
// Requested meeting: 5 hours
// Result: ❌ Advisor excluded for all days (5h > 4h limit)
```

**API Behavior:**
- Advisors at capacity are automatically filtered out
- No explicit error is returned - they simply don't appear in results
- Limits reset at midnight (per day calculation)

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

This means customers can book meetings starting at any half-hour mark within the employee's available working hours.

#### Reserve Time Slot
Reserve a time slot for booking. **Reservations expire after 5 minutes** if not converted to a meeting.

```http
POST /time-slots/reserve
```

**Request Body:**
```json
{
  "timeSlot": {
    "startDate": "datetime",
    "endDate": "datetime",
    "status": "string",
    "roomId": "uuid",
    "employeeId": "uuid",
    "serviceGroup": "string"
  },
  "token": "uuid",
  "existingMeetingId": "uuid"  // Optional
}
```

**Parameters:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `timeSlot` | object | Yes | Time slot details to reserve |
| `timeSlot.startDate` | datetime | Yes | Start time (ISO 8601) |
| `timeSlot.endDate` | datetime | Yes | End time (ISO 8601) |
| `timeSlot.status` | string | Yes | Should be `"Reserved"` |
| `timeSlot.employeeId` | uuid | No | Employee/advisor ID |
| `timeSlot.roomId` | uuid | No | Room ID if room is required |
| `timeSlot.serviceGroup` | string | No | Service group identifier |
| `token` | uuid | Yes | Unique reservation token (see [Token Behavior](#token-behavior)) |
| `existingMeetingId` | uuid | No | Meeting ID when modifying an existing booking |

##### Token Behavior

The `token` parameter is crucial for managing reservations:

**Same Token = Automatic Replacement:**
When you reserve a new time slot with the **same token** as a previous reservation, the system automatically:
1. Deletes the old reservation immediately
2. Creates the new reservation
3. Ensures only one active reservation per token

**Different Token = Separate Reservations:**
Using a different token creates a separate reservation. The old reservation will remain until it expires (5 minutes) or is explicitly replaced.

**Response:** Reserved TimeSlot object with confirmation

### Rooms

#### List All Rooms
Retrieve all available meeting rooms.

```http
GET /rooms
```

**Response:** Array of Room objects

#### Get Room Details
Get details for a specific room.

```http
GET /rooms/{id}
```

**Response:** Room object

#### Check Room Vacancies
Check room availability for a specific time slot.

```http
GET /room-vacancies
```

**Query Parameters:**
- `location` (string, required): Room location
- `timeSlotId` (uuid, required): Time slot ID

**Response:** Array of available rooms

### Employees

#### List All Employees
Retrieve all employees.

```http
GET /employees
```

**Response:** Array of Employee objects

#### Get Employee Details
Get details for a specific employee.

```http
GET /employees/{id}
```

**Response:** Employee object

### Topics

#### List Topics
Retrieve all meeting topics.

```http
GET /meeting-topics
```

**Query Parameters:**
- `customerTypeId` (uuid, optional): Filter by customer type
- `isCustomer` (boolean, required): Flag indicating if the request is for a customer

**Response:** Array of Topic objects

### Configuration API

#### List Customer Types
Retrieve all customer types.

```http
GET /config/customer-types
```

**Response:** Array of CustomerType objects

#### Get Customer Type
Get details for a specific customer type.

```http
GET /config/customer-types/{id}
```

**Response:** CustomerType object

#### Create Customer Type
Create a new customer type.

```http
POST /config/customer-types
```

**Request Body:** CustomerType object

**Response:** Created CustomerType object

#### Update Customer Type
Update an existing customer type.

```http
PUT /config/customer-types/{id}
```

**Request Body:** CustomerType object

**Response:** Updated CustomerType object

#### Delete Customer Type
Delete a customer type.

```http
DELETE /config/customer-types/{id}
```

**Response:** 204 No Content

### Labels API (V3)

The Labels API provides centralized management for labels used to categorize resources across the platform.

#### List Labels
```http
GET /config/labels
```

**Query Parameters:**
- `pageNumber` (int, optional): Page number (0-indexed, default: 0)
- `pageSize` (int, optional): Items per page (default: 20)
- `activeFilter` (string, optional): Filter by status: `All`, `Active`, or `Inactive`

**Response:** Paginated list of LabelRegistration objects

#### Get Label
```http
GET /config/labels/{id}
```

**Response:** LabelRegistration object

#### Create Label
```http
POST /config/labels
```

**Request Body:**
```json
{
  "labelName": "Premium",
  "color": "#FFD700",
  "description": "Premium tier services"
}
```

**Response:** 201 Created with LabelRegistration object

#### Update Label
```http
PATCH /config/labels/{id}
```

**Request Body:**
```json
{
  "color": "#FF5733",
  "description": "Updated description"
}
```

**Response:** Updated LabelRegistration object

#### Delete Label
```http
DELETE /config/labels/{id}
```

**Note:** Labels can only be deleted when they have zero usages.

**Response:** 204 No Content

#### Search Labels
Fuzzy search labels by name.

```http
GET /config/labels/search
```

**Query Parameters:**
- `q` (string): Search query
- `threshold` (float, optional): Similarity threshold 0.0-1.0 (default: 0.3)
- `limit` (int, optional): Maximum results (default: 20)
- `activeFilter` (string, optional): Filter by status

**Response:** Array of LabelSearchResult objects with similarity scores

#### Label Suggestions
Get autocomplete suggestions.

```http
GET /config/labels/suggest
```

**Query Parameters:**
- `prefix` (string): Prefix to search for
- `limit` (int, optional): Maximum suggestions (default: 10)

**Response:** Array of LabelSuggestion objects

### Competence Groups API (V3)

Competence Groups define expertise areas and associate employees, topics, and customer types.

#### List Competence Groups
```http
GET /bookme/config/competence-groups
```

**Query Parameters:**
- `labels` (array, optional): Filter by labels

**Response:** Array of CompetenceGroup objects

#### Get Competence Group
```http
GET /bookme/config/competence-groups/{id}
```

**Response:** CompetenceGroup object

#### Create Competence Group
```http
POST /bookme/config/competence-groups
```

**Request Body:**
```json
{
  "name": "Mortgage Specialists",
  "employeeIds": ["uuid1", "uuid2"],
  "customerTypeIds": ["uuid3"],
  "topicIds": ["uuid4"],
  "labels": ["Finance", "Premium"]
}
```

**Response:** 201 Created with CompetenceGroup object

#### Update Competence Group
```http
PATCH /bookme/config/competence-groups/{id}
```

**Request Body:** Array of JSON Patch operations
```json
[
  { "op": "replace", "path": "/name", "value": "Updated Name" },
  { "op": "replace", "path": "/labels", "value": ["Finance", "Updated"] }
]
```

**Response:** 200 OK

#### Delete Competence Group
```http
DELETE /bookme/config/competence-groups/{id}
```

**Response:** 204 No Content

### Service Groups API (V3)

Service Groups organize employees into logical groups for scheduling.

#### List Service Groups
```http
GET /bookme/config/service-groups
```

**Query Parameters:**
- `labels` (array, optional): Filter by labels

**Response:** Array of ServiceGroup objects

#### Get Service Group
```http
GET /bookme/config/service-groups/{id}
```

**Response:** ServiceGroup object

#### Create Service Group
```http
POST /bookme/config/service-groups
```

**Request Body:**
```json
{
  "name": "Customer Service Team",
  "membershipEmail": "team@example.com",
  "employeeIds": ["uuid1", "uuid2"],
  "competenceGroupIds": ["uuid3"],
  "labels": ["Support"]
}
```

**Response:** 201 Created with ServiceGroup object

#### Update Service Group
```http
PATCH /bookme/config/service-groups/{id}
```

**Request Body:** Array of JSON Patch operations

**Response:** 200 OK

#### Delete Service Group
```http
DELETE /bookme/config/service-groups/{id}
```

**Response:** 204 No Content

#### Get Service Group Advisors
Get advisor membership showing advisors from different sources.

```http
GET /bookme/config/service-groups/{id}/advisors
```

**Response:**
```json
{
  "skillBased": ["uuid1", "uuid2"],
  "assigned": ["uuid3"],
  "competenceGroupAdvisors": ["uuid4", "uuid5"]
}
```

#### Update Service Trigger
Update service trigger configuration for a service group.

```http
PATCH /bookme/config/service-groups/{id}/service-trigger
```

**Request Body:** Array of JSON Patch operations

**Response:** 200 OK

#### Update Service Level
Update service level configuration for a service group.

```http
PATCH /bookme/config/service-groups/{id}/service-level
```

**Request Body:** Array of JSON Patch operations

**Response:** 200 OK

### Portals API (V3)

Portals represent booking interfaces that can be customized with fields, styling, and authentication.

#### List Portals
```http
GET /bookme/config/portals
```

**Query Parameters:**
- `includeHiddenFields` (boolean, optional): Include hidden form fields
- `labels` (array, optional): Filter by labels

**Response:** Array of Portal objects

#### Get Portal
```http
GET /bookme/config/portals/{id}
```

**Query Parameters:**
- `includeHiddenFields` (boolean, optional): Include hidden form fields

**Response:** Portal object

#### Create Portal
```http
POST /bookme/config/portals
```

**Request Body:**
```json
{
  "name": "Customer Booking Portal",
  "location": "Copenhagen",
  "authenticationType": "AzureAD",
  "fields": [
    {
      "name": "phone",
      "label": "Phone Number",
      "type": "Phone",
      "validation": {
        "required": true
      }
    }
  ],
  "logoUrl": "https://example.com/logo.png",
  "styling": "/* Custom CSS */",
  "customerTypeId": "uuid",
  "topicId": "uuid",
  "icalEnabled": true,
  "labels": ["Public"]
}
```

**Response:** 201 Created with Portal object

#### Update Portal
```http
PATCH /bookme/config/portals/{id}
```

**Request Body:** Array of JSON Patch operations

**Response:** 200 OK

#### Delete Portal
```http
DELETE /bookme/config/portals/{id}
```

**Response:** 204 No Content

## Data Models

### Meeting Object
```json
{
  "id": "string",
  "salesforceId": "string",
  "bookedBy": {},
  "customerTypeId": "string",
  "timeSlotId": "string",
  "dateCreated": "2025-08-20T10:00:00Z",
  "dateModified": "2025-08-20T10:00:00Z",
  "title": "string",
  "description": "string",
  "videoLink": "string",
  "additionalEmployees": ["string"],
  "roomId": "string",
  "startDate": "2025-08-20T10:00:00Z",
  "endDate": "2025-08-20T11:00:00Z",
  "type": {},
  "topicId": "string",
  "employeeId": "uuid",
  "customerId": "string"
}
```

### TimeSlot Object
```json
{
  "id": "string",
  "employeeId": "uuid",
  "startTime": "2025-08-20T10:00:00Z",
  "endTime": "2025-08-20T11:00:00Z",
  "available": true,
  "roomId": "string"
}
```

### Room Object
```json
{
  "id": "string",
  "name": "string",
  "capacity": 10,
  "location": "string",
  "features": ["string"],
  "available": true
}
```

### LabelRegistration Object (V3)
```json
{
  "id": "uuid",
  "labelName": "Premium",
  "color": "#FFD700",
  "description": "Premium tier services",
  "usageCount": 5,
  "isActive": true,
  "firstSeen": "2025-01-15T10:30:00Z",
  "lastUpdated": "2025-03-20T14:45:00Z"
}
```

### CompetenceGroup Object (V3)
```json
{
  "id": "uuid",
  "name": "Mortgage Specialists",
  "childGroupIds": ["uuid"],
  "parentGroupIds": ["uuid"],
  "customerTypes": [{ "id": "uuid", "name": "Business" }],
  "employeeIds": ["uuid"],
  "topics": [{ "id": "uuid", "name": "Mortgage" }],
  "serviceGroupIds": ["uuid"],
  "labels": ["Finance", "Premium"]
}
```

### ServiceGroup Object (V3)
```json
{
  "id": "uuid",
  "name": "Customer Service Team",
  "membershipEmail": "team@example.com",
  "employeeIds": ["uuid"],
  "competenceGroupIds": ["uuid"],
  "labels": ["Support"]
}
```

### Portal Object (V3)
```json
{
  "id": "uuid",
  "name": "Customer Booking Portal",
  "location": "Copenhagen",
  "fields": [
    {
      "id": "uuid",
      "name": "phone",
      "label": "Phone Number",
      "type": "Phone",
      "placeholder": "+45...",
      "hidden": false,
      "validation": {
        "required": true,
        "pattern": "^\\+?[0-9]{8,}$"
      }
    }
  ],
  "logoUrl": "https://example.com/logo.png",
  "logoHeight": 60,
  "styling": "/* Custom CSS */",
  "authenticationType": "AzureAD",
  "customerTypeId": "uuid",
  "topicId": "uuid",
  "crmMappingConfigurationId": "uuid",
  "icalEnabled": true,
  "labels": ["Public"]
}
```

### Portal Field Types (V3)
- `Text`: Text input field
- `Phone`: Phone number field
- `Email`: Email field
- `Checkbox`: Checkbox field
- `Dropdown`: Dropdown selection field

### Portal Authentication Types (V3)
- `AzureAD`: Standard Azure AD authentication
- `MitID`: Danish MitID national identity authentication

## Code Examples

### JavaScript/Node.js
```javascript
const axios = require('axios');

const ACCESS_TOKEN = 'your-access-token';
const SUBSCRIPTION_KEY = 'your-subscription-key';
const BASE_URL = 'https://apim-public-api-prod.azure-api.net/api/v2/bookme';

// List meetings
async function listMeetings() {
  try {
    const response = await axios.get(`${BASE_URL}/meetings`, {
      headers: {
        'Authorization': `Bearer ${ACCESS_TOKEN}`,
        'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching meetings:', error);
  }
}

// Create a meeting with V2 features
async function createMeeting(meetingData) {
  try {
    const payload = {
      bookedBy: "Customer",
      salesforceId: meetingData.salesforceId, // Required in V2
      customerTypeId: meetingData.customerTypeId || null, // Optional in V2
      timeSlotId: meetingData.timeSlotId,
      employeeId: meetingData.employeeId,
      customerId: meetingData.customerId,
      type: "Physical",
      // V2 new features
      portalId: meetingData.portalId || null,
      customFields: meetingData.customFields || [],
      externalAttendees: meetingData.externalAttendees || [],
      videoLink: meetingData.videoLink || null,
      ...meetingData
    };
    
    const response = await axios.post(`${BASE_URL}/meetings`, payload, {
      headers: {
        'Authorization': `Bearer ${ACCESS_TOKEN}`,
        'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY,
        'Content-Type': 'application/json'
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error creating meeting:', error);
  }
}
```

### C#/.NET
```csharp
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

public class BookMeApiClient
{
    private readonly HttpClient _httpClient;
    private const string AccessToken = "your-access-token";
    private const string SubscriptionKey = "your-subscription-key";
    private const string BaseUrl = "https://apim-public-api-prod.azure-api.net/api/v2/bookme";

    public BookMeApiClient()
    {
        _httpClient = new HttpClient();
        _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {AccessToken}");
        _httpClient.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", SubscriptionKey);
    }

    public async Task<List<Meeting>> GetMeetingsAsync()
    {
        var response = await _httpClient.GetAsync($"{BaseUrl}/meetings");
        response.EnsureSuccessStatusCode();
        
        var json = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<List<Meeting>>(json);
    }

    public async Task<Meeting> CreateMeetingAsync(CreateMeetingRequest meetingRequest)
    {
        var json = JsonConvert.SerializeObject(meetingRequest);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        
        var response = await _httpClient.PostAsync($"{BaseUrl}/meetings", content);
        response.EnsureSuccessStatusCode();
        
        var resultJson = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<Meeting>(resultJson);
    }
}

// V2 Meeting Request Model
public class CreateMeetingRequest
{
    public string BookedBy { get; set; } // "Employee", "Customer", "PortalPartner", "PortalCustomer"
    public string SalesforceId { get; set; } // Required in V2
    public string CustomerTypeId { get; set; } // Optional in V2
    public string TimeSlotId { get; set; }
    public string PortalId { get; set; } // V2 only
    public string Cpr { get; set; } // V2 only
    public List<CustomField> CustomFields { get; set; } // V2 only
    public List<ExternalAttendee> ExternalAttendees { get; set; } // V2 only
    public string Title { get; set; }
    public string Description { get; set; }
    public string VideoLink { get; set; } // V2 only
    public List<string> AdditionalEmployees { get; set; }
    public string RoomId { get; set; }
    public string Type { get; set; } // "Physical", "Online", "Telephone", "Offsite"
    public string TopicId { get; set; } // Optional in V2
    public string EmployeeId { get; set; }
    public string CustomerId { get; set; }
}

public class CustomField
{
    public string Key { get; set; }
    public string Value { get; set; }
}

public class ExternalAttendee
{
    public string Name { get; set; }
    public string Email { get; set; }
}
```

### cURL
```bash
# List meetings
curl -X GET "https://apim-public-api-prod.azure-api.net/api/v2/bookme/meetings" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key"

# Create a V2 meeting with new features
curl -X POST "https://apim-public-api-prod.azure-api.net/api/v2/bookme/meetings" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key" \
  -H "Content-Type: application/json" \
  -d '{
    "bookedBy": "Customer",
    "salesforceId": "sf-customer-123",
    "timeSlotId": "timeslot-uuid",
    "employeeId": "employee-uuid",
    "customerId": "customer-id",
    "title": "Customer Meeting",
    "type": "Online",
    "videoLink": "https://meet.example.com/room123",
    "customFields": [
      {
        "key": "project_code",
        "value": "PROJ-123"
      }
    ],
    "externalAttendees": [
      {
        "name": "John Smith",
        "email": "john.smith@external.com"
      }
    ]
  }'

# Generate iCal for meeting (V2 only)
curl -X POST "https://apim-public-api-prod.azure-api.net/api/v2/bookme/meetings/meeting-id/ical" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Custom Meeting Title",
    "description": "Meeting description for calendar",
    "location": "Online via Teams"
  }'
```

## Full API Specification

For the complete API specification including all endpoints, parameters, and response schemas:
- [V3 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v3/openapi.yaml) - Latest
- [V2 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v2/openapi.yaml)
- [V1 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v1/openapi.yaml)

## What's New in V3

V3 is fully backward compatible with V2. All new features are additive.

### New APIs
- **Labels API**: Centralized label management for categorizing resources with fuzzy search and autocomplete
- **Competence Groups API**: Manage expertise-based employee groupings with hierarchical relationships
- **Service Groups API**: Organize employees into logical service groups with advisor membership tracking
- **Portals API**: Configure booking portals with custom form fields, styling, and authentication

### Key Features
- **Label Filtering**: All new resources support labels for categorization and filtering
- **JSON Patch Operations**: V3 PATCH endpoints use RFC 6902 JSON Patch format
- **Service Group Advisors**: Get advisor membership from multiple sources (skill-based, assigned, competence groups)
- **Portal Configuration**: Custom fields with validation, authentication types (AzureAD, MitID), CSS styling

For detailed migration instructions, see our [V2 to V3 Migration Guide]({{ site.baseurl }}/api/migration-guide-v3).

## What's New in V2

### Key Changes from V1
- **Required Fields**: `salesforceId` is now required, while `customerTypeId`, `topicId`, and `timeSlotId` are now optional
- **Portal Integration**: New `bookedBy` types: `PortalPartner` and `PortalCustomer`
- **Enhanced Features**: Custom fields, external attendees, video links, CPR field, and iCal generation
- **Employee Types**: New types `Local` and `ServiceGroup` replace deprecated `Global` type
- **Time Slot Status**: New internal meeting statuses for better scheduling
- **Portal meeting external attendees**: External attendees can now optionally be added for portal meetings.

For detailed migration instructions, see our [V1 to V2 Migration Guide]({{ site.baseurl }}/api/migration-guide).