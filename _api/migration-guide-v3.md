---
layout: default
title: V2 to V3 Migration Guide
parent: Public API
nav_order: 5
---

# Migration Guide: API V2 to V3

This guide provides step-by-step instructions for migrating from &Money Public API V2 to V3.

## Overview

API V3 introduces a comprehensive label management system and exposes new configuration endpoints for Competence Groups, Service Groups, and Portals. **V3 is fully backward compatible with V2** - all existing V2 functionality works identically in V3.

## Quick Migration Checklist

- [ ] Update base URLs from `/api/v2/` to `/api/v3/`
- [ ] No code changes required for existing V2 functionality
- [ ] Optionally integrate new label management features
- [ ] Optionally use new Competence Groups, Service Groups, and Portals APIs

## Step 1: Update Base URLs

**V2 URLs:**
```
Production: https://apim-public-api-prod.azure-api.net/api/v2/
Test: https://apim-public-api-test.azure-api.net/api/v2/
```

**V3 URLs:**
```
Production: https://apim-public-api-prod.azure-api.net/api/v3/
Test: https://apim-public-api-test.azure-api.net/api/v3/
```

## Step 2: Authentication (No Changes)

Authentication remains the same between V2 and V3:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

## New Features in V3

### Label Registry API

Centralized label management for categorizing resources across the platform.

**Endpoints:**
- `GET /config/labels` - List all labels (paginated)
- `GET /config/labels/{id}` - Get label details
- `POST /config/labels` - Create a label
- `PATCH /config/labels/{id}` - Update label metadata
- `DELETE /config/labels/{id}` - Delete a label
- `GET /config/labels/search` - Fuzzy search labels
- `GET /config/labels/suggest` - Autocomplete suggestions

**Example: Create a label**
```javascript
const createLabel = async () => {
  const response = await fetch('/api/v3/config/labels', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      labelName: 'Premium',
      color: '#FFD700',
      description: 'Premium tier services'
    })
  });
  return response.json();
};
```

### Competence Groups API

Manage expertise-based employee groupings.

**Endpoints:**
- `GET /bookme/config/competence-groups` - List (supports `?labels=` filter)
- `GET /bookme/config/competence-groups/{id}` - Get details
- `POST /bookme/config/competence-groups` - Create
- `PATCH /bookme/config/competence-groups/{id}` - Update (JSON Patch)
- `DELETE /bookme/config/competence-groups/{id}` - Delete

**Example: Create a competence group**
```javascript
const createCompetenceGroup = async () => {
  const response = await fetch('/api/v3/bookme/config/competence-groups', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: 'Mortgage Specialists',
      employeeIds: ['uuid1', 'uuid2'],
      customerTypeIds: ['uuid3'],
      topicIds: ['uuid4'],
      labels: ['Finance', 'Premium']
    })
  });
  return response.json();
};
```

### Service Groups API

Organize employees into logical service groups.

**Endpoints:**
- `GET /bookme/config/service-groups` - List (supports `?labels=` filter)
- `GET /bookme/config/service-groups/{id}` - Get details
- `POST /bookme/config/service-groups` - Create
- `PATCH /bookme/config/service-groups/{id}` - Update (JSON Patch)
- `DELETE /bookme/config/service-groups/{id}` - Delete
- `GET /bookme/config/service-groups/{id}/advisors` - Get advisor membership
- `PATCH /bookme/config/service-groups/{id}/service-trigger` - Update service trigger
- `PATCH /bookme/config/service-groups/{id}/service-level` - Update service level

**Example: Get advisor membership**
```javascript
const getServiceGroupAdvisors = async (id) => {
  const response = await fetch(`/api/v3/bookme/config/service-groups/${id}/advisors`, {
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey
    }
  });
  return response.json();
};

// Response:
// {
//   "skillBased": ["uuid1", "uuid2"],
//   "assigned": ["uuid3"],
//   "competenceGroupAdvisors": ["uuid4", "uuid5"]
// }
```

### Portals API

Configure booking portals with custom fields and styling.

