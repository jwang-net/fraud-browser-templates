FROM python:2.7

WORKDIR /home
ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename
ENV BROWSER_VERSION=$version
ENV DISPLAY=:99

RUN apt-get -y update \
  && apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
    libasound2 libnspr4 libnss3 libxss-dev lsb-release wget unzip vim xdg-utils libfontconfig1 libfontconfig1-dbg

RUN CHROME_DRIVER_VERSION=$(echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)) \
  && wget --no-verbose https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -O /tmp/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip -d /home/selenium \
  && rm -rf /tmp/chromedriver_linux64.zip \
  && mv /home/selenium/chromedriver /home/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod u+x /home/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /home/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

RUN dpkg -i $filename
RUN echo Chrome version: $(/usr/bin/google-chrome -version | awk '{ print $3 }')
RUN pip install selenium==3.8.0
