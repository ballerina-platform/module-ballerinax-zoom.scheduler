// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied. See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

configurable int HTTP_STS_PORT = 9444;
configurable int TOKEN_VALIDITY_PERIOD = 10000;

http:Listener stsListener = check new (HTTP_STS_PORT);

http:Service sts = service object {
    resource function post token() returns json {
        return {
            "access_token": "test-access-token",
            "token_type": "Bearer",
            "expires_in": TOKEN_VALIDITY_PERIOD,
            "refresh_token": "test-refresh-token",
            "scope": "scheduler:read scheduler:write"
        };
    }

    resource function post introspect() returns json {
        return {
            "active": true,
            "scope": "scheduler:read scheduler:write",
            "client_id": "test-client-id",
            "username": "test-user",
            "token_type": "Bearer",
            "exp": TOKEN_VALIDITY_PERIOD,
            "iat": 1419350238,
            "nbf": 1419350238,
            "sub": "test-user-123",
            "aud": "https://api.zoom.us",
            "iss": "https://zoom.us/oauth/token",
            "jti": "test-jwt-id",
            "extension_field": "zoom-scheduler-test",
            "scp": "scheduler:read scheduler:write"
        };
    }
};
