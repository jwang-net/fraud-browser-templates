#!/bin/bash

function usage {
    cat <<EOM
Usage:
    build.sh (--simple|--grid) (--chrome_version|--firefox_version)

    --simple                No selenium grid
    --grid                  With selenium grid
    --chrome_version        Specify chrome version
    --firefox_version       Specify firefox version
EOM
    exit 1
}

function build_docker_image_simple {
    cd "${1}"_simple
    export BROWSER_FILENAME=$(find . -name "${EXTENSION}" | sed 's/^.\///')
    export IMAGE_NAME="${BROWSER}"_"${BROWSER_VERSION}"_simple
    docker build -t "${IMAGE_NAME}" . --build-arg version="${BROWSER_VERSION}" --build-arg filename="${BROWSER_FILENAME}"
}

function build_docker_image_grid {
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
    python get_browser.py "${BROWSER}" "${BROWSER_VERSION}" "${BUILD_MODE}"

    if [ "${BUILD_MODE}" = simple ]; then
        build_docker_image_simple "${BROWSER}"
    fi
    
    if [ "${BUILD_MODE}" = grid ]; then
        docker network create grid

        # Create images
        build_docker_image_grid base
        build_docker_image_grid hub
        build_docker_image_grid "${BROWSER}"

        # Run hub & node
        docker run -d -p 4444:4444 --net grid --name fraud-hub fraud-selenium-hub
        docker run -d --net grid -e HUB_HOST=fraud-hub -v /dev/shm:/dev/shm "${IMAGE_NAME}"
        docker image ls
    fi
}

# Check that the script is being run from this directory
[[ $(echo $(basename `git rev-parse --show-toplevel`)) = fraud-browser-templates ]] || echo "$(echo "ERROR: build.sh must be run from the root of repo fraud-browser-templates" ; exit 1)"
export ROOT_DIR=`pwd`

# Check script params
for arg in "$@"; do
    case "${arg}" in
        --simple)
            export BUILD_MODE=simple
            ;;
        --grid)
            export BUILD_MODE=grid
            ;;
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
