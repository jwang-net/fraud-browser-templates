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
    exit 1
}

function build_docker_image {
    if [ "${1}" = base ]; then
        cd base
        echo "Building Docker base image..."
        docker build -t fraud-browser-base .
        cd "${ROOT_DIR}"
    else
        cd "${1}"
        export BROWSER_FILENAME=$(find . -name "${EXTENSION}" | sed 's/^.\///')
        export IMAGE_NAME="${BROWSER}"_"${BROWSER_VERSION}"
        echo "Building docker image $IMAGE_NAME with $BROWSER version $BROWSER_VERSION"
        docker build -t "${IMAGE_NAME}" . --build-arg version="${BROWSER_VERSION}" --build-arg filename="${BROWSER_FILENAME}"
        cd "${ROOT_DIR}"
    fi
}

function main {
    python get_browser.py "${BROWSER}" "${BROWSER_VERSION}"
    build_docker_image base
    build_docker_image "${BROWSER}"
    docker image ls
}

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
