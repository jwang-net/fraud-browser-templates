#!/bin/bash

# get test repos
source "${WORKSPACE}"/cleanup.sh
cd "${WORKSPACE}"/chrome_simple
git clone git@github.com:integralads/pyvault.git
git clone git@github.com:integralads/swarm-js.git
git clone git@github.com:integralads/charmer.git
cd "${WORKSPACE}"
source build.sh --simple --chrome_version="$@"

# execute additional stuff on container
CONTAINER_ID=$(docker run -it -d "${IMAGE_NAME}" /bin/bash)
docker exec -it "${CONTAINER_ID}" cd /home/pyvault && python setup.py install
docker exec -it "${CONTAINER_ID}" cd /home/charmer && python setup.py install
docker exec -it "${CONTAINER_ID}" cd /home/swarm-js && cat requirements.txt | xargs -n 1 pip install

# run tests
docker exec -it "${CONTAINER_ID}" cd /home/charmer && ./test-runner --location=local --chrome --test=/home/swarm-js/test/python/component/test_homies.py
