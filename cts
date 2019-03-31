#! /bin/bash

# kill existing adb server
adb kill-server

# run docker
docker run -it --privileged -e USER_ID=$(id -u) -e GROUP_ID=$(id -g) -e USER_NAME=$(id -un) -e GROUP_NAME=$(id -gn) -e USER_HOME=$HOME -v $HOME:$HOME cts_env:v0.1
