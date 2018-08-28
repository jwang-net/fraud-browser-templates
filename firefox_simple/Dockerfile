FROM ubuntu:xenial

RUN apt-get -y update && apt-get -qq install -y python python-pip python3 python3-pip libgconf2-4 libnss3-1d libxss1 \
  fonts-liberation libappindicator1 xdg-utils software-properties-common curl unzip wget xvfb vim

RUN GECKODRIVER_VERSION=$(curl https://github.com/mozilla/geckodriver/releases/latest | grep -Po 'v[0-9]+.[0-9]+.[0-9]+') && \
    wget https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_VERSION/geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz && \
    tar -zxf geckodriver-$GECKODRIVER_VERSION-linux64.tar.gz -C /usr/local/bin && \
    chmod +x /usr/local/bin/geckodriver

RUN add-apt-repository -y ppa:ubuntu-mozilla-daily/ppa
RUN apt-get update && apt-get install -y firefox

RUN pip3 install selenium
RUN pip3 install pyvirtualdisplay

ENV APP_HOME /usr/src/app
WORKDIR /$APP_HOME

COPY . $APP_HOME/

CMD tail -f /dev/null
