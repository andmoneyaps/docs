---
layout: default
title: Public API
nav_order: 5
has_children: true
permalink: /api
---

# &money Public API Documentation

Welcome to the &money Public API documentation. Our APIs provide programmatic access to the BookMe booking platform and Present presentation services.

## Available APIs

### BookMe API
The BookMe API enables integration with our enterprise booking and scheduling platform. Key features include:
- Meeting management and scheduling
- Time slot reservations
- Room and resource booking
- Employee availability
- Customer type management
- Topic categorization

[View BookMe API Documentation]({{ site.baseurl }}/api/bookme)

### Present API  
The Present API provides access to our presentation generation services. Capabilities include:
- Template management
- Dynamic slide generation
- PDF conversion
- Slide customization
- Tag-based content mapping

[View Present API Documentation]({{ site.baseurl }}/api/present)

## Getting Started

### Base URLs

| Environment | Base URL |
|------------|----------|
| Production | `https://api.andmoney.dk/v1` |
| Test | `https://api-test.andmoney.dk/v1` |

### Authentication

All API requests require authentication using an API key. Include your API key in the request header:

```
X-API-Key: your-api-key-here
```

To obtain an API key, please contact the Service Desk.

### Rate Limiting

API requests are subject to rate limiting to ensure service reliability:
- Default limit: 1000 requests per hour
- Burst limit: 100 requests per minute

Rate limit headers are included in all responses:
- `X-RateLimit-Limit`: Maximum requests allowed
- `X-RateLimit-Remaining`: Requests remaining in current window
- `X-RateLimit-Reset`: UTC timestamp when limit resets

### Error Handling

The API uses standard HTTP status codes to indicate success or failure:

| Status Code | Description |
|------------|-------------|
| 200 | Success |
| 400 | Bad Request - Invalid parameters |
| 401 | Unauthorized - Invalid or missing API key |
| 403 | Forbidden - Insufficient permissions |
| 404 | Not Found - Resource does not exist |
| 429 | Too Many Requests - Rate limit exceeded |
| 500 | Internal Server Error |

Error responses include a JSON body with details:

```json
{
  "code": "ERROR_CODE",
  "message": "Human-readable error description",
  "details": {}
}
```

## API Specifications

Download the complete API specifications:
- [BookMe OpenAPI Specification (YAML)]({{ site.baseurl }}/files/bookme-api.yaml)
- [Present OpenAPI Specification (JSON)]({{ site.baseurl }}/files/swagger.json)

## Support

For API support and questions, contact the Service Desk.

## Changelog

View the latest API updates and changes in our [Release Notes]({{ site.baseurl }}/release-news).