FROM python:2.7

WORKDIR /home
ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename
ENV DISPLAY=:99

RUN apt-get -y update \
  && apt-get -qq install -y python python-dev python-pip python-virtualenv fonts-liberation libappindicator3-1 \
    libasound2 libnspr4 libnss3 libxss-dev lsb-release wget unzip vim xdg-utils libfontconfig1 libfontconfig1-dbg

RUN echo "Installing Firefox version $version"
RUN echo "Filename: $filename"
RUN apt-get -qqy update \
  && tar -C /opt -xjf /home/$filename \
  && rm /home/$filename

RUN GECKODRIVER_VERSION=$(echo $(wget -qO- "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([0-9.]+)".*/\1/')) \
  && wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v$GECKODRIVER_VERSION/geckodriver-v$GECKODRIVER_VERSION-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /opt/geckodriver /opt/geckodriver-$GECKODRIVER_VERSION \
  && chmod u+x /opt/geckodriver-$GECKODRIVER_VERSION \
  && ln -fs /opt/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver

RUN pip install selenium==3.8.0
