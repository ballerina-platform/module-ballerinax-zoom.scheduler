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
configurable string serviceUrl = isLiveServer ? "https://api.zoom.us/v2/scheduler" : "http://localhost:9090";
configurable string userId = "test-user-123";
configurable string clientId = "test-client-id";
configurable string clientSecret = "test-client-secret";
configurable string refreshToken = "test-refresh-token";
configurable string refreshUrl = "http://localhost:9444/token";
configurable string scheduleId = "jh3hnu6tzs1spm4p8i3pnwwbd4";
configurable string availabilityId = "x3h1u4id4liffdyszsp8kpxl80";
configurable string eventId = "7b5sfk4nb2p8ruetuqihpbc6el";
configurable string attendeeId = "3nqf8ct4pw5ng2v9r8wbh9sq1a";
configurable string routingFormId = "f1a3c5e7g9i1k3m5o7q9s1u3w5";
configurable string routingResponseId = "r8k2m4n6p8q0s2u4w6y8a0c2e4";

// The refresh-token grant fetches a token when the client is constructed, so the client is
// created only after the mock token service has started.
Client zoom = test:mock(Client);

@test:BeforeSuite
function initClient() returns error? {
    if !isLiveServer {
        check stsListener.attach(sts, "/");
        check stsListener.'start();
    }
    zoom = check new ({auth: {clientId, clientSecret, refreshToken, refreshUrl}}, serviceUrl);
}

@test:AfterSuite
function stopTokenService() returns error? {
    if !isLiveServer {
        check stsListener.gracefulStop();
    }
}

final WeeklyRecurrence weekdays = {
    mon: [{'start: "09:00", end: "17:00"}],
    tue: [{'start: "09:00", end: "17:00"}],
    wed: [{'start: "09:00", end: "17:00"}],
    thu: [{'start: "09:00", end: "17:00"}],
    fri: [{'start: "09:00", end: "17:00"}]
};

function availabilityRequest(string name) returns CreateAvailabilityRequest => {
    name,
    timeZone: "America/New_York",
    segmentsRecurrence: weekdays
};

function scheduleRequest(string summary) returns CreateScheduleRequest => {
    summary,
    duration: 30,
    capacity: 1,
    availabilityOverride: false,
    availabilityRules: [{useCustom: true, timeZone: "America/New_York", segmentsRecurrence: weekdays}]
};

function bookingRequest() returns CreateBookingRequest => {
    scheduleId,
    duration: 30,
    startDateTime: "2026-10-01T13:00:00Z",
    timeZone: "America/New_York",
    booker: {firstName: "Jill", lastName: "Chill", email: "jill.chill@acme-corp.com"}
};

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetAnalyticsReport() returns error? {
    AnalyticsReport report = check zoom->getAnalyticsReport(userId = userId, 'from = "2026-09-01", to = "2026-09-30");
    test:assertTrue(report.lastNDays !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListAvailabilities() returns error? {
    AvailabilityList result = check zoom->listAvailabilities(userId = userId, pageSize = 10);
    test:assertTrue((result.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateAvailability() returns error? {
    CreatedAvailability created = check zoom->createAvailability(availabilityRequest("Weekday hours"));
    test:assertEquals(created.name, "Weekday hours");
    test:assertTrue(created.availabilityId !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetAvailability() returns error? {
    Availability result = check zoom->getAvailability(availabilityId);
    test:assertEquals(result.availabilityId, availabilityId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testUpdateAvailability() returns error? {
    error? result = zoom->updateAvailability(availabilityId, {name: "Updated hours", timeZone: "America/New_York"});
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDeleteAvailability() returns error? {
    CreatedAvailability created = check zoom->createAvailability(availabilityRequest("Temporary hours"));
    string? id = created.availabilityId;
    if id is () {
        return error("createAvailability returned no availabilityId");
    }
    error? result = zoom->deleteAvailability(id);
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateBooking() returns error? {
    Booking booking = check zoom->createBooking(bookingRequest());
    test:assertTrue(booking.eventId !is ());
    test:assertEquals(booking.scheduleId, scheduleId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListScheduledEvents() returns error? {
    ScheduledEventList result = check zoom->listScheduledEvents(userId = userId, pageSize = 10);
    test:assertTrue((result.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetScheduledEvent() returns error? {
    ScheduledEvent event = check zoom->getScheduledEvent(eventId, userId = userId);
    test:assertEquals(event.eventId, eventId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testUpdateScheduledEvent() returns error? {
    error? result = zoom->updateScheduledEvent(eventId, {meetingNotes: "Follow up next week"}, userId = userId);
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDeleteScheduledEvent() returns error? {
    Booking booking = check zoom->createBooking(bookingRequest());
    string? id = booking.eventId;
    if id is () {
        return error("createBooking returned no eventId");
    }
    error? result = zoom->deleteScheduledEvent(id, userId = userId);
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetScheduledEventAttendee() returns error? {
    ScheduledEventAttendee attendee = check zoom->getScheduledEventAttendee(eventId, attendeeId);
    test:assertEquals(attendee.attendeeId, attendeeId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetRoutingFormResponse() returns error? {
    RoutingFormResponse response = check zoom->getRoutingFormResponse(routingFormId, routingResponseId);
    test:assertEquals(response.formId, routingFormId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListRoutingResponses() returns error? {
    RoutingResponseList result = check zoom->listRoutingResponses();
    test:assertTrue(result.responses !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListSchedules() returns error? {
    ScheduleList result = check zoom->listSchedules(userId = userId, pageSize = 10);
    test:assertTrue((result.items ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateSchedule() returns error? {
    CreatedSchedule created = check zoom->createSchedule(scheduleRequest("Intro call"), userId = userId);
    test:assertEquals(created.summary, "Intro call");
    test:assertTrue(created.scheduleId !is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetSchedule() returns error? {
    Schedule schedule = check zoom->getSchedule(scheduleId, userId = userId);
    test:assertEquals(schedule.scheduleId, scheduleId);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testUpdateSchedule() returns error? {
    error? result = zoom->updateSchedule(scheduleId, {description: "Updated description"}, userId = userId);
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testDeleteSchedule() returns error? {
    CreatedSchedule created = check zoom->createSchedule(scheduleRequest("Temporary schedule"), userId = userId);
    string? id = created.scheduleId;
    if id is () {
        return error("createSchedule returned no scheduleId");
    }
    error? result = zoom->deleteSchedule(id, userId = userId);
    test:assertTrue(result is ());
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListAvailableTimes() returns error? {
    AvailableTimes times = check zoom->listAvailableTimes(scheduleId, 'from = "2026-10-01T00:00:00Z", to = "2026-10-07T00:00:00Z");
    test:assertEquals(times.scheduleId, scheduleId);
    test:assertTrue(times.days.length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateSingleUseLink() returns error? {
    SingleUseLink link = check zoom->createSingleUseLink({scheduleId});
    test:assertTrue(link.schedulingUrl.startsWith("https://"));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testCreateShare() returns error? {
    Share share = check zoom->createShare({scheduleId, duration: 45, timeZone: "America/New_York"});
    test:assertTrue(share.schedulingUrl.startsWith("https://"));
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testListTeams() returns error? {
    TeamList result = check zoom->listTeams(userId = userId);
    test:assertTrue((result.teams ?: []).length() > 0);
}

@test:Config {groups: ["live_tests", "mock_tests"]}
function testGetUser() returns error? {
    SchedulerUser user = check zoom->getUser(userId);
    test:assertTrue(user.schedulingUrl !is ());
}
