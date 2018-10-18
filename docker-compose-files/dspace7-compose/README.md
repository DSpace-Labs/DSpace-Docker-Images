{% include nav.html %}
# Running DSpace7 (Angular + REST) with Docker compose

The DSpace Angular UI has a client (js) and a server component (Node js).  Each component needs to point to the proper REST API.
- js client - the REST api is located on localhost:8080
  - this is defined in environment.dev.js
- Node js server - the REST api is located at dspace:8080
  - this is defined in the docker-compose.yml file

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)
- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.

```
export DSPACE_VER=dspace-7_x-jdk8-test
```

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.

```
export DPROJ=d7
```

## 2. Using Docker Compose

- cd to the **dspace7-compose** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 3 containers: (1) database (2) tomcat - REST (3) Node - Angular.

```
$ docker ps -a
CONTAINER ID        IMAGE                             COMMAND                  CREATED             STATUS              PORTS                                            NAMES
7d6532ef898f        dspace/dspace-angular             "/bin/sh -c 'yarn ru…"   25 seconds ago      Up 24 seconds       0.0.0.0:3000->3000/tcp, 0.0.0.0:9876->9876/tcp   d7_dspace-angular_1
9d2a514f9c38        dspace/dspace:master              "catalina.sh run"        26 seconds ago      Up 24 seconds       8009/tcp, 0.0.0.0:8080->8080/tcp                 d7_dspace_1
d3c80bc6c2e4        dspace/dspace-postgres-pgcrypto   "docker-entrypoint.s…"   26 seconds ago      Up 25 seconds       5432/tcp                                         d7_dspacedb_1
```

The dspace container and the dspacedb container will persist data in a docker volume.

```
$ docker volume ls -f "label=com.docker.compose.project=$DPROJ"
DRIVER              VOLUME NAME
local               d7_assetstore
local               d7_pgdata
local               d7_solr
```

## 3. Accessing the Command Line

### 3a. Tomcat Command Line

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

### 3b. Angular Command Line

#### Bash
```
docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspace-angular_1 /bin/sh
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspace-angular_1 //bin/sh
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

```
$ docker volume ls -f "label=com.docker.compose.project=$DPROJ"
DRIVER              VOLUME NAME
local               d7_assetstore
local               d7_pgdata
local               d7_solr
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
docker volume rm ${DPROJ}_assetstore ${DPROJ}_pgdata ${DPROJ}_solr
```
