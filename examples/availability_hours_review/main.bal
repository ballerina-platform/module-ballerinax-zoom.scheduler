// Copyright (c) 2026, WSO2 LLC. (http://www.wso2.com).
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

// Reviews a user's Scheduler set-up: reads the profile, pages through every availability,
// creates a named set of working hours if it is missing, and compares booking analytics for a
// period with the period before it.

import ballerina/io;
import ballerinax/zoom.scheduler as zoom;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string userId = ?;
configurable string availabilityName = ?;
configurable string timeZone = ?;
configurable string reportFrom = ?;
configurable string reportTo = ?;

public function main() returns error? {
    zoom:Client scheduler = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: read the user's Scheduler profile.
    zoom:SchedulerUser user = check scheduler->getUser(userId);
    io:println("Scheduler user: ", user.displayName ?: userId, " (", user.timeZone ?: "no time zone", ")");

    // Step 2: page through every availability the user owns.
    zoom:AvailabilitySummary[] availabilities = [];
    zoom:AvailabilityList page = check scheduler->listAvailabilities(userId = userId, pageSize = 30);
    while true {
        zoom:AvailabilitySummary[] items = page.items ?: [];
        availabilities.push(...items);
        string next = page.nextPageToken ?: "";
        if next == "" {
            break;
        }
        page = check scheduler->listAvailabilities(userId = userId, pageSize = 30, nextPageToken = next);
    }
    io:println("Availabilities: ", availabilities.length());
    boolean exists = false;
    foreach zoom:AvailabilitySummary availability in availabilities {
        io:println("  - ", availability.name ?: "(unnamed)", " [", availability.timeZone ?: "", "]",
            availability.default == true ? " (default)" : "");
        if availability.name == availabilityName {
            exists = true;
        }
    }

    // Step 3: create the named working hours if they are not there yet.
    if !exists {
        zoom:TimeSegment[] day = [{'start: "08:00", end: "18:00"}];
        zoom:CreatedAvailability created = check scheduler->createAvailability({
            name: availabilityName,
            timeZone,
            segmentsRecurrence: {mon: day, tue: day, wed: day, thu: day, fri: [{'start: "08:00", end: "16:00"}]}
        });
        io:println("Created availability ", created.availabilityId ?: "(unknown)", " named ", availabilityName);
    }

    // Step 4: compare booking activity with the previous period of the same length.
    zoom:AnalyticsReport report = check scheduler->getAnalyticsReport(userId = userId, 'from = reportFrom,
        to = reportTo, timeZone = timeZone);
    zoom:AnalyticsLastNDays? current = report.lastNDays;
    zoom:AnalyticsPreviousPeriod? previous = report.previousPeriod;
    if current is () {
        io:println("No analytics for ", reportFrom, " to ", reportTo);
        return;
    }
    int created = current.scheduledEventsCreated ?: 0;
    int before = previous?.scheduledEventsCreated ?: 0;
    io:println("Events created: ", created, " (previous period: ", before, ")");
    io:println("Completed: ", current.scheduledEventsCompleted ?: 0, ", cancelled: ",
        current.scheduledEventsCanceled ?: 0, ", rescheduled: ", current.scheduledEventsRescheduled ?: 0);
}
