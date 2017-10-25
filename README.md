[![Build][build-badge]][build-url]
[![Issues][issues-badge]][issues-url]
[![Gitter][gitter-badge]][gitter-url]

Remote Monitoring preconfigured solution with Azure IoT
========
<div align="center">
<img src="https://user-images.githubusercontent.com/3317135/31798657-c75aaaec-b4e9-11e7-9835-dea95cb5316d.png" width="600" height="auto"/>
</div>

Overview
========
>  This solution is currently in preview. The preview offers many features
but there are known bugs. You can refer to our [Issues List](issues) in
this repo (and in any submodules) to see known requests and issues. Feel
free to submit new issues (and submit PRs for fixes if you'd like).

Remote monitoring helps you get better visibility into your devices, assets, and
sensors wherever they happen to be located. You can collect and analyze real-time
device data using a remote monitoring solution that triggers automatic alerts and
actions — from remote diagnostics to maintenance requests. You can also command and
control your devices.

[Azure IoT Hub][iot-hub]
is a key building block of the remote monitoring solution. IoT Hub is a fully
managed service that enables reliable and secure bidirectional communications between
millions of IoT devices and a solution back end.

Check out the [Interactive Demo](http://dev-azureiotclicks01.azurewebsites.net/demos/remotemonitoring)
for a detailed overview of features and use cases.

To get started you can follow along with the [Getting Started](#getting-started)
for a command line deployment. You can also deploy using the web interface
at https://azureiotsuite.com.

Getting Started
===============

## Prerequisites
* [Azure Subscription](https://azure.microsoft.com/free/) (also see [permissions guidelines](https://docs.microsoft.com/azure/iot-suite/iot-suite-permissions))

## Setup
1. Open a terminal window or command shell
1. Check out the repository and submodules
    ```
    git clone --recursive https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet.git
    ```
1. Set up command line interface for deployments
    ```
    cd pcs-cli
    npm install
    npm start
    npm link
    ```
1. Sign into your Azure account with
    ```
    pcs login
    ```

## Deploy a remote monitoring solution
### Standard Deployment
A standard deployment is a production-ready solution for reliability and scale. *See [Basic vs. Standard Deployments](#basic-vs-standard-deployments) for more details.*
```
pcs -s standard --runtime java
```

### Basic Deployment
A lower-cost showcase solution best for discovering and learning about what a Remote Monitoring preconfigured solution has to offer.  *See [Basic vs. Standard Deployments](#basic-vs-standard-deployments) for more details.*
```
pcs --runtime java
```

### Local Deployment
To set up a Remote Monitoring Solution locally see
[Local Development](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/wiki/Developer-Reference-Guide#local-development)

Common Scenarios
================

## All done? Connect a device!
By default, the solution uses simulated devices. You can start adding your
own devices with the instructions here: [Connect a physical device](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/wiki/Developer-Reference-Guide#connect-a-physical-device)

## Stopping Simulated Devices
Once you are ready, you can stop the default simulated devices by calling the simulation endpoint with the instructions [here](https://github.com/Azure/device-simulation-dotnet/wiki/%5BAPI-Specifications%5D-Simulations#stop-simulation).

Basic vs. Standard Deployments
==============================
## Basic
Basic deployment is geared toward showcasing the solution. To reduce the cost
of this demonstration, all the microservices are deployed in a single
virtual machine; this is not considered a production-ready architecture.

Our Standard deployment option should be used when you are ready to customize
a production-ready architecture, built for scale and extensibility.

Creating a Basic solution will result in the following Azure services being
provisioned into your Azure subscription at cost: 

| Count | Resource                       | Type         | Used For |
|-------|--------------------------------|--------------|----------|
| 1 | [Azure Active Directory Application][azure-active-directory] | | User Authentication |
| 1 | [Linux Virtual Machine][virtual-machines] | Standard D1 V2 (1 core, 3.5GB memory) | Hosting microservices |
| 1 | [Azure IoT Hub][iot-hub] | S1 – Basic tier | Device management and communication |
| 1 | [Azure Cosmos DB][cosmos-db] | Standard | Storing configuration data, and device telemetry like rules, alarms, and messages |
| 1 | [Azure Storage Account][storage-account] | Standard GRS | Storage for VM and Stream Analytics checkpoints |
| 1 | [Web Application][web-application] | | Hosting front-end web application |

## Standard
The standard deployment is a production-ready deployment a developer can
customize and extend to meet their needs. For reliability and scale, application
microservices are built as Docker containers and deployed using an orchestrator
([Kubernetes](https://kubernetes.io/) by default). The orchestrator is
responsible for deployment, scaling, and management of the application.

Creating a Standard solution will result in the following Azure services being
provisioned into your Azure subscription at cost:

| Count | Resource                       | Type         | Used For |
|-------|--------------------------------|--------------|----------|
| 1 | [Azure Active Directory Application][azure-active-directory] | | User Authentication |
| 1 | [Azure Container Service][container-service] | | [Kubernetes](https://kubernetes.io/) orchestrator |
| 4 | [Linux Virtual Machines][virtual-machines] | Standard D1 V2 (1 core, 3.5GB memory) | 1 master VM & 3 agents for hosting microservices with redundancy |
| 1 | [Azure IoT Hub][iot-hub] | S1 – Basic tier | Device management and communication |
| 1 | [Azure Cosmos DB][cosmos-db] | Standard | Storing configuration data, and device telemetry like rules, alarms, and messages |
| 5 | [Azure Storage Accounts][storage-account] | Standard GRS | 4 for VM storage, and 1 for the Stream Analytics checkpoints |
| 1 | [Web Application][web-application] | | Hosting front-end web application |

> Pricing information for these services can be found
[here](https://azure.microsoft.com/pricing). Usage amounts and billing details
for your subscription can be found in the
[Azure Portal](https://portal.azure.com/).

Architecture Overview
=====================
<div align="center">
<img src="https://user-images.githubusercontent.com/3317135/31914374-44a4be80-b7ff-11e7-86b2-19845ab65d7a.png" width="700" height="auto"/>
</div>

[Open in draw.io][draw-io-map]

## Microservices & Docker Containers
Remote Monitoring is the first of our preconfigured solutions to leverage a
microservices architecture. The solution is available in both .NET and Java.
Microservices have emerged as a prevalent pattern to achieve scale and flexibility
(by allowing containers to be scaled individually), without compromising development speed.
Microservices compartmentalize the code and provide well defined interfaces
making the solution easier to understand and less monolithic. It also further
expands options for partners that want to extend our current preconfigured
solutions to build finished solutions that can be monetized.

**Learn more about Docker Containers**
* [Install Docker](https://docs.docker.com/engine/installation/)
* [Common Docker Commands for Remote Monitoring](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/wiki/Developer-Reference-Guide#common-docker-commands)
* [Docker Getting Started](https://docs.docker.com/get-started/)

## Components
* [Remote Monitoring Web UI](https://github.com/Azure/pcs-remote-monitoring-webui)
* [Command Line Interface (CLI)](https://github.com/Azure/pcs-cli)
* [IoT Hub manager](https://github.com/Azure/iothub-manager-java)
* [User Management](https://github.com/Azure/pcs-auth-dotnet)
* [Device Simulation](https://github.com/Azure/device-simulation-java)
* [Telemetry](https://github.com/Azure/device-telemetry-java)
* [Telemetry Agent](https://github.com/Azure/telemetry-agent-java)
* [Configuration](https://github.com/azure/pcs-config-java)
* [Storage Adapter](https://github.com/azure/pcs-storage-adapter-java)
* [Application Gateway (SSL Proxy WebApp)](https://github.com/Azure/reverse-proxy-dotnet)
* [API Gateway](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/tree/master/reverse-proxy)

How-to and Troubleshooting Resources
====================================
* [Developer Troubleshooting Guide](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/wiki/Developer-Troubleshooting-Guide)
* [Developer Reference Guide](https://github.com/Azure/azure-iot-pcs-remote-monitoring-dotnet/wiki/Developer-Reference-Guide#running-all-pcs-microservices-locally)

Feedback
========
If you have feedback, feature requests, or find a problem, you can create
a new issue in the [GitHub Issues](issues)

Contributing
============
Refer to our [contribution guidelines](CONTRIBUTING.md)

License
=======
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the [MIT](LICENSE.txt) License.

[build-badge]: https://img.shields.io/travis/Azure/azure-iot-pcs-remote-monitoring-dotnet.svg
[build-url]: https://travis-ci.org/Azure/azure-iot-pcs-remote-monitoring-dotnet
[issues-badge]: https://img.shields.io/github/issues/azure/azure-iot-pcs-remote-monitoring-dotnet.svg
[issues-url]: https://github.com/azure/azure-iot-pcs-remote-monitoring-dotnet/issues
[gitter-badge]: https://img.shields.io/gitter/room/azure/iot-solutions.js.svg
[gitter-url]: https://gitter.im/Azure/iot-solutions
[azure-active-directory]: https://azure.microsoft.com/services/active-directory/
[iot-hub]: https://azure.microsoft.com/services/iot-hub/
[cosmos-db]: https://azure.microsoft.com/services/cosmos-db/
[container-service]: https://azure.microsoft.com/services/container-service/
[storage-account]: https://docs.microsoft.com/azure/storage/common/storage-introduction#types-of-storage-accounts
[virtual-machines]: https://azure.microsoft.com/services/virtual-machines/
[web-application]: https://azure.microsoft.com/services/app-service/web/
[draw-io-map]: https://www.draw.io/?lightbox=1&edit=_blank&layers=1&nav=1#R7V1bc6O4Ev41qdrzgIs7%2BDHjTGZnay6pSU7t7lNKBtnWBCMfkJ1kf%2F1KgDAgmWAbDMxJpqYShACh%2FtT9qbslrozZ%2BuVTBDarr9iHwZWu%2Bi9Xxs2Vruu2odJfrOQ1K1Gn07RkGSE%2FLVP3BffoH5gWarx0i3wYZ2VpEcE4IGhTLvRwGEKPlMpAFOHncrUFDvxSwQYsYakZrODeAwEUqv2JfLJKS12rUPt3iJYr%2FmRNzc7Mgfe0jPA2zJ4X4hCmZ9aA3yarGq%2BAj58LRcbHK2MWYUzSv9YvMxiwfi332O2Bs3mTIxgSyQX%2FjWH0ff6T9ZauBmBORZZUSi8LUPiUHq8IYZ18zS7Ub5eIrLbziYfX9OD6n21E3%2BaWwACuIYleFdoPIVF%2Bgh1Ib8Mbo5t2%2FkZ5S2PyyvuXvvuG%2FYnWiSA%2BJL%2Bv400qS5WWAH6wQC%2BQ3vXDDkYEUQl9YU2%2FwzEiCIf0%2FBwTQlu3r3AdoCU7QfCG35kelV8LkckWR3CJwwn0t7Qgfo0JZO%2B4QAEFHq3BrvOAt2IvHDNkPBL8aNrq48ujwaR9y95aCfASK7T0hZZNNuGSPnGBQ3IL1ihg4H8AK7wGtFSUTiYw1mz4UijKOu0TxEkf0yrZWcW20kuyUaWYhpkWPO8xyuusCvA0MyGDbFQs81vv4UH%2FyATFDwuAaRtAgP1WECbKxouVCK4xgcoah4jgCIVLGaBs8x1Q7QOKq2WOKMO0fk1E%2BZiEkDDdFUFWfw2oeCL6RwRpf8VQ2UT45bWCOcsYNOa8LQ6X%2F9tSSGWd8bxRqEEkDBD67XYTYOAz5Omq5tBfKhNNuEThSwKyzsFl6RVwWYYmgssQwWWZbYBLMJBO9qgdCLawCLSCSJ9XiMD7DfDY8TMlN7QvVmTNcKkd7CxWmlEYzWXHKAhmOMBRck%2Fj2rm5uZ3R8phE%2BAkWztjJDz3jg3jF8JE8pIW%2B12y33PWuKXY9fb5sYB%2Ff%2BUJPc8HX9TT0KeHKDnFEVhSRIQg%2B7ks%2FeNtol3dKQqmSI7UsEviCyF%2BFv%2F9mVSYWOwpps%2F%2FKrkgO9ud%2BQkJeM5mBLcG0aN%2BIL5gNulzgXLTW8aMlxtvIy1446wICoiXMamWAZF1RK9UIBoCgXZmbniMgLvl3AdULyOxNQM67gJoIyO5NQO67gJoISOtNx1na0CUU044i18xbQYsSR0FWdovYW2WX%2BLyGF4A4Rl5amFXRBiNoc3ohQR%2BaNFzffaYFnwCBz4Bebwe0YR%2FmlOLbS%2FbXbwnz%2Fc%2FVQKYWhb4RJxZ7nDG5NeCkZ4j1GELPiXlO6F1XYJUad28VWaWtHi3mJoxeU50LD2lnYGNamFLMkp9GUxWrOvGozFsWi4XueU1VgiHR%2FarVs05g5aIq%2BApCOp1eJ9Pk6rkT9APTClRGq1wRFAd6vQdhoANdn1YGujZVxYFuyAa61clA5486z5afYL6bjsM6ldBMbiWt1GjEmZIR57Q94LJL7zBio4UjhLKriiWYVjR82qrssors83Y04nGaegFZ60PX62ry01ivt4MmVeuLvGumeoLQ3y17cluL40SGn%2FYsvhQxl7L4AmJMwUJ8xg%2B04Pft%2FBADiASIDdYe62V166hGQ3t8PPEWja%2FehvFtODYPDEC9fY%2FGYaPfCP22iH73MsZXMQTr61TEnDa0HevrDk0RlzTYeLRyCsVzFK4Ecv1PsW7gDtEGCir2Hq237Ik4vDp%2BSuUnN1Xi%2FB7SuVV9islgdXkTJ0pLuvyImPsDz%2BmpF5ePvXiyRl6EY7wgmdhgqGxj7iljqQ6YKCtmd%2FlfChVoktKlrGEcU9Mbs0A1HUxbryJTd4QyzS%2FZ6%2BPuzPMRIv1%2BvSUrXRyamwjvqCyi%2BFj3RyPhA4%2BpGcVHEW0QZu%2FChjMMqA4VTyo7nblHCfZwECsY%2BV4ZDtNLwwFkeRcehQMliC3ho0LfNM7n3sJH1a635E6RkOULG%2Fk6G%2B%2F0FL1qP1R1gL%2FZ04ld%2BLEq6NBdp3y%2B%2FIADnhXKcFjYI6%2B2YRXimlZoWkVrcaJ%2F2%2FyKzHTtkZi24mSyqfUy6%2F8VCWUdgT5qNHTMNg9AbVqZ4dhTu9EoOAV0YlrYDIcLtNxGBfo6eBIiEkvdbmhlTmAhhzM3U0YRb0DIOQWfIai51yWtw9JgC9W64p1sIrHOIz4Kpl26Q%2FC5zDNSx%2FnYeadtNQ3TdMMrDNlQiteYyki9YW44sGZ9Fc7jTdIDKQ58tOMYmFFlCkI%2FAvSCj1SzEuTdQxB5K3qczA0fwJzKRJ%2BJzPUBrRnGaBMRjAsQK9xd8kBIvMmhyqMY9gIGDK4G3sJAXniW17V3Jvlm5Ka5JS4Y%2Fr1ZL9p%2BrWz7M3awN%2Fzq%2BZIvhdQlHvbWfYyNJW31Lelax6A%2B7oQqmaiN3lLnNM6JOpQtH7mZeN8Kov%2BKHP1kZHTFw4%2BeQ7qVFR5mllh%2BcApZvcCyKrg8cwLpdJ8QptY4Mgo66u%2Bsat9YzQO%2F6Rm%2BmvWI1SzlQLJ5w%2F6dg972M0VPdIDwOWWOXttuFY2GjBwJFLTgeK9y2utlIUdtlPSUTtwrfcw7vYOUUYkd65Cj%2FJ8YK4v9q7fbB3HSj%2B%2FIqLhXtYovSXf0Ov%2Fqgdj52baRrz%2FsyzYaIoG%2FJzhiC0tFxeODDRlPfkxVyRj6BZWM1UpualfBlJHPizhXKM2LBkJ%2B82jFfvH8G%2BxXvCKLqLQXQDHfDV5bEZTDToiToXtBI2hUVoDnOrGDHDHHvjjq%2BtBrl5tb1bg6T1eblwpvG3pVy7laV9DjL1owvoX5lCRMcB2AaB0np9Qf22RnlnFwHCG8ZzgSktNVDrAlbhiQ5epRuKTiFHuSvhopdxeti%2F5JQjjp4MxsLK1tfbiyGPLZ%2BIuzDr2SpOPI90eJqYBQuHxIhqpilgVjSNLhdcu1bqZdCkyzK94FdyomhemmRF5mG%2FJqsH9AgDKFWdRdyW4kSXZWujENlS0rLwpxAyNEG8TEccO2O5tTxXu3L5MIld6DPWyWb9ZWCZQYkrUIPoDuwpNpXdtz4XzBbsukTlj%2FOodXxrQhSqOi0FzTEYeeRJJuG6LMJy6DmE8Myuw2I3iNLGbOzEp0TbvUonZJ3r04Xb9BYBliFhRnAXXaIUGSRDkWC1adpbviVmNtTdIPpaf8geeZ7f8KKdL87GCG12sQZkeCg%2FYHVV%2BweO7NrILPd%2FSmVJ9RfUit0jFX0uHBbGq6d1ed57evPBm1KOTRJso4MuxJkyT0bjJlNPUCE%2FX8YLSq%2B3DMraFSlyQx8qhMbytmvlMClWQWMi2%2B30eENWkHE5dTB1n54pDHeTOUYiPKo32M2xcIo92cSujaBdPichpRsOVf8DKW6P%2B47JF%2F0158%2F3qfmrDrzeZzGCevkhzfRazpK7jNTFyXiW5nULAzpKqpDee%2F%2Bd7MZ%2FExY9oDCx%2BPuq5dc14%2Fmai6zhqpdoli7yatQPRvmWZ9fHHquCfEF4XnaHwPwBzwOt8J4%2BSlIGc5eS%2B4n9qlVnrXLkE6iMOuEWapE6PwY7rVALZrtgEwXa8%2B56jHtLgCwxXzxgubNwzTq6ibB%2FHWirWreHtdyd7J0tky1xpt7Ki32QS0V9JFMDU76%2F0J5ykDOWV3vdImedJl3lq6GGhkLFRx1IoDuPfd8qaiE78HTjOwPUu1qcTxp1%2BISri2U1LBZcCYql062zCCK1twask0edPndEgz6jfuUz8z%2FbwAsv0lfvsBgUdO0TjyXTyf4XyLqopnjKvCKKj0oSme982SZYrHERVPro06Vz2OYdfpBMt0SzrBOFX1GG6NhnvjKS1SzKnogvmauMyYl3sMwetudIVRzSpwZcsHeeS6xDPtw5Br%2FJ0ItUHu5HuYuvH%2BzE5lELuWZB%2BaruLUesv7dO4X1Qhrao7R1qfucM73vhzE5yD0k8JFJ0WImvZteR%2FJljtaV1tPVmve1aKfi6WUUQ65FmQwUAYo7Bcp9R50lSuWC0%2Fag1UeD0O%2FMHHouHPb%2Fs6S4rjVDy1dtKf1Bvaz76%2BU1YYn828nJNeykjRISQs9HMFJvOv0G2XfwLeS%2BPLjgvTyslKO3vFeNon0GnjUhym9WIFjll5e2MqON0c7IJrtbqkb9ak2fSMjKZ2gOXs7evjzj293H6wcFI8MAI8X%2Bc6gXl3qYOlidg8P35amMNOjUSBxd7QIjNovSWR5we94eBsPQuBUHyce3o6NZAsg3kHxZvKp4OAas5Jo5L7OvoA2WGw8Pz9PkixcmL1h9u3a6zjekwr62zWhMYe6qVju3FPM6dRTpr6lKgtXdV3NcheaBvLqnTrWhX1%2BZRhyJBg6ni0egaG72T0tmH35fCKYvEAAzigDri7f7SHX%2B0Z3y8C7H%2BMSsdRvjt33eN7RKpAQOHlGTwhMQuxh%2FITgJJ0iUNJbnCj47D%2BbKzy8bmDsRWhD9oYgsXwoTvIObilFhjFt9K03p4%2FUVc3SVMqNDcPU7G5NhivwCNE3zrlnabi7XcLpR6L7adnXYurw5NvHhxOA1vTbhiUc2vVEdCzqwZSIswf1IJfnH2AHOpDnz%2Fy2e2mOcUWHKE3DGoQ0LzYG9UHbguHwfre6yZcmxsS64%2F2i089ukITVt%2FQYM%2Fex9wSjDKr0dqnVhguwDZg5X6Bk7fwtxSl%2B5Pd%2BDFgMp3OZatMKD3enotNdtrK6ml9wktfWbrC0um8BPm3nMKIDDcYThIu0awF2iE6zuhdR1Scnyyvg9Lz1tAK7Qb5R3yKKIXxKNGA6wnIJ3bBh5uFYYScVW3Nnzs1HTb1Wihd0Lr8q9ZVtXsAjXWdS3xYtKbWhbGVbuoo1kpEdvT6jr29QIDLZUtO4pCMU%2BluGkteYwHVB3ybXecBbsfeN6W3hI8GPpq0%2BvjwaLJ3mlr11Ch5a%2BkLLune4VpOIbFPUx9z%2FVoqi6QOjYhUASZnXG5907h1CQ2Feghve5iZ5bB7XLF5H%2BMZCMsViDBwVI1Us1Sm7JmYyj0KxCBCSR3zNYYNosKrF1MQV3oNWLaDo6E2%2BNiRVKvVfuOwdD7%2BGUjFUcWoyaKUiAY9cnQyc7A5WnRiSz2sPWp1wM7O3L4BtHX8gZeAdFo1gUd2s1zRGhoqinsg2FlFAurO3zNqY7xS2A%2F9zde2%2BPWJjUwWRXL28k9iT1ItuX1K90KIIY1Ko%2FikCm9VX7DOMfPwX
