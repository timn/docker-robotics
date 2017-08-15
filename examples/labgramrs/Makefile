
SILENT = @
DOCKER_CMD=sudo docker

ACTORSIM_RCLL_GIT_HEAD_labgramrs1   = labgramrs-1/master
FAWKES_ROBOTINO_GIT_HEAD_labgramrs1 = labgramrs-1/master
FAWKES_CORE_GIT_HEAD_labgramrs1     = labgramrs-1/master

ACTORSIM_RCLL_GIT_HEAD_labgramrs2   = labgramrs-2/master
FAWKES_ROBOTINO_GIT_HEAD_labgramrs2 = 2016-2
FAWKES_CORE_GIT_HEAD_labgramrs2     = labgramrs-1/master

ACTORSIM_RCLL_GIT_HEAD_labgramrs3   = labgramrs-3/master
FAWKES_ROBOTINO_GIT_HEAD_labgramrs3 = labgramrs-3/master
FAWKES_CORE_GIT_HEAD_labgramrs3     = labgramrs-1/master


BUILD_GROUPS=labgramrs1 labgramrs2 labgramrs3

.build_fawkes_%.touch: Dockerfile.fawkes
	$(SILENT)echo
	$(SILENT)echo "Building Fawkes image for group $*"
	$(SILENT)echo
	$(SILENT)echo "FAWKES_ROBOTINO_GIT_HEAD  $(FAWKES_ROBOTINO_GIT_HEAD_$*)"
	$(SILENT)echo "FAWKES_CORE_GIT_HEAD      $(FAWKES_CORE_GIT_HEAD_$*)"
	$(SILENT)$(DOCKER_CMD) build \
		-v $(SSH_AUTH_SOCK):/ssh-agent \
		--build-arg GIT_HEAD=$(FAWKES_ROBOTINO_GIT_HEAD_$*) \
		--build-arg GIT_CORE_HEAD=$(FAWKES_CORE_GIT_HEAD_$*) \
		-t timn/fawkes-robotino:$* \
		-f Dockerfile.fawkes .
	$(SILENT)echo "Tagging timn/fawkes-robotino:$* ->" \
		"registry.kbsg.rwth-aachen.de/timn/fawkes-robotino:$*"
	$(SILENT)$(DOCKER_CMD) tag \
		timn/fawkes-robotino:$* \
		registry.kbsg.rwth-aachen.de/timn/fawkes-robotino:$*
	$(SILENT)touch $@

.build_actorsim_%.touch: Dockerfile.actorsim $(wildcard scripts/*)
	$(SILENT)echo
	$(SILENT)echo "Building ActorSim image for group $*"
	$(SILENT)echo
	$(SILENT)echo "ACTORSIM_RCLL_GIT_HEAD    $(ACTORSIM_RCLL_GIT_HEAD_$*)"
	$(SILENT)$(DOCKER_CMD) build \
		-v $(SSH_AUTH_SOCK):/ssh-agent \
		--build-arg ACTORSIM_RCLL_GIT_HEAD=$(ACTORSIM_RCLL_GIT_HEAD_$*) \
		-t timn/actorsim:$* \
		-f Dockerfile.actorsim .
	$(SILENT)echo "Tagging timn/actorsim:$* ->" \
		"registry.kbsg.rwth-aachen.de/timn/actorsim:$*"
	$(SILENT)$(DOCKER_CMD) tag \
                timn/actorsim:$* \
                registry.kbsg.rwth-aachen.de/timn/actorsim:$*
	$(SILENT)touch $@

.PHONY: upload all clean

all: $(foreach G,$(BUILD_GROUPS),.build_fawkes_$G.touch .build_actorsim_$G.touch )

upload: all
	$(SILENT)for g in $(BUILD_GROUPS); do \
		$(DOCKER_CMD) push registry.kbsg.rwth-aachen.de/timn/fawkes-robotino:$$g; \
		$(DOCKER_CMD) push registry.kbsg.rwth-aachen.de/timn/actorsim:$$g; \
	done

clean:
	$(SILENT)rm -f .build_*.touch

