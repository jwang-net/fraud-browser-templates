FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename

RUN echo "Installing Firefox version $version"
RUN echo "Filename: $filename"
RUN tar -xvjf $filename
