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

import ballerina/http;

listener http:Listener httpListener = new (9090);

service / on httpListener {

    # Report analytics
    #
    # + user_id - The specific user's web user ID
    # + 'from - The lower bound for filtering
    # + to - The upper bound for filtering
    # + time_zone - The time zone in the response
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns the scheduler analytics.)
    # error (The request has failed.)
    resource function get analytics(string? user_id, string? 'from, string? to, string? time_zone) returns InlineResponse200|error {
        return {
            lastNDays: {
                scheduledEventsCreated: 10,
                scheduledEventsCompleted: 7,
                scheduledEventsCanceled: 1,
                scheduledEventsRescheduled: 1,
                schedulesCreated: 5,
                schedulesCanceled: 0,
                oneToOne: 3,
                oneToMany: 2,
                anyHostAvailable: 5,
                allHostAvailable: 3,
                oneOffMeeting: 1,
                meetingPoll: 0
            },
            previousPeriod: {
                scheduledEventsCreated: 8,
                scheduledEventsCompleted: 6,
                scheduledEventsCanceled: 0,
                scheduledEventsRescheduled: 2,
                schedulesCreated: 3,
                schedulesCanceled: 1,
                oneToOne: 6,
                oneToMany: 2,
                anyHostAvailable: 4,
                allHostAvailable: 2,
                oneOffMeeting: 0,
                meetingPoll: 1
            }
        };
    }

    # List availability
    #
    # + page_size - The maximum number of availability returned
    # + next_page_token - The token that specifies which result page to return
    # + user_id - The return of the specific user's availability
    # + return - returns can be any of following types
    # http:Ok (Successful availability of the schedule query result.)
    # error (The request has failed.)
    resource function get availability(int? page_size, string? next_page_token, string? user_id) returns InlineResponse2001|error {
        return {
            items: [
                {
                    owner: "test-owner@example.com",
                    default: true,
                    name: "Working Hours",
                    availabilityId: "avail-123",
                    timeZone: "UTC"
                }
            ]
        };
    }

    # Get availability 
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns an availability resource.)
    # error (The request has failed.)
    resource function get availability/[string availabilityId]() returns InlineResponse2002|error {
        return {
            owner: "test-owner@example.com",
            default: true,
            name: "Working Hours",
            availabilityId: availabilityId,
            timeZone: "UTC"
        };
    }

    # Delete availability
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # error (The request has failed.)
    resource function delete availability/[string availabilityId]() returns error? {
        return;
    }

    # Patch availability
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # error (The request has failed.)
    resource function patch availability/[string availabilityId](@http:Payload AvailabilityavailabilityIdBody payload) returns error? {
        return;
    }

    # Insert availability
    #
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns an availability resource.)
    # error (The request has failed.)
    resource function post availability(@http:Payload SchedulerAvailabilityBody payload) returns InlineResponse201|error {
        return {
            owner: "test-owner@example.com",
            default: true,
            name: "New Working Hours",
            availabilityId: "avail-new-123",
            timeZone: "UTC"
        };
    }

    # List scheduled events
    #
    # + to - The upper bound for filtering
    # + 'from - The lower bound for filtering  
    # + page_size - The maximum number of events returned
    # + order_by - Order by field
    # + time_zone - The time zone in the response
    # + next_page_token - The token for pagination
    # + show_deleted - Whether to include deleted events
    # + event_type - Event type filter
    # + user_id - The specific user's scheduled events
    # + search - Search term
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns scheduled events.)
    # error (The request has failed.)
    resource function get events(string? to, string? 'from, int? page_size, string? order_by, string? time_zone, string? next_page_token, boolean? show_deleted, string? event_type, string? user_id, string? search) returns InlineResponse2003|error {
        return {
            items: [
                {
                    eventId: "event-123",
                    summary: "Test Meeting",
                    description: "A test meeting",
                    startDateTime: "2024-06-15T10:00:00Z",
                    endDateTime: "2024-06-15T11:00:00Z",
                    status: "confirmed",
                    scheduleId: "schedule-456"
                }
            ]
        };
    }

    # Get scheduled events 
    #
    # + eventId - The event ID
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns the scheduled event resource.)
    # error (The request has failed.)
    resource function get events/[string eventId](string? user_id) returns InlineResponse2004|error {
        return {
            eventId: eventId,
            summary: "Test Meeting",
            description: "A test meeting",
            startDateTime: "2024-06-15T10:00:00Z",
            endDateTime: "2024-06-15T11:00:00Z",
            status: "confirmed",
            scheduleId: "schedule-456"
        };
    }

    # Delete scheduled events 
    #
    # + eventId - The event ID
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # error (The request has failed.)
    resource function delete events/[string eventId](string? user_id) returns error? {
        return;
    }

    # Patch scheduled events
    #
    # + eventId - The opaque identifier of the scheduled event.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an event resource.)
    # error (The request has failed.)
    resource function patch events/[string eventId](@http:Payload EventseventIdBody payload, string? user_id) returns error? {
        return;
    }

    # List schedules
    #
    # + to - The upper bound for filtering
    # + 'from - The lower bound for filtering
    # + page_size - The maximum number of schedule results returned
    # + next_page_token - The token for pagination
    # + show_deleted - Whether to include deleted schedules
    # + time_zone - The time zone in the response
    # + user_id - The specific user's schedules
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns schedules.)
    # error (The request has failed.)
    resource function get schedules(string? to, string? 'from, int? page_size, string? next_page_token, boolean? show_deleted, string? time_zone, string? user_id) returns InlineResponse2005|error {
        return {
            items: [
                {
                    scheduleId: "schedule-456",
                    summary: "Test Schedule",
                    description: "A test schedule",
                    duration: 30,
                    capacity: 1,
                    active: true,
                    status: "confirmed",
                    availabilityOverride: false
                }
            ]
        };
    }

    # Insert schedules
    #
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns a schedule resource.)
    # error (The request has failed.)
    resource function post schedules(@http:Payload SchedulerSchedulesBody payload, string? user_id) returns InlineResponse2011|error {
        return {
            scheduleId: "schedule-new-789",
            summary: payload.summary ?: "Default Summary",
            description: payload.description ?: "Default description",
            duration: payload.duration ?: 30,
            capacity: payload.capacity,
            active: payload.active ?: true,
            availabilityOverride: payload.availabilityOverride,
            status: "confirmed"
        };
    }

    # Get schedules
    #
    # + scheduleId - The schedule's unique identifier.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns a schedule resource.)
    # error (The request has failed.)
    resource function get schedules/[string scheduleId](string? user_id) returns InlineResponse2006|error {
        return {
            scheduleId: scheduleId,
            summary: "Test Schedule",
            description: "A test schedule",
            duration: 30,
            capacity: 1,
            active: true,
            status: "confirmed",
            availabilityOverride: false
        };
    }

    # Delete schedules
    #
    # + scheduleId - The unique identifier of the schedule.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # error (The request has failed.)
    resource function delete schedules/[string scheduleId](string? user_id) returns error? {
        return;
    }

    # Patch schedules
    #
    # + scheduleId - The schedule's unique identifier.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # error (The request has failed.)
    resource function patch schedules/[string scheduleId](@http:Payload SchedulesscheduleIdBody payload, string? user_id) returns error? {
        return;
    }

    # Single use link
    #
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns a scheduling link URL.)
    # error (The request has failed.)
    resource function post schedules/single_use_link(@http:Payload SchedulesSingleUseLinkBody payload) returns InlineResponse2012|error {
        return {
            schedulingUrl: "https://scheduler.zoom.us/single-use/" + payload.scheduleId
        };
    }

    # Get user
    #
    # + userId - The user ID
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns user information.)
    # error (The request has failed.)
    resource function get users/[string userId]() returns InlineResponse2007|error {
        return {
            displayName: "Test User",
            schedulingUrl: "https://scheduler.zoom.us/test-user",
            timeZone: "UTC",
            slug: "test-user"
        };
    }
}
