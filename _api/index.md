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

## API Versions

### Version 3.0.0 (Latest)
- **Base URL**: `https://apim-public-api-prod.azure-api.net/api/v3/`
- **Status**: Active
- **Released**: 2025
- **Features**: Label management, Competence Groups, Service Groups, Portals configuration APIs
- **Migration**: See our [V2 to V3 Migration Guide]({{ site.baseurl }}/api/migration-guide-v3) for upgrade instructions

### Version 2.0.0
- **Base URL**: `https://apim-public-api-prod.azure-api.net/api/v2/`
- **Status**: Active
- **Released**: 2025
- **Features**: Portal integration, custom fields, enhanced employee types, iCal generation, external attendees for portal meetings

### Version 1.0.0
- **Base URL**: `https://apim-public-api-prod.azure-api.net/api/v1/`
- **Status**: Active
- **Released**: 2025
- **Migration**: See our [V1 to V2 Migration Guide]({{ site.baseurl }}/api/migration-guide) for upgrade instructions

## Getting Started

### Authentication

All API requests require OAuth2 authentication using Azure AD with the following headers:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

To obtain an API key, please contact the Service Desk.

For detailed authentication setup, see our [Authentication Guide]({{ site.baseurl }}/api/authentication).

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
| 401 | Unauthorized - Invalid or missing access token |
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
- [V3 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v3/openapi.yaml) - Latest
- [V2 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v2/openapi.yaml)
- [V1 OpenAPI Specification (YAML)](https://apim-public-api-prod.azure-api.net/api/v1/openapi.yaml)
- [Present OpenAPI Specification (JSON)]({{ site.baseurl }}/files/swagger.json)

## Support

For API support and questions, contact the Service Desk.

## Changelog

View the latest API updates and changes in our [Release Notes]({{ site.baseurl }}/release-news).
