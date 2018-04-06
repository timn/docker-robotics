
if [ -e /usr/lib64/ros/setup.bash ]; then
	source /usr/lib64/ros/setup.bash
fi

if [[ -n "$ROS_DISTRO" && -e /opt/ros/$ROS_DISTRO/setup.bash ]]; then
	source /opt/ros/$ROS_DISTRO/setup.bash
fi

