FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename

EXPOSE 4444

#ENV GRID_MAX_SESSION 5
#ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
#ENV GRID_THROW_ON_CAPABILITY_NOT_PRESENT true
#ENV GRID_JETTY_MAX_THREADS -1
#ENV GRID_CLEAN_UP_CYCLE 5000
#ENV GRID_BROWSER_TIMEOUT 0
#ENV GRID_TIMEOUT 30
#ENV GRID_DEBUG false
#ENV GRID_HUB_PORT 4444
#ENV GRID_HUB_HOST "0.0.0.0"

# xvfb
RUN apt-get update \
  && apt-get -qqy install xvfb \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# chrome
RUN echo "Installing chrome version $version"
RUN echo "Filename: $filename"
RUN dpkg -i $filename



#==============================
# Locale and encoding settings
#==============================
ENV LANG_WHICH en
ENV LANG_WHERE US
ENV ENCODING UTF-8
ENV LANGUAGE ${LANG_WHICH}_${LANG_WHERE}.${ENCODING}
ENV LANG ${LANGUAGE}
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

#ENV NODE_MAX_INSTANCES 1
#ENV NODE_MAX_SESSION 1
#ENV NODE_HOST 0.0.0.0
#ENV NODE_PORT 5555
#ENV NODE_REGISTER_CYCLE 5000
#ENV NODE_POLLING 5000
#ENV NODE_UNREGISTER_IF_STILL_DOWN_AFTER 60000
#ENV NODE_DOWN_POLLING_LIMIT 2
#ENV NODE_APPLICATION_NAME ""

#==============================
# Scripts to run Selenium Node
#==============================
COPY entry_point.sh \
    /opt/bin/

RUN chmod u+x /opt/bin/entry_point.sh
CMD ["/opt/bin/entry_point.sh"]
