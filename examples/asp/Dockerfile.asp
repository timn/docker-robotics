FROM       timn/fawkes-buildenv:f27-kinetic

RUN dnf install -y re2c bison cppunit-devel && dnf clean all

# Get and compile Clingo
RUN /bin/bash -c "cd /opt &&\
	git clone -n https://github.com/potassco/clingo.git clingo &&\
	cd clingo &&\
	git checkout 4223a4b4a618e60602142bab360d1a906a091bf6 &&\
	git submodule update --init --recursive &&\
	mkdir build &&\
	cd build &&\
	cmake -DCLINGO_BUILD_WITH_LUA=OFF .. &&\
	make -j$(nproc) \
	"

ARG  SSH_AUTH_SOCK=/ssh-agent
ARG  GIT_HEAD=bschaepers/asp-docker
ARG  GIT_CORE_HEAD=bschaepers/asp-docker

COPY scripts/* /opt/fawkes-runenv/

# Get and compile Fawkes
RUN /bin/bash -c "if [ -z \"$SSH_AUTH_SOCK\" ]; then >&2 echo SSH_AUTH_SOCK not set; exit 1; fi; \
	if [ ! -e \"$SSH_AUTH_SOCK\" ]; then \
		>&2 echo \"SSH auth socket $SSH_AUTH_SOCK does not exist. Forgot build volume?\"; \
		exit 1; \
	fi; \
	if ! ssh-add -l >/dev/null; then \
		>&2 echo \"No identities have been added to SSH agent, run ssh-agent on host\"; \
		exit 1; \
	fi; \
	source /opt/fawkes-buildenv/setup.bash && \
	/opt/fawkes-buildenv/get-fawkes-from-git -C /opt --repo fawkes-robotino \
	  --branch $GIT_HEAD \${GIT_CORE_HEAD:+--core-head $GIT_CORE_HEAD} &&\
	/opt/fawkes-buildenv/apply-patches -C /opt/fawkes-robotino -p1 -d fawkes /opt/fawkes-buildenv/patches.d/fawkes-core-*.patch &&\
	/opt/fawkes-buildenv/apply-patches -C /opt/fawkes-robotino -p1 /opt/fawkes-buildenv/patches.d/fawkes-robotino-*.patch &&\
	/opt/fawkes-buildenv/generic-build-flags -C /opt/fawkes-robotino &&\
	/opt/fawkes-buildenv/build -C /opt/fawkes-robotino &&\
	/opt/fawkes-buildenv/tweaks -C /opt/fawkes-robotino rcll-sim-cluster &&\
	cd /opt/fawkes-robotino && \
	for i in \$(seq 1 6); do \
		sed -i cfg/gazsim-configurations/default/host_robotino_\$i.yaml \
		    -e \"s/team-name: Carologistics/team-name: CaroASP/g\"; \
	done &&\
	cp -a cfg/gazsim-configurations/default/asp-planer.yaml \
	      cfg/gazsim-configurations/default/asp-planer-cyan.yaml &&\
	cp -a cfg/gazsim-configurations/default/host_asp_planer.yaml \
	      cfg/gazsim-configurations/default/host_asp_planer_cyan.yaml &&\
	cp -a cfg/gazsim-configurations/default/asp-planer.yaml \
	      cfg/gazsim-configurations/default/asp-planer-magenta.yaml &&\
	cp -a cfg/gazsim-configurations/default/host_asp_planer.yaml \
	      cfg/gazsim-configurations/default/host_asp_planer_magenta.yaml &&\
	sed -i cfg/gazsim-configurations/default/asp-planer-cyan.yaml \
	    -e "s/host_asp_planer.yaml/host_asp_planer_cyan.yaml/" &&\
	sed -i cfg/gazsim-configurations/default/asp-planer-magenta.yaml \
	    -e "s/host_asp_planer.yaml/host_asp_planer_magenta.yaml/" &&\
	sed -i cfg/gazsim-configurations/default/host_asp_planer_cyan.yaml \
			-e \"s/peer-address: .*\$/peer-address: refbox/\" \
			-e \"s/peer-recv-port: .*\$/peer-recv-port: 4417/\" \
			-e \"s/peer-send-port: .*\$/peer-send-port: 4457/\" \
			-e \"s/cyan-recv-port: .*\$/cyan-recv-port: 4477/\" \
			-e \"s/cyan-send-port: .*\$/cyan-send-port: 4497/\" \
			-e \"s/magenta-recv-port: .*\$/magenta-recv-port: 4520/\" \
			-e \"s/magenta-send-port: .*\$/magenta-send-port: 4540/\" &&\
	sed -i cfg/gazsim-configurations/default/host_asp_planer_magenta.yaml \
			-e \"s/peer-address: .*\$/peer-address: refbox/\" \
			-e \"s/peer-recv-port: .*\$/peer-recv-port: 4420/\" \
			-e \"s/peer-send-port: .*\$/peer-send-port: 4460/\" \
			-e \"s/cyan-recv-port: .*\$/cyan-recv-port: 4477/\" \
			-e \"s/cyan-send-port: .*\$/cyan-send-port: 4497/\" \
			-e \"s/magenta-recv-port: .*\$/magenta-recv-port: 4520/\" \
			-e \"s/magenta-send-port: .*\$/magenta-send-port: 4540/\" \
	"

