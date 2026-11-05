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

listener http:Listener ep0 = new (9090);

service / on ep0 {
    # Delete availability
    #
    # + availabilityId - The UUID of the availability schedule
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an empty response body)
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function delete availability/[string availabilityId]() returns http:NoContent|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Delete scheduled event
    #
    # + eventId - The opaque identifier of the scheduled event
    # + userId - This field indicates whether the admin handles certain users. It's only for admin
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an empty response body)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  NotFound <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  Conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  IntenralErr <br>
# )
    resource function delete events/[string eventId](@http:Query {name: "user_id"} string? userId) returns http:NoContent|http:Unauthorized|http:NotFound|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Delete schedule
    #
    # + scheduleId - The unique identifier of the schedule
    # + userId - This field indicates that the admin handles certain users. This setting is only for admin
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an empty response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401 ` <br>
#  unauthorized <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function delete schedules/[string scheduleId](@http:Query {name: "user_id"} string? userId) returns http:NoContent|http:BadRequest|http:Unauthorized|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Report analytics
    #
    # + to - The upper bound (exclusive) for an event's start time to filter by. Optional. The default is not to filter by start time. It must be an RFC3339 timestamp with mandatory time zone offset. For example, 2011-06-03T10:00:00-07:00, 2011-06-03T10:00:00Z. Milliseconds may be provided but are ignored. If `timeMin` is set, `timeMax` must be greater than `timeMin`
    # + 'from - The lower bound (exclusive) for an event's end time from which to filter. Optional. The default is not to filter by end time. It must be an RFC3339 timestamp with mandatory time zone offset, for example, 2011-06-03T10:00:00-07:00, 2011-06-03T10:00:00Z. Milliseconds can be provided but are ignored. If `timeMax` is set, `timeMin` must be smaller than `timeMax`
    # + timeZone - The time zone in the response. The default is the time zone of the calendar. Optional. 
    # + userId - The specific user's web user ID. Default is "me". Use "all" to query for analytics with respect to all members under that account. 
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns the scheduler analytics or the user ID or account ID provided)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function get analytics(string? to, string? 'from, @http:Query {name: "time_zone"} string? timeZone, @http:Query {name: "user_id"} string? userId) returns AnalyticsReport|http:BadRequest|http:Unauthorized|http:NotFound|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return {
            lastNDays: {
                scheduledEventsCreated: 42,
                scheduledEventsCompleted: 35,
                scheduledEventsCanceled: 4,
                scheduledEventsRescheduled: 3,
                schedulesCreated: 6,
                schedulesCanceled: 1,
                oneToOne: 30,
                oneToMany: 8,
                anyHostAvailable: 2,
                allHostAvailable: 1,
                oneOffMeeting: 1,
                meetingPoll: 0
            },
            previousPeriod: {
                scheduledEventsCreated: 37,
                scheduledEventsCompleted: 31,
                scheduledEventsCanceled: 5,
                scheduledEventsRescheduled: 2,
                schedulesCreated: 4,
                schedulesCanceled: 0,
                oneToOne: 26,
                oneToMany: 7,
                anyHostAvailable: 3,
                allHostAvailable: 0,
                oneOffMeeting: 1,
                meetingPoll: 0
            }
        };
    }

    # List availability
    #
    # + pageSize - The maximum number of availability returned on one result page
    # + nextPageToken - The token that specifies which result page to return
    # + userId - The return of the specific user's availability
    # + return - returns can be any of following types 
    # http:Ok (Successful availability of the schedule query result of given user)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function get availability(@http:Query {name: "page_size"} int? pageSize, @http:Query {name: "next_page_token"} string? nextPageToken, @http:Query {name: "user_id"} string? userId) returns AvailabilityList|http:Unauthorized|http:NotFound|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return {
            nextPageToken: "",
            items: [
                {
                    availabilityId: "x3h1u4id4liffdyszsp8kpxl80",
                    name: "Working hours",
                    owner: "KDcuGIm1QgePTO8WbOqwIQ",
                    default: true,
                    timeZone: "America/New_York",
                    segmentsRecurrence: {
                mon: [{'start: "09:00", end: "12:00"}, {'start: "13:00", end: "17:00"}],
                tue: [{'start: "09:00", end: "17:00"}],
                wed: [{'start: "09:00", end: "17:00"}],
                thu: [{'start: "09:00", end: "17:00"}],
                fri: [{'start: "09:00", end: "15:00"}]
            }
                }
            ]
        };
    }

    # Get availability
    #
    # + availabilityId - The UUID of the availability schedule
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns an availability resource in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function get availability/[string availabilityId]() returns Availability|http:BadRequest|http:Unauthorized|http:NotFound|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return {
            availabilityId: availabilityId,
            name: "Working hours",
            owner: "KDcuGIm1QgePTO8WbOqwIQ",
            default: true,
            timeZone: "America/New_York",
            segmentsRecurrence: {
                mon: [{'start: "09:00", end: "12:00"}, {'start: "13:00", end: "17:00"}],
                tue: [{'start: "09:00", end: "17:00"}],
                wed: [{'start: "09:00", end: "17:00"}],
                thu: [{'start: "09:00", end: "17:00"}],
                fri: [{'start: "09:00", end: "15:00"}]
            }
        };
    }

    # List scheduled events
    #
    # + to - The upper bound (exclusive) for an event's start time from which to filter
    # + 'from - The lower bound (exclusive) for an event's end time from which to filter. 
    # + pageSize - The maximum number of events returned on one result page
    # + orderBy - This field indicates the start time or the time when the event has been updated
    # + timeZone - The time zone in the response
    # + nextPageToken - The token that specifies which result page to return
    # + showDeleted - Whether to include deleted events (with status equals `cancelled`) in the result
    # + eventType - Whether to return the pending events
    # + userId - The return of the specific user's scheduled event. It's only for admin
    # + search - This field returns search results from meeting ID or summary
    # + teamId - The team ID of which the user belongs
    # + accountLevel - An optional field. The default is false. False means only list scheduled events of specify user, or it means list scheduled events of all users below current account
    # + createdFrom - The lower bound (exclusive) for an event's create time from which to filter. 
    # + createdTo - The upper bound (exclusive) for an event's create time from which to filter. 
    # + updatedFrom - The lower bound (exclusive) for an event's update time from which to filter
    # + updatedTo - The upper bound (exclusive) for an event's update time from which to filter. 
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns a response body with the following structure:)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function get events(string? to, string? 'from, @http:Query {name: "page_size"} int? pageSize, @http:Query {name: "order_by"} string? orderBy, @http:Query {name: "time_zone"} string? timeZone, @http:Query {name: "next_page_token"} string? nextPageToken, @http:Query {name: "show_deleted"} boolean? showDeleted, @http:Query {name: "event_type"} "pending"? eventType, @http:Query {name: "user_id"} string? userId, string? search, @http:Query {name: "team_id"} string? teamId, @http:Query {name: "account_level"} boolean? accountLevel, @http:Query {name: "created_from"} string? createdFrom, @http:Query {name: "created_to"} string? createdTo, @http:Query {name: "updated_from"} string? updatedFrom, @http:Query {name: "updated_to"} string? updatedTo) returns ScheduledEventList|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return {
            nextPageToken: "",
            items: [
                {
                    eventId: "7b5sfk4nb2p8ruetuqihpbc6el",
                    scheduleId: "jh3hnu6tzs1spm4p8i3pnwwbd4",
                    summary: "30 minute product demo",
                    description: "Walkthrough of the Scheduler integration",
                    startDateTime: "2026-10-01T15:00:00Z",
                    endDateTime: "2026-10-01T15:30:00Z",
                    eventType: "default",
                    status: "confirmed",
                    location: "https://zoom.us/j/95551234567",
                    updated: "2026-09-20T14:05:11Z",
                    attendees: [{
                    attendeeId: "3nqf8ct4pw5ng2v9r8wbh9sq1a",
                    firstName: "Jill",
                    lastName: "Chill",
                    displayName: "Jill Chill",
                    email: "jill.chill@acme-corp.com",
                    timeZone: "America/New_York",
                    created: "2026-09-20T14:05:11Z",
                    booker: true,
                    noShow: false
                }],
                    trackingParams: [{'key: "utm_source", label: "Source", value: "newsletter"}]
                }
            ]
        };
    }

    # Get scheduled event
    #
    # + eventId - The opaque identifier of the scheduled event
    # + userId - This field indicates whether the admin handles certain users. It's only for admin
    # + teamId - The ID of the team to which the user belongs
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns the scheduled event resource in the response body)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  NotFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function get events/[string eventId](@http:Query {name: "user_id"} string? userId, @http:Query {name: "team_id"} string? teamId) returns ScheduledEvent|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            eventId: eventId,
            scheduleId: "jh3hnu6tzs1spm4p8i3pnwwbd4",
            summary: "30 minute product demo",
            description: "Walkthrough of the Scheduler integration",
            startDateTime: "2026-10-01T15:00:00Z",
            endDateTime: "2026-10-01T15:30:00Z",
            eventType: "default",
            status: "confirmed",
            location: "https://zoom.us/j/95551234567",
            meetingNotes: "Customer wants to see the routing forms",
            updated: "2026-09-20T14:05:11Z",
            attendees: [{
                    attendeeId: "3nqf8ct4pw5ng2v9r8wbh9sq1a",
                    firstName: "Jill",
                    lastName: "Chill",
                    displayName: "Jill Chill",
                    email: "jill.chill@acme-corp.com",
                    timeZone: "America/New_York",
                    created: "2026-09-20T14:05:11Z",
                    booker: true,
                    noShow: false
                }]
        };
    }

    # Get scheduled event attendee
    #
    # + eventId - The ID of scheduled event
    # + attendeeId - The ID of attendee to get scheduled event attendee information
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns the scheduled event attendee resource in the response body)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401 ` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  NotFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function get events/[string eventId]/attendees/[string attendeeId]() returns ScheduledEventAttendee|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            eventId: eventId,
            attendeeId: attendeeId,
            scheduleId: "jh3hnu6tzs1spm4p8i3pnwwbd4",
            firstName: "Jill",
            lastName: "Chill",
            displayName: "Jill Chill",
            email: "jill.chill@acme-corp.com",
            timeZone: "America/New_York",
            created: "2026-09-20T14:05:11Z",
            noShow: false,
            customValues: [{name: "Company", position: 1, values: ["Acme Corp"]}]
        };
    }

    # Get routing form response
    #
    # + formId - The identifier of the routing form
    # + responseId - The identifier of the response to a particular routing form
    # + return - returns can be any of following types 
    # http:Ok (If succeeded, this method returns the routing response details in the response body. The response body will include basic routing form information, the questions in the form and the corresponding awnsers, and the final results after submitting the response, which could be one of the following: a URL, a text or a booking link. )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  Unauthorized  
