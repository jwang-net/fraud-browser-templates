#!/bin/bash

function main {
    docker rm $(docker ps -a -q) --force
    docker rmi $(docker images -q) --force
}

main
