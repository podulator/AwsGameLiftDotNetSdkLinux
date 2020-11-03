#!/bin/bash

function showHelp() {
    echo "usage: ${0} -y"
    echo "this script will delete *all* your docker images, hence the -y flag"
}

numArgs=$#

if [[ 1 -ne ${numArgs} ]]; then
    showHelp
    exit 1
elif [[ ${1} != "-y" ]]; then
    showHelp
    exit 2
else
    running=$(docker ps -a -q)
    if [[ "x${running}" != "x" ]]; then
        echo "running images: ${running}"
        docker rm -vf $(docker ps -a -q)
    fi
    built=$(docker images -a -q)
    if [[ "x${built}" != "x" ]]; then
        echo "built images: ${built}"
        docker rmi -f $(docker images -a -q)
    fi
    if [[ -d ./binaries ]]; then
        rm -rf ./binaries
    fi
    echo "done"
fi
