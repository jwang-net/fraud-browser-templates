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

# Chrome Driver
# TODO: Add ability to specify chrome driver version
RUN CHROME_DRIVER_VERSION=$(echo $(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)) \
  && wget --no-verbose https://chromedriver.storage.googleapis.com/$CHROME_DRIVER_VERSION/chromedriver_linux64.zip -O /tmp/chromedriver_linux64.zip \
  && unzip /tmp/chromedriver_linux64.zip -d /home/selenium \
  && rm -rf /tmp/chromedriver_linux64.zip \
  && mv /home/selenium/chromedriver /home/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && chmod u+x /home/selenium/chromedriver-$CHROME_DRIVER_VERSION \
  && ln -fs /home/selenium/chromedriver-$CHROME_DRIVER_VERSION /usr/bin/chromedriver

RUN chmod u+x /home/entry_point.sh \
  && chmod u+x /home/generate_config
RUN /home/generate_config > /home/config.json
CMD ["/home/entry_point.sh"]
