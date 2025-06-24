# Ballerina Zoom Scheduler connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-zoom.scheduler.svg)](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/zoom.scheduler.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%zoom.scheduler)


## Overview

[Zoom](https://www.zoom.com/) is a video communications platform that enables users to schedule, host, and join virtual meetings, webinars, and conferences.

The `ballerinax/zoom.scheduler` package offers APIs to connect ant interract with [Zoom Scheduler](https://developers.zoom.us/docs/api/scheduler) endpoints. specifically based on Zoom API v2.


## Setup guide

To use the Zoom scheduler connector, you must have access to the Zoom API through [Zoom Marketplace](https://marketplace.zoom.us/) and a project under it. If you do not have a Zoom account, you can sign up for one [here](https://zoom.us/signup#/signup).

### Step 1: Create a new app

1. Open the [Zoom Marketplace](https://marketplace.zoom.us/).

2. Click "Develop" → "Build App"

    <img src="docs/setup/resources/zoom-marketplace.png" alt="Zoom marketplace" style="width: 70%;">

3. Choose **"General App"** app type (for user authorization with refresh tokens)

   <img src="docs/setup/resources/app-type.png" alt="App Type" style="width: 70%;">

4. Fill in basic information

### Step 2: Configure OAuth Settings

3. **Note down your credentials**:
   * Client ID
   * Client Secret

   <img src="docs/setup/resources/app-credentials.png" alt="App Credentials" style="width: 70%;">

2. **Set Redirect URI**: Add your application's redirect URI (e.g., `http://localhost:8080/callback`)
      <img src="docs/setup/resources/redirect-URI.png" alt="Scope" style="width: 70%;">

3. **Add Scopes**: Make sure your Zoom app has the necessary scopes for the Scheduler API:
   * Add `scheduler:read`, `scheduler:write` and `user:read` in the scope

   <img src="docs/setup/resources/zoom-scopes.png" alt="Scope" style="width: 70%;">


### Step 3: Activate the App

1. Complete all required information
2. Activate the app

   <img src="docs/setup/resources/activate-app.png" alt="Activate App" style="width: 70%;">

### Step 4: Get User Authorization

1. **Direct users to authorization URL** (replace `YOUR_CLIENT_ID` and `YOUR_REDIRECT_URI`):
```
https://zoom.us/oauth/authorize?response_type=code&client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&scope=scheduler:read scheduler:write user:read
```

2. **User authorizes the app** and gets redirected to your callback URL with an authorization code

3. **Exchange authorization code for tokens**:
```curl
curl -X POST https://zoom.us/oauth/token \
  -H "Authorization: Basic $(echo -n 'CLIENT_ID:CLIENT_SECRET' | base64)" \
  -d "grant_type=authorization_code&code=AUTHORIZATION_CODE&redirect_uri=YOUR_REDIRECT_URI"
```

This returns both `access_token` and `refresh_token`.

* Replace:
   * `CLIENT_ID` with your app's Client ID
   * `CLIENT_SECRET` with your app's Client Secret
   * `AUTHORIZATION_CODE` with the code received from the callback
   * `YOUR_REDIRECT_URI` with your configured redirect URI

### Step 5: Verify Your Setup
```curl
curl -X GET "https://api.zoom.us/v2/users/me" \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```
This will give you the user ID needed for API calls.

### Step 6: Configure the Connector

#### Option 1: Use Config.toml (Recommended)

```toml
isLiveServer = true
clientId = "your_client_id"
clientSecret = "your_client_secret"
refreshToken = "user_refresh_token_from_step4"
refreshUrl = "https://zoom.us/oauth/token"
userId = "user_id_from_step5"
```

#### Option 2: Use Environment Variables
```bash
export IS_LIVE_SERVER="true"
export ZOOM_CLIENT_ID="your_client_id"
export ZOOM_CLIENT_SECRET="your_client_secret"  
export ZOOM_REFRESH_TOKEN="user_refresh_token_from_step4"
export ZOOM_USER_ID="user_id_from_step5"
```

### Benefits of This Setup

**Long-lived tokens** - Refresh tokens don't expire like Server-to-Server tokens  
**Automatic refresh** - Connector handles token refresh automatically  
**User consent** - Users explicitly authorize your app  
**Secure** - Follows OAuth2 best practices

### Alternative: Server-to-Server OAuth

If you prefer automated access without user interaction (tokens expire hourly):

1. Choose **"Server-to-Server OAuth"** in Step 1
2. Use account credentials grant:
```curl
curl -X POST https://zoom.us/oauth/token \
  -H "Authorization: Basic $(echo -n 'CLIENT_ID:CLIENT_SECRET' | base64)" \
  -d "grant_type=account_credentials&account_id=ACCOUNT_ID"
```
3. Configure with bearer token:
```toml
isLiveServer = true
token = "your_access_token"
userId = "your_user_id"
```
## Quickstart

To use the `Zoom` connector in your Ballerina application, update the `.bal` file as follows:

### Step 1: Import the module

Import the `zoom.scheduler` module.

```ballerina
import ballerinax/zoom.scheduler;
```

### Step 2: Instantiate a new connector

1. Create a `Config.toml` file and, configure the obtained credentials in the above steps as follows:

```bash
token = "<Access Token>"
```

2. Create a `zoom.scheduler:ConnectionConfig` with the obtained access token and initialize the connector with it.

```ballerina
configurable string token = ?;

final zoom.scheduler:Client zoom.scheduler = check new({
    auth: {
        token
    }
});
```
### Step 3: Invoke the connector operation

Now, utilize the available connector operations.

#### Schedule a meeting

```ballerina
<!-- to do -->
```

### Step 4: Run the Ballerina application

```bash
bal run
```

## Examples

The `Zoom Scheduler` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/module-ballerinax-zoom.scheduler/tree/main/examples/), covering the following use cases:

* **[Meeting Scheduler](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/meeting-scheduler)** - Create scheduled meetings, generate single-use scheduling links, and manage team meeting schedules with automated booking capabilities.

* **[Availability Manager](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/availability-manager)** - Configure availability schedules, analyze scheduler analytics, and manage working hours for different time zones and business requirements.

## Issues and projects

The **Issues** and **Projects** tabs are disabled for this repository as this is part of the Ballerina library. To report bugs, request new features, start new discussions, view project boards, etc., visit the Ballerina library [parent repository](https://github.com/ballerina-platform/ballerina-library).

This repository only contains the source code for the package.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`zoom.scheduler` package](https://central.ballerina.io/ballerinax/zoom.scheduler/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
   