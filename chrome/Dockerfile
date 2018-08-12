FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename

# xvfb
RUN apt-get update \
  && apt-get -qqy install xvfb \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# chrome
RUN echo "Installing chrome version $version"
RUN echo "Filename: $filename"
RUN dpkg -i $filename

RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    language-pack-en \
    tzdata \
    locales \
  && locale-gen ${LANGUAGE} \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qyy autoremove \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean

#================
# Font libraries
#================
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install \
    libfontconfig \
    libfreetype6 \
    xfonts-cyrillic \
    xfonts-scalable \
    fonts-liberation \
    fonts-ipafont-gothic \
    fonts-wqy-zenhei \
    fonts-tlwg-loma-otf \
    ttf-ubuntu-font-family \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get -qyy clean

#========================
# Selenium Configuration
#========================
ENV SCREEN_WIDTH 1360
ENV SCREEN_HEIGHT 1020
ENV SCREEN_DEPTH 24
ENV DISPLAY :99.0


#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh \
    /opt/bin/

RUN chmod u+x /opt/bin/entry_point.sh
CMD ["/opt/bin/entry_point.sh"]
