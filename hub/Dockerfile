FROM fraud-browser-base

COPY config.json /home

RUN java -jar /home/selenium-server-standalone.jar -role hub \
  -hubConfig /home/config.json & NODE_PID=$!
