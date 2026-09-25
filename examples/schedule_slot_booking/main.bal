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

// Publishes a 30-minute booking page, finds the first open slot in a time window, optionally
// books it for an invitee, and issues a single-use scheduling link for the same page.

import ballerina/io;
import ballerinax/zoom.scheduler as zoom;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string refreshUrl = ?;
configurable string userId = ?;
configurable string timeZone = ?;
configurable string windowStart = ?;
configurable string windowEnd = ?;
configurable string inviteeFirstName = ?;
configurable string inviteeLastName = ?;
configurable string inviteeEmail = ?;
// Booking sends a calendar invitation to the invitee, so it is off unless enabled.
configurable boolean confirmBooking = false;

public function main() returns error? {
    zoom:Client scheduler = check new ({
        auth: {clientId, clientSecret, refreshToken, refreshUrl}
    });

    // Step 1: create a one-to-one, 30-minute booking page available on weekdays.
    zoom:TimeSegment[] workingDay = [{'start: "09:00", end: "17:00"}];
    zoom:CreatedSchedule schedule = check scheduler->createSchedule({
        summary: "Product demo",
        description: "A 30 minute walkthrough of the product",
        duration: 30,
        capacity: 1,
        scheduleType: "one",
        addOnType: "zoomMeeting",
        timeZone,
        availabilityOverride: false,
        availabilityRules: [
            {
                useCustom: true,
                timeZone,
                segmentsRecurrence: {mon: workingDay, tue: workingDay, wed: workingDay, thu: workingDay, fri: workingDay}
            }
        ]
    }, userId = userId);
    string? scheduleId = schedule.scheduleId;
    if scheduleId is () {
        return error("Zoom did not return an ID for the new schedule");
    }
    io:println("Created schedule ", scheduleId, " at ", schedule.schedulingUrl ?: "(no public URL)");

    // Step 2: find the first open slot in the requested window.
    zoom:AvailableTimes times = check scheduler->listAvailableTimes(scheduleId, 'from = windowStart, to = windowEnd,
        timeZone = timeZone);
    string? firstSlot = ();
    foreach zoom:AvailableDay day in times.days {
        foreach zoom:AvailableSpot spot in day.spots ?: [] {
            if spot.status == "available" && firstSlot is () {
                firstSlot = spot.startTime;
            }
        }
    }
    if firstSlot is () {
        io:println("No open slots between ", windowStart, " and ", windowEnd);
    } else if confirmBooking {
        // Step 3: book the slot for the invitee.
        zoom:Booking booking = check scheduler->createBooking({
            scheduleId,
            duration: times.duration,
            startDateTime: firstSlot,
            timeZone,
            booker: {firstName: inviteeFirstName, lastName: inviteeLastName, email: inviteeEmail}
        });
        io:println("Booked event ", booking.eventId ?: "(unknown)", " starting ", booking.startDateTime ?: firstSlot);
    } else {
        io:println("First open slot: ", firstSlot, " (set confirmBooking = true to book it)");
    }

    // Step 4: issue a link the invitee can use exactly once.
    zoom:SingleUseLink link = check scheduler->createSingleUseLink({scheduleId});
    io:println("Single-use scheduling link: ", link.schedulingUrl);
}
