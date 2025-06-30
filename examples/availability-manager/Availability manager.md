# Zoom Scheduler Availability Manager

This example demonstrates how to manage availability schedules and retrieve analytics using the Zoom Scheduler connector in Ballerina. The example shows how to fetch user information, create availability schedules, and monitor scheduler analytics.

## Prerequisites

### 1. Setup Zoom developer account

Create a Zoom app with the following scopes:
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
```
