FROM       timn/fawkes-robotino:2016-f25-kinetic

# ROS_DISTRO set by fedora-ros layer

RUN dnf install -y gnome-terminal mesa-dri-drivers jq && dnf clean all

RUN /bin/bash -c "sed -i /opt/fawkes-robotino/cfg/conf.d/gazsim.yaml \
    -e 's/~\/fawkes-robotino/\/opt\/fawkes-robotino/g' \
    -e 's/refbox-host: .*$/refbox-host: refbox/' \
    -e 's/addresses: .*$/addresses: [\"refbox\", \"robot-c1\", \"robot-c2\", \"robot-c3\", \"robot-m1\", \"robot-m2\", \"robot-m3\", \"agent-c1\", \"agent-c2\", \"agent-c3\", \"agent-m1\", \"agent-m2\", \"agent-m3\"]/' \
    -e \"s/send-ports: .*$/send-ports: [4445, $(seq -s ', ' 4411 4422)]/\" \
    -e \"s/recv-ports: .*$/recv-ports: [4444, $(seq -s ', ' 4451 4462)]/\" \
    -e \"s/send-ports-crypto1: .*$/send-ports-crypto1: [4446, $(seq -s ', ' 4471 4482)]/\" \
    -e \"s/recv-ports-crypto1: .*$/recv-ports-crypto1: [4441, $(seq -s ', ' 4491 4502)]/\" \
    -e \"s/send-ports-crypto2: .*$/send-ports-crypto2: [4447, $(seq -s ', ' 4511 4522)]/\" \
    -e \"s/recv-ports-crypto2: .*$/recv-ports-crypto2: [4442, $(seq -s ', ' 4531 4542)]/\" &&\
		for i in \$(seq 1 6); do \
				sed -i /opt/fawkes-robotino/cfg/gazsim-configurations/default/host_robotino_\$i.yaml \
						-e \"s/peer-address: .*\$/peer-address: refbox/\" \
						-e \"s/peer-recv-port: .*\$/peer-recv-port: \$(expr 4410 + \$i)/\" \
						-e \"s/peer-send-port: .*\$/peer-send-port: \$(expr 4450 + \$i)/\" \
						-e \"s/cyan-recv-port: .*\$/cyan-recv-port: \$(expr 4470 + \$i)/\" \
						-e \"s/cyan-send-port: .*\$/cyan-send-port: \$(expr 4490 + \$i)/\" \
						-e \"s/magenta-recv-port: .*\$/magenta-recv-port: \$(expr 4510 + \$i)/\" \
						-e \"s/magenta-send-port: .*\$/magenta-send-port: \$(expr 4530 + \$i)/\"; \
		done \
		"

# Get and compile Gazebo stuff
# And set to real-time (originally is at 1.2 real-time)
RUN cd /opt && \
	git clone https://github.com/robocup-logistics/gazebo-rcll.git && \
	cd gazebo-rcll/plugins && \
	make -j$(nproc) CFLAGS_MTUNE_NATIVE="-m64 -mtune=generic" &&\
	cd /opt/gazebo-rcll &&\
	sed -i -e 's|<max_step_size>0.004</max_step_size>|<max_step_size>0.00333</max_step_size>|g' \
		worlds/carologistics/llsf.world \
		worlds/carologistics/llsf-default.world

# Get and compile RCLL Referee Box
RUN cd /opt && \
	git clone https://git.fawkesrobotics.org/llsf-refbox.git && \
	cd llsf-refbox && \
	EMAIL="docker@invalid.invalid" git merge --no-edit --no-ff origin/timn/instruct-tool && \
	make -j$(nproc) all gui

RUN mkdir /opt/rcll-sim
COPY scripts/* /opt/rcll-sim/
#ENTRYPOINT ["/opt/rcll-sim/run-standalone"]
