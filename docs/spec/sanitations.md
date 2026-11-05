_Author_:  @LinukaAr
_Created_: 20-06-2025 \
_Updated_: 25-09-2026 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Zoom Scheduler.
The OpenAPI specification is obtained from [wso2/api-specs](https://github.com/wso2/api-specs/blob/main/openapi/zoom/scheduler/2.0.0/openapi.json).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

## Sanitization Details

1. **Security Scheme Update**: Changed authentication mechanism from API key to Bearer token
   - **Before**: Used `openapi_authorization` with `apiKey` type in header
   ```json
   "openapi_authorization" : {
     "type" : "apiKey",
     "name" : "Authorization",
     "in" : "header",
     "x-ballerina-name" : "authorization"
   }
   ```
   - **After**: Updated to `bearer_token` with `http` type and `bearer` scheme
   ```json
   "bearer_token" : {
     "type" : "http",
     "scheme" : "bearer"
   }
   ```
    - **Reason**: The original API key authentication method was not suitable for OAuth 2.0 based authentication that Zoom uses. Bearer token authentication provides better security and aligns with Zoom's OAuth 2.0 implementation, allowing for proper token-based authorization.

2. **Security References Update**: Updated all security references across endpoints
   - **Before**: Referenced `openapi_authorization: []` in endpoint security
   - **After**: Changed all references to `bearer_token: []` (24 operations) to maintain consistency with the new security scheme
   - **Reason**: Updated to maintain consistency with the new bearer token security scheme. This ensures all endpoints use the correct authentication mechanism and prevents authentication errors when the client is generated.

3. Change the `url` property of the servers object
- **Original**: `https://api.zoom.us/v2`
- **Updated**: `https://api.zoom.us/v2/scheduler`
- **Reason**: Common prefix added to base URL to simplify endpoint paths.
<!-- auto-generated -->

4. Update the API Paths
- **Original**: Paths included common prefix `/scheduler` in each endpoint.
- **Updated**: Common prefix removed from endpoints as it is now in the base URL.
- **Reason**: Simplifies API paths and avoids duplication.
<!-- auto-generated -->

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/aligned_ballerina_openapi.json --mode client --license docs/license.txt --client-methods remote -o ballerina
```

Note: The license year is hardcoded to 2025, change if necessary.
