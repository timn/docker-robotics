# This is an auto generated Dockerfile for gazebo:gzweb7
# generated from templates/docker_images/create_gzweb_image.Dockerfile.em
# generated on 2017-01-27 02:26:09 +0000
FROM gazebo:libgazebo7

# install packages
RUN apt-get update && apt-get install -q -y \
    build-essential \
    cmake \
    git \
    imagemagick \
    libboost-all-dev \
    libgts-dev \
    libjansson-dev \
    libtinyxml-dev \
    libyaml-cpp-dev \
    mercurial \
    nodejs \
    nodejs-legacy \
    npm \
    pkg-config \
    psmisc \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# install gazebo packages
RUN apt-get update && apt-get upgrade -q -y \
    && rm -rf /var/lib/apt/lists/*

# Get and compile Gazebo stuff
RUN cd /opt && \
	git clone https://github.com/robocup-logistics/gazebo-rcll.git && \
	cd gazebo-rcll/plugins && \
	make -j$(nproc) CFLAGS_MTUNE_NATIVE="-m64 -mtune=generic"

# clone gzweb
RUN hg clone https://bitbucket.org/osrf/gzweb /opt/gzweb

# build gzweb
RUN bash -c "\
    cd /opt/gzweb \
    && hg up default \
		&& mkdir -p http/client/assets \
    && sed -i -e 's/gzserver/xvfb-run -s \"-screen 0 1280x1024x24\" gzserver/g' tools/gzthumbnails.sh \
    && source /usr/share/gazebo/setup.sh \
    && export GAZEBO_MODEL_PATH=\"$GAZEBO_MODEL_PATH:/opt/gazebo-rcll/models\" \
    && ./deploy.sh -m \
    "
RUN apt-get update && apt-get install -q -y jq \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/* /opt/gzweb/

# setup environment
EXPOSE 8080
EXPOSE 7681

# run gzserver and gzweb
CMD ./root/gzweb/start_gzweb.sh && gzserver
