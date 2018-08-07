{% include nav.html %}
# Setting Up DSpace on Docker

## Install Docker
- [Docker Install](https://docs.docker.com/install/)

### GitHub for windows
In GitHub for Windows, you can set your default shell to "Git Bash".  ([Screenshot: git-bash options](git-bash.png))

### Shell Variations
If you are running Docker from Windows, some actions will vary based on the shell that you are using.  Notes about these variations are described below.

## Running a Docker Image

The docker __run__ command starts a docker container using a specific image.
- The __-it__ option enables terminal output.
- The __--rm__ option will clean up container resources when the process completes.

### Example: List the contents of the root directory
The following command will list the root directory for a container.

The [ubuntu](https://hub.docker.com/_/ubuntu/) linux image will be used in this example.

#### Bash
```
docker run -it --rm ubuntu ls /
```

#### Git-Bash Windows

The Git Bash Shell attempts to convert a starting slash to a windows host directory.  Use a double slash if you are running in Git Bash.  If you expect to see command line output from a docker command, prefix the command with `winpty`.

```
winpty docker run -it --rm ubuntu ls //
```

## Executing a process within a running container

The docker __run__ command starts a docker container using a specific image.
- The __-d__ option detaches the running process from the current window.
- The __--name__ option assigns a name to the running container (making subsequent commands easier to perform)

### Example: run tomcat within docker
The following command will start a [tomcat](https://hub.docker.com/_/tomcat/) server within docker.
```
docker run --name myContainer tomcat
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