# 
#  )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  NotFound 
# 
#  )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  InternalErr 
# 
#  )
    resource function get routing/forms/[string formId]/response/[string responseId]() returns RoutingFormResponse|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            formId: formId,
            createdTime: "2026-09-18T10:22:43Z",
            creatorEmail: "jill.chill@acme-corp.com",
            resultType: "event",
            resultValue: "jh3hnu6tzs1spm4p8i3pnwwbd4",
            booked: true,
            bookingLink: "https://scheduler.zoom.us/sales-team/product-demo",
            questionsAndAnswers: [
                {questionId: "q1", questionContent: "What is your team size?", answers: ["11-50"]}
            ]
        };
    }

    # List account routing responses
    #
    # + return - returns can be any of following types 
    # http:Ok (If succeeded, this method returns a list of routing responses across all routing forms under the account)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  Unauthorized  
# 
#  )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  NotFound 
# 
#  )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  InternalErr 
# 
#  )
    resource function get routing/responses() returns RoutingResponseList|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            nextPageToken: "",
            responses: [
                {
                    responseId: "r8k2m4n6p8q0s2u4w6y8a0c2e4",
                    formId: "f1a3c5e7g9i1k3m5o7q9s1u3w5",
                    formName: "Sales qualification",
                    createdTime: "2026-09-18T10:22:43Z",
                    creatorEmail: "jill.chill@acme-corp.com",
                    resultType: "event",
                    resultValue: "jh3hnu6tzs1spm4p8i3pnwwbd4",
                    booked: true,
                    bookingLink: "https://scheduler.zoom.us/sales-team/product-demo"
                }
            ]
        };
    }

    # List schedules
    #
    # + to - The upper bound (exclusive) for a schedule's start time from which to filter
    # + 'from - The lower bound (exclusive) for a schedule's end time from which to filter
    # + pageSize - The maximum number of schedule results returned on a result page
    # + nextPageToken - The token that specifies which result page to return
    # + showDeleted - Whether to include the deleted schedule (with status equals "cancelled") in the result
    # + timeZone - The time zone in the response
    # + userId - The return of the specific user's schedules. Ths setting is only for admin
    # + teamId - The team ID to which the user belongs
    # + search - This field returns search results from meeting ID or summary
    # + accountLevel - An optional field. The default is false. False means only list schedules of specify user, or it means list schedules of all users below current account
    # + createdFrom - The lower bound (exclusive) for an event's create time from which to filter. 
    # + createdTo - The upper bound (exclusive) for an event's create time from which to filter. 
    # + updatedFrom - The lower bound (exclusive) for an event's update time from which to filter
    # + updatedTo - The upper bound (exclusive) for an event's update time from which to filter. 
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns a response body with this structure)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  InvalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function get schedules(string? to, string? 'from, @http:Query {name: "page_size"} int? pageSize, @http:Query {name: "next_page_token"} string? nextPageToken, @http:Query {name: "show_deleted"} boolean? showDeleted, @http:Query {name: "time_zone"} string? timeZone, @http:Query {name: "user_id"} string? userId, @http:Query {name: "team_id"} string? teamId, string? search, @http:Query {name: "account_level"} boolean? accountLevel, @http:Query {name: "created_from"} string? createdFrom, @http:Query {name: "created_to"} string? createdTo, @http:Query {name: "updated_from"} string? updatedFrom, @http:Query {name: "updated_to"} string? updatedTo) returns ScheduleList|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return {
            nextPageToken: "",
            items: [
                {
                    scheduleId: "jh3hnu6tzs1spm4p8i3pnwwbd4",
                    summary: "Product demo",
                    description: "A 30 minute walkthrough of the product",
                    duration: 30,
                    capacity: 1,
                    scheduleType: "one",
                    addOnType: "zoomMeeting",
                    timeZone: "America/New_York",
                    slug: "product-demo",
                    schedulingUrl: "https://scheduler.zoom.us/sales-team/product-demo",
                    active: true,
                    status: "confirmed",
                    intervalType: "unlimited",
                    buffer: {before: 5, after: 10},
                    creator: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
                    organizer: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
                    updated: "2026-09-20T14:05:11Z",
                    created: "2026-09-01T09:00:00Z"
                }
            ]
        };
    }

    # Get schedule
    #
    # + scheduleId - The schedule's unique identifier
    # + userId - This field indicates that admins handle certain users. This setting is only for admin
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns an schedule resource in the response body)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  NotFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function get schedules/[string scheduleId](@http:Query {name: "user_id"} string? userId) returns Schedule|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            scheduleId: scheduleId,
            summary: "Product demo",
            description: "A 30 minute walkthrough of the product",
            duration: 30,
            capacity: 1,
            scheduleType: "one",
            addOnType: "zoomMeeting",
            timeZone: "America/New_York",
            slug: "product-demo",
            schedulingUrl: "https://scheduler.zoom.us/sales-team/product-demo",
            active: true,
            status: "confirmed",
            intervalType: "unlimited",
            buffer: {before: 5, after: 10},
            creator: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
            organizer: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
            updated: "2026-09-20T14:05:11Z",
            availabilityRules: [{useCustom: false, availabilityId: "x3h1u4id4liffdyszsp8kpxl80", timeZone: "America/New_York"}]
        };
    }

    # List schedule available times
    #
    # + scheduleId - The unique identifier of the schedule or scheduling page this query belongs to
    # + 'from - The minimum time boundary (start time) for querying available slots. Must be in ISO 8601 / RFC 3339 format in UTC
    # + to - The maximum time boundary (end time) for querying available slots. Must be in ISO 8601 / RFC 3339 format in UTC. Must be strictly after `from`
    # + user - The user slug identifier to filter available time slots for a specific host or team member. Format: `t/` followed by the user identifier, for example `t/x0ghart`. Required if the schedule object contains a `user` field — pass the exact value from that field. Omit if the schedule has no `user` field
    # + timeZone - The timezone identifier of the user or location, represented in the IANA Time Zone Database format (e.g., "America/Los_Angeles")
    # + return - returns can be any of following types 
    # http:Ok (Successfully returned the available time slots)
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  Unregistered user or expired token.
# 
#  )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  The schedule does not exist.
# 
#  )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  A service error occurred.
# 
#  )
    # http:BadGateway (**HTTP Status Code:** `502` <br>
