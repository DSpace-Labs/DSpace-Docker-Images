# DSpace-Docker-Images

This repository contains docker resources for the [DSpace](https://dspace.org) project.
- Docker Compose files for DSpace 4x and 5x
- Special purpose Docker Compose and Dockerfiles for DSpace
- Tutorials for running DSpace with Docker and Docker Compose

References
- [Docker](https://docs.docker.com/get-started/) simplifies the installation requirements for hosting an application by running an application image (_docker image_) within a containerized environment (_docker container_).
- [Docker Hub](https://dockerhub.com) is a registry of published application images.
- The DSpace project has published a set of [DSpace Images on DockerHub](https://hub.docker.com/r/dspace/dspace) to simplify testing and development of the DSpace platform.
  - The project has automated the build of Docker Images for each of the supported branches of the DSpace code base ([build details](https://hub.docker.com/r/dspace/dspace/builds/)).
- A [Docker compose](https://docs.docker.com/compose/overview/) file is used to orchestrate the launch of interdependent containers.  
  - For DSpace 4, 5 and 6, those containers are the database and tomcat (xmlui, jspui)
  - For DSpace 7, the containers are the database, tomcat (for the REST api), and Node (running the Angular UI)
- The Docker compose file manages the allocation of _docker volumes_ which persist the contents of the DSpace database and the DSpace assetstore.

## Why Publish DSpace Images for Docker?
- To enable users (developers and repository mangagers) to easily test the latest code from each of the supported branches of DSpace
- To enable users (developers and repository mangagers) to easily test the code from each published release of DSpace
- To simplify the installation requirements for developers wishing to contribute code to the DSpace platform
- To simplify the management of multiple versions of DSpace (DSpace 5, 6, and 7) on a user's desktop
- To simplify the management of applicaiton dependencies for DSpace 7 (database, REST API, Angular UI) on a user's desktop
-  __Note: These images are intended for DSpace development purposes and are not appropriate for production use.__

## Workshops

  - [DuraSpace Webinar: DSpace Docker for Repository Managers: Running Any Version of DSpace from your Desktop](documentation/webinar/webinar.md)
  - [Open Repositories 2019: Docker for DSpace – Lowering the Barrier of Entry for New Contributors](documentation/workshop/info.md)

## Tutorials

- [Setting Up Docker](documentation/tutorialSetup.md)
  - [Common Tasks after Start Up](documentation/run.CommonTasks.md)
- [Running DSpace with Docker Compose](docker-compose-files/dspace-compose/README.md)
  - [Docker Compose Configuration Options for Optional DSpace Services](docker-compose-files/dspace-compose/ComposeFiles.md)
- [Creating automated builds for your DSpace contributions](documentation/forkBuild.md)

## References
- [DSpace 7 Preview Release Setup](documentation/run.DSpace7Entities.md)

---

## Docker Images
This table lists the special purpose docker images supported by the DSpace project.  

| Image Name | Repo | Dockerfile | Branches | Comments |
| ---------- | ---- | ---------- | -------- | -------- |
| dspace/dspace-dependencies | DSpace/DSpace | 4-7 | Dockerfile.dependencies | Base image that optimizes the build of DSpace images by caching maven downloads |
| dspace/dspace | DSpace/DSpace | Dockerfile.* | 4-7 |Docker web app container |
| dspace/dspace-cli | DSpace/DSpace | Dockerfile.cli.* | 6-7 |Docker CLI container |
| dspace/dspace-postgres-pgcrypto:latest | DSpace/DSpace | 5-7 | dspace/src/main/docker/dspace-postgres-pgcrypto/Dockefile | Database container |
| dspace/dspace-postgres-pgcrypto:loadsql | DSpace/DSpace | 5-7 | dspace/src/main/docker/dspace-postgres-pgcrypto-curl/Dockefile | Database container that downloads and ingests a SQL dump |
| dspace/dspace-postgres-4x | DSpace-Labs/DSpace-Docker-Images | 4 | dockerfiles/dspace-postgres-4x/Dockefile | Database container |
| dspace/dspace-solr | DSpace/DSpace | dspace/src/main/docker/solr/Dockerfile | 7 | Standalone SOLR instance with DSpace schemas loaded |
| dspace/dspace-angular | DSpace/DSpace-angular | Dockerfile | 7 | Angular UI |

## Compose files
The following Docker Compose files can be used to simplify the management of DSpace components allowing a user to run an end-to-end DSpace instance from their desktop.

| Version | Scenario | Repo | Command line | Comments |
| ------- | -------- | ---- | ------------ | -------- |
| 7x REST    | Run published images | DSpace/DSpace | `docker-compose -p d7 up -d` | |
| 7x REST    | Build REST | DSpace/DSpace | `docker-compose -p d7 up -d --build` | |
| 7x UI+REST | Run published images | DSpace/DSpace | `docker-compose -p d7 -f docker-compose.yml -f dspace/src/main/docker-compose/docker-compose-angular.yml up -d` | Can be run from DSpace or DSpace-angular |
| 7x UI+REST | Run published images | DSpace/DSpace-angular | `docker-compose -p d7 -f docker-compose.yml -f docker/docker-compose-rest.yml up -d` | Can be run from DSpace or DSpace-angular |
| 7x UI+REST | Build REST | DSpace/DSpace | `docker-compose -p d7 -f docker-compose.yml -f dspace/src/main/docker-compose/docker-compose-angular.yml up -d` |  |
| 7x UI+REST | Build Angular | DSpace/DSpace-angular | `docker-compose -p d7 -f docker-compose.yml -f docker/docker-compose-rest.yml up -d --build` |  |
| 7x UI+REST | Build REST Angular | DSpace/DSpace| `docker-compose -p d7 up -d --build` | 2 step process |
|            |                    | DSpace/DSpace-angular | `docker-compose -p d7 up -d --build` | 2 step process |
| 6x         | Run published images | DSpace/DSpace | `docker-compose -p d6 up -d` | |
| 6x         | Build images | DSpace/DSpace | `docker-compose -p d6 up -d --build` | |
| 5x         | Run published images | DSpace-Labs/DSpace-Docker-Images : docker-compose-files/dspace-compose | `docker-compose -p d5 -f docker-compose.yml -f d5.override.yml up -d` | |
| 5x         | Build images | DSpace-Labs/DSpace-Docker-Images : docker-compose-files/dspace-compose | `docker-compose -p d5 -f docker-compose.yml -f d5.override.yml -f src.override.yml up -d --build` | |
| 4x         | Run published images | DSpace-Labs/DSpace-Docker-Images : docker-compose-files/dspace-compose | `docker-compose -p d4 -f docker-compose.yml -f d4.override.yml up -d` | |
| 4x         | Build images | DSpace-Labs/DSpace-Docker-Images : docker-compose-files/dspace-compose | `docker-compose -p d4 -f docker-compose.yml -f d4.override.yml -f src.override.yml up -d --build` | |
| Other | Special Cases | DSpace-Labs/DSpace-Docker-Images : docker-compose-files/dspace-compose | See [Special Cases](docker-compose-files/dspace-compose/ComposeFiles.md) | |


### Main DSpace Compose Files
[DSpace Compose Files](docker-compose-files/dspace-compose/ComposeFiles.md)
- Base DSpace Compose File: docker-compose.yml
- DSpace 7 Compose File: d7.override.yml
- DSpace 6 Compose File: d6.override.yml
- DSpace 5 Compose File: d5.override.yml
- DSpace 4 Compose File: d4.override.yml
- DSpace RDF Compose File: rdf.override.yml
- Oracle Compose File: oracle.override.yml
- DSpace Local Build Compose File: src.override.yml

### Special Purpose Compose files

| Compose File | Host  | Image | Notes |
| ------------ | ----- | ----- | ----- |
| | dspace-angular | dspace/dspace-angular-bare   | |
| | dspacedb | atmire/dspace-oracle            | |
| | dspace   | dspace/dspace                   | ||


---

## More information
For more information, join our [#dspace-docker channel](https://dspace-org.slack.com/messages/C9YD42PV3) on
[Dspace Slack](https://wiki.duraspace.org/display/DSPACE/Slack).

[DSpace Docker Wiki Page](https://wiki.duraspace.org/display/DSPACE/DSpace+and+Docker)
