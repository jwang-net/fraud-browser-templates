FROM ubuntu:16.04

WORKDIR /home

RUN apt-get update
RUN dpkg --configure -a
RUN apt-get upgrade -y
RUN apt-get -qq install -y python python-dev python-pip python-virtualenv
  && rm -rf /var/lib/apt/lists/*
