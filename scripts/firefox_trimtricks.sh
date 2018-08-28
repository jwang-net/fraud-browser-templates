#!/bin/bash

# get test repos
source "${WORKSPACE}"/cleanup.sh
cd "${WORKSPACE}"/firefox_simple
git clone git@github.com:integralads/pyvault.git
git clone -b SAD-4717 --single-branch git@github.com:integralads/swarm-js.git
git clone -b SAD-4717 --single-branch git@github.com:jwang-net/charmer.git
cd "${WORKSPACE}"
source build.sh --simple --firefox_version=61.0

# execute additional stuff on container
CONTAINER_ID=$(docker run -t -d "${IMAGE_NAME}" /bin/bash)
docker exec "${CONTAINER_ID}" bash -c "cd /usr/src/app/charmer && cat requirements.txt | xargs -n 1 pip install && python setup.py install"
docker exec "${CONTAINER_ID}" bash -c "cd /usr/src/app/pyvault && python setup.py install"
docker exec "${CONTAINER_ID}" bash -c "cd /usr/src/app/swarm-js && cat requirements.txt | xargs -n 1 pip install"

# run tests
docker exec "${CONTAINER_ID}" bash -c "pytest /usr/src/app/swarm-js/test/python/component/test_homies_virtualdisplay.py"
