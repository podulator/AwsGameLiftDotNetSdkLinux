#!/bin/bash

myDir=`pwd`
sharedDir="${myDir}/binaries"
if [[ ! -d ${sharedDir} ]]; then
	mkdir ${sharedDir}
fi

docker run -it \
    --rm \
	--name sdk \
	-v ${sharedDir}:/tmp/final \
	-e SDK_ZIP_URL=https://gamelift-release.s3-us-west-2.amazonaws.com/GameLift_09_17_2020.zip \
	-e USER_ID=$(id -u) \
	-e GROUP_ID=$(id -g) \
	podulator/gameliftsdk:0.1
