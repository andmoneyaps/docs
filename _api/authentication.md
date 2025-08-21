---
layout: default
title: Authentication
parent: Public API
nav_order: 3
---

# API Authentication

The &money Public API uses OAuth 2.0 with PKCE for authentication. All API requests require a Bearer token.

## Quick Start

Test the API using our developer portal: [https://apim-public-api-test.azure-api.net](https://apim-public-api-test.azure-api.net)

## Implementation

### Option 1: Use MSAL.js (Recommended)

```javascript
import { PublicClientApplication } from '@azure/msal-browser';

const msalConfig = {
  auth: {
    clientId: '42c4043e-27f1-42ce-a03c-c55cb504f2fd',
    authority: 'https://login.microsoftonline.com/organizations',
    redirectUri: 'https://your-app.com/callback'
  }
};

const msalInstance = new PublicClientApplication(msalConfig);

// Login and get token
const response = await msalInstance.loginPopup({
  scopes: ['api://f100d6c7-bbee-405b-9231-7e1c05c4b944/access_as_user'] // Test environment
});

// Use token
const apiResponse = await fetch('https://api.andmoney.dk/v1/bookme/meetings', {
  headers: { 'Authorization': `Bearer ${response.accessToken}` }
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
  `client_id=42c4043e-27f1-42ce-a03c-c55cb504f2fd&` +
  `response_type=code&` +
  `redirect_uri=${encodeURIComponent('https://your-app.com/callback')}&` +
  `scope=${encodeURIComponent('api://f100d6c7-bbee-405b-9231-7e1c05c4b944/access_as_user')}&` +
  `code_challenge=${codeChallenge}&` +
  `code_challenge_method=S256`;

// 3. Exchange code for token (in callback)
const tokenResponse = await fetch('https://login.microsoftonline.com/organizations/oauth2/v2.0/token', {
  method: 'POST',
  headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  body: new URLSearchParams({
    client_id: '42c4043e-27f1-42ce-a03c-c55cb504f2fd',
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
| Test | `api://f100d6c7-bbee-405b-9231-7e1c05c4b944/access_as_user` |
| Production | `api://642f0f04-31f9-4641-a1cb-793f31496bd3/access_as_user` |

**Client ID**: `42c4043e-27f1-42ce-a03c-c55cb504f2fd` (same for all environments)

## Important Notes

- Your redirect URI must be registered with us before use
- Tokens expire after 1 hour
- No client secret needed (PKCE handles security)

## Support

Contact [info@andmoney.dk](mailto:info@andmoney.dk) to register your redirect URIs or get production access.