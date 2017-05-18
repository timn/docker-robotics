FROM       timn/fedora-ros:f25-kinetic

# ROS_DISTRO set by fedora-ros layer

COPY fawkes-pre.rosinstall /opt/ros/

# Get and compile ROS pre bits
RUN /bin/bash -c "source /etc/profile && \
  mkdir -p /opt/ros/catkin_ws_${ROS_DISTRO}_fawkes_pre/src; \
  cd /opt/ros/catkin_ws_${ROS_DISTRO}_fawkes_pre; \
  wstool init -j $(nproc) src ../fawkes-pre.rosinstall; \
  rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y; \
  catkin_make_isolated --install --install-space /opt/ros/$ROS_DISTRO \
    -DCMAKE_BUILD_TYPE=$ROS_BUILD_TYPE || exit $?; \
  rm -rf *_isolated; \
  "

RUN mkdir -p /opt/patches.fawkes
COPY patches.d/* /opt/patches.fawkes/

# Get and compile Fawkes
# Use generic optimization so that the resulting image works on more platforms.
# Enable the old 2015 agent, only that has the full model of the production.
RUN /bin/bash -c "source /opt/ros/$ROS_DISTRO/setup.bash && \
	cd /opt && \
	curl -O https://files.fawkesrobotics.org/releases/fawkes-robotino-2016-2.tar.bz2 && \
	tar xf fawkes-robotino-2016-2.tar.bz2 && \
	cd fawkes-robotino && \
	for p in /opt/patches.fawkes/fawkes-core-*.patch; do echo PATCH \$p; patch -d fawkes -p1 -N <\$p; done && \
	for p in /opt/patches.fawkes/fawkes-robotino-*.patch; do echo PATCH \$p; patch -p1 -N <\$p; done && \
	sed -i -e 's/\(agent: rcll2016\/rcll2016\)/# \1/;s/# \(agent: llsf2015\/llsf2015\)/\1/' cfg/conf.d/clips-agent.yaml && \
	sed -i -e 's/CFLAGS_EXTRA  += -g/CFLAGS_EXTRA += -m64 -mtune=generic -g/g' etc/buildsys/config.mk && \
	make -j$(nproc) all gui ${VERBOSE_FLAG} CFLAGS_MTUNE_NATIVE= &&\
	find . -name '.objs_*' -prune -exec rm -rf {} \; &&\
	find . -name '.deps_*' -prune -exec rm -rf {} \;"

