# Docker Images for Robotics
This repository contains images related to Robotics development.

### Fedora Robotics Image
This image is based on the
[Docker Fedora image](https://hub.docker.com/_/fedora/). It additionally adds
a number of packages relevant to develop and run robotics software on
Fedora. In particular, it is suitable to build and use
[ROS](http://www.ros.org) and [Fawkes](https://www.fawkesrobotics.org).
It also contains packages from copr repos for
[planners](https://copr.fedorainfracloud.org/coprs/thofmann/planner/),
[Plexil](https://copr.fedorainfracloud.org/coprs/thofmann/plexil),
[OpenPRS](https://copr.fedorainfracloud.org/coprs/timn/openprs), and
[Clingo](https://copr.fedorainfracloud.org/coprs/timn/clingo).


### Fedora ROS Image
This image is based on the Fedora Robotics Image. A build downloads
and installs ROS from the
[ROS copr](https://copr.fedorainfracloud.org/coprs/thofmann/ros/).

### Fawkes Robotino Image
This image is based on the Fedora ROS image. It adds all software
required to run the
[RoboCup Logistics League Simulation](https://www.fawkesrobotics.org/projects/llsf-sim/)
based on the
[Fawkes RCLL release](https://www.fawkesrobotics.org/blog/2017/02/08/rcll2016-release/).

### Fawkes Build Environment and Builder Images

The [fawkes-buildenv](fawkes-buildenv/) image provides an environment
to build further images that contain Fawkes. It provides build scripts
and patches crucial for the release.

The [fawkes-builder](fawkes-builder/) image is used for continuous
integration builds through buildkite. It contains the largest amount
of prerequisites of Fawkes as possible to maximize the coverage of the
builds.

### Kubernetes Cluster

Some images are used for the
[RCLL Simulation Cluster](https://github.com/timn/rcll-sim-cluster)
based on Kubernetes to run RCLL games fully automated. It has been used,
for example, for the
[Planning and Execution Competition for Logistics Robots in Simulation](http://www.robocup-logistics.org/sim-comp)
held at [ICAPS 2017](http://icaps17.icaps-conference.org/) and
[ICAPS 2018](http://icaps18.icaps-conference.org/).