#  Bad Gateway  A service routing error occurred.
# 
#  )
    resource function get schedules/[string scheduleId]/available_times(string 'from, string to, string? user, @http:Query {name: "time_zone"} string? timeZone) returns AvailableTimes|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError|http:BadGateway {
        return {
            scheduleId: scheduleId,
            duration: 30,
            days: [
                {
                    date: "2026-10-01",
                    status: "available",
                    spots: [
                        {startTime: "2026-10-01T13:00:00Z", availableNumber: 1, status: "available"},
                        {startTime: "2026-10-01T13:30:00Z", availableNumber: 1, status: "available"}
                    ]
                },
                {date: "2026-10-02", status: "unavailable", spots: []}
            ]
        };
    }

    # List teams
    #
    # + userId - This field specifies teams that include a specific user
    # + return - returns can be any of following types 
    # http:Ok (The response body of the list team)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  The query URL is invalid 
# 
#  )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  The query user is unauthroized 
# 
#  )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  The server is temporarily unavailable 
# 
#  )
    resource function get teams(@http:Query {name: "user_id"} string? userId) returns TeamList|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return {
            teams: [
                {
                    teamId: "t4e6a8m0b2c4d6e8f0g2h4i6j8",
                    name: "Sales team",
                    slug: "sales-team",
                    ownerId: "KDcuGIm1QgePTO8WbOqwIQ",
                    timezone: "America/New_York",
                    memberCount: 5
                }
            ]
        };
    }

    # Get Scheduler user
    #
    # + userId - The identifier of the user whose Scheduler details are returned
    # + return - returns can be any of following types 
    # http:Ok (If successful, this method returns user information in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function get users/[string userId]() returns SchedulerUser|http:BadRequest|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return {
            displayName: "Sam Seller",
            slug: "sam-seller",
            timeZone: "America/New_York",
            schedulingUrl: "https://scheduler.zoom.us/sam-seller",
            picture: "https://zoom.us/p/KDcuGIm1QgePTO8WbOqwIQ/avatar.png",
            logo: "https://zoom.us/p/KDcuGIm1QgePTO8WbOqwIQ/logo.png"
        };
    }

    # Update availability
    #
    # + availabilityId - The UUID of the availability schedule
    # + payload - In the request body, supply availability resource properties 
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an empty response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  notFound <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function patch availability/[string availabilityId](@http:Payload UpdateAvailabilityRequest payload) returns http:NoContent|http:BadRequest|http:Unauthorized|http:NotFound|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Update scheduled event
    #
    # + eventId - The opaque identifier of the scheduled event
    # + userId - This field indicates whether the admin handles certain users. It's only for admin
    # + payload - In the request body, it supplies the relevant portions of event resource 
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an event resource in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  InvalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function patch events/[string eventId](@http:Query {name: "user_id"} string? userId, @http:Payload UpdateScheduledEventRequest payload) returns http:NoContent|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Update schedule
    #
    # + scheduleId - The schedule's unique identifier
    # + userId - This field indicates that the admin handles certain users. This setting is only for admin
    # + payload - In the request body, it supplies the relevant portions of a schedule resource, according to the rules of patch semantics 
    # + return - returns can be any of following types 
    # http:NoContent (If successful, this method returns an empty response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  InvaildArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:NotFound (**HTTP Status Code:** `404` <br>
#  Not Found  
# 
#  **Error Code:** `404` <br>
#  NotFound <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function patch schedules/[string scheduleId](@http:Query {name: "user_id"} string? userId, @http:Payload UpdateScheduleRequest payload) returns http:NoContent|http:BadRequest|http:Unauthorized|http:NotFound|http:TooManyRequests|http:InternalServerError {
        return http:NO_CONTENT;
    }

    # Create a booking for a schedule slot
    #
    # + user - The user slug identifier to filter available time slots for a specific host or team member. Format: `t/` followed by the user identifier, for example `t/x0ghart`. **Required** if the schedule object contains a `user` field — pass the exact value from that field. Omit if the schedule has no `user` field
    # + payload - The booking details including the schedule to book, time slot, booker information, and optional configuration 
    # + return - returns can be any of following types 
    # http:Created (Booking created successfully. Returns the full booking event object with attendee details, assigned host, and computed fields)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  Invalid request body or time slot has already been scheduled. 
# 
#  )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  Unregistered user or expired token. 
# 
#  )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  The service is unavailable. 
# 
#  )
    resource function post attendee(string? user, @http:Payload CreateBookingRequest payload) returns Booking|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        Booking booking = {
            eventId: "e2v4e6n8t0i2d4f6h8j0l2n4p6",
            scheduleId: payload.scheduleId,
            summary: "30 minute product demo",
            'type: "one",
            capacity: 1,
            duration: <decimal>payload.duration,
            startDateTime: payload.startDateTime,
            endDateTime: "2026-10-01T13:30:00Z",
            status: "confirmed",
            location: "https://zoom.us/j/95551234567",
            locationKind: "zoomMeeting",
            attendees: [
                {
                    id: "a1t2t3e4n5d6e7e8i9d0a1b2c3",
                    firstName: payload.booker.firstName,
                    lastName: payload.booker.lastName,
                    displayName: payload.booker.firstName + " " + payload.booker.lastName,
                    email: payload.booker.email,
                    timeZone: payload.timeZone ?: "America/New_York",
                    responseStatus: "accepted",
                    booker: true,
                    created: "2026-09-25T09:00:00Z"
                }
            ]
        };
        return booking;
    }

    # Create availability
    #
    # + payload - In the request body, it supplies an availability resource properties 
    # + return - returns can be any of following types 
    # http:Created (If successful, this method returns a availability resource in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function post availability(@http:Payload CreateAvailabilityRequest payload) returns CreatedAvailability|http:BadRequest|http:Unauthorized|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return {
            availabilityId: "q9w8e7r6t5y4u3i2o1p0a9s8d7",
            name: payload.name,
            owner: "KDcuGIm1QgePTO8WbOqwIQ",
            default: payload.default ?: false,
            timeZone: payload.timeZone,
            segmentsRecurrence: payload.segmentsRecurrence
        };
    }

    # Create schedule
    #
    # + userId - This field indicates that the admin handles certain users. This setting is only for admin
    # + payload - In the request body, it supplies the schedule resource properties 
    # + return - returns can be any of following types 
    # http:Created (If successful, this method returns an schedule resource in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  InvalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InternalErr <br>
