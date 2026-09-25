# Availability hours review

This example reviews a user's Zoom Scheduler set-up. It reads the user's Scheduler profile, lists every availability across all result pages, creates a named set of working hours if it does not exist yet, and compares booking analytics for a period with the period before it.

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
availabilityName = "<availability-name, e.g. Extended office hours>"
timeZone = "<iana-time-zone, e.g. America/New_York>"
reportFrom = "<report-start-date, e.g. 2026-09-01>"
reportTo = "<report-end-date, e.g. 2026-09-30>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
```
