FROM       timn/rcll-sim-ros:2016-f25-kinetic

# ROS_DISTRO set by fedora-ros layer

# Install additional ROSPlan dependencies
RUN dnf install -y flex python2-pymongo && dnf clean all

COPY rcll-sim-rosplan.rosinstall /opt/ros/

RUN /bin/bash -c "source /etc/profile; \
  mkdir -p /opt/ros/catkin_ws_${ROS_DISTRO}_tf2_bullet/src; \
  cd /opt/ros/catkin_ws_${ROS_DISTRO}_tf2_bullet; \
  rosinstall_generator tf2_bullet --rosdistro $ROS_DISTRO --deps --wet-only --tar --exclude RPP > $ROS_DISTRO-tf2-bullet.rosinstall; \
  wstool init -j $(nproc) src ${ROS_DISTRO}-tf2-bullet.rosinstall; \
  rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y; \
  catkin_make_isolated --install --install-space /opt/ros/$ROS_DISTRO \
    -DCMAKE_BUILD_TYPE=$ROS_BUILD_TYPE; \
  rm -rf *_isolated; \
  "

# Get and compile ROS RCLL sim bits
RUN /bin/bash -c "source /etc/profile && \
  mkdir -p /opt/ros/catkin_ws_${ROS_DISTRO}_rcll_sim_rosplan/src; \
  cd /opt/ros/catkin_ws_${ROS_DISTRO}_rcll_sim_rosplan; \
  wstool init -j $(nproc) src ../rcll-sim-rosplan.rosinstall; \
  rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y; \
  catkin_make_isolated --install --install-space /opt/ros/$ROS_DISTRO \
    -DCMAKE_BUILD_TYPE=$ROS_BUILD_TYPE || exit $?; \
  rm -rf *_isolated; \
  "

RUN mkdir -p /opt/rosplan_kb

