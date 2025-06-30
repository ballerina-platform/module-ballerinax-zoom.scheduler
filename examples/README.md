# Examples

The `ballerinax/zoom.scheduler` connector provides practical examples illustrating usage in various scenarios.

1. **[Meeting Scheduler](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/meeting-scheduler)** - Create scheduled meetings, generate single-use scheduling links, and manage team meeting schedules with automated booking capabilities.

2. **[Availability Manager](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/availability-manager)** - Configure availability schedules, analyze scheduler analytics, and manage working hours for different time zones and business requirements. 

## Prerequisites

1. Generate Zoom credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/zoom.scheduler/latest#setup-guide).

2. For each example, create a Config.toml file the related configuration. Here's an example of how your Config.toml file should look:

```toml
   isLiveServer = true
   clientId = "your_client_id"
   clientSecret = "your_client_secret"
   refreshToken = "user_refresh_token_from_step"
   userId = "user_id_from_step5"
```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
