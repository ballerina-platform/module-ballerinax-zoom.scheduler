# Change Log

This file contains all the notable changes done to the Ballerina Zoom Scheduler connector through the releases.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0]

### Breaking changes

- The client now exposes **remote methods** instead of resource methods. Every 1.x call site changes, as listed below.
  Query parameters are still passed as named arguments, and request payloads are passed as the first argument after
  any path parameters.
- Generated record types are renamed from `InlineResponse*` / `*Body` names to descriptive names, for example
  `InlineResponse2011` (create schedule response) is now `CreatedSchedule`, and `SchedulerSchedulesBody` is now
  `CreateScheduleRequest`.
- The minimum Ballerina distribution is now **2201.13.4** (Swan Lake Update 13), up from 2201.12.0.

| 1.x resource method | 2.0.0 remote method |
|---|---|
| `->/analytics.get(...)` | `->getAnalyticsReport(...)` |
| `->/availability.get(...)` | `->listAvailabilities(...)` |
| `->/availability.post(payload)` | `->createAvailability(payload)` |
| `->/availability/[availabilityId].get()` | `->getAvailability(availabilityId)` |
| `->/availability/[availabilityId].delete()` | `->deleteAvailability(availabilityId)` |
| `->/availability/[availabilityId].patch(payload)` | `->updateAvailability(availabilityId, payload)` |
| `->/events.get(...)` | `->listScheduledEvents(...)` |
| `->/events/[eventId].get(...)` | `->getScheduledEvent(eventId, ...)` |
| `->/events/[eventId].delete(...)` | `->deleteScheduledEvent(eventId, ...)` |
| `->/events/[eventId].patch(payload, ...)` | `->updateScheduledEvent(eventId, payload, ...)` |
| `->/schedules.get(...)` | `->listSchedules(...)` |
| `->/schedules.post(payload, ...)` | `->createSchedule(payload, ...)` |
| `->/schedules/[scheduleId].get(...)` | `->getSchedule(scheduleId, ...)` |
| `->/schedules/[scheduleId].delete(...)` | `->deleteSchedule(scheduleId, ...)` |
| `->/schedules/[scheduleId].patch(payload, ...)` | `->updateSchedule(scheduleId, payload, ...)` |
| `->/schedules/single_use_link.post(payload)` | `->createSingleUseLink(payload, ...)` |
| `->/users/[userId].get()` | `->getUser(userId)` |

Before:

```ballerina
zoom:InlineResponse2005 schedules = check zoomClient->/schedules.get(userId = userId, pageSize = 10);
```

After:

```ballerina
zoom:ScheduleList schedules = check zoomClient->listSchedules(userId = userId, pageSize = 10);
```

### Added

- `createBooking` — book a time slot on an existing schedule (`POST /attendee`).
- `getScheduledEventAttendee` — get an attendee of a scheduled event.
- `getRoutingFormResponse` and `listRoutingResponses` — read routing-form responses.
- `listAvailableTimes` — list the open time slots of a schedule.
- `createShare` — create a customised scheduling link for a specific attendee.
- `listTeams` — list the Scheduler teams of a user.
- `createSingleUseLink` accepts an optional `teamId` query parameter.

## [1.0.2]

- Last 1.x release: 17 Zoom Scheduler operations exposed as resource methods.
