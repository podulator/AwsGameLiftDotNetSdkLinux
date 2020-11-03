#!/bin/bash

echo "Building the SDK from: '${SDK_ZIP_URL}'"

rm -rf /tmp/*
rm -f /tmp/*.zip

wget ${SDK_ZIP_URL} -O /tmp/GameLift.zip
echo "SDK source download completed, saved to /tmp"
ls -l /tmp

echo "Unzipping archive"
unzip /tmp/GameLift.zip -d /tmp/sdk && rm -f /tmp/GameLift.zip

mv /tmp/sdk/GameLift_*/GameLift-SDK-Release-*/GameLift-CSharp-ServerSDK-* /tmp/build
cd /tmp/build && nuget restore && xbuild /p:Configuration=Release ./*.sln
tree /tmp/build/Net45/bin

echo "copying to shared dir: /tmp/final"
cp -arp /tmp/build/Net45/bin /tmp/final

if [[ ${USER_ID} -gt 0 ]]; then
	echo "fixing permissions: ${USER_ID}:${GROUP_ID}"
	chown -R ${USER_ID}:${GROUP_ID} /tmp/final
fi

echo "SDK build done!"
