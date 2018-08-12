FROM fraud-browser-base

ADD . /home
ARG version=None
ARG filename=None
ARG version
ARG filename
ENV BROWSER_VERSION=$version

# xvfb
RUN apt-get update \
  && apt-get -qqy install xvfb

# Languages
RUN apt-get -qqy update \
  && apt-get -qqy --no-install-recommends install language-pack-en tzdata locales \
  && locale-gen ${LANGUAGE} \
  && dpkg-reconfigure --frontend noninteractive locales \
  && apt-get -qyy autoremove \
  && apt-get -qyy clean

# Fonts
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
  && apt-get -qyy clean

# Chrome
RUN echo "Installing chrome version $version"
RUN echo "Filename: $filename"
RUN dpkg -i $filename
RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/lib/apt/lists/*

# Entrypoint script
COPY entry_point.sh \
    /opt/bin/

RUN chmod u+x /opt/bin/entry_point.sh
CMD ["/opt/bin/entry_point.sh"]
