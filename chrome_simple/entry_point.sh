#!/bin/bash

git clone git@github.com:integralads/swarm-js.git
git clone git@github.com:integralads/charmer.git
cd /home/swarm-js && pip install -r requirements.txt
cd /home/charmer

./test-runner --chrome --location=local --test=/home/swarm-js/test/python/component/test_homies.py
