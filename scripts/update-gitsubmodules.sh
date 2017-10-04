#!/usr/bin/env bash

set -e

APP_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )/"

cd $APP_HOME

git checkout master
git pull

COL="\e[93m\e[1m"
NOCOL="\e[0m"

echo -e "${COL}### CLI${NOCOL}"
cd $APP_HOME && git submodule update --init cli               && cd cli               && git checkout master && git pull
echo -e "${COL}### Config${NOCOL}"
cd $APP_HOME && git submodule update --init config            && cd config            && git checkout master && git pull
echo -e "${COL}### Device Simulation${NOCOL}"
cd $APP_HOME && git submodule update --init device-simulation && cd device-simulation && git checkout master && git pull
echo -e "${COL}### IoT Hub Manager${NOCOL}"
cd $APP_HOME && git submodule update --init iothub-manager    && cd iothub-manager    && git checkout master && git pull
echo -e "${COL}### Storage Adapter${NOCOL}"
cd $APP_HOME && git submodule update --init storage-adapter   && cd storage-adapter   && git checkout master && git pull
echo -e "${COL}### Telemetry${NOCOL}"
cd $APP_HOME && git submodule update --init telemetry         && cd telemetry         && git checkout master && git pull
echo -e "${COL}### Telemetry Agent${NOCOL}"
cd $APP_HOME && git submodule update --init telemetry-agent   && cd telemetry-agent   && git checkout master && git pull
echo -e "${COL}### Web UI${NOCOL}"
cd $APP_HOME && git submodule update --init webui             && cd webui             && git checkout master && git pull

cd $APP_HOME
