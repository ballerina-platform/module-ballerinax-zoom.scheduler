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

No configuration is needed. When `IS_LIVE_SERVER` is not set to `true`, the tests run against the mock server on port `9090` and the mock token endpoint on port `9444`.

```bash
./gradlew clean test
```

## Running tests against the live Zoom API

Set the following environment variables, then run the tests.

| Variable | Description |
|---|---|
| `IS_LIVE_SERVER` | Set to `true` to target `https://api.zoom.us/v2/scheduler` instead of the mock server |
| `ZOOM_CLIENT_ID` | OAuth app client ID |
| `ZOOM_CLIENT_SECRET` | OAuth app client secret |
| `ZOOM_REFRESH_TOKEN` | OAuth 2.0 refresh token |
| `ZOOM_USER_ID` | ID of your Zoom user |
| `ZOOM_SCHEDULE_ID` | ID of an existing schedule |
| `ZOOM_AVAILABILITY_ID` | ID of an existing availability |
| `ZOOM_EVENT_ID` | ID of an existing scheduled event |
| `ZOOM_ATTENDEE_ID` | ID of an attendee of that event |
| `ZOOM_ROUTING_FORM_ID` | ID of a routing form |
| `ZOOM_ROUTING_RESPONSE_ID` | ID of a response to that form |

```bash
export IS_LIVE_SERVER=true
export ZOOM_CLIENT_ID=<your-client-id>
# ... and the remaining variables above
./gradlew clean test
```

The create, update and delete tests change data in your Zoom account. Each delete test creates the availability, schedule or booking it deletes, so no existing data is removed.
