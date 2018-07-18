# Running DSpace with Docker compose

## 1. Pre-requisites

- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.
  - master, dspace-6_x, dspace-6.3, dspace-5.9, dspace-4.9
- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version)
  - d7, d6, d5, d4
- Set the environment variable **AIP_DIR** to the directory containing your AIP files.
  - A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).
- Set the environment variable **INGEST_TOOLS** to the **[mount_ingest_tools](../../add-ons/mount_ingest_tools)** folder within this project.

## 2. Using Docker Compose

- cd to the **dspace-ingest-compose** directory

Run Docker compose
_In the following example, "d6" is being passed as a "compose project name".  This will be used to prefix the name of the network and volumes created by Docker.  This will permit you to maintain multiple variants of a DSpace install (ie DSpace 5 and DSpace 6)._

_If a compose project is already running, stop it first with `dspace-compose -p d6 stop`._

```
docker-compose -p $DPROJ up -d
```

## 2. Configuring DSpace Admin and Content

#### Use the tomcat bash terminal to configure the DSpace administrator

```
docker exec ${DPROJ}_dspace_1 //ingest-tools/createAdmin.sh
docker exec ${DPROJ}_dspace_1 //ingest-tools/ingestAIP.sh
```

#### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

```
docker exec ${DPROJ}_dspacedb_1 psql -U dspace -f //ingest-tools/updateSequences.sql
```

## 3. Open DSpace in a Browser
- DSpace 5 or 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## 4. Stopping DSpace

```
docker-compose -p $DPROJ stop
```
