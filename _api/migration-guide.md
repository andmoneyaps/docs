---
layout: default
title: V1 to V2 Migration Guide
parent: Public API
nav_order: 4
---

# Migration Guide: API V1 to V2

This guide provides step-by-step instructions for migrating from &Money Public API V1 to V2.

## Overview

API V2 introduces significant improvements including portal integration, enhanced meeting features, and better employee type management. While most endpoints remain compatible, there are important breaking changes to be aware of.

## Quick Migration Checklist

- [ ] Update base URLs from `/api/v1/` to `/api/v2/`
- [ ] Review and update authentication headers
- [ ] Update required fields in meeting creation requests
- [ ] Handle new employee types and remove deprecated `Global` type
- [ ] Update time slot status handling
- [ ] Test new V2-only features if needed

## Step 1: Update Base URLs

**V1 URLs:**
```
Production: https://apim-public-api-prod.azure-api.net/api/v1/
Test: https://apim-public-api-test.azure-api.net/api/v1/
```

**V2 URLs:**
```
Production: https://apim-public-api-prod.azure-api.net/api/v2/
Test: https://apim-public-api-test.azure-api.net/api/v2/
```

## Step 2: Authentication (No Changes)

Authentication remains the same between V1 and V2:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

## Step 3: Breaking Changes

### 1. Meeting Creation Requirements

The most significant change is in the `CreateMeetingRequest` required fields:

**V1 Requirements:**
```json
{
  "customerTypeId": "uuid",  // REQUIRED in V1
  "topicId": "uuid",         // REQUIRED in V1  
  "salesforceId": "string"   // OPTIONAL in V1
}
```

**V2 Requirements:**
```json
{
  "salesforceId": "string",  // REQUIRED in V2
  "customerTypeId": "uuid",  // OPTIONAL in V2  
  "topicId": "uuid",         // OPTIONAL in V2
  "timeSlotId": "uuid"       // OPTIONAL in V2 (was required in V1)
}
```

#### Migration Example

**Before (V1):**
```javascript
const meetingData = {
  bookedBy: "Customer",
  customerTypeId: "uuid-required",     // Required
  topicId: "uuid-required",            // Required
  salesforceId: "optional-sf-id",     // Optional
  timeSlotId: "timeslot-uuid",
  employeeId: "employee-uuid",
  customerId: "customer-id",
  type: "Physical"
};
```

**After (V2):**
```javascript
const meetingData = {
  bookedBy: "Customer",
  salesforceId: "required-sf-id",      // Now required
  customerTypeId: "uuid-optional",    // Now optional
  topicId: "uuid-optional",           // Now optional
  timeSlotId: "timeslot-uuid",        // Now optional (was required in V1)
  employeeId: "employee-uuid",        // Still required
  customerId: "customer-id",          // Still required
  type: "Physical",                   // Still required
  // New V2 optional fields
  portalId: null,
  customFields: [],
  videoLink: null,
  externalAttendees: null,
};
```

### 2. Employee Type Changes

The `Global` employee type has been removed in V2.

**V1 Employee Types:**
- `Explicit`
- `Global` *(removed in V2)*

**V2 Employee Types:**
- `Explicit`
- `Local` *(new)*
- `ServiceGroup` *(new)*

#### Migration Code

```javascript
// V1 to V2 employee type mapping
function migrateEmployeeType(v1Type) {
  switch (v1Type) {
    case "Global":
      // Business logic determines replacement
      return "Local"; // or "ServiceGroup" based on your needs
    case "Explicit":
      return "Explicit"; // unchanged
    default:
      return "Local"; // default fallback
  }
}
```

### 3. New BookedBy Options

V2 adds new portal integration options:

**V1 Values:**
- `Employee`
- `Customer`

**V2 Values:**
- `Employee`
- `Customer`  
- `PortalPartner` *(new)*
- `PortalCustomer` *(new)*

### 4. Time Slot Status Updates

V2 adds new internal meeting statuses:

