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

import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string userId = isLiveServer ? os:getEnv("ZOOM_USER_ID") : "test-user-123";
configurable string serviceUrl = isLiveServer ? "https://api.zoom.us/v2/scheduler" : "http://localhost:9090";

configurable string clientId = isLiveServer ? os:getEnv("ZOOM_CLIENT_ID") : "test-client-id";
configurable string clientSecret = isLiveServer ? os:getEnv("ZOOM_CLIENT_SECRET") : "test-client-secret";
configurable string refreshToken = isLiveServer ? os:getEnv("ZOOM_REFRESH_TOKEN") : "test-refresh-token";
configurable string refreshUrl = isLiveServer ? os:getEnv("ZOOM_REFRESH_URL") : "https://zoom.us/oauth/token";


ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshUrl,
        refreshToken
    }
};

final Client zoomClient = check new Client(config, serviceUrl);

final string testScheduleId = "test-schedule-456";

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAnalytics() returns error? {
    InlineResponse200 response = check zoomClient->/analytics.get(userId = userId);
    test:assertTrue(response.lastNDays !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAvailability() returns error? {
    InlineResponse2001 response = check zoomClient->/availability.get(userId = userId);
    test:assertTrue(response.items !is ());
}

// This test is enabled only for mock server, as getting a specific user by a test ID is not feasible on the live server.
@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
isolated function testGetSchedulerUser() returns error? {
    InlineResponse2007 response = check zoomClient->/users/[userId].get();
    test:assertTrue(response.displayName !is ());
}

// This test is enabled only for mock server, as creating arbitrary schedules may not be desirable or permissible on the live server.
@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
isolated function testCreateSchedule() returns error? {
    SchedulerSchedulesBody schedulePayload = {
        summary: "Test Schedule",
        duration: 30,
        capacity: 1,
        availabilityRules: [{
            email: "test@example.com",
            timeZone: "UTC"
        }],
        availabilityOverride: false
    };

    InlineResponse2011 response = check zoomClient->/schedules.post(payload = schedulePayload, userId = userId);
    test:assertTrue(response.scheduleId !is ());
}

// This test is enabled only for mock server, as it relies on a hardcoded, non-existent schedule ID.
@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
isolated function testGetSchedule() returns error? {
    InlineResponse2006 response = check zoomClient->/schedules/[testScheduleId].get(userId = userId);
    test:assertTrue(response.summary !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListSchedules() returns error? {
    InlineResponse2005 response = check zoomClient->/schedules.get(userId = userId, pageSize = 10);
    test:assertTrue(response.items !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAnalyticsWithDateRange() returns error? {
    string fromDate = "2024-01-01";
    string toDate = "2024-12-31";

    InlineResponse200 response = check zoomClient->/analytics.get(userId = userId, 'from = fromDate, to = toDate);
    test:assertTrue(response.lastNDays !is ());
}

// This test is enabled only for mock server, as it uses a fake pagination token.
@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
isolated function testListSchedulesWithPagination() returns error? {
    InlineResponse2005 response = check zoomClient->/schedules.get(
        userId = userId,
        pageSize = 5,
        nextPageToken = "test-pagination-token"
    );
    test:assertTrue(response.items !is ());
}

// This test is enabled only for mock server to validate complex payload structures.
@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
isolated function testCreateScheduleWithComplexRules() returns error? {
    SchedulerSchedulesBody schedulePayload = {
        summary: "Complex Schedule",
        duration: 60,
        capacity: 5,
        availabilityRules: [
            {
                email: "user1@example.com",
                timeZone: "UTC"
            },
            {
                email: "user2@example.com",
                timeZone: "America/Los_Angeles"
            }
        ],
        availabilityOverride: false
    };

    InlineResponse2011 response = check zoomClient->/schedules.post(payload = schedulePayload, userId = userId);
    test:assertTrue(response.scheduleId !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListScheduledEvents() returns error? {
    InlineResponse2003 response = check zoomClient->/events.get(userId = userId, pageSize = 10);
    test:assertTrue(response.items !is ());
}
