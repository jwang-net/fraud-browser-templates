#!/bin/bash

function usage {
    cat <<EOM
Usage:
    build.sh (--chrome_version|--firefox_version)

    --chrome_version        Specify chrome version
    --firefox_version       Specify firefox version
EOM
    fail
}

function fail {
    >&2 echo "${1}"
#    exit 1
}

function build_docker_image {
    if [ "${1}" = base ]; then
        cd base
        echo "Building Docker base image..."
        docker build -t fraud-browser-base .
    elif [ "${1}" = hub ]; then
        cd hub
        echo "Building Selenium hub..."
        docker build -t fraud-selenium-hub .
    else
        cd "${1}"
        export BROWSER_FILENAME=$(find . -name "${EXTENSION}" | sed 's/^.\///')
        export IMAGE_NAME="${BROWSER}"_"${BROWSER_VERSION}"
        echo "Building docker image $IMAGE_NAME with $BROWSER version $BROWSER_VERSION"
        docker build -t "${IMAGE_NAME}" . --build-arg version="${BROWSER_VERSION}" --build-arg filename="${BROWSER_FILENAME}"
    fi
    cd "${ROOT_DIR}"
}

function main {
    python get_browser.py "${BROWSER}" "${BROWSER_VERSION}"
    # Create network
    docker network create grid

    # Create images
    build_docker_image base
    build_docker_image hub
    build_docker_image "${BROWSER}"

    # Run hub & node
    docker run -d -p 4444:4444 --net grid --name fraud-hub fraud-selenium-hub
    docker run -d --net grid -e HUB_HOST=fraud-hub -v /dev/shm:/dev/shm "${IMAGE_NAME}"
    docker image ls
}

if [ -z "$@" ]; then
    fail "ERROR: No args"
    usage
fi
[[ $(pwd) = *fraud-browser-templates* ]] || fail "ERROR: build.sh must be run from the root of this directory"
export ROOT_DIR=`pwd`

for arg in "$@"; do
    case "${arg}" in
        --chrome_version=*)
            export BROWSER_VERSION="${arg#*=}"
            export BROWSER=chrome
            export EXTENSION="*.deb"
            ;;
        --firefox_version=*)
            export BROWSER_VERSION="${arg#*=}"
            export BROWSER=firefox
            export EXTENSION="*.tar.bz2"
            ;;
        *)
            usage
            ;;
    esac
done

main
cd "${ROOT_DIR}"
