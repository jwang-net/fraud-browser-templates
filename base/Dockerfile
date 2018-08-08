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
