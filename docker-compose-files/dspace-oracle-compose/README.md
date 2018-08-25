
{% include nav.html %}
# Running DSpace + Oracle with Docker compose

Docker compose will enable DSpace developers without a local Oracle installation to test DSpace changes with an Oracle database.

Note: this requires you to download a local copy of Oracle's JDBC client driver file.  That file is not bundled within the DSpace Docker image.

This compose file makes use of Atmire's dspace-oracle Docker image.

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)
- Set the environment variable DSPACE_VER to the [DSpace image version](https://hub.docker.com/r/dspace/dspace/tags/) you would like to use.
  - master, dspace-6_x, dspace-6.3, dspace-5.9, dspace-4.9

```
export DSPACE_VER=dspace-6_x
```

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.
  - d7ora, d6ora, d5ora, d4ora

```
export DPROJ=d6ora
```

- Download a copy of the Oracle ojdbc6.jar from https://www.oracle.com/technetwork/

```
export ORADRIVER=<path to your copy of odbc6.jar>
```

## 2. Using Docker Compose

- cd to the **[dspace-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/dspace-compose)** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 2 containers: (1) oracle database (2) tomcat.

The dspace container and the dspacedb container will persist data in a docker volume.

## 3. Verify Install

### 3a. Verify DSpace Version

#### Bash
```
docker exec -it ${DPROJ}_dspace_1 /dspace/bin/dspace version
```

#### Git-Bash Windows
```
winpty docker exec -it ${DPROJ}_dspace_1 //dspace/bin/dspace version
```

### 3b. Verify Database Schema

#### Bash
```
docker exec -it ${DPROJ}_dspacedb_1 psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

#### Git-Bash Windows
```
winpty docker exec -it ${DPROJ}_dspacedb_1 psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

## 4. Accessing the Command Line

### 4a. Tomcat

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

### Database

#### Bash
```
docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspacedb_1 psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspacedb_1 psql -U dspace
```

## 5. Open DSpace in a Browser
- DSpace 5 or 6: [http://localhost:8080/xmlui](http://localhost:8080/xmlui)
- DSpace 7: [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)

## 6. Stopping DSpace
To stop DSpace, the following command can be run.  The image will be retained in a stopped state.
```
docker-compose -p $DPROJ stop
```

You can destroy the images with the following command.  This command will be necessary to run if you change the compose file that you are using.

```
docker-compose -p $DPROJ down
```

After stopping or destroying your instances, note that the volumes have persisted.

## 7. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

```
docker-compose -p $DPROJ up -d
```

## 8. Ingesting content or updating code within an image
To ingest content into this DSpace instance see [dspace-ingest-compose](../dspace-ingest-compose).  This compose file will help you to ingest content into the docker volumes that you just created.

To deploy new code within your image, see [dspace-dev-compose](../dspace-dev-compose).

### Note: Switching Compose File Settings
Remember that you will need to run the following command if you use an alternate compose file.  When you recreate the images, your volume content will be retained.
```
docker-compose -p $DPROJ down
```

## 9. Destroying Docker Resources
If you no longer need to retain your Docker volumes, run  the following commands.

```
docker volume rm ${DPROJ}_assetstore ${DPROJ}_oracledata ${DPROJ}_solr
```
