## 1. Pre-requisites

### Before cloning the DSpace repo on Windows

    git config --global core.autocrlf false
    git config --global core.eol lf

### DSpace Branch:
- dspace-6_x
- master

### Create local.cfg for the Docker image in the DSpace root directory
_This file is already in the .gitignore file, it is intended to be localized_

- dspace.dir=/dspace
- db.url = jdbc:postgresql://dspacedb:5432/dspace
- dspace.hostname = dspacetomcat
- dspace.baseUrl = http://dspacetomcat:8080

### Note on passing working directory to Docker
- Windows 10 Powershell: ${PWD}
- MacOS: "$(pwd)"

Note: There are 2 options for starting your Docker images.
- Option 1: will build Docker images individually (good for learning)
- Option 2: using Docker Compose (this is easier)
---
## 2A: Option 1: Using the Docker Command


### Create network for our DSpace components

    docker network create dspacenet

### Build DSpace
_It is not necessary to run this step using Docker. The following instructions illustrate how Docker can be used to run Docker._

#### Windows Flavor

    docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v ${PWD}:/opt/maven -w /opt/maven maven mvn clean install

#### MacOS Flavor

    docker run -it --rm -v "$(home)":/root/.m2 -v "$(pwd)":/opt/maven -w /opt/maven maven mvn clean install

### Create DSpace Database
_This volume will persist you database data even if you stop the database server_

    docker volume create pgdataD6

_Start the database service - this must be done before deployment_

    docker run -it -d --network dspacenet --name dspacedb -v pgdataD6:/pgdata -e PGDATA=/pgdata dspace/dspace-postgres-pgcrypto

_Attach to the database server to query directly_

    docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace

### Create DSpace Deployment
_This volume will persist the DSpace assetstore and solr content between runs_

    docker volume create dspaceD6

#### Deploy/install DSpace_

Windows Flavor

    docker run -it --rm --network dspacenet -v ${PWD}/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer dspace/dspace-tomcat ant update clean_backups

MacOS Flavor

    docker run -it --rm --network dspacenet -v "$(pwd)"/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer dspace/dspace-tomcat ant update clean_backups

#### Start tomcat

    docker run -it --network dspacenet -v dspaceD6:/dspace -p 8080:8080 --name dspacetomcat -e DSPACE_INSTALL=/dspace dspace/dspace-tomcat

#### Attach to tomcat directly to run dspace commands in bash (/dspace/bin/dspace)
_Note that ctrl-P is used to terminate the terminal session_

    docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash

---
## 2B: Option 2: Using Docker Compose

Setup
- Set **DSPACE_SRC** to the root directory for your DSpace code.
- Run the maven build
- cd to the **compose-dspace6-postgres** directory

Run Docker compose
_In the following example, "d6" is being passed as a "compose project name".  This will be used to prefix the name of the network and volumes created by Docker.  This will permit you to maintain multiple variants of a DSpace install (ie DSpace 5 and DSpace 6)._

    docker-compose -p d6 up -d

### Deploy DSpace

    docker exec -w /dspace-src/dspace/target/dspace-installer  d6_dspacetomcat_1 ant update clean_backups

If necessary, you can start and stop tomcat with the following commands.

    docker-compose -p d6 restart
---
## 3. Configuring DSpace Admin and Content
_If you started the images with docker-compose, replace the image **dspacetomcat** with the qualified image name such as **D6_dspacetomcat_1**_


#### Use the tomcat bash terminal to configure the DSpace administrator

    docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash

    docker exec -it --detach-keys "ctrl-p" d6_dspacetomcat_1 /bin/bash

Bash Command
```
/dspace/bin/dspace create-administrator -e test@test.edu -f Admin -l User -p admin -c en
```

---
### Load AIP Files into DSpace

Identify a set of AIP files to use for testing.

A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).

#### Copy the AIP files to the Docker Image

In the **dspacetomcat bash terminal**, create an input directory

    mkdir /tmp/testdata

To facilitate the data import, use docker cp.

    docker cp **yourSourceDir** dspacetomcat:/tmp/testdata

    docker cp **yourSourceDir** d6_dspacetomcat_1:/tmp/testdata

#### Load the AIP Files into DSpace

In the bash window created above, run the following command to import data.
```
cd /tmp/testdata
```

```
for file in COMM* COLL* ITEM*;
do
  /dspace/bin/dspace packager -r -t AIP -e test@test.edu -f -u $file
done
```

#### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

    docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace

    docker exec -it --detach-keys "ctrl-p" d6_dspacedb_1 psql -U dspace

SQL
```
SELECT
  setval(
    'handle_seq',
    CAST (
      max(
      to_number(
          regexp_replace(handle, '.*/', ''),
          '999999999999'
        )
      )
      AS BIGINT
    )
  )
FROM handle
WHERE handle SIMILAR TO '%/[0123456789]*';
```

---
## 4. Open DSpace in a Browser
- DSpace 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## 5. Stopping DSpace

If you started the instances with the docker command...

    docker stop dspacetomcat
    docker stop dspacedb

If you started the instances with docker-Compose

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

If you started the instances with the docker command...

    docker start dspacetomcat
    docker start dspacedb

If you started the instances with docker-Compose

    docker-compose -p d6 start
