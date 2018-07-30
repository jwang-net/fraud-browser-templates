#!/bin/bash

function check_dep {
    if ! command "$1" > /dev/null 2>&1; then
        case "$1" in
            docker)
                echo "$(sudo yum install docker -y)"
                echo "$(sudo service docker start)"
                echo "$(sudo usermod -a -G docker jenkins)"
                ;;
            yum)
                echo "ERROR: Incompatible OS. This should be run on a jenkins slave."
                ;;
            *)
                break
                ;;
        esac
    else
        echo "$1 already installed"
    fi
}

function check_python {
    if [[ -z "${VIRTUAL_ENV}" ]]; then
        echo "$(virtualenv venv)"
        echo "$(source venv/bin/activate)"
        echo "$(pip install -r requirements.txt)"
    fi
}

function setup {
    echo "Checking dependencies..."
    check_dep yum
    check_dep docker
    check_python
}

setup
