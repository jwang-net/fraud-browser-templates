FROM ubuntu:16.04

WORKDIR /home

# Default packages
RUN apt-get update \
  && apt-get upgrade -y \
  && dpkg --configure -a \
  && apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
    libasound2 libnspr4 libnss3 libxss-dev lsb-release wget unzip vim xdg-utils libfontconfig1 libfontconfig1-dbg \
  && DEBIAN_FRONTEND=noninteractive \
  apt-get -y install default-jre-headless \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Selenium
RUN mkdir selenium \
  && wget --no-verbose https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar \
    -O /home/selenium/selenium-server-standalone.jar
RUN pip install selenium==3.8.0

# Selenium node locale settings
ENV LANGUAGE en_US.UTF-8
ENV LANG ${LANGUAGE}

# Selenium node screen dimensions
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0

# Used by nodes
ENV HUB_HOST fraud-selenium-hub
EXPOSE 4444