**Endpoints:**
- `GET /bookme/config/portals` - List (supports `?labels=` and `?includeHiddenFields=`)
- `GET /bookme/config/portals/{id}` - Get details
- `POST /bookme/config/portals` - Create
- `PATCH /bookme/config/portals/{id}` - Update (JSON Patch)
- `DELETE /bookme/config/portals/{id}` - Delete

**Portal Authentication Types:**
- `AzureAD` - Standard Azure AD authentication
- `MitID` - Danish MitID national identity authentication

**Portal Field Types:**
- `Text`, `Phone`, `Email`, `Checkbox`, `Dropdown`

**Example: Create a portal**
```javascript
const createPortal = async () => {
  const response = await fetch('/api/v3/bookme/config/portals', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: 'Customer Booking Portal',
      location: 'Copenhagen',
      authenticationType: 'AzureAD',
      fields: [
        {
          name: 'phone',
          label: 'Phone Number',
          type: 'Phone',
          validation: { required: true }
        }
      ],
      logoUrl: 'https://example.com/logo.png',
      icalEnabled: true,
      labels: ['Public']
    })
  });
  return response.json();
};
```

### Template Labels

Templates can now be filtered by labels and have their labels updated.

**New Features:**
- `GET /present/templates?labels=Premium,Finance` - Filter templates by labels
- `PATCH /present/templates/{id}/labels` - Update template labels

**Example: Update template labels**
```javascript
const updateTemplateLabels = async (templateId, labels) => {
  const response = await fetch(`/api/v3/present/templates/${templateId}/labels`, {
    method: 'PATCH',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ labels })
  });
  return response.json();
};

// Usage
await updateTemplateLabels('template-uuid', ['Premium', 'Q1-2024', 'Marketing']);
```

## JSON Patch Operations

V3 PATCH endpoints for Competence Groups, Service Groups, and Portals use [RFC 6902 JSON Patch](https://datatracker.ietf.org/doc/html/rfc6902) format.

**Supported Operations:**
- `add` - Add a value
- `remove` - Remove a value
- `replace` - Replace a value
- `move` - Move a value
- `copy` - Copy a value
- `test` - Test a value

**Example: Update a service group**
```javascript
const updateServiceGroup = async (id) => {
  const response = await fetch(`/api/v3/bookme/config/service-groups/${id}`, {
    method: 'PATCH',
    headers: {
      'Authorization': `Bearer ${accessToken}`,
      'Ocp-Apim-Subscription-Key': subscriptionKey,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify([
      { op: 'replace', path: '/name', value: 'Updated Team Name' },
      { op: 'replace', path: '/employeeIds', value: ['uuid1', 'uuid2'] },
      { op: 'replace', path: '/labels', value: ['Support', 'Premium'] }
    ])
  });
  return response.ok;
};
```

## Summary of V3 Additions

| Feature | V2 | V3 |
|---------|----|----|
| Label Registry API | - | Full CRUD + search/suggest |
| Competence Groups API | - | Full CRUD with label support |
| Service Groups API | - | Full CRUD + advisor membership + trigger/level config |
| Portals API | - | Full CRUD with label support |
| Template label filtering | - | Query parameter support |
| Template label updates | - | PATCH endpoint |

## Breaking Changes

**V3 has no breaking changes from V2.** All existing V2 functionality works identically in V3.

## Rollback Strategy

Since V3 is fully backward compatible, you can safely switch between V2 and V3:

```javascript
const API_VERSION = process.env.API_VERSION || 'v3';
const BASE_URL = `https://apim-public-api-prod.azure-api.net/api/${API_VERSION}`;

// All V2 code works without modification in V3
```

## Additional Resources

- [V3 BookMe API Documentation]({{ site.baseurl }}/api/bookme)
- [V3 Present API Documentation]({{ site.baseurl }}/api/present)
- [V3 OpenAPI Specification](https://apim-public-api-prod.azure-api.net/api/v3/openapi.yaml)
- [V2 OpenAPI Specification](https://apim-public-api-prod.azure-api.net/api/v2/openapi.yaml)
