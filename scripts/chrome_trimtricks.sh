#!/bin/bash -l

# get test repos
source "${WORKSPACE}"/cleanup.sh
cd "${WORKSPACE}"/chrome_simple
git clone git@github.com:integralads/pyvault.git
git clone -b SAD-4717 git@github.com:integralads/swarm-js.git
git clone -b SAD-4717 --single-branch git@github.com:jwang-net/charmer.git
cd "${WORKSPACE}"
source build.sh --simple --chrome_version=68.0.3440.87

# execute additional stuff on container
CONTAINER_ID=$(docker run -t -d "${IMAGE_NAME}" /bin/bash)
docker exec "${CONTAINER_ID}" bash -c "cd /home/charmer && cat requirements.txt | xargs -n 1 pip install && python setup.py install"
docker exec "${CONTAINER_ID}" bash -c "cd /home/pyvault && python setup.py install"
docker exec "${CONTAINER_ID}" bash -c "cd /home/swarm-js && cat requirements.txt | xargs -n 1 pip install"

# run tests
docker exec "${CONTAINER_ID}" bash -c "cd /home/charmer && ./test-runner --location=local --chrome --test=/home/swarm-js/test/python/component/test_homies.py"
