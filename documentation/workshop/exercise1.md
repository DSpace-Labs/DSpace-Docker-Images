{% include nav.wkshop.html %}
# Exercise 1: Verify Installation

## Verify Git Install
```shell
git version
```

## Verify Docker Installation

```shell
docker version
```

## Verify Docker Compose Installation
```shell
docker-compose version
```

## Check terminal access to a Docker image
_We will explain these commands in more detail later. Please run each step to verify that your configuration is ready for the later exercises._

Linux or MacOS
```shell
docker run -it --rm ubuntu /bin/bash
```

Windows
```shell
winpty docker run -it --rm ubuntu //bin/bash
```

You will see a different shell prompt in your terminal.  Enter `exit` to exit the shell.

## Verify that you have DSpace Docker Resources Locally

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
git pull
ls
```

Several files should be present.  If you do not see them, revisit the [setup](../tutorialSetup.md) page.

```shell
docker-compose config
```

This will output a screenful of information.  To simplify this output, run the following command.

```shell
docker-compose config | grep container_name
```

You should see the following output

```
    container_name: dspace
    container_name: dspacedb
```

These are the default (DSpace 6 containers that will be started in Docker.)
