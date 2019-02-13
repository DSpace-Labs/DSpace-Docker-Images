{% include nav.html %}
# Running DSpace with Docker compose

[![Demonstration Video](https://i.ytimg.com/vi/ovJ8sJk1Apg/hqdefault.jpg)](https://www.youtube.com/watch?v=ovJ8sJk1Apg)

## 1. Pre-requisites

See [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md).

For purposes of this tutorial, the latest changes to the DSpace 6x branch will be used.  See [Compose File Options](ComposeFiles.md) available.

## 2. Using Docker Compose

- cd to the **[dspace-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/dspace-compose)** directory

Run Docker compose

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

This will start 2 containers: (1) dspacedb - postgres (2) dspace - tomcat.

The `-p d6` argument creates a "project" named d6.  This will create project-specific volumes that can be isolated from other run configurations.  

If a different version of DSpace (DSpace 5, DSpace 7) is started, a different project name should be used.  As currently designed, only one version of DSpace can be running at a time because each version uses the same port numbers and container names.
```
$ docker ps -a
CONTAINER ID        IMAGE                             COMMAND                  CREATED              STATUS              PORTS                              NAMES
98677e1cde3b        dspace/dspace:dspace-6_x          "catalina.sh run"        About a minute ago   Up About a minute   8009/tcp, 0.0.0.0:8080->8080/tcp   dspace
5186cf451eff        dspace/dspace-postgres-pgcrypto   "docker-entrypoint.s…"   About a minute ago   Up About a minute   5432/tcp                           dspacedb
```

The dspace container and the dspacedb container will persist data in a docker volume.  Each Solr repository will be saved to a docker volume.

```
$ docker volume ls -f "label=com.docker.compose.project=d6"
DRIVER              VOLUME NAME
local               d6_assetstore
local               d6_pgdata
local               d6_solr_authority
local               d6_solr_oai
local               d6_solr_search
local               d6_solr_statistics
```

### 2a. Passing Variables and Properties to DSpace

DSpace uses Apache Commons Config to access runtime properties.  Values can be passed to Apache commons through the dspace.cfg file, the local.cfg file, as system properties (-Ddspace.name=Foo), and as environment variables.

Note that enviroment variables containing dots in their names are not supported by some Linux shells.  While it is possible to pass an ENV variable (`-e dspace.name=Foo`) through docker run or Docker Compose, that value will not propagate to the DSpace runtime becuase the underlying shell will reject the variable name.

If you need to set a property name that contains a period, the recommended approach is to pass the override as a system property set in JAVA_OPTS.  `-e JAVA_OPTS=-Ddspace.name=Foo`.

## 3. Verify Install

### 3a. Verify DSpace Version

#### Bash
```
docker exec -it dspace /dspace/bin/dspace version
```

#### Git-Bash Windows
```
winpty docker exec -it dspace //dspace/bin/dspace version
```

### 3b. Verify Database Schema

#### Bash
```
docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

#### Git-Bash Windows
```
winpty docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

## 4. Accessing the Command Line

### 4a. Tomcat

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspace /bin/bash
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspace //bin/bash
```

Bash Command
```
/dspace/bin/dspace version
```

### Database

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

## 5. Open DSpace in a Browser
- DSpace 5 or 6: [http://localhost:8080/xmlui](http://localhost:8080/xmlui)
- DSpace 7: [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)

## 6. Stopping DSpace
To stop DSpace, the following command can be run.  The containers will be retained in a stopped state.
Any code or configuration changes that you made to your containers will be retained.
```
docker-compose -p d6 stop
```

You can destroy the images with the following command.  Any code changes that you have made within the containers will be lost.
The code directories will be refreshed from the docker images on recreation.  
Note that the contents of the assetstore, database, and solr repositories will be persisted as docker volumes.

```
docker-compose -p d6 down
```

After stopping or destroying your instances, note that the volumes have persisted.
```
$ docker volume ls -f "label=com.docker.compose.project=d6"
DRIVER              VOLUME NAME
local               d6_assetstore
local               d6_pgdata
local               d6_solr_authority
local               d6_solr_oai
local               d6_solr_search
local               d6_solr_statistics
```

## 7. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

```
docker-compose -p d6 up -d
```

## 8. Updating code within an image

To deploy new code within your image, see [trigger ant redeploy](ComposeFiles.md#trigger-ant-re-deploy).

### Note: Switching Compose File Settings
Remember that you will need to run the following command if you use an alternate compose file.  When you recreate the images, your volume content will be retained.
```
docker-compose -p d6 down
```

## 9. Destroying Docker Resources
If you no longer need to retain your Docker volumes, run  the following commands.

```
docker volume rm d6_assetstore d6_pgdata d6_solr_authority d6_solr_oai d6_solr_search d6_solr_statistics
```
A helper script exists in this repository to remove volumes.

```
../../removeVols.sh d6
```
