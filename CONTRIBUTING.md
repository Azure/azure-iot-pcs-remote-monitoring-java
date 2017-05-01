Contribution license Agreement
==============================

If you want/plan to contribute, we ask you to sign a [CLA](https://cla.microsoft.com/) 
(Contribution license Agreement). A friendly bot will remind you about it when you submit 
a pull-request.

Development
===========

... notes about code style ...
... how to run tests locally ...
... requirements, e.g. Azure sub, IoT Hub setup etc. ...
... useful scripts included in the project ...

Development setup
=================

## Java setup

1. Install the latest Java SDK.
2. Optionally install Gradle, or feel free to use the included Gradle 
   wrapper (`gradlew`).
3. Use your preferred IDE, IntelliJ IDEA and Eclipse are the most popular, 
   however anything will work.

We provide also a [.NET version here](https://github.com/Azure/device-simulation-dotnet).

## IoT Hub setup

At some point you will probably want to setup your Azure IoT Hub, for 
development and integration tests.

The project includes some Bash scripts to help you with this setup:

* Create new IoT Hub: `./scripts/iothub/create-hub.sh`
* List existing hubs: `./scripts/iothub/list-hubs.sh`
* Show IoT Hub details (e.g. keys): `./scripts/iothub/show-hub.sh`

and in case you had multiple Azure subscriptions:

* Show subscriptions list: `./scripts/iothub/list-subscriptions.sh`
* Change current subscription: `./scripts/iothub/select-subscription.sh`

## Git setup

The project includes a Git hook, to automate some checks before accepting a 
code change. You can run the tests manually, or let the CI platform to run 
the tests. We use the following Git hook to automatically run all the tests
before sending code changes to GitHub and speed up the development workflow.

To setup the included hooks, open a Windows/Linux/MacOS console and execute:

```
cd PROJECT-FOLDER
cd scripts/git
setup
```

If at any point you want to remove the hook, simply delete the file installed 
under `.git/hooks`. You can also bypass the pre-commit hook using the 
`--no-verify` option.