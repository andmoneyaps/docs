---
layout: default
title: Present API
parent: Public API
nav_order: 3
---

# Present API Documentation

The Present API enables dynamic generation of PowerPoint presentations and PDFs from templates. V3 adds label management for templates.

## Base URL

```
Production (V3): https://apim-public-api-prod.azure-api.net/api/v3/present
Production (V2): https://apim-public-api-prod.azure-api.net/api/v2/present
Test (V3): https://apim-public-api-test.azure-api.net/api/v3/present
Test (V2): https://apim-public-api-test.azure-api.net/api/v2/present
```

## Authentication

All API requests require OAuth2 authentication using Azure AD:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

## Endpoints

### Slides

#### Create Slide Deck
Create a new PowerPoint presentation.

```http
POST /slides
```

**Request Body:**
```json
{
  "template": "template-name",
  "slides": [
    {
      "slideId": "slide-1",
      "data": {
        "title": "Meeting Overview",
        "content": "Dynamic content"
      }
    }
  ]
}
```

**Response:** PowerPoint file download

#### Generate Slide Content
Generate slide content with dynamic data.

```http
POST /slides/generate
```

**Request Body:**
```json
{
  "template": "template-name",
  "data": {
    "customerName": "Company Name",
    "meetingDate": "2025-08-20",
    "advisorName": "John Doe"
  }
}
```

**Response:** Content response with generated data

#### Convert to PDF
Convert slides to PDF format. Supports both JSON and file upload.

**JSON Request:**
```http
POST /slides/pdf
Content-Type: application/json
```

```json
{
  "slideLocation": "path-to-slides",
  "options": {
    "handoutMode": false,
    "notesPages": false
  }
}
```

**File Upload:**
```http
POST /slides/pdf
Content-Type: multipart/form-data
```

**Response:** PDF file or download URL

### Templates

#### List All Templates
Retrieve all available presentation templates.

```http
GET /templates
```

**Query Parameters (V3):**
- `labels` (array, optional): Filter templates by labels

**Response:** Array of SlideTemplate objects

#### Get Template Details
Get details for a specific template.

```http
GET /templates/{name}
```

**Response:** SlideTemplateDetails object

#### Upload Template
Upload a new presentation template. Supports both JSON and file upload.

**JSON Upload:**
```http
POST /templates
Content-Type: application/json
```

```json
{
  "contentId": "template-content-id",
  "name": "Template Name",
  "category": "Business"
}
```

**File Upload:**
```http
POST /templates
Content-Type: multipart/form-data
```

Form fields:
- `file`: Template file (PowerPoint)
- `name`: Template name
- `category`: Template category

**Response:** SlideTemplateDetails object

#### Delete Template
Delete a template.

```http
DELETE /templates/{name}
```

**Response:** 200 OK on success

#### Validate Template
Validate template structure and tags. Supports both JSON and file upload.

**JSON Validation:**
```http
POST /templates/validation
Content-Type: application/json
```

```json
{
  "contentId": "template-content-id"
}
```

**File Validation:**
```http
POST /templates/validation
Content-Type: multipart/form-data
```

Form field:
- `file`: Template file to validate

**Response:** Array of ValidationResult objects

#### Get Template Slides
Get all slides from a template as images.

```http
GET /templates/{name}/slides
```

**Response:** SlideImagesResponse with slide images

#### Get Specific Template Slide
Get a specific slide from a template.

```http
GET /templates/{templateName}/slides/{slideName}
```

**Response:** Image URL for the specific slide

#### Update Template Labels (V3)
Update the labels on a template.

```http
PATCH /templates/{id}/labels
```

**Request Body:**
```json
{
  "labels": ["Premium", "Finance", "Q1-2024"]
}
```

**Response:** Updated SlideTemplate object

## Data Models

### SlideTemplate
```json
{
  "uri": "template-uri",
  "name": "Template Name",
  "customerType": "Business",
  "tenantId": "tenant-uuid",
  "ownerId": "owner-uuid"
}
```

### SlideTemplateDetails
```json
{
  "uri": "template-uri",
  "name": "Template Name", 
  "customerType": "Business",
  "tenantId": "tenant-uuid",
  "ownerId": "owner-uuid",
  "tags": [
    {
      "name": "customer_name",
      "description": "Customer company name"
    }
  ],
  "sections": [
    {
      "name": "Introduction",
      "slides": ["slide-1", "slide-2"]
    }
  ]
}
```

### ValidationResult
```json
{
  "type": "Error|Warning|Info",
  "message": "Validation message",
  "location": "slide-1",
  "details": {}
}
```

## Code Examples

### JavaScript/Node.js
```javascript
const ACCESS_TOKEN = 'your-access-token';
const SUBSCRIPTION_KEY = 'your-subscription-key';
const BASE_URL = 'https://apim-public-api-prod.azure-api.net/api/v2/present';

// Create presentation
async function createPresentation(templateData) {
  const response = await fetch(`${BASE_URL}/slides`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${ACCESS_TOKEN}`,
      'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY,
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(templateData)
  });
  
  return response.blob(); // PowerPoint file
}

// List templates
async function listTemplates() {
  const response = await fetch(`${BASE_URL}/templates`, {
    headers: {
      'Authorization': `Bearer ${ACCESS_TOKEN}`,
      'Ocp-Apim-Subscription-Key': SUBSCRIPTION_KEY
    }
  });
  
  return response.json();
}
```

### cURL
```bash
# List templates
curl -X GET "https://apim-public-api-prod.azure-api.net/api/v2/present/templates" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key"

# Upload template (file)
curl -X POST "https://apim-public-api-prod.azure-api.net/api/v2/present/templates" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@template.pptx" \
  -F "name=Business Template" \
  -F "category=Business"

# Generate slides
curl -X POST "https://apim-public-api-prod.azure-api.net/api/v2/present/slides/generate" \
  -H "Authorization: Bearer your-access-token" \
  -H "Ocp-Apim-Subscription-Key: your-subscription-key" \
  -H "Content-Type: application/json" \
  -d '{
    "template": "business-template",
    "data": {
      "customerName": "Acme Corp",
      "meetingDate": "2025-09-15"
    }
  }'
```

## What's New in V3

- **Template Labels**: Templates can now be filtered by labels and have their labels updated
- **Label Filtering**: Use `?labels=Premium,Finance` to filter templates

For detailed migration instructions, see our [V2 to V3 Migration Guide]({{ site.baseurl }}/api/migration-guide-v3).

## Full API Specification

For the complete API specification including all endpoints, parameters, and response schemas:
- [V3 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v3/openapi.yaml) - Latest
- [V2 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v2/openapi.yaml)
