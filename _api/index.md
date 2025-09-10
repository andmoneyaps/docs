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

### Version 2.0.0 (Current)
- **Base URL**: `https://apim-public-api.azure-api.net/api/v2/`
- **Status**: Active
- **Released**: 2025
- **Features**: Portal integration, custom fields, enhanced employee types, iCal generation

### Version 1.0.0 (Deprecated)
- **Base URL**: `https://apim-public-api.azure-api.net/api/v1/`
- **Status**: Deprecated
- **Released**: 2025
- **Migration**: See our [V1 to V2 Migration Guide]({{ site.baseurl }}/api/migration-guide) for upgrade instructions

## Getting Started

### Authentication

All API requests require OAuth2 authentication using Azure AD with the following headers:

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

To obtain access credentials, please contact our support team at [info@andmoney.dk](mailto:info@andmoney.dk).

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
- [V2 BookMe OpenAPI Specification (YAML)](https://apim-public-api.azure-api.net/api/v2/openapi.yaml)
- [V1 BookMe OpenAPI Specification (YAML)](https://apim-public-api.azure-api.net/api/v1/openapi.yaml) *(Deprecated)*
- [Present OpenAPI Specification (JSON)]({{ site.baseurl }}/files/swagger.json)

## Support

For API support and questions:
- Email: [info@andmoney.dk](mailto:info@andmoney.dk)
- Documentation issues: [GitHub Issues](https://github.com/andmoneyaps/docs/issues)

## Changelog

View the latest API updates and changes in our [Release Notes]({{ site.baseurl }}/release-news).
