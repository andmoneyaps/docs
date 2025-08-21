---
layout: default
title: BookMe API
parent: Public API
nav_order: 1
---

# BookMe API Documentation

The BookMe API provides comprehensive access to meeting booking and scheduling functionality.

## Base URL

```
Production: https://api.andmoney.dk/v1/bookme
Test: https://api-test.andmoney.dk/v1/bookme
```

## Authentication

Include your API key in the request header:

```
X-API-Key: your-api-key-here
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

**Request Body:** Meeting object

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

#### Generate iCal
Generate an iCal file for a meeting.

```http
GET /meetings/{id}/ical
```

**Response:** iCal file content

### Time Slots

#### List Time Slots
Retrieve available time slots.

```http
GET /timeslots
```

**Query Parameters:**
- `employeeId` (uuid, optional): Filter by employee
- `roomId` (string, optional): Filter by room
- `startDate` (datetime): Start of date range
- `endDate` (datetime): End of date range

**Response:** Array of TimeSlot objects

#### Reserve Time Slot
Reserve a time slot for booking.

```http
POST /timeslots/{id}/reserve
```

**Request Body:**
```json
{
  "duration": 60,
  "customerId": "customer-id"
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

#### Check Room Availability
Check room availability for a date range.

```http
GET /rooms/{id}/vacancies
```

**Query Parameters:**
- `startDate` (datetime): Start of availability check
- `endDate` (datetime): End of availability check

**Response:** Array of available time slots

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
GET /topics
```

**Response:** Array of Topic objects

#### Create Topic
Create a new meeting topic.

```http
POST /topics
```

**Request Body:** Topic object

**Response:** Created Topic object

### Customer Types

#### List Customer Types
Retrieve all customer types.

```http
GET /customertypes
```

**Response:** Array of CustomerType objects

#### Create Customer Type
Create a new customer type.

```http
POST /customertypes
```

**Request Body:** CustomerType object

**Response:** Created CustomerType object

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

const API_KEY = 'your-api-key';
const BASE_URL = 'https://api.andmoney.dk/v1/bookme';

// List meetings
async function listMeetings() {
  try {
    const response = await axios.get(`${BASE_URL}/meetings`, {
      headers: {
        'X-API-Key': API_KEY
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching meetings:', error);
  }
}

// Create a meeting
async function createMeeting(meetingData) {
  try {
    const response = await axios.post(`${BASE_URL}/meetings`, meetingData, {
      headers: {
        'X-API-Key': API_KEY,
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
    private const string ApiKey = "your-api-key";
    private const string BaseUrl = "https://api.andmoney.dk/v1/bookme";

    public BookMeApiClient()
    {
        _httpClient = new HttpClient();
        _httpClient.DefaultRequestHeaders.Add("X-API-Key", ApiKey);
    }

    public async Task<List<Meeting>> GetMeetingsAsync()
    {
        var response = await _httpClient.GetAsync($"{BaseUrl}/meetings");
        response.EnsureSuccessStatusCode();
        
        var json = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<List<Meeting>>(json);
    }

    public async Task<Meeting> CreateMeetingAsync(Meeting meeting)
    {
        var json = JsonConvert.SerializeObject(meeting);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        
        var response = await _httpClient.PostAsync($"{BaseUrl}/meetings", content);
        response.EnsureSuccessStatusCode();
        
        var resultJson = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<Meeting>(resultJson);
    }
}
```

### cURL
```bash
# List meetings
curl -X GET "https://api.andmoney.dk/v1/bookme/meetings" \
  -H "X-API-Key: your-api-key"

# Create a meeting
curl -X POST "https://api.andmoney.dk/v1/bookme/meetings" \
  -H "X-API-Key: your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Customer Meeting",
    "employeeId": "employee-uuid",
    "customerId": "customer-id",
    "startDate": "2025-08-21T10:00:00Z",
    "endDate": "2025-08-21T11:00:00Z"
  }'
```

## Full API Specification

For the complete API specification including all endpoints, parameters, and response schemas, download the [BookMe OpenAPI Specification]({{ site.baseurl }}/files/bookme-api.yaml).