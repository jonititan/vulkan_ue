FROM ubuntu:22.04

# Needed to share GPU
ENV NVIDIA_DRIVER_CAPABILITIES=all
ENV NVIDIA_VISIBLE_DEVICES=all

RUN apt-get update && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install \
    pciutils \
    vulkan-tools \
    mesa-utils \
    libvulkan-dev

# Install our build prerequisites
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y --no-install-recommends \
	build-essential \
	ca-certificates \
	curl \
	git \
	git-lfs \
	python3 \
	python3-dev \
	python3-pip \
	shared-mime-info \
	software-properties-common \
	sudo \
	tzdata \
	unzip \
	xdg-user-dirs \
	zip \
	pulseaudio \
	python3 \
	python3-pip \
	sudo \
	wget \ 
    libxext6 \
    mono-complete \
    build-essential \
	x11-xserver-utils \
	xdg-user-dirs \
    lsb-release \
    rsync \
    software-properties-common \
	unzip \
    llvm && \
	rm -rf /var/lib/apt/lists/* && echo '' && echo 'RUN directive complete. Docker will now commit the filesystem layer to disk.' && echo 'Note that for large filesystem layers this can take quite some time.' && echo 'Performing filesystem layer commit...' && echo ''

RUN pip3 install setuptools wheel
RUN pip3 install airsimdroneracinglab

RUN useradd --create-home --home /home/ue5 --shell /bin/bash --uid 1000 ue5 && \
	passwd -d ue5 && \
	usermod -a -G audio,video,sudo ue5 && echo '' && echo 'RUN directive complete. Docker will now commit the filesystem layer to disk.' && echo 'Note that for large filesystem layers this can take quite some time.' && echo 'Performing filesystem layer commit...' && echo ''


COPY --chown=ue5 UnrealEngine* /home/ue5/UnrealEngine/


USER ue5
ENV USER ue5

#https://github.com/microsoft/AirSim/issues/4535#issuecomment-1136095046
#COPY --chown=ue5 Colosseum* /home/ue5/Colosseum/
# git -C /home/ue4 clone -b ue5 https://github.com/CodexLabsLLC/Colosseum.git 
#RUN cd /home/ue5/Colosseum && \
#    echo "Running setup.sh" && \
#	bash ./setup.sh  && \
#    echo "Running build.sh" && \
#    bash ./build.sh  
