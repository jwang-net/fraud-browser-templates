FROM ubuntu:xenial

WORKDIR /home
ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename
ENV BROWSER_VERSION=$version

RUN apt-get -y update && apt-get -qq install -y python python-pip libgconf2-4 libnss3-1d libxss1 \
  fonts-liberation libappindicator1 xdg-utils software-properties-common curl unzip wget xvfb vim

RUN GECKODRIVER_VERSION=$(curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+') && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver

RUN echo "Installing Firefox version $version"
RUN echo "Filename: $filename"
RUN apt-get -qqy update \
  && tar -C /opt -xjf /home/$filename

RUN pip install selenium==3.8.0
RUN pip install pyvirtualdisplay
