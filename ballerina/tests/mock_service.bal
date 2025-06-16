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
import ballerina/log;


listener http:Listener httpListener = new (9091);

http:Service mockService = service object {

    # Delete availability
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # http:Response (The request has failed.)
    resource function delete scheduler/availability/[string availabilityId]() returns http:Response {
        return new http:Response();
    }

    # Delete scheduled events 
    #
    # + eventId - The event ID
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # http:Response (The request has failed.)
    resource function delete scheduler/events/[string eventId](string? user_id) returns http:Response {
        return new http:Response();
    }

    # Delete schedules
    #
    # + scheduleId - The unique identifier of the schedule.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # http:Response (The request has failed.)
    resource function delete scheduler/schedules/[string scheduleId](string? user_id) returns http:Response {
        return new http:Response();
    }

    # Report analytics
    #
    # + user_id - The specific user's web user ID
    # + 'from - The lower bound for filtering
    # + to - The upper bound for filtering
    # + time_zone - The time zone in the response
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns the scheduler analytics.)
    # http:Response (The request has failed.)
    resource function get scheduler/analytics(string? user_id, string? 'from, string? to, string? time_zone) returns json|http:Response {
        return {
            "last_n_days": {
                "scheduled_events_created": 10,
                "scheduled_events_completed": 7,
                "scheduled_events_canceled": 1,
                "scheduled_events_rescheduled": 1,
                "schedules_created": 5,
                "schedules_canceled": 0,
                "one_to_one": 3,
                "one_to_many": 2,
                "any_host_available": 5,
                "all_host_available": 3,
                "one_off_meeting": 1,
                "meeting_poll": 0
            },
            "previous_period": {
                "scheduled_events_created": 8,
                "scheduled_events_completed": 6,
                "scheduled_events_canceled": 0,
                "scheduled_events_rescheduled": 2,
                "schedules_created": 3,
                "schedules_canceled": 1,
                "one_to_one": 6,
                "one_to_many": 2,
                "any_host_available": 4,
                "all_host_available": 2,
                "one_off_meeting": 0,
                "meeting_poll": 1
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
    # http:Response (The request has failed.)
    resource function get scheduler/availability(int? page_size, string? next_page_token, string? user_id) returns json|http:Response {
        return {
            "items": [
                {
                    "owner": "test-owner@example.com",
                    "default": true,
                    "name": "Working Hours",
                    "availability_id": "avail-123",
                    "time_zone": "UTC"
                }
            ]
        };
    }

    # Get availability 
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns an availability resource.)
    # http:Response (The request has failed.)
    resource function get scheduler/availability/[string availabilityId]() returns json|http:Response {
        return {
            "owner": "test-owner@example.com",
            "default": true,
            "name": "Working Hours",
            "availability_id": availabilityId,
            "time_zone": "UTC"
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
    # http:Response (The request has failed.)
    resource function get scheduler/events(string? to, string? 'from, int? page_size, string? order_by, string? time_zone, string? next_page_token, boolean? show_deleted, string? event_type, string? user_id, string? search) returns json|http:Response {
        return {
            "items": [
                {
                    "event_id": "event-123",
                    "summary": "Test Meeting",
                    "description": "A test meeting",
                    "start_date_time": "2024-06-15T10:00:00Z",
                    "end_date_time": "2024-06-15T11:00:00Z",
                    "status": "confirmed",
                    "schedule_id": "schedule-456"
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
    # http:Response (The request has failed.)
    resource function get scheduler/events/[string eventId](string? user_id) returns json|http:Response {
        return {
            "event_id": eventId,
            "summary": "Test Meeting",
            "description": "A test meeting",
            "start_date_time": "2024-06-15T10:00:00Z",
            "end_date_time": "2024-06-15T11:00:00Z",
            "status": "confirmed",
            "schedule_id": "schedule-456"
        };
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
    # http:Response (The request has failed.)
    resource function get scheduler/schedules(string? to, string? 'from, int? page_size, string? next_page_token, boolean? show_deleted, string? time_zone, string? user_id) returns json|http:Response {
        return {
            "items": [
                {
                    "schedule_id": "schedule-456",
                    "summary": "Test Schedule",
                    "description": "A test schedule",
                    "duration": 30,
                    "capacity": 1,
                    "active": true,
                    "status": "confirmed",
                    "availability_override": false
                }
            ]
        };
    }

    # Get schedules
    #
    # + scheduleId - The schedule's unique identifier.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns a schedule resource.)
    # http:Response (The request has failed.)
    resource function get scheduler/schedules/[string scheduleId](string? user_id) returns json|http:Response {
        return {
            "schedule_id": scheduleId,
            "summary": "Test Schedule",
            "description": "A test schedule",
            "duration": 30,
            "capacity": 1,
            "active": true,
            "status": "confirmed",
            "availability_override": false
        };
    }

    # Get user
    #
    # + userId - The user ID
    # + return - returns can be any of following types
    # http:Ok (If successful, this method returns user information.)
    # http:Response (The request has failed.)
    resource function get scheduler/users/[string userId]() returns json|http:Response {
        return {
            "display_name": "Test User",
            "scheduling_url": "https://scheduler.zoom.us/test-user",
            "time_zone": "UTC",
            "slug": "test-user"
        };
    }

    # Patch availability
    #
    # + availabilityId - The UUID of the availability schedule.
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # http:Response (The request has failed.)
    resource function patch scheduler/availability/[string availabilityId](@http:Payload json payload) returns http:Response {
        return new http:Response();
    }

    # Patch scheduled events
    #
    # + eventId - The opaque identifier of the scheduled event.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an event resource.)
    # http:Response (The request has failed.)
    resource function patch scheduler/events/[string eventId](@http:Payload json payload, string? user_id) returns http:Response {
        return new http:Response();
    }

    # Patch schedules
    #
    # + scheduleId - The schedule's unique identifier.
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:NoContent (If successful, this method returns an empty response body.)
    # http:Response (The request has failed.)
    resource function patch scheduler/schedules/[string scheduleId](@http:Payload json payload, string? user_id) returns http:Response {
        return new http:Response();
    }

    # Insert availability
    #
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns an availability resource.)
    # http:Response (The request has failed.)
    resource function post scheduler/availability(@http:Payload json payload) returns json|http:Response {
        return {
            "owner": "test-owner@example.com",
            "default": true,
            "name": "New Working Hours",
            "availability_id": "avail-new-123",
            "time_zone": "UTC"
        };
    }

    # Insert schedules
    #
    # + user_id - User ID query parameter
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns a schedule resource.)
    # http:Response (The request has failed.)
    resource function post scheduler/schedules(@http:Payload json payload, string? user_id) returns json|http:Response {
        json schedulePayload = payload;
        return <json>{
            "schedule_id": "schedule-new-789",
            "summary": schedulePayload is map<json> && schedulePayload.hasKey("summary") ? schedulePayload["summary"] : "Default Summary",
            "description": schedulePayload is map<json> && schedulePayload.hasKey("description") ? schedulePayload["description"] : "Default description",
            "duration": schedulePayload is map<json> && schedulePayload.hasKey("duration") ? schedulePayload["duration"] : 30,
            "capacity": schedulePayload is map<json> && schedulePayload.hasKey("capacity") ? schedulePayload["capacity"] : 1,
            "active": schedulePayload is map<json> && schedulePayload.hasKey("active") ? schedulePayload["active"] : true,
            "availability_override": schedulePayload is map<json> && schedulePayload.hasKey("availabilityOverride") ? schedulePayload["availabilityOverride"] : false,
            "status": "confirmed"
        };
    }

    # Single use link
    #
    # + return - returns can be any of following types
    # http:Created (If successful, this method returns a scheduling link URL.)
    # http:Response (The request has failed.)
    resource function post scheduler/schedules/single_use_link(@http:Payload json payload) returns json|http:Response {
        json schedulePayload = payload;
        string scheduleId = schedulePayload is map<json> && schedulePayload.hasKey("schedule_id") && schedulePayload["schedule_id"] is string
            ? <string>schedulePayload["schedule_id"] : "default-id";
        return <json>{
            "scheduling_url": "https://scheduler.zoom.us/single-use/" + scheduleId
        };
    }
};

function init() returns error? {
    if isLiveServer {
        log:printInfo("Skipping mock server initialization as the tests are running on live server");
        return;
    }
    log:printInfo("Initiating mock server");
    check httpListener.attach(mockService, "/");
    check httpListener.'start();
}