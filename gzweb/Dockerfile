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
    psmisc\
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
    && ./deploy.sh -m

# setup environment
EXPOSE 8080
EXPOSE 7681

# run gzserver and gzweb
CMD ./root/gzweb/start_gzweb.sh && gzserver
