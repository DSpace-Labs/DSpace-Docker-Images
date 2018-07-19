# Running DSpace with Docker compose

## 1. Pre-requisites

- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.
  - master, dspace-6_x, dspace-6.3, dspace-5.9, dspace-4.9
- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.
  - d7, d6, d5, d4
- Set the environment variable **AIP_DIR** to the directory containing your AIP files.
  - A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).
- Set the environment variable **INGEST_TOOLS** to the **[mount_ingest_tools](../../add-ons/mount_ingest_tools)** folder within this project.

## 2. Using Docker Compose

- cd to the **dspace-ingest-compose** directory

Run Docker compose

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

## 4. Stopping DSpace

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