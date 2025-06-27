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

import ballerina/test;

configurable boolean isLiveServer = false;
configurable string userId = "test-user-123";
configurable string serviceUrl = "http://localhost:9090";

configurable string clientId = "test-client-id";
configurable string clientSecret = "test-client-secret";
configurable string refreshToken = "test-refresh-token";
configurable string refreshUrl = "http://localhost:9444/token";

ConnectionConfig config = {
    auth: {
        clientId,
        clientSecret,
        refreshUrl,
        refreshToken
    }
};

Client? zoomClient = ();

@test:BeforeSuite
function startMockServices() returns error? {
    if !isLiveServer {
        _ = check stsListener.attach(sts, "/");
        check stsListener.'start();
    }
    
    zoomClient = check new Client(config, serviceUrl);
}

@test:AfterSuite
function stopMockServices() returns error? {
    if !isLiveServer {
        check stsListener.gracefulStop();
    }
}

final string testScheduleId = "test-schedule-456";

function getClient() returns Client|error {
    Client? clientInstance = zoomClient;
    if clientInstance is () {
        return error("Client not initialized");
    }
    return clientInstance;
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetSchedulerAnalytics() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse200 response = check zoomClientInstance->/analytics.get(userId = userId);
    test:assertTrue(response.lastNDays !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetSchedulerAvailability() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2001 response = check zoomClientInstance->/availability.get(userId = userId);
    test:assertTrue(response.items !is ());
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
function testGetSchedulerUser() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2007 response = check zoomClientInstance->/users/[userId].get();
    test:assertTrue(response.displayName !is ());
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
function testCreateSchedule() returns error? {
    Client zoomClientInstance = check getClient();
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

    InlineResponse2011 response = check zoomClientInstance->/schedules.post(payload = schedulePayload, userId = userId);
    test:assertTrue(response.scheduleId !is ());
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
function testGetSchedule() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2006 response = check zoomClientInstance->/schedules/[testScheduleId].get(userId = userId);
    test:assertTrue(response.summary !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListSchedules() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2005 response = check zoomClientInstance->/schedules.get(userId = userId, pageSize = 10);
    test:assertTrue(response.items !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetSchedulerAnalyticsWithDateRange() returns error? {
    Client zoomClientInstance = check getClient();
    string fromDate = "2024-01-01";
    string toDate = "2024-12-31";

    InlineResponse200 response = check zoomClientInstance->/analytics.get(userId = userId, 'from = fromDate, to = toDate);
    test:assertTrue(response.lastNDays !is ());
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
function testListSchedulesWithPagination() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2005 response = check zoomClientInstance->/schedules.get(
        userId = userId,
        pageSize = 5,
        nextPageToken = "test-pagination-token"
    );
    test:assertTrue(response.items !is ());
}

@test:Config {
    enable: !isLiveServer,
    groups: ["mock_tests"]
}
function testCreateScheduleWithComplexRules() returns error? {
    Client zoomClientInstance = check getClient();
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

    InlineResponse2011 response = check zoomClientInstance->/schedules.post(payload = schedulePayload, userId = userId);
    test:assertTrue(response.scheduleId !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testListScheduledEvents() returns error? {
    Client zoomClientInstance = check getClient();
    InlineResponse2003 response = check zoomClientInstance->/events.get(userId = userId, pageSize = 10);
    test:assertTrue(response.items !is ());
}
