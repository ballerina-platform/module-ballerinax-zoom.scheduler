# Zoom Scheduler Meeting Scheduler

This example demonstrates how to create and manage meeting schedules using the Zoom Scheduler connector in Ballerina. The example shows how to create new schedules, fetch schedule details, and list existing schedules.

## Prerequisites

### 1. Setup Zoom developer account

Create a Zoom OAuth with the following scopes:
- `scheduler:read`
- `scheduler:write` 
- `user:read`

### 2. Configuration

Create a `Config.toml` file in the example's root directory and provide your Zoom account related configurations as follows:

```bash
clientId = "<Client ID>"
clientSecret = "<Client Secret>"
refreshToken = "<Refresh Token>"
userId = "<User ID>"
```

## Run the example

Execute the following command to run the example:

```bash
bal run
