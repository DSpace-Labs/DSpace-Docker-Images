## Pre-requisites

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

## Note on passing working directory to Docker
- Windows 10 Powershell: ${PWD}
- MacOS: "$(pwd)"

## Create network for our DSpace components

    docker network create dspacenet

## Build DSpace

#### Windows Flavor

    docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v ${PWD}:/opt/maven -w /opt/maven maven mvn clean install

#### MacOS Flavor

    docker run -it --rm -v "$(home)":/root/.m2 -v "$(pwd)":/opt/maven -w /opt/maven maven mvn clean install

## Create DSpace Database
_This volume will persist you database data even if you stop the database server_

    docker volume create pgdataD6

_Start the database service - this must be done before deployment_

    docker run -it -d --network dspacenet --name dspacedb -v pgdataD6:/pgdata -e PGDATA=/pgdata dspace/dspace-postgres-pgcrypto

_Attach to the database server to query directly_

    docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace

## Create DSpace Deployment
_This volume will persist the DSpace assetstore and solr content between runs_

    docker volume create dspaceD6

### Deploy/install DSpace_

#### Windows Flavor

    docker run -it --rm --network dspacenet -v ${PWD}/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer dspace/dspace-tomcat ant update clean_backups

#### MacOS Flavor

    docker run -it --rm --network dspacenet -v "$(pwd)"/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer dspace/dspace-tomcat ant update clean_backups

### Start tomcat

    docker run -it --network dspacenet -v dspaceD6:/dspace -p 8080:8080 --name dspacetomcat -e DSPACE_INSTALL=/dspace dspace/dspace-tomcat

#### Attach to tomcat directly to run dspace commands in bash (/dspace/bin/dspace)
_Note that ctrl-P is used to terminate the terminal session_

    docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash

## Configuring DSpace Admin and Content

#### Use the tomcat bash terminal to configure the DSpace administrator
```
/dspace/bin/dspace create-administrator -e test@test.edu -f Admin -l User -p admin -c en
```

## Load AIP Files into DSpace

Identify a set of AIP files to use for testing.

A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).

### Copy the AIP files to the Docker Image

In the **dspacetomcat bash terminal**, create an input directory

    mkdir /tmp/testdata

To facilitate the data import, use docker cp.

    docker cp **yourSourceDir** dspacetomcat:/tmp/testdata

### Load the AIP Files into DSpace

In the dspacetomcat bash window, run the following command to import data.
```
cd /tmp/testdata
for file in COMM* COLL* ITEM*;
do
  /dspace/bin/dspace packager -r -t AIP -e test@test.edu -f -u $file
done
```

### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

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

## Open in a Browser
- DSpace 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## Using the docker-compose.yml file
_This is not yet working -- under development_

    docker-compose up -d
