---
layout: default
title: API Documentation
nav_order: 9
parent: Present
collection: present
---

# Present API Documentation

## Interactive API Explorer

The Present API enables dynamic generation of PowerPoint presentations from templates. Below you can explore the full API specification.

### Authentication Required

To test the API endpoints, you need a valid JWT token. See our [Authentication Guide]({{ site.baseurl }}/api/authentication) for detailed instructions on obtaining a token.

**Quick Start:**
1. Obtain a JWT token using your Azure AD credentials
2. Click the "Authorize" button below or in Swagger UI
3. Enter your token with the "Bearer " prefix
4. The token will be automatically included in all API requests

<div class="auth-wrapper" style="background: #f5f5f5; padding: 15px; border-radius: 5px; margin: 20px 0;">
  <strong>Authorization:</strong>
  <div style="margin: 10px 0;">
    <input type="text" id="bearer-token" placeholder="Bearer YOUR_TOKEN_HERE" style="width: 400px; padding: 8px; border: 1px solid #ddd; border-radius: 4px;">
    <button onclick="setAuthToken()" style="padding: 8px 15px; margin-left: 10px; background: #547dbf; color: white; border: none; border-radius: 4px; cursor: pointer;">Set Token</button>
    <a href="{{ site.baseurl }}/api/authentication" target="_blank" style="margin-left: 10px;">How to get a token?</a>
  </div>
</div>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5.9.0/swagger-ui.css" />

<div id="swagger-ui"></div>

<script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5.9.0/swagger-ui-bundle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@5.9.0/swagger-ui-standalone-preset.js"></script>
<script>
window.onload = function() {
  const ui = SwaggerUIBundle({
    url: "{{ site.baseurl }}/files/swagger.json",
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout",
    validatorUrl: null,
    tryItOutEnabled: true,
    persistAuthorization: true,
    requestInterceptor: (request) => {
      // Add bearer token if provided
      const token = localStorage.getItem('api_token');
      if (token && !request.headers.Authorization) {
        request.headers.Authorization = `Bearer ${token}`;
      }
      return request;
    },
  });
  window.ui = ui;
  
  // Function to set auth token
  window.setAuthToken = function() {
    const tokenInput = document.getElementById('bearer-token').value.trim();
    // Remove "Bearer " prefix if user included it
    const token = tokenInput.replace(/^Bearer\s+/i, '');
    
    if (token) {
      localStorage.setItem('api_token', token);
      // Update the Swagger UI auth
      ui.preauthorizeApiKey('Bearer', token);
      // Update input to show it's set
      document.getElementById('bearer-token').style.backgroundColor = '#d4edda';
      alert('✅ Token set successfully! It will be used for all API requests.');
    } else {
      alert('❌ Please enter a valid token');
    }
  };
}
</script>

## API Overview

The Present API provides endpoints for:
- **Template Management** - Upload, validate, and manage presentation templates
- **Slide Generation** - Generate dynamic presentations from templates with custom data
- **PDF Conversion** - Convert generated presentations to PDF format
- **Slide Customization** - Customize individual slides with dynamic content

## Quick Links

- [Full API Documentation]({{ site.baseurl }}/api/present)
- [Download OpenAPI Specification]({{ site.baseurl }}/files/swagger.json)
- [Present Overview]({{ site.baseurl }}/present/present-introduction/)
- [Template Guidelines]({{ site.baseurl }}/present/validation-tool-master-template/)

## Authentication

All API requests require an API key to be included in the request headers:

```
X-API-Key: your-api-key-here
```

## Base URLs

| Environment | Base URL |
|------------|----------|
| Production | `https://api.andmoney.dk/v1/present` |
| Test | `https://api-test.andmoney.dk/v1/present` |

## Support

For API support and questions, please contact [info@andmoney.dk](mailto:info@andmoney.dk).
