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

    docker run -it -d --network dspacenet -p 5432:5432 --name dspacedb -v pgdataD6:/var/lib/postgresql/data dspace/dspace-postgres-pgcrypto

_Attach to the database server to query directly_

    docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace

## Create DSpace Deployment
_This volume will persist the DSpace assetstore and solr content between runs_

    docker volume create dspaceD6

### Deploy/install DSpace_

#### Windows Flavor

    docker run -it --rm --network dspacenet -v ${PWD}/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer terrywbrady/dspace-docker-ant ant update clean_backups

#### MacOS Flavor

    docker run -it --rm --network dspacenet -v "$(pwd)"/dspace/target/dspace-installer:/installer -v dspaceD6:/dspace -w /installer terrywbrady/dspace-docker-ant ant update clean_backups

### Start tomcat 

    docker run -it --network dspacenet -v dspaceD6:/dspace -p 8080:8080 --name dspacetomcat -e DSPACE_INSTALL=/dspace dspace/dspace-tomcat

#### Attach to tomcat directly to run dspace commands (/dspace/bin/dspace)

    docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash

## Open in a Browser
- DSpace 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## Using the docker-compose.yml file
_This is not yet working -- under development_

    docker-compose up -d