# )
    resource function post schedules(@http:Query {name: "user_id"} string? userId, @http:Payload CreateScheduleRequest payload) returns CreatedSchedule|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return {
            scheduleId: "p0o9i8u7y6t5r4e3w2q1a2s3d4",
            summary: payload.summary ?: "Untitled schedule",
            description: payload.description,
            duration: payload.duration ?: 30,
            capacity: payload.capacity,
            scheduleType: payload.scheduleType ?: "one",
            addOnType: payload.addOnType ?: "zoomMeeting",
            timeZone: payload.timeZone ?: "America/New_York",
            slug: payload.slug ?: "untitled-schedule",
            schedulingUrl: "https://scheduler.zoom.us/sales-team/untitled-schedule",
            active: payload.active ?: true,
            status: "confirmed",
            availabilityOverride: payload.availabilityOverride,
            creator: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
            organizer: {self: true, displayName: "Sam Seller", email: "sam.seller@acme-corp.com"},
            updated: "2026-09-25T09:00:00Z"
        };
    }

    # Create single-use scheduling link
    #
    # + teamId - This field identifies the specific team. If this parameter exists, the link will be created for the team to which the user belongs
    # + payload - Schedule ID for which a single-use scheduling link is created 
    # + return - returns can be any of following types 
    # http:Created (If successful, this method returns a scheduling link URL in the response body)
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  invalidArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  unauthorized <br>
# )
    # http:Conflict (**HTTP Status Code:** `409` <br>
