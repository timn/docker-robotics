# Docker Images for Robotics
This repository contains images related to Robotics development.

### Fedora Robotics Image
This image is based on the [Docker Fedora image](https://hub.docker.com/_/fedora/). It additionally adds a number of packages relevant to develop and run robotics software on Fedora. In particular, it is suitable to build and use [ROS](http://www.ros.org) and [Fawkes](https://www.fawkesrobotics.org). The current image is based on Fedora 23.

### Fedora ROS Image
This image is based on the Fedora Robotics Image. A build downloads and installs ROS to /opt/ros. The current image is based on Fedora 23 and ROS Jade.

### Fawkes Robotino Image
This image is based on the Fedora ROS image. It adds all software required to run the [RoboCup Logistics League Simulation](https://www.fawkesrobotics.org/projects/llsf-sim/). It has been tested to run on Fedora 23 and Ubuntu 14.04. Note that due to aggressive optimization flags in the build the image may not be portable among host with different CPU architectures or feature sets (e.g., compiling on a CPU with AVX2 instructions and running it on another without will most likely fail and you will see "illegal instruction" errors in the kernel log dmesg). You can run this image with:
```
docker run -it -v /tmp/.X11-unix:/tmp/.X11-unix \
           -e DISPLAY=unix$DISPLAY --name rcll-sim --privileged \
       timn/fawkes-robotino:2015-f23-jade
```

### Note
The images serve as a proof-of-concept that this can be done. We make no promises as to how often we maintain the images. However, should you find and fix issues we happily take pull requests!
