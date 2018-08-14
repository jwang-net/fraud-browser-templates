FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename
ENV BROWSER_VERSION=$version

RUN echo "Installing Firefox version $version"
RUN echo "Filename: $filename"
RUN apt-get -qqy update \
  && tar -C /opt -xjf /home/$filename \
  && rm /home/$filename
