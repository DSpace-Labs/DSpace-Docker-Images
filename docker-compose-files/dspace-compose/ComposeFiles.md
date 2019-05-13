## Docker Compose Startup Options

| Compose File | Purpose |
| -- | -- |
| docker-compose.yml | Base image for DSpace 4, 5, 6, 7.  Ingests content (if needed) and starts tomcat. |
| d4.override.yml | Sets base image for DSpace4x.  <br/>Since Flyway is not supported in DSpace4x, a special 4x postgres image. |
| d5.override.yml | Sets base image for DSpace5x.  Activates Mirage2. |
| d6.override.yml | Sets base image for DSpace6x.  Activates Mirage2. |
| d7.override.yml | Sets base image for DSpace7x.  <br/>Adds Angular UI to replace XMLUI and JSPUI. <br/> REST: http://localhost:8080/spring-rest <br/> Angular UI: http://localhost:3000 |
| d7.preview.yml  | Sets image name to stable images for the preview release |
| d7solr.override.yml | Adds externalized solr to d7.override.yml <br/> Solr http://localhost:8983 |
| src.override.yml | Optional add-on to trigger and redeploy and tomcat start. |
| rdf.override.yml | Optional RDF Add-on for DSpace6x and DSpace7x. <br/>http://localhost:3030 |
| sword.override.yml | One Webapp: Optional Add-on for enabling and testing the sword and swordv2 services |
| oai.override.yml | One Webapp: Optional Add-on for enabling OAI Service |
| oracle.override.yml | Add-on to run DSpace6x and DSpace7x with Oracle. |
| load.entities.yml | Optional config to load the Entities working group test data into DSpace 7 |

## Basic Startup Commands
_Note: only one compose file should be running at a given time.  
Because each version of DSpace reuses the same ports and container names, you must run `docker-compose -p dX down` to stop one instance before starting another.  Each instance will persist data in a separate volume._

The `docker-compose ... pull` command will ensure that you have the latest version of each Docker image.

The `docker-compose ... up -d` command will start your containers.

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml pull
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d

docker-compose -p d6 -f docker-compose.yml -f d6.override.yml pull
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d

docker-compose -p d5 -f docker-compose.yml -f d5.override.yml pull
docker-compose -p d5 -f docker-compose.yml -f d5.override.yml up -d

docker-compose -p d4 -f docker-compose.yml -f d4.override.yml pull
docker-compose -p d4 -f docker-compose.yml -f d4.override.yml up -d
```

The following command can be used to view the output from a container.  You can specify the container to track.

`docker logs -f dspace`

---

### Override the default branch/pr to use.

Each compose file points to a specific [tagged DSpace Docker image](https://hub.docker.com/r/dspace/dspace/tags).
- Set the DOCKER_OWNER environment variable to change the dockerhub repository
- Set the DSPACE_VER environment variable to change the DSpace tagged version
- Set the AIPZIP environment variable to point to a zip file of AIP files that will be ingested on startup.
  - After ingest, `/dspace/assetstore/ingest.hasrun.flag` will be created.  This will prevent additional ingest on subsequent startup.
- Set the SKIPAIP=Y environment variable to skip AIP processing on startup.

## Build DSpace Image Locally
Adding the `-f src.override.yml` to your startup command will allow you to buid a local image `dspace/dspace:local-build`.

Set DSPACE_SRC to your source directory for DSpace.

Run the build
```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml build
```

10 GB of temporary images will be retained from the build process.  Run the following to free space.
```
docker image prune
```
Start the application with the following command.
```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml up -d
```

---

## Running with Oracle (DSpace6 and DSpace7)

Oracle drivers cannot be distributed within a docker image.  Download a copy of the Oracle ojdbc6.jar from https://www.oracle.com/technetwork/ and set the following variable.
```
export ORADRIVER=<path to your copy of odbc6.jar>
```

Add "-f orace.override.yml" to your docker-compose up command.  As a good practice, use a separate project such as `-p d6ora` to keep your volumes unique from your postgres configurations.

The Oracle container will take a bit of time to initialize.  A delay has been added to the startup script to allocate time for this container to start.

---

## Add the RDF Service (DSpace6 and DSpace7)

Add `-f rdf.override.yml` to add an RDF Triplestore to your DSpace distribution.


#### Create Dataset in the RDF Triplestore (fuseki)

_The initialization script should build the RDF Dataset automatically. _
_The instructions indicate how to build it manually._

- http://localhost:3030
- user: admin
- password: dspace

Create a dataset named **dspace**

#### Build the RDF dataset from the DSpace repository

Bash
```
docker exec -it dspace /dspace/bin/dspace rdfizer -c -v
```

Git-Bash Windows
```
winpty docker exec -it dspace //dspace/bin/dspace rdfizer -c -v
```

### View Metadata via the RDF service

- http://localhost:8080/rdf/handle/123456789/1/rdf?text=true

---
## Test the Sword and Swordv2 Services

See the **tools/sword** directory for a sample zip file to deposit and for the command line calls to force a test of these services.

## Enable the Sword and Swordv2 Services -- [One Webapp PR](https://github.com/DSpace/DSpace/pull/2265)

Add `-f sword.override.yml` to enable the sword and swordv2 services

See the **tools/sword** directory for a sample zip file to deposit and for the command line calls to force a test of these services.

## Enable the OAI Service -- [One Webapp PR](https://github.com/DSpace/DSpace/pull/2265)

Add `-f oai.override.yml` to enable the OAI service

---
## Testing DSpace Entities

A test dataset exists to illustrate the functionality of **DSpace Configurable Entities** .

[Tutorial Instructions](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/runDSpace7Entities.html)

---

## Miscellaneous Notes

### Passing Variables and Properties to DSpace

DSpace uses Apache Commons Config to access runtime properties.  Values can be passed to Apache commons through the dspace.cfg file, the local.cfg file, as system properties (-Ddspace.name=Foo), and as environment variables.

Note that enviroment variables containing dots in their names are not supported by some Linux shells.  While it is possible to pass an ENV variable (`-e dspace.name=Foo`) through docker run or Docker Compose, that value will not propagate to the DSpace runtime becuase the underlying shell will reject the variable name.

If you need to set a property name that contains a period, the recommended approach is to pass the override as a system property set in JAVA_OPTS.  `-e JAVA_OPTS=-Ddspace.name=Foo`.

### Verify DSpace Version

#### Bash
```
docker exec -it dspace /dspace/bin/dspace version
```

#### Git-Bash Windows
```
winpty docker exec -it dspace //dspace/bin/dspace version
```

### Verify Database Schema

#### Bash
```
docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

#### Git-Bash Windows
```
winpty docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

## Accessing the Command Line

### Tomcat

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspace /bin/bash
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspace //bin/bash
```

### Database

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

## Destroying Docker Resources
If you no longer need to retain your Docker volumes, run the following command.  Alter the volume prefix to match your version of DSpace

```
docker volume rm d6_assetstore d6_pgdata d6_solr_authority d6_solr_oai d6_solr_search d6_solr_statistics
```
A helper script exists in this repository to remove volumes.  You will need to save or copy this script in order to run it.

[removeVols script](../../tools/removeVols.md)