**New V2 Statuses:**
- `BookedInternalBusy`: Internal meeting blocking availability
- `BookedInternalFree`: Internal meeting not blocking availability

## Step 4: New Features in V2

### Portal Integration

```javascript
// Creating portal-initiated meetings
const portalMeeting = {
  bookedBy: "PortalPartner",
  portalId: "portal-uuid",        // New field
  salesforceId: "required-sf-id",
  timeSlotId: "timeslot-uuid",
  employeeId: "employee-uuid",
  customerId: "customer-id", 
  type: "Online",
  videoLink: "https://meet.example.com/room" // New field
  externalAttendees: [
    { name: "John Doe", email: "john.doe@example.com" },
    { name: "Jane Smith", email: "jane.smith@example.com" }
  ] // New field
};
```

### Custom Fields

```javascript
// Adding custom metadata to meetings
const meetingWithCustomFields = {
  // ... standard fields
  customFields: [
    { key: "project_code", value: "PROJ-123" },
    { key: "department", value: "Sales" },
    { key: "priority", value: "High" }
  ]
};
```

### iCal Generation (V2 Only)

```javascript
// Generate calendar file for meeting
async function generateMeetingICal(meetingId) {
  const response = await fetch(`/api/v2/bookme/meetings/${meetingId}/ical`, {
    method: 'POST',
    headers: {
      'Authorization': 'Bearer ' + accessToken,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      title: "Custom Meeting Title",
      description: "Meeting description for calendar",
      location: "Conference Room A"
    })
  });
  
  const icalData = await response.blob();
  return icalData;
}
```

### Enhanced Time Slot Filtering

```javascript
// V2 provides more sophisticated filtering
const availableSlots = await fetch('/api/v2/bookme/time-slots/available?' + new URLSearchParams({
  startDate: '2025-09-15T08:00:00Z',
  employeeTypes: ['Local', 'ServiceGroup'], // New V2 filter
  meetingTypes: ['Physical', 'Online'],
  requireEmployeeParticipation: true
}));
```

## Step 5: Testing Your Migration

### 1. Endpoint Testing

Test key endpoints with V2 URLs:

```bash
# Test meeting listing
curl -X GET "https://apim-public-api-prod.azure-api.net/api/v2/bookme/meetings" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Ocp-Apim-Subscription-Key: YOUR_KEY"

# Test meeting creation with V2 requirements
curl -X POST "https://apim-public-api-prod.azure-api.net/api/v2/bookme/meetings" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Ocp-Apim-Subscription-Key: YOUR_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "bookedBy": "Customer",
    "salesforceId": "REQUIRED_IN_V2",
    "timeSlotId": "timeslot-uuid",
    "employeeId": "employee-uuid",
    "customerId": "customer-id",
    "type": "Physical"
  }'
```

### 2. Error Handling

V2 maintains the same error response format:

```json
{
  "code": "ERROR_CODE", 
  "message": "Human-readable error description",
  "details": {}
}
```

Common V2 migration errors:
- `400 Bad Request`: Missing required `salesforceId` field
- `400 Bad Request`: Invalid employee type (using deprecated `Global`)

## Step 6: Rollback Strategy

Keep your V1 implementation ready as a fallback:

```javascript
const API_VERSION = process.env.API_VERSION || 'v2';
const BASE_URL = `https://apim-public-api-prod.azure-api.net/api/${API_VERSION}`;

// Feature flags for V2-only features
const useV2Features = API_VERSION === 'v2';

if (useV2Features) {
  // Use V2-specific fields and endpoints
} else {
  // Fall back to V1 behavior
}
```

## Migration Timeline

1. **Development**: Update and test in development environment
2. **Staging**: Full testing in staging environment  
3. **Production**: Gradual rollout with monitoring

## Additional Resources

- [V2 API Documentation]({{ site.baseurl }}/api/bookme)
- [V2 OpenAPI Specification](https://apim-public-api-prod.azure-api.net/api/v2/openapi.yaml)
- [V1 OpenAPI Specification](https://apim-public-api-prod.azure-api.net/api/v1/openapi.yaml) (deprecated)