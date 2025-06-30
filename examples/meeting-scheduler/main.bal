// Copyright (c) 2025 WSO2 LLC. (http://www.wso2.com).
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

import ballerina/io;
import ballerinax/zoom.scheduler;

configurable string clientId = ?;
configurable string clientSecret = ?;
configurable string refreshToken = ?;
configurable string userId = ?;

final scheduler:Client zoomClient = check new ({
    auth: {
        clientId,
        clientSecret,
        refreshUrl: "https://zoom.us/oauth/token",
        refreshToken
    }
});

public function main() returns error? {
    scheduler:InlineResponse2007 userInfo = check zoomClient->/users/[userId].get();
    io:println("Meeting Scheduler for ", userInfo.displayName ?: "User");
    io:println("Time Zone: ", userInfo.timeZone ?: "UTC");
    
    scheduler:SchedulerSchedulesBody newSchedule = {
        addOnType: "zoomMeeting",
        availabilityOverride: false,
        availabilityRules: [{
            availabilityId: "gl6te5euumgkfelwor0yf7ag80",
            email: "cvkgluxkqpagt2l2o3rpbq@scheduler.zoom.us",
            segments: [{
                'start: "2025-06-27T01:00:00Z",
                end: "2025-06-27T02:00:00Z"
            }],
            segmentsRecurrence: {
                sun: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                mon: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                tue: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                wed: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                thu: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                fri: [{
                    end: "17:00",
                    'start: "09:00"
                }],
                sat: [{
                    end: "17:00",
                    'start: "09:00"
                }]
            },
            timeZone: "Asia/Shanghai",
            useCustom: false
        }],
        bookingLimit: 0,
        buffer: {
            after: 0,
            before: 0
        },
        capacity: 1,
        color: "#fff200",
        cushion: 0,
        customFields: [{
            customFieldId: "0l6imf50il8jchyapni3p5ckc0",
            enabled: true,
            format: "text",
            includeOther: false,
            name: "Please share anything that will help prepare for our meeting.",
            position: 0,
            required: false,
            answerChoices: ["At home"]
        }],
        description: "15 Minute Meeting",
        duration: 30,
        endDate: "2025-07-05",
        segments: [{
            'start: "2025-06-27T01:00:00Z",
            end: "2025-06-27T02:00:00Z"
        }],
        segmentsRecurrence: {
            sun: [{
                end: "17:00",
                'start: "09:00"
            }],
            mon: [{
                end: "17:00",
                'start: "09:00"
            }],
            tue: [{
                end: "17:00",
                'start: "09:00"
            }],
            wed: [{
                end: "17:00",
                'start: "09:00"
            }],
            thu: [{
                end: "17:00",
                'start: "09:00"
            }],
            fri: [{
                end: "17:00",
                'start: "09:00"
            }],
            sat: [{
                end: "17:00",
                'start: "09:00"
            }]
        },
        timeZone: "Asia/Shanghai",
        location: "AAA office",
        intervalType: "fixed",
        secret: false,
        slug: "conference",
        startDate: "2025-06-27",
        startTimeIncrement: 30,
        summary: "daily meeting",
        scheduleType: "one",
        active: true
    };
    
    scheduler:InlineResponse2011 createdSchedule = check zoomClient->/schedules.post(
        payload = newSchedule
    );
    
    io:println("Created: ", createdSchedule.summary, " (", createdSchedule.scheduleId, ")");
    
    scheduler:InlineResponse2005|error allSchedulesResult = zoomClient->/schedules.get(
        userId = userId,
        pageSize = 10,
        showDeleted = false
    );
    
    if allSchedulesResult is scheduler:InlineResponse2005 {
        scheduler:InlineResponse2005 allSchedules = allSchedulesResult;
        if allSchedules.items is scheduler:InlineResponse2005Items[] {
            scheduler:InlineResponse2005Items[] schedules = <scheduler:InlineResponse2005Items[]>allSchedules.items;
            io:println("Total Schedules: ", schedules.length());
            if schedules.length() > 0 {
                foreach int i in 0..<schedules.length() {
                    scheduler:InlineResponse2005Items schedule = schedules[i];
                    io:println("- ", schedule.summary ?: "Unnamed Schedule", " (", schedule.duration ?: 0, "min)");
                }
            } else {
                io:println("No meeting schedules found.");
            }
        }
    } else {
        io:println("Error fetching schedules: ", allSchedulesResult.message());
        io:println("This might be due to invalid data in existing schedules");
        io:println("Continuing with event fetching...");
    }
    
    scheduler:InlineResponse2003|error scheduledEventsResult = zoomClient->/events.get(
        userId = userId,
        pageSize = 2
    );
    
    if scheduledEventsResult is scheduler:InlineResponse2003 {
        scheduler:InlineResponse2003 scheduledEvents = scheduledEventsResult;
        io:println("Total Events: ", scheduledEvents["totalRecords"] ?: 0);        
        if scheduledEvents.items is scheduler:InlineResponse2003Items[] {
            scheduler:InlineResponse2003Items[] events = <scheduler:InlineResponse2003Items[]>scheduledEvents.items;
            
            if events.length() > 0 {
                foreach int i in 0..<events.length() {
                    scheduler:InlineResponse2003Items event = events[i];
                    io:println("- Event ", event.eventId ?: "Unknown", " (", event.status ?: "Unknown", ")");
                }
            } else {
                io:println("No scheduled events found yet.");
            }
        }
    } else {
        io:println("Error fetching events: ", scheduledEventsResult.message());
    }
}
