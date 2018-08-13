#!/bin/bash

export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"
export HUB_PORT=4444
export SERVERNUM=99

xvfb-run -n "${SERVERNUM}" --server-args="-screen 0 "${GEOMETRY}" -ac +extension RANDR" \
  java -jar /home/selenium/selenium-server-standalone.jar -role node \
    -hub http://"${HUB_HOST}":4444/grid/register \
    -nodeConfig /home/config.json &
NODE_PID=$!

trap shutdown SIGTERM SIGINT
wait "${NODE_PID}"
