---
layout: default
title: Present API
parent: Public API
nav_order: 2
---

# Present API Documentation

The Present API enables dynamic generation of PowerPoint presentations and PDFs from templates.

## Base URL

```
Production: https://api.andmoney.dk/v1/present
Test: https://api-test.andmoney.dk/v1/present
```

## Authentication

Include your API key in the request header:

```
X-API-Key: your-api-key-here
```

## Endpoints

### Slides

#### Generate Presentation
Generate a PowerPoint presentation from a template with dynamic data.

```http
POST /slides/generate
```

**Request Body:**
```json
{
  "templateId": "template-uuid",
  "data": {
    "customerName": "Company Name",
    "meetingDate": "2025-08-20",
    "advisorName": "John Doe",
    "customFields": {}
  },
  "slides": [
    {
      "slideId": "slide-1",
      "enabled": true,
      "customData": {}
    }
  ]
}
```

**Response:**
```json
{
  "presentationId": "generated-uuid",
  "downloadUrl": "https://api.andmoney.dk/v1/present/download/generated-uuid",
  "expiresAt": "2025-08-21T10:00:00Z"
}
```

#### Create Slide
Add a new slide to a presentation.

```http
POST /slides
```

**Request Body:** Slide configuration object

**Response:** Created slide with ID

#### Convert to PDF
Convert a generated presentation to PDF format.

```http
POST /slides/pdf
```

**Request Body:**
```json
{
  "presentationId": "presentation-uuid",
  "options": {
    "handoutMode": false,
    "notesPages": false
  }
}
```

**Response:**
```json
{
  "pdfUrl": "https://api.andmoney.dk/v1/present/pdf/download-uuid",
  "expiresAt": "2025-08-21T10:00:00Z"
}
```

### Templates

#### List All Templates
Retrieve all available presentation templates.

```http
GET /templates
```

**Response:** Array of Template objects

#### Get Template Details
Get detailed information about a specific template.

```http
GET /templates/{id}
```

**Response:** Template object with slide information

#### Get Template Slides
Retrieve all slides for a template.

```http
GET /templates/{id}/slides
```

**Response:** Array of Slide objects

#### Get Template Slide
Get details for a specific slide in a template.

```http
GET /templates/{id}/slides/{slideId}
```

**Response:** Slide object

#### Upload Template
Upload a new PowerPoint template.

```http
POST /templates/upload
```

**Request:** Multipart form data with file

**Response:** Created Template object

#### Validate Template
Validate a template for compliance with system requirements.

```http
POST /templates/validate
```

**Request:** Multipart form data with file

**Response:**
```json
{
  "valid": true,
  "errors": [],
  "warnings": [],
  "metadata": {
    "slideCount": 15,
    "tags": ["tag1", "tag2"],
    "sections": ["intro", "analysis", "recommendations"]
  }
}
```

#### Delete Template
Remove a template from the system.

```http
DELETE /templates/{id}
```

**Response:** 204 No Content

## Data Models

### Template Object
```json
{
  "id": "template-uuid",
  "name": "Customer Meeting Template",
  "description": "Standard template for customer meetings",
  "version": "1.0.0",
  "createdDate": "2025-08-01T10:00:00Z",
  "modifiedDate": "2025-08-15T14:30:00Z",
  "slideCount": 15,
  "tags": ["meeting", "customer", "standard"],
  "sections": [
    {
      "name": "Introduction",
      "slides": [1, 2, 3]
    },
    {
      "name": "Analysis",
      "slides": [4, 5, 6, 7, 8]
    }
  ]
}
```

### Slide Object
```json
{
  "id": "slide-uuid",
  "templateId": "template-uuid",
  "slideNumber": 1,
  "title": "Welcome",
  "layout": "TitleSlide",
  "tags": ["intro", "welcome"],
  "customizable": true,
  "requiredFields": ["customerName", "meetingDate"],
  "optionalFields": ["logo", "subtitle"]
}
```

### Presentation Object
```json
{
  "id": "presentation-uuid",
  "templateId": "template-uuid",
  "createdDate": "2025-08-20T10:00:00Z",
  "status": "completed",
  "slides": [
    {
      "slideId": "slide-1",
      "included": true,
      "customData": {}
    }
  ],
  "downloadUrl": "https://api.andmoney.dk/v1/present/download/presentation-uuid",
  "pdfUrl": null,
  "expiresAt": "2025-08-21T10:00:00Z"
}
```

## Code Examples

