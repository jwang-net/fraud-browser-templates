FROM ubuntu:16.04

WORKDIR /home

RUN apt-get update \
  && apt-get upgrade -y \
  && dpkg --configure -a \
  && apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
    libasound2 libnspr4 libnss3 libxss-dev lsb-release wget xdg-utils libfontconfig1 libfontconfig1-dbg \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get -y install default-jre-headless \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar \
    -O selenium-server-standalone.jar

# Hub environment variables
ENV GRID_MAX_SESSION 5
ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
ENV GRID_THROW_ON_CAPABILITY_NOT_PRESENT true
ENV GRID_JETTY_MAX_THREADS -1
ENV GRID_CLEAN_UP_CYCLE 5000
ENV GRID_BROWSER_TIMEOUT 0
ENV GRID_TIMEOUT 30
ENV GRID_DEBUG false
ENV GRID_HUB_PORT 4444
ENV GRID_HUB_HOST "0.0.0.0"

# Node environment variables
ENV NODE_MAX_INSTANCES 1
ENV NODE_MAX_SESSION 1
ENV NODE_HOST 0.0.0.0
ENV NODE_PORT 5555
ENV NODE_REGISTER_CYCLE 5000
ENV NODE_POLLING 5000
ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
ENV NODE_DOWN_POLLING_LIMIT 2
ENV NODE_APPLICATION_NAME ""
