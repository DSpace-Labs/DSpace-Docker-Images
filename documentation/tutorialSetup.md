{% include nav.html %}
# Setting Up Docker

[![Demonstration Video](https://i.ytimg.com/vi/4mgVtB0t8aM/hqdefault.jpg)](https://www.youtube.com/watch?v=4mgVtB0t8aM)

## Install Docker
- Docker is supported on the following platforms
  - Linux
  - MacOS
  - Windows 10
- [Docker Install](https://docs.docker.com/install/)

## Command Line Access
Most of your interaction with Docker will take place from the command line.  The terminal/shell that you use for command line access will alter the syntax of your docker commands.

For simplicity, this tutorial will document the syntax needed for each of the following shell environments. 
- ### Linux and MacOS --> Use Bash Shell
- ### Windows 10 --> Use Git-Bash
  - If you run GitHub for windows, there is an option to enable the "Git Bash" shell.  ([Screenshot: git-bash options](git-bash.png))
  - This shell environment was chosen because it is the most similar to the Bash shell environment.
  - Otherwise, you can [install Git-Bash](https://git-scm.com/downloads).

## Running a Docker Image

The docker __run__ command starts a docker container using a published or compiled docker image.  
- The __--rm__ option will clean up container resources when the process completes.

Published images can be discovered on [Docker Hub](https://hub.docker.com/explore/).

### Example: List the contents of the root directory
The following command will list the root directory (`ls -l`) for the [ubuntu](https://hub.docker.com/_/ubuntu/) linux image.

#### Bash
```
docker run --rm ubuntu ls /
```

#### Git-Bash Windows

The Git Bash Shell attempts to convert a starting slash to a windows host directory.  Use a double slash if you are running in Git Bash.  
```
docker run --rm ubuntu ls //
```

### Example: Run a bash shell on ubuntu
The following command will run a bash shell on ubnuntu.  This requires terminal input/output; therefore the command is run with the __-it__ option.

#### Bash
```
docker run -it --rm ubuntu /bin/bash
```

#### Git-Bash Windows

The Git Bash Shell attempts to convert a starting slash to a windows host directory.  Use a double slash if you are running in Git Bash.  
In order to interact with the terminal from Git-Bash, you must prefix the command with `winpty`.

```
winpty docker run -it --rm ubuntu //bin/bash
```

## Executing a process within a running container

The docker __run__ command starts a docker container using a specific image.
- The __-d__ option detaches the running process from the current window.
- The __--name__ option assigns a name to the running container (making subsequent commands easier to perform)

### Example: run tomcat within docker
The following command will start a [tomcat](https://hub.docker.com/_/tomcat/) server within docker.
```
docker run --name myContainer -d tomcat
```

#### View the running process

```
$ docker ps -a
```

Note the name of the container that is running.
```
CONTAINER ID        IMAGE                             COMMAND                  CREATED             STATUS              PORTS                              NAMES
de1eac490eae        tomcat                            "catalina.sh run"        9 minutes ago       Up 9 minutes        8080/tcp                           myContainer
```

#### Execute a command within the container

The docker __exec__ command runs a command within an running container.

```
docker exec myContainer pwd
```

#### Stop the container

```
docker stop myContainer
```

If you run `docker ps -a` you will see that the container is stopped.

#### Remove the container

```
docker rm myContainer
```

## Setting Environment Variables
This tutorial will focus on the syntax for Bash on Linux/MacOS and Git-Bash on Windows 10.

It is possible to run docker using an alternative shell.  Some commands will require a variation in the syntax if you are using an alternate shell.

Set FOO to BAR
- MacOS or bash: `export FOO=BAR`
- Windows CMD: `set FOO=BAR`
- Windows Powershell: ???

Set DSPACE_SRC to current directory
- MacOS or bash: `export DSPACE_SRC=$(pwd)`
- Windows CMD: `set DSPACE_SRC=%cd%`
- Windows Powershell: ???
