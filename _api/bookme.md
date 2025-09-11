---
layout: default
title: BookMe API
parent: Public API
nav_order: 1
---

# BookMe API Documentation

The BookMe API provides comprehensive access to meeting booking and scheduling functionality. This documentation covers API Version 2.0.0 (current). For V1 documentation, see the [V1 reference]({{ site.baseurl }}/api/bookme-v1).

## Base URL

```
Production: https://apim-public-api.azure-api.net/api/v2/bookme
Test: https://apim-public-api-test.azure-api.net/api/v2/bookme
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

**Response:** Created Meeting object with ID

#### Update Meeting
Update an existing meeting.

```http
PUT /meetings/{id}
```

**Request Body:** Meeting object

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
- `explicitEmployeeIds` (array): Specific employee IDs
- `startDate` (datetime): Start date
- `lookForwardTime` (timespan): Look-ahead duration
- `topic` (uuid): Meeting topic ID
- `customerTypeId` (uuid): Customer type
- `meetingTypes` (array): Types of meetings
- `employeeTypes` (array): Types of employees (V2 only: "Local", "ServiceGroup", "Explicit")
- `customerLocation` (string): Customer location
- `meetingLocation` (string): Meeting location
- `requireRoom` (boolean): Room requirement
- `requireEmployeeParticipation` (boolean, required): Employee participation requirement

**Response:** Array of available TimeSlot objects

#### Reserve Time Slot
Reserve a time slot for booking.

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
  "token": "string",
  "existingMeetingId": "uuid"
}
```

**Response:** Reservation confirmation

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

## Code Examples

### JavaScript/Node.js
```javascript
const axios = require('axios');

const ACCESS_TOKEN = 'your-access-token';
const SUBSCRIPTION_KEY = 'your-subscription-key';
const BASE_URL = 'https://apim-public-api.azure-api.net/api/v2/bookme';

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
    private const string BaseUrl = "https://apim-public-api.azure-api.net/api/v2/bookme";

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
curl -X GET "https://apim-public-api.azure-api.net/api/v2/bookme/meetings" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key"

# Create a V2 meeting with new features
curl -X POST "https://apim-public-api.azure-api.net/api/v2/bookme/meetings" \
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
curl -X POST "https://apim-public-api.azure-api.net/api/v2/bookme/meetings/meeting-id/ical" \
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
- [V2 OpenAPI Specification (YAML)](https://apim-public-api.azure-api.net/api/v2/openapi.yaml) - Current version
- [V1 OpenAPI Specification (YAML)](https://apim-public-api.azure-api.net/api/v1/openapi.yaml) - Active

## What's New in V2

### Key Changes from V1
- **Required Fields**: `salesforceId` is now required, while `customerTypeId`, `topicId`, and `timeSlotId` are now optional
- **Portal Integration**: New `bookedBy` types: `PortalPartner` and `PortalCustomer`
- **Enhanced Features**: Custom fields, external attendees, video links, CPR field, and iCal generation
- **Employee Types**: New types `Local` and `ServiceGroup` replace deprecated `Global` type
- **Time Slot Status**: New internal meeting statuses for better scheduling

For detailed migration instructions, see our [V1 to V2 Migration Guide]({{ site.baseurl }}/api/migration-guide).