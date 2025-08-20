---
layout: default
title: Authentication
parent: Public API
nav_order: 3
---

# API Authentication

The &money Public API uses OAuth 2.0 with Azure AD. All requests require a Bearer token.

## Quick Start

### 1. Get a Token

**For server applications (recommended):**

```bash
curl -X POST "https://login.microsoftonline.com/{tenant-id}/oauth2/v2.0/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id={your-client-id}" \
  -d "scope={audience-id}/.default" \
  -d "client_secret={your-client-secret}" \
  -d "grant_type=client_credentials"
```

### 2. Use the Token

```bash
curl -X GET "https://api.andmoney.dk/v1/bookme/meetings" \
  -H "Authorization: Bearer {token}"
```

## Environment Configuration

| Environment | Audience ID |
|------------|------------|
| Test | `f100d6c7-bbee-405b-9231-7e1c05c4b944` |
| Production | Contact support for credentials |

## Code Examples

### JavaScript
```javascript
const response = await fetch('https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({
    client_id: 'your-client-id',
    client_secret: 'your-client-secret',
    scope: 'audience-id/.default',
    grant_type: 'client_credentials'
  })
});
const { access_token } = await response.json();
```

### C#
```csharp
var client = new HttpClient();
var content = new FormUrlEncodedContent(new[] {
    new KeyValuePair<string, string>("client_id", "your-client-id"),
    new KeyValuePair<string, string>("client_secret", "your-client-secret"),
    new KeyValuePair<string, string>("scope", "audience-id/.default"),
    new KeyValuePair<string, string>("grant_type", "client_credentials")
});
var response = await client.PostAsync(
    "https://login.microsoftonline.com/{tenant}/oauth2/v2.0/token", 
    content);
var token = await response.Content.ReadAsAsync<TokenResponse>();
```

## Testing with Swagger UI

1. Get a token using the method above
2. Go to [Interactive API Docs]({{ site.baseurl }}/present/API-Docs/)
3. Enter token in the authorization field
4. Click "Set Token"

## Troubleshooting

| Error | Solution |
|-------|----------|
| 401 Unauthorized | Check token is valid and properly formatted |
| 403 Forbidden | Verify token has required permissions |
| Token expired | Request a new token (tokens expire after 1 hour) |

## Support

For production access: [info@andmoney.dk](mailto:info@andmoney.dk)