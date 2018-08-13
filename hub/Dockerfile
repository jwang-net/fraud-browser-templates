FROM fraud-browser-base

# Entrypoint script
COPY generate_config /home/selenium
COPY entry_point.sh /home

RUN chmod u+x /home/entry_point.sh \
  && chmod u+x /home/selenium/generate_config
RUN /home/selenium/generate_config > /home/selenium/config.json

CMD ["/home/entry_point.sh"]
