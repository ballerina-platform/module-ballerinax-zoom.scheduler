# Running Tests

## Prerequisites

To run the tests against the live Zoom API you need a Zoom OAuth app, its client ID and client secret, and a refresh token. Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/blob/main/ballerina/README.md#setup-guide) to obtain them.

Several tests also need the ID of your Zoom user. You can find it with:

```bash
curl -X GET "https://api.zoom.us/v2/users/me" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

## Test environments

There are two test environments. The default is a mock server for the Zoom Scheduler API, together with a mock OAuth token endpoint. The other is the live Zoom API.

 Test Groups | Environment
-------------|------------------------------------------------
 mock_tests  | Mock server for Zoom Scheduler API (default)
 live_tests  | Zoom Scheduler API

## Running tests against the mock server

No configuration is needed. With no `Config.toml`, or with `isLiveServer = false`, the tests run against the mock server on port `9090` and the mock token endpoint on port `9444`.

```bash
./gradlew clean test
```

## Running tests against the live Zoom API

Create a `Config.toml` file in the `ballerina/tests` directory with the following content:

```toml
isLiveServer = true
clientId = "<your-client-id>"
clientSecret = "<your-client-secret>"
refreshToken = "<your-refresh-token>"
refreshUrl = "https://zoom.us/oauth/token"
userId = "<your-user-id>"
scheduleId = "<an-existing-schedule-id>"
availabilityId = "<an-existing-availability-id>"
eventId = "<an-existing-scheduled-event-id>"
attendeeId = "<an-attendee-id-of-that-event>"
routingFormId = "<a-routing-form-id>"
routingResponseId = "<a-response-id-of-that-form>"
```

The create, update and delete tests change data in your Zoom account. Each delete test creates the availability, schedule or booking it deletes, so no existing data is removed.

Then run:

```bash
./gradlew clean test
```
