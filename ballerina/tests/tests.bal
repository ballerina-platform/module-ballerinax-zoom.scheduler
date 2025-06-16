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
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/os;
import ballerina/test;
import ballerina/time;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string userId = isLiveServer ? os:getEnv("ZOOM_USER_ID") : "test";
configurable string token = isLiveServer ? os:getEnv("ZOOM_TOKEN") : "test";
configurable string serviceUrl = isLiveServer ? "https://api.zoom.us/v2" : "http://localhost:9091";

ConnectionConfig config = {
    auth: {
        Authorization: "Bearer " + token
    }
};
final Client zoomClient = check new Client(config, serviceUrl);

final string testUserId = "test-user-123";
final string testScheduleId = "test-schedule-456";

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAnalytics() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse200 response = check zoomClient->/scheduler/analytics.get(headers, 
        userId = userId
    );
    test:assertTrue(response.lastNDays !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAvailability() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse2001 response = check zoomClient->/scheduler/availability.get(headers, 
        userId = userId
    );
    test:assertTrue(response.items !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerUser() returns error? {
    map<string|string[]> headers = {};

    InlineResponse2007 response = check zoomClient->/scheduler/users/[testUserId].get(headers);
    test:assertTrue(response.displayName !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateSchedule() returns error? {
    time:Utc utc = time:utcNow();
    string scheduleSummary = "Test Schedule at " + utc.toString();
    
    SchedulerSchedulesBody schedulePayload = {
        summary: scheduleSummary,
        duration: 30,
        capacity: 1,
        availabilityRules: [
            {
                email: "test@example.com",
                timeZone: "UTC"
            }
        ],
        availabilityOverride: false
    };

    map<string|string[]> headers = {};
    
    InlineResponse2011 response = check zoomClient->/scheduler/schedules.post(schedulePayload, headers, 
        userId = userId
    );
    test:assertTrue(response.scheduleId !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedule() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse2006 response = check zoomClient->/scheduler/schedules/[testScheduleId].get(headers, 
        userId = userId
    );
    test:assertTrue(response.summary !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListSchedules() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse2005 response = check zoomClient->/scheduler/schedules.get(headers, 
        userId = userId,
        pageSize = 10
    );
    test:assertTrue(response.items !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testGetSchedulerAnalyticsWithDateRange() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse200 response = check zoomClient->/scheduler/analytics.get(headers, 
        userId = userId,
        'from = "2024-01-01",
        to = "2024-12-31"
    );
    test:assertTrue(response.lastNDays !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testListSchedulesWithPagination() returns error? {
    map<string|string[]> headers = {};
    
    InlineResponse2005 response = check zoomClient->/scheduler/schedules.get(headers, 
        userId = userId,
        pageSize = 5,
        nextPageToken = "test-token"
    );
    test:assertTrue(response.items !is ());
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
isolated function testCreateScheduleWithComplexRules() returns error? {
    time:Utc utc = time:utcNow();
    string scheduleSummary = "Complex Schedule at " + utc.toString();
    
    SchedulerSchedulesBody schedulePayload = {
        summary: scheduleSummary,
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
        availabilityOverride: true
    };

    map<string|string[]> headers = {};
    
    InlineResponse2011 response = check zoomClient->/scheduler/schedules.post(schedulePayload, headers, 
        userId = userId
    );
    test:assertTrue(response.scheduleId !is ());
}