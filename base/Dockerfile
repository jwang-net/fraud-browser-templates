FROM ubuntu:16.04

WORKDIR /home

RUN apt-get update
RUN dpkg --configure -a
RUN apt-get upgrade -y
RUN apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
  libasound2 libnspr4 libnss3 libxss-dev lsb-release wget xdg-utils libfontconfig1 libfontconfig1-dbg \
  && rm -rf /var/lib/apt/lists/*
RUN wget --no-verbose https://selenium-release.storage.googleapis.com/3.13/selenium-server-standalone-3.13.0.jar \
  -O selenium-server-standalone.jar
