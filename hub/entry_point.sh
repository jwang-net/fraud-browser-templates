#!/bin/bash

java -jar /home/selenium/selenium-server-standalone.jar -role hub -hubConfig /home/selenium/config.json &
export NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait "${NODE_PID}"
