#!/bin/bash

echo "Preparing simulation environment"

source /etc/profile

export FAWKES_DIR=/opt/fawkes-robotino
export GAZEBO_RCLL=/opt/gazebo-rcll
export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:$GAZEBO_RCLL/plugins/lib/gazebo
export GAZEBO_MODEL_PATH=$GAZEBO_RCLL/models
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$GAZEBO_RCLL/models/carologistics

export LLSF_REFBOX_DIR=/opt/llsf-refbox
export GAZEBO_WORLD_PATH=$GAZEBO_RCLL/worlds/carologistics/llsf.world

mkdir -p /run/dbus
dbus-daemon --system --fork

echo "Running simulation"
cd $FAWKES_DIR/bin
./gazsim.bash -x start -n 1 -r -a -t

echo "Starting game"
$LLSF_REFBOX_DIR/rcll-refbox-instruct -c Carologistics -p PRODUCTION -s RUNNING

echo "Startup complete. Press Enter to shutdown."
read

./gazsim.bash -x kill

