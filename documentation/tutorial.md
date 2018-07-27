{% include nav.html %}
# Deploying DSpace to Docker Manually
_This tutorial describes the individual steps for deploying DSpace to Docker using the docker command.  See [dspace-dev-compose](dspace-dev-compose) for an automated setup using Docker compose.  This tutorial is useful for understanding how Docker manages DSpace components._


## Pre-requisites
- [Setting Up Docker for DSpace](tutorialSetup.md)
- [Building DSpace for Docker](tutorialBuild.md)
- Make sure that the environment variable **DSPACE_SRC** is set to the directory containing your cloned DSpace repo

```
export DSPACE_SRC=$(pwd)
```

## Create network for our DSpace components

```
docker network create dspace-demo-net
```

## Create DSpace Database
_This volume will persist you database data even if you stop the database server_

```
docker volume create pgdata-demo
```

_Start the database service - this must be done before deployment_

```
docker run -it -d --network dspace-demo-net --name dspacedb -v pgdata-demo:/pgdata -e PGDATA=/pgdata dspace/dspace-postgres-pgcrypto
```

_Attach to the database server to query directly_

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

## Create DSpace Deployment
_This volume will persist the DSpace assetstore and solr content between runs_

```
docker volume create dspace-demo
```

## Deploy/install DSpace

#### Bash
```
docker run -it --rm --network dspace-demo-net -v ${DSPACE_SRC}:/dspace-src -v dspace-demo:/dspace -w /dspace-src/dspace/target/dspace-installer dspace/dspace-tomcat ant update clean_backups
```

#### Git-Bash Windows
```
winpty docker run -it --rm --network dspace-demo-net -v /${DSPACE_SRC}:/dspace-src -v dspace-demo://dspace -w //dspace-src/dspace/target/dspace-installer dspace/dspace-tomcat ant update clean_backups
```

#### Start tomcat

```
docker run --network dspace-demo-net -v dspace-demo:/dspace -p 8080:8080 --name dspacetomcat -e DSPACE_INSTALL=/dspace dspace/dspace-tomcat
```

#### Attach to tomcat directly to run dspace commands in bash (/dspace/bin/dspace)
_Note that ctrl-P is used to terminate the terminal session_

##### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash
```

##### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacetomcat //bin/bash
```

##### Verify the DSpace version (from the bash window)
```
/dspace/bin/dspace version
```

## 3. Configuring DSpace Admin and Content

### Use the tomcat bash terminal to configure the DSpace administrator

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacetomcat /bin/bash
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacetomcat //bin/bash
```

Bash Command
```
/dspace/bin/dspace create-administrator -e test@test.edu -f Admin -l User -p admin -c en
```

### Load AIP Files into DSpace

Identify a set of AIP files to use for testing.

A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).

#### Copy the AIP files to the Docker Image

In the **dspacetomcat bash terminal**, create an input directory

```
mkdir /tmp/testdata
```

To facilitate the data import, use docker cp.
```
docker cp **yourLocalTestDataDir** dspacetomcat:/tmp/testdata
```

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

### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

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

## 4. Open DSpace in a Browser
- DSpace 5 or 6: [http://localhost:8080/xmlui](http://localhost:8080/xmlui)
- DSpace 7: [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)

## 5. Stopping DSpace

```
docker stop dspacetomcat
docker stop dspacedb
```

## 6. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

```
docker start dspacedb
docker start dspacetomcat
```

## 7. Cleanup

```
docker stop dspacetomcat
docker stop dspacedb
docker rm dspacetomcat
docker rm dspacedb
docker network rm dspace-demo-net
docker volume rm pgdata-demo
docker volume rm dspace-demo
```