#  Conflict  
# 
#  **Error Code:** `409` <br>
#  conflict <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rest/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  internalErr <br>
# )
    resource function post schedules/single_use_link(@http:Query {name: "team_id"} string? teamId, @http:Payload CreateSingleUseLinkRequest payload) returns SingleUseLink|http:BadRequest|http:Unauthorized|http:Conflict|http:TooManyRequests|http:InternalServerError {
        return {schedulingUrl: string `https://scheduler.zoom.us/d/${payload.scheduleId}/single-use-8f2k1m`};
    }

    # Create share
    #
    # + payload - Schedule customisations to share with a specific attendee without a new schedule 
    # + return - returns can be any of following types 
    # http:Created (Returned a customed link )
    # http:BadRequest (**HTTP Status Code:** `400` <br>
#  Bad Request  
# 
#  **Error Code:** `400` <br>
#  InvaildArgument <br>
# )
    # http:Unauthorized (**HTTP Status Code:** `401` <br>
#  Unauthorized  
# 
#  **Error Code:** `401` <br>
#  Unauthorized  <br>
# )
    # http:TooManyRequests (**HTTP Status Code:** `429` <br>
#  Too Many Requests. For more information, see [rate limits](https://developers.zoom.us/docs/api/rate-limits/). 
# 
#  )
    # http:InternalServerError (**HTTP Status Code:** `500` <br>
#  Internal Server Error  
# 
#  **Error Code:** `500` <br>
#  InrernalErr <br>
# )
    resource function post shares(@http:Payload CreateShareRequest payload) returns Share|http:BadRequest|http:Unauthorized|http:TooManyRequests|http:InternalServerError {
        return {schedulingUrl: string `https://scheduler.zoom.us/s/${payload.scheduleId}/shared-3h7d9q`};
    }
}
