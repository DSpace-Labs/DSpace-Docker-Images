{% include nav.html %}
# Ingesting Content into DSpace with Docker compose

[![Demonstration Video](https://i.ytimg.com/vi/rdtdLZetZW0/hqdefault.jpg)](https://www.youtube.com/watch?v=rdtdLZetZW0)

## 1. Pre-requisites
- See [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)
- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.

```
export DSPACE_VER=dspace-6_x-jdk8-test
```

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.
  - d7, d6, d5, d4[*](../../documentation/tutorial4x)

```
export DPROJ=d6
```


- Set the environment variable **INGEST_TOOLS** to the **[mount_ingest_tools](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/add-ons/mount_ingest_tools)** folder within this project.

```
export INGEST_TOOLS=../../add-ons/mount_ingest_tools
```

## 2. Using Docker Compose

- cd to the **[dspace-ingest-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/dspace-ingest-compose)** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

## 2. Configuring DSpace Admin and Content

### Use the tomcat bash terminal to configure the DSpace administrator

A sample set is available here https://github.com/DSpace-Labs/AIP-Files.  

You can specify a collection of AIP resources to download for ingest by setting the following variable.

```
export AIPZIP=https://github.com/DSpace-Labs/AIP-Files/raw/master/DogPhotosAIP.zip
```

#### Bash
```
docker exec ${DPROJ}_dspace_1 chmod o+x /ingest-tools/createAdmin.sh
docker exec ${DPROJ}_dspace_1 chmod o+x /ingest-tools/getAIP.sh
docker exec ${DPROJ}_dspace_1 chmod o+x /ingest-tools/ingestAIP.sh
docker exec ${DPROJ}_dspace_1 /ingest-tools/createAdmin.sh
docker exec ${DPROJ}_dspace_1 /ingest-tools/getAIP.sh
docker exec ${DPROJ}_dspace_1 /ingest-tools/ingestAIP.sh
```

#### Git-Bash Windows
```
docker exec ${DPROJ}_dspace_1 //ingest-tools/createAdmin.sh
docker exec ${DPROJ}_dspace_1 //ingest-tools/getAIP.sh
docker exec ${DPROJ}_dspace_1 //ingest-tools/ingestAIP.sh
```

#### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

#### Bash
```
docker exec ${DPROJ}_dspacedb_1 psql -U dspace -f /ingest-tools/updateSequences.sql
```

#### Git-Bash Windows
```
docker exec ${DPROJ}_dspacedb_1 psql -U dspace -f //ingest-tools/updateSequences.sql
```

## 4. Open DSpace in a Browser to View Your content
- DSpace 5 or 6: [http://localhost:8080/xmlui](http://localhost:8080/xmlui)
- DSpace 7: [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)

## 5. Stopping DSpace

```
docker-compose -p $DPROJ stop
```

Now that your data has been loaded, you can use the [dspace-compose](../dspace-compose) file for regular execution of your image.

To deploy new code within your image, see [dspace-dev-compose](../dspace-dev-compose).

### Note: Switching Compose File Settings
Remember that you will need to run the following command if you use an alternate compose file.  When you recreate the images, your volume content will be retained.
```
docker-compose -p $DPROJ down
```
