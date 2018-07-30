FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename

RUN apt-get -qq install -y

RUN echo "Installing chrome version $version"
RUN echo "Filename: $filename"
RUN dpkg -i $filename
