# Examples

The `ballerinax/zoom.scheduler` connector provides practical examples illustrating usage in various scenarios.

1. **[Schedule slot booking](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/schedule_slot_booking)** - Create a booking page, find the first open slot in a time window, book it for an invitee and issue a single-use scheduling link.

2. **[Availability hours review](https://github.com/ballerina-platform/module-ballerinax-zoom.scheduler/tree/main/examples/availability_hours_review)** - Review a user's availabilities across all pages, create missing working hours and compare booking analytics with the previous period.

## Prerequisites

1. Generate Zoom credentials to authenticate the connector as described in the [Setup guide](https://central.ballerina.io/ballerinax/zoom.scheduler/latest#setup-guide).

2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your Config.toml file should look:

```toml
clientId = "<client-id>"
clientSecret = "<client-secret>"
refreshToken = "<refresh-token>"
refreshUrl = "https://zoom.us/oauth/token"
userId = "<zoom-user-id>"
```

Each example lists the additional values it needs in its own README.

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
