# Build DSpace for Docker
_It is not necessary to run this step using Docker. The following instructions illustrate how Docker can be used to run Docker._

_If you have maven installed locally, it is probably preferable to run the maven build using your local mave installation._

## Building DSpace Using Docker

Set the environment variable **DSPACE_SRC** to the root directory of your cloned DSpace repository.

#### Bash

```
export DSPACE_SRC=$(pwd)
docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v ${DSPACE_SRC}:/opt/maven -w /opt/maven maven mvn clean install
```

#### Git-Bash Windows

```
export DSPACE_SRC=$(pwd)
winpty docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v /${DSPACE_SRC}:/opt/maven -w //opt/maven maven mvn clean install
```

## DSpace Development With Git
See https://wiki.duraspace.org/display/DSPACE/Development+with+Git for instructions on using Git with the DSpace code base.
