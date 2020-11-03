FROM amazonlinux:latest

LABEL version="0.1"
LABEL description="Docker file for building the DotNet Game Lift Server SDK on Amazon linux 2"

WORKDIR /tmp

RUN yum update -y && yum upgrade -y

RUN yum install -y \
	git \
	tree \
	unzip \
	wget \
	yum-utils

COPY libpng15-1.5.28-3.fc27.x86_64.rpm .
RUN yum install -y ./libpng15-1.5.28-3.fc27.x86_64.rpm && rm -f ./libpng15-1.5.28-3.fc27.x86_64.rpm

RUN rpm --import "http://keyserver.ubuntu.com/pks/lookup?op=get&search=0x3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF"
RUN yum-config-manager --add-repo http://download.mono-project.com/repo/centos/
RUN yum clean all && yum makecache
RUN yum install -y \
	mono-complete \
	nuget
RUN rm -rf /var/cache/yum

#The 4.5 solution is compatible with Unity. In the Unity Editor, import the following libraries produced by the build. Be sure to pull all the DLLs into the Assets/Plugins directory:
#* GameLiftServerSDKNet45.dll
#* Google.Protobuf.dll
#* log4net.dll
#* Newtonsoft.Json.dll
#* System.Buffers.dll
#* System.Collections.Immutable.dll
#* System.Memory.dll
#* System.Runtime.CompilerServices.Unsafe.dll
#* websocket-sharp.dll

COPY sdk-helper.sh .
RUN chmod +x ./sdk-helper.sh

ENTRYPOINT ./sdk-helper.sh
