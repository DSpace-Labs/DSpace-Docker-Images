# Running DSpace7 (Angular + REST) with Docker compose

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)
- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.

```
export DSPACE_VER=master
```

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.

```
export DPROJ=d7
```

## 2. Using Docker Compose

- cd to the **dspace-compose** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 3 containers: (1) database (2) tomcat - REST (3) Node - Angular. 

## 3. Accessing the command line

#### Bash
```
docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspace_1 /bin/bash
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspace_1 //bin/bash
```

Bash Command
```
/dspace/bin/dspace version
```

## 4. Open DSpace in a Browser
- DSpace 7 REST: [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)
- DSpace 7 UI: [http://localhost:3000](http://localhost:3000)

## 5. Stopping DSpace
To stop DSpace, the following command can be run.  The image will be retained in a stopped state.
```
docker-compose -p $DPROJ stop
```

You can destroy the images with the following command.  This command will be necessary to run if you change the compose file that you are using.

```
docker-compose -p $DPROJ down
```

After stopping or destroying your instances, note that the volumes have persisted.
- The ${DPROJ}_dspace volume contains the contents of your [dspace-install] directory
- The ${DPROJ}_pgdata contains the contents of your database


```
docker volume ls
```

Sample Output
```
DRIVER              VOLUME NAME
local               269bb301cec95f0bcb1c6f0b5e0947c33308d59628185856eb727a08f654980e
local               d6_dspace
local               d6_pgdata
```

## 6. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

```
docker-compose -p $DPROJ up -d
```

## 7. Destroying Docker Resources
If you no longer need to retain your Docker volumes, run  the following commands.

```
docker-compose -p $DPROJ down
```

```
docker volume rm ${DPROJ}_dspace_1 ${DPROJ}_pgdata_1
```
