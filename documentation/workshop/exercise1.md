{% include nav.html %}
# Exercise 1: Verify Instalation

http://bit.ly/dspace-docker

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

```shell
docker run --rm -d --name test tomcat
```

Check that the container is running

```shell
docker ps
```

Connect to the container

Linux or MacOS
```shell
docker exec -it test echo Hello
docker exec -it test ls /
```

Windows Git Bash
```shell
winpty docker exec -it test echo Hello
winpty docker exec -it test ls //
```

Check that the container is running

```shell
docker stop test
```

Check that the container is no longer running

```shell
docker ps
```

## Verify that you have DSpace Docker Resources Locally

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
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
