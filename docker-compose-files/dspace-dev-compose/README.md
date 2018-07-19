# Running DSpace with Docker compose

## 1. Building DSpace
See the following pages for instructions on building DSpace from source code.
- [Setup](../../documentation/tutorialSetup.md)
- [Building DSpace](../../documentation/tutorialBuild.md)

## 2. Pre-requisites
- Make sure that the environment variable **DSPACE_SRC** is set to the directory containing your cloned DSpace repo
- Set the environment variable DSPACE_VER to the DSpace image version you would like to use.
  - master, dspace-6_x, dspace-6.3, dspace-5.9, dspace-4.9
- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.
  - d7, d6, d5, d4

## 3: Using Docker Compose

- cd to the **dspace-dev-compose** directory

Run Docker compose

```
export DSPACE_VER=dspace-6_x
```
```
export DPROJ=d6
```
```
export DSPACE_SRC=...
```
```
docker-compose -p ${DPROJ} up -d
```

### Deploy DSpace

#### Bash
```
docker exec -w /dspace-src/dspace/target/dspace-installer  ${DPROJ}_dspace_1 ant update clean_backups
```

#### Git-Bash Windows
```
winpty docker exec -w //dspace-src/dspace/target/dspace-installer  ${DPROJ}_dspace_1 ant update clean_backups
```

If necessary, you can start and stop tomcat with the following commands.

```
docker-compose -p ${DPROJ} restart
```

## 4. Open the DSpace Web App
Confirm that your changes have taken effect.
