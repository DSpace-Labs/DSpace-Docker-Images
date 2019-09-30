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
- [Running DSpace 7 (Angular Only) with Docker Compose](docker-compose-files/angular-compose/README.md)
  - [Testing DSpace 7 Angular Code with Docker Compose](docker-compose-files/angular-dev-compose/README.md)
- [Creating automated builds for your DSpace contributions](documentation/forkBuild.md)

## References
- [DSpace 7 Preview Release Setup](documentation/run.DSpace7Entities.md)

---

## Published Images
This table lists the special purpose docker images supported by the DSpace project.  

| Image Name | Status | DockerHub | Sample Labels | Comments |
| ---------- | ------ | --------- | ------------- | -------- |
| [dspace-postgres-4x](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/dockerfiles/dspace-postgres-4x) | Published |  [dspace/dspace-postgres-4x](https://hub.docker.com/r/dspace/dspace-postgres-4x/) | latest | Postgres image for DSpace 4x containing a pre-loaded DSpace 4x schema.|

## Compose files
The following Docker Compose files can be used to simplify the management of DSpace components allowing a user to run an end-to-end DSpace instance from their desktop.

### Main DSpace Compose Files
[DSpace Compose Files](docker-compose-files/dspace-compose/ComposeFiles.md)
- Base DSpace Compose File: docker-compose.yml
- DSpace 7 Compose File: d7.override.yml (d7solr.override.yml - until PR 2058 is merged)
- DSpace 6 Compose File: d6.override.yml
- DSpace 5 Compose File: d5.override.yml
- DSpace 4 Compose File: d4.override.yml
- DSpace RDF Compose File: rdf.override.yml
- Oracle Compose File: oracle.override.yml
- DSpace Local Build Compose File: src.override.yml

### Special Purpose Compose files

| Compose File | Host  | Image | Notes |
| ------------ | ----- | ----- | ----- |
| [angular-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/angular-compose) | | | Compose file to run the DSpace 7 Angular UI with an External REST Service |
| [angular-dev-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/angular-dev-compose) | | | Compose file to develop the DSpace 7 Angular UI with an External REST Service |
| | dspace-angular | dspace/dspace-angular-bare   | |
| | dspacedb | atmire/dspace-oracle            | |
| | dspace   | dspace/dspace                   | ||


---

## More information
For more information, join our [#dspace-docker channel](https://dspace-org.slack.com/messages/C9YD42PV3) on
[Dspace Slack](https://wiki.duraspace.org/display/DSPACE/Slack).

[DSpace Docker Wiki Page](https://wiki.duraspace.org/display/DSPACE/DSpace+and+Docker)
