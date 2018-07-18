# Running DSpace with Docker compose

## 1. Pre-requisites
- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.
  - master, dspace-6_x, dspace-6.3, dspace-5.9, dspace-4.9
- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version)
  - d7, d6, d5, d4

## 2. Using Docker Compose

- cd to the **dspace-compose** directory

Run Docker compose
_In the following example, "d6" is being passed as a "compose project name".  This will be used to prefix the name of the network and volumes created by Docker.  This will permit you to maintain multiple variants of a DSpace install (ie DSpace 5 and DSpace 6)._

    docker-compose -p $DPROJ up -d

## 3. Accessing the command line

    docker exec -it --detach-keys "ctrl-p" ${DPROJ}_dspace_1 /bin/bash

Bash Command
```
/dspace/bin/dspace version
```

## 4. Open DSpace in a Browser
- DSpace 5 or 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## 5. Stopping DSpace

    docker-compose -p $DPROJ stop

After stopping your instances, note that the volumes have persisted.

    docker volume ls

Sample Output
```
DRIVER              VOLUME NAME
local               269bb301cec95f0bcb1c6f0b5e0947c33308d59628185856eb727a08f654980e
local               d6_dspace
local               d6_pgdata
```

## 6. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

    docker-compose -p $DPROJ up -d

## 7. Ingest content
To ingest content into this DSpace instance see [dspace-ingest-compose](../dspace-ingest-compose).

This compose file will hep you to ingest content into the docker volumes that you just created.
