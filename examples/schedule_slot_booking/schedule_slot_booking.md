# Schedule slot booking

This example creates a 30-minute Zoom Scheduler booking page, finds the first open slot in a time window, optionally books that slot for an invitee, and creates a single-use scheduling link for the page.

## Prerequisites

### 1. Set up a Zoom OAuth app

Follow the [Setup guide](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/blob/main/ballerina/README.md#setup-guide) to obtain a client ID, client secret and refresh token. The app needs the `scheduler:read` and `scheduler:write` scopes.

### 2. Configuration

Create a `Config.toml` file in this example's directory with the following content:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://zoom.us/oauth/token"
userId = "<zoom-user-id>"
timeZone = "<iana-time-zone, e.g. America/New_York>"
windowStart = "<window-start, e.g. 2026-10-05T00:00:00Z>"
windowEnd = "<window-end, e.g. 2026-10-09T23:59:59Z>"
inviteeFirstName = "<invitee-first-name>"
inviteeLastName = "<invitee-last-name>"
inviteeEmail = "<invitee-email>"
confirmBooking = false
```

Booking a slot sends a calendar invitation to the invitee, so the example only books when `confirmBooking` is `true`. Otherwise it prints the slot it would book.

## Run the example

Execute the following command to run the example:

```bash
bal run
```
