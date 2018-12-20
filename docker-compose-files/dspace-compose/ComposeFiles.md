## Proposed Changes to Docker Compose Startup

| Compose File | Purpose |
| -- | -- |
| docker-compose.yml | Base image for DSpace 4, 5, 6, 7.  Ingests content (if needed) and starts tomcat. |
| d4.override.yml | Sets base image for DSpace4x.  <br/>Since Flyway is not supported in DSpace4x, a special 4x postgres image. |
| d5.override.yml | Sets base image for DSpace5x.  Activates Mirage2. |
| d6.override.yml | Sets base image for DSpace6x.  Activates Mirage2. |
| d7.override.yml | Sets base image for DSpace7x.  <br/>Adds Angular UI to replace XMLUI and JSPUI. <br/>TBD: Add externalized SOLR service<br/> REST: http://localhost:8080/spring-rest <br/> Angular UI: http://localhost:3000 |
| src.override.yml | Optional add-on to trigger and redeploy and tomcat start. |
| rdf.override.yml | Optional RDF Add-on for DSpace6x and DSpace7x. <br/>http://localhost:3030 |

## Basic Startup Commands

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
docker-compose -p d5 -f docker-compose.yml -f d5.override.yml up -d
docker-compose -p d4 -f docker-compose.yml -f d4.override.yml up -d
```

### Override the default branch/pr to use.

Each compose file points to a specific [tagged DSpace Docker image](https://hub.docker.com/r/dspace/dspace/tags).
- Set the DOCKER_OWNER environment variable to change the dockerhub repository
- Set the DSPACE_VER environment variable to change the DSpace tagged version
- Set the AIPZIP environment variable to point to a zip file of AIP files that will be ingested on startup.
  - After ingest, `/dspace/assetstore/ingest.hasrun.flag` will be created.  This will prevent additional ingest on subsequent startup.

## Trigger ant re-deploy
Set DSPACE_SRC to your source branch.  Run `mvn package` locally.

Add `-f src.override.yml` to your startup command to trigger an ant re-deploy.

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml restart
```

## Add the RDF Service (DSpace6 and DSpace7)

Add `-f rdf.override.yml` to add an RDF Triplestore to your DSpace distribution.

#### Create Dataset in the RDF Triplestore (fuseki)
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

#### View Metadata via the RDF service

- http://localhost:8080/rdf/handle/123456789/1/rdf?text=true
