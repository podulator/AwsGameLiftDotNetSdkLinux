# AwsGameLiftDotNetSdkLinux


Docker container and convenience scripts to build the AWS GameLift DotNet SDK for Unity on linux

## Build the container

Run the accompanying `build.sh` script

## Run the container

The container will download the SDK that you point to, and build it, with the binaries ending up under /tmp/final.
You can expose this back directly with the `-v` flag, and set permissions on that directory using the `USER_ID` and `GROUP_ID` environment variables.

The bundled `run.sh` shell script does all of this for you, as a convenience, creating a folder called `binaries`, owned by you.

## Clean up

There is a very aggressive script called `clean.sh` that will remove all built images. If you have no other docker work in progress, you can use it to remove everything after a successful sdk build. You need to supply a `-y` switch.
