
source /etc/profile

# Save some environment variables which might be set from container
# env but would be overwritten by some statements (from included files)
SAVE_VARS="GAZEBO_MASTER_URI ROS_MASTER_URI"

for v in $SAVE_VARS; do
	if [ -n "${!v}" ]; then
		eval PREENV_$v=${!v}
	fi
done

export FAWKES_DIR=/opt/fawkes-robotino
export GAZEBO_RCLL=/opt/gazebo-rcll
export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:$GAZEBO_RCLL/plugins/lib/gazebo
export GAZEBO_MODEL_PATH=$GAZEBO_RCLL/models
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$GAZEBO_RCLL/models/carologistics

export LLSF_REFBOX_DIR=/opt/llsf-refbox

if [ -n "$GAZEBO_WORLD" ]; then
	if [[ "$GAZEBO_WORLD" != /* ]]; then
		# just the map basename, form full path
		export GAZEBO_WORLD_PATH=$GAZEBO_RCLL/worlds/carologistics/${GAZEBO_WORLD}.world
	else
		export GAZEBO_WORLD_PATH=$GAZEBO_WORLD
	fi
else
	export GAZEBO_WORLD_PATH=${GAZEBO_WORLD_PATH:-$GAZEBO_RCLL/worlds/carologistics/llsf.world}
fi

source /usr/share/gazebo/setup.sh
source /opt/ros/$ROS_DISTRO/setup.bash

if [ ! -e /run/dbus/messagebus.pid ]; then
	mkdir -p /run/dbus
	dbus-daemon --system --fork
fi

# Restore some settings from before
for v in $SAVE_VARS; do
	VN=PREENV_$v
	if [ -n "${!VN}" ]; then
		export $v=${!VN}
	fi
done
