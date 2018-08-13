FROM ubuntu:16.04

WORKDIR /home

RUN apt-get update \
  && apt-get upgrade -y \
  && dpkg --configure -a \
  && apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
    libasound2 libnspr4 libnss3 libxss-dev lsb-release wget unzip xdg-utils libfontconfig1 libfontconfig1-dbg \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get -y install default-jre-headless \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar \
    -O /home/selenium/selenium-server-standalone.jar

# Node locale settings
ENV LANGUAGE en_US.UTF-8
ENV LANG ${LANGUAGE}

# Node screen dimensions
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

# Used by downstream images
ENV HUB_HOST fraud-selenium-hub

EXPOSE 4444
