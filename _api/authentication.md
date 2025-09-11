---
layout: default
title: Authentication
parent: Public API
nav_order: 2
---

# API Authentication

The &money Public API uses OAuth 2.0 authentication with Azure AD. All API requests require both a Bearer token and a subscription key.

## Required Headers

```
Authorization: Bearer <access_token>
Ocp-Apim-Subscription-Key: <subscription_key>
```

## Quick Start

1. Register your application and redirect URIs
2. Obtain your subscription key
3. Get access to test and production environments

## Implementation

### Option 1: Use MSAL.js (Recommended)

```javascript
import { PublicClientApplication } from '@azure/msal-browser';

const msalConfig = {
  auth: {
    clientId: '8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b',
    authority: 'https://login.microsoftonline.com/organizations',
    redirectUri: 'https://your-app.com/callback'
  }
};

const msalInstance = new PublicClientApplication(msalConfig);

// Login and get token
const response = await msalInstance.loginPopup({
  scopes: ['api://c096f1c4-781b-4544-9491-610e4b384261/access_as_user'] // Production scope
});

// Use token for API calls
const apiResponse = await fetch('https://apim-public-api.azure-api.net/api/v2/bookme/meetings', {
  headers: { 
    'Authorization': `Bearer ${response.accessToken}`,
    'Ocp-Apim-Subscription-Key': 'your-subscription-key'
  }
});
```

### Option 2: Manual PKCE Implementation

```javascript
// 1. Generate PKCE parameters
const codeVerifier = base64URLEncode(crypto.getRandomValues(new Uint8Array(32)));
const codeChallenge = base64URLEncode(await crypto.subtle.digest('SHA-256', 
  new TextEncoder().encode(codeVerifier)));

// 2. Redirect to authorization
window.location.href = `https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize?` +
  `client_id=8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b&` +
  `response_type=code&` +
  `redirect_uri=${encodeURIComponent('https://your-app.com/callback')}&` +
  `scope=${encodeURIComponent('api://c096f1c4-781b-4544-9491-610e4b384261/access_as_user')}&` +
  `code_challenge=${codeChallenge}&` +
  `code_challenge_method=S256`;

// 3. Exchange code for token (in callback)
const tokenResponse = await fetch('https://login.microsoftonline.com/organizations/oauth2/v2.0/token', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({
    client_id: '8d9cb59c-e0cd-4630-9e6e-efeb3f7aea6b',
    grant_type: 'authorization_code',
    code: authorizationCode,
    redirect_uri: 'https://your-app.com/callback',
    code_verifier: codeVerifier
  })
});

function base64URLEncode(buffer) {
  return btoa(String.fromCharCode(...new Uint8Array(buffer)))
    .replace(/\+/g, '-').replace(/\//g, '_').replace(/=/g, '');
}
```

## Configuration

| Environment | API Scope |
|------------|-----------|
| Production | `api://c096f1c4-781b-4544-9491-610e4b384261/access_as_user` |
| Test | `api://ca6233a5-e7a5-4a47-b72d-8d2161b90af3/access_as_user` |

**Note**: Client IDs and redirect URIs must be registered with us before use.

## Important Notes

- Tokens expire after 1 hour and must be refreshed
- Both Bearer token and subscription key are required for API calls
- All authentication uses OAuth 2.0 with Azure AD
- Contact support for client registration and subscription key access
