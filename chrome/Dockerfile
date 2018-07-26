FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename

RUN apt-get -qq install -y fonts-liberation libappindicator3-1 libasound2 libnspr4 libnss3 libxss-dev lsb-release \
  wget xdg-utils libfontconfig1 libfontconfig1-dbg

RUN echo "Installing chrome version $version"
RUN echo "Filename: $filename"
RUN dpkg -i $filename
