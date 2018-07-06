# Running DSpace with Docker compose

## 1. Pre-requisites
- [Setup](../tutorialSetup.md)
- [Building DSpace](../tutorialBuild.md)
- Make sure that the environment variable **DSPACE_SRC** is set to the directory containing your cloned DSpace repo

## 2: Using Docker Compose

- cd to the **dspace-dev-compose** directory

Run Docker compose
_In the following example, "d6" is being passed as a "compose project name".  This will be used to prefix the name of the network and volumes created by Docker.  This will permit you to maintain multiple variants of a DSpace install (ie DSpace 5 and DSpace 6)._

    docker-compose -p d6 up -d

### Deploy DSpace

    docker exec -w /dspace-src/dspace/target/dspace-installer  d6_dspace_1 ant update clean_backups

If necessary, you can start and stop tomcat with the following commands.

    docker-compose -p d6 restart

## 3. Accessing the command line

    docker exec -it --detach-keys "ctrl-p" d6_dspace_1 /bin/bash

Bash Command
```
/dspace/bin/dspace version
```

## 4. Open DSpace in a Browser
- DSpace 5 or 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## 5. Stopping DSpace

    docker-compose -p d6 stop

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

    docker-compose -p d6 start

## 7. Ingest content
To ingest content into this DSpace instance see [dspace-ingest-compose](../dspace-ingest-compose).

This compose file will hep you to ingest content into the docker volumes that you just created.
