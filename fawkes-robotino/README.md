Fawkes Robotino Images
======================

These images are based on fawkes-robotino domain-specific repository
which is based on the public Fawkes core and maintained by the
Carologistics RoboCup team. Images can be built based on public point
releases, or on a specific Git version.

Note that the repository is private and requires authentication
credentials to be provided. For this, the build argument SSH_AUTH_SOCK
can be passed to perform the SSH authentication from outside the build
container, i.e., the user invoking the build requires access to the
repository.

Building the Point Release
--------------------------
The following describes building the 2016 public release.

```bash
docker build -f Dockerfile.2016-f25-kinetic -t timn/fawkes-robotino:2016-f25-kinetic .
```
Note that you may need to choose a different tag when building
locally.

Further note, that this builds the RCLL Simulation Cluster version.
Use Dockerfile.2016-f25-kinetic-standalone to run outside the cluster
with the simulation startup script all running within a single container
(this is, however, no longer the primary intention of these images and
 no longer well tested).

Building a Git version
----------------------
The following builds the latest version of the 2016 code before we
branched off the release branch.

```bash
docker build -v $SSH_AUTH_SOCK:/ssh-agent \
  --build-arg GIT_HEAD=2016-0 --build-arg GIT_CORE_HEAD=1.0.1 \
  -f Dockerfile.2016-f25-kinetic-git \
  -t timn/fawkes-robotino:2016-f25-kinetic-git-2016-0 .
```

Note the build-time bind mount for the authentication socket. It
assumes that ssh-agent is properly setup and the SSH_AUTH_SOCK
variable is set. This is also often the case when using Gnome Keyring
(it doubles as an SSH agent).

