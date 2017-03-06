# Docker Images for Robotics
This repository contains images related to Robotics development.

### Fedora Robotics Image
This image is based on the [Docker Fedora image](https://hub.docker.com/_/fedora/). It additionally adds a number of packages relevant to develop and run robotics software on Fedora. In particular, it is suitable to build and use [ROS](http://www.ros.org) and [Fawkes](https://www.fawkesrobotics.org). The current image is based on Fedora 25.

### Fedora ROS Image
This image is based on the Fedora Robotics Image. A build downloads and installs ROS to /opt/ros. The current image is based on Fedora 25 and ROS Kinetic.

### Fawkes Robotino Image
This image is based on the Fedora ROS image. It adds all software required to run the [RoboCup Logistics League Simulation](https://www.fawkesrobotics.org/projects/llsf-sim/). It has been tested to run on Fedora 25 and Ubuntu 14.04. You can run this image with:
```
xhost +local:
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=unix$DISPLAY --name rcll-sim \
       timn/fawkes-robotino:2016-f25-kinetic
```

### Note
The images serve as a proof-of-concept that this can be done. We make no promises as to how often we maintain the images. However, should you find and fix issues we happily take pull requests!
