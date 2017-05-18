FROM       timn/fawkes-robotino:2016-f25-kinetic

# ROS_DISTRO set by fedora-ros layer

COPY rcll-sim-ros.rosinstall /opt/ros/

# Get and compile ROS RCLL sim bits
RUN /bin/bash -c "source /etc/profile && \
  mkdir -p /opt/ros/catkin_ws_${ROS_DISTRO}_rcll_sim_ros/src; \
  cd /opt/ros/catkin_ws_${ROS_DISTRO}_rcll_sim_ros; \
  wstool init -j $(nproc) src ../rcll-sim-ros.rosinstall; \
  rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y; \
  catkin_make_isolated --install --install-space /opt/ros/$ROS_DISTRO \
    -DCMAKE_BUILD_TYPE=$ROS_BUILD_TYPE || exit $?; \
  rm -rf *_isolated; \
  "