### JavaScript/Node.js
```javascript
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');

const API_KEY = 'your-api-key';
const BASE_URL = 'https://api.andmoney.dk/v1/present';

// Generate presentation
async function generatePresentation(templateId, data) {
  try {
    const response = await axios.post(`${BASE_URL}/slides/generate`, {
      templateId: templateId,
      data: data
    }, {
      headers: {
        'X-API-Key': API_KEY,
        'Content-Type': 'application/json'
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error generating presentation:', error);
  }
}

// Upload template
async function uploadTemplate(filePath) {
  try {
    const form = new FormData();
    form.append('file', fs.createReadStream(filePath));
    
    const response = await axios.post(`${BASE_URL}/templates/upload`, form, {
      headers: {
        'X-API-Key': API_KEY,
        ...form.getHeaders()
      }
    });
    return response.data;
  } catch (error) {
    console.error('Error uploading template:', error);
  }
}
```

### C#/.NET
```csharp
using System;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;

public class PresentApiClient
{
    private readonly HttpClient _httpClient;
    private const string ApiKey = "your-api-key";
    private const string BaseUrl = "https://api.andmoney.dk/v1/present";

    public PresentApiClient()
    {
        _httpClient = new HttpClient();
        _httpClient.DefaultRequestHeaders.Add("X-API-Key", ApiKey);
    }

    public async Task<PresentationResponse> GeneratePresentationAsync(
        string templateId, 
        Dictionary<string, object> data)
    {
        var request = new
        {
            templateId = templateId,
            data = data
        };
        
        var json = JsonConvert.SerializeObject(request);
        var content = new StringContent(json, Encoding.UTF8, "application/json");
        
        var response = await _httpClient.PostAsync($"{BaseUrl}/slides/generate", content);
        response.EnsureSuccessStatusCode();
        
        var resultJson = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<PresentationResponse>(resultJson);
    }

    public async Task<Template> UploadTemplateAsync(string filePath)
    {
        using var form = new MultipartFormDataContent();
        using var fileStream = File.OpenRead(filePath);
        using var streamContent = new StreamContent(fileStream);
        
        form.Add(streamContent, "file", Path.GetFileName(filePath));
        
        var response = await _httpClient.PostAsync($"{BaseUrl}/templates/upload", form);
        response.EnsureSuccessStatusCode();
        
        var json = await response.Content.ReadAsStringAsync();
        return JsonConvert.DeserializeObject<Template>(json);
    }
}
```

### cURL
```bash
# Generate presentation
curl -X POST "https://api.andmoney.dk/v1/present/slides/generate" \
  -H "X-API-Key: your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "templateId": "template-uuid",
    "data": {
      "customerName": "Acme Corp",
      "meetingDate": "2025-08-20"
    }
  }'

# Upload template
curl -X POST "https://api.andmoney.dk/v1/present/templates/upload" \
  -H "X-API-Key: your-api-key" \
  -F "file=@/path/to/template.pptx"

# Convert to PDF
curl -X POST "https://api.andmoney.dk/v1/present/slides/pdf" \
  -H "X-API-Key: your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "presentationId": "presentation-uuid"
  }'
```

## Template Requirements

### Supported Formats
- PowerPoint 2007+ (.pptx)
- PowerPoint 97-2003 (.ppt) - limited support

### Template Guidelines
1. Use consistent slide naming conventions
2. Define clear section boundaries
3. Use standard PowerPoint placeholders for dynamic content
4. Include metadata tags in slide notes
5. Validate templates before production use

### Dynamic Content Tags
Templates support the following dynamic content tags:

- `{% raw %}{{customerName}}{% endraw %}` - Customer/company name
- `{% raw %}{{meetingDate}}{% endraw %}` - Meeting date
- `{% raw %}{{advisorName}}{% endraw %}` - Advisor/consultant name
- `{% raw %}{{customField:fieldName}}{% endraw %}` - Custom field values
- `{% raw %}{{chart:dataSource}}{% endraw %}` - Dynamic charts
- `{% raw %}{{image:imageId}}{% endraw %}` - Dynamic images

## Error Codes

| Code | Description |
|------|-------------|
| TEMPLATE_NOT_FOUND | Specified template does not exist |
| INVALID_TEMPLATE | Template validation failed |
| GENERATION_FAILED | Presentation generation failed |
| INVALID_DATA | Required data fields missing |
| FILE_TOO_LARGE | Uploaded file exceeds size limit |
| UNSUPPORTED_FORMAT | File format not supported |

## Full API Specification

For the complete API specification including all endpoints, parameters, and response schemas:
- [Present OpenAPI Specification (JSON)]({{ site.baseurl }}/files/swagger.json)
- [Interactive API Documentation]({{ site.baseurl }}/present/API-Docs/)