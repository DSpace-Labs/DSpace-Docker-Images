# DSpace-Docker-Images
Repository for developing and managing published Docker images (https://hub.docker.com/u/dspace/) for DSpace development

__This project is under development__

__Note: These images are intended for DSpace development purposes and are not appropriate for production use.__

## DSpace Docker Overview
![Diagram](documentation/DSpaceDocker.jpg)

## Tutorials

- [Running DSpace with Docker Compose](dspace-compose/README.md)
- [Building and Running DSpace with Docker Compose](dspace-dev-compose/README.md)
- [Manually deploying DSpace with Docker](tutorial.md)

## Images
- Recommended Published images (on Dockerhub)
  - [dspace/dspace-postgres-pgcrypto](dspace-postgres-pgcrypto)
    - Postgres image for DSpace 6+.  Also suitable for DSpace 5.
  - [dspace/dspace-tomcat](dspace-tomcat)
    - Tomcat + Ant image configured for DSpace
    - Requires an ant deploy to become usable (otherwise tomcat will start with no DSpace webapps).  User must mount DSPACE_SRC in order to deploy.
  - [dspace/dspace](dspace)
    - Tomcat + Ant with populated dspace-install directory
    - DSpace code will be cloned and built during image build
    - Image contains local.cfg and build.properties file suitable for the container.
- Other Published images (on Dockerhub)
  - [dspace/dspace-codenvy-tomcat](dspace-codenvy-tomcat)
    - DSpace image configured for the constraints of the Codenvy Service
- Images Under Development
  - [dspace/dspace-janitor-angular](dspace-janitor-angular)
    - Configured for use with the Janitor framework
  - [dspace-angular-dev](dspace-angular-dev)
- Planned images
  - dspace-oracle
- Planned compose configurations
  - dspace-compose-ingest
    - Compose file designed to facilitate the ingest of AIP files into Docker volumes
  - dspace7-compose
    - Compose file designed to run the angular UI and DSpace 7 backend components

## More information
For more information, join our [#dspace-docker Slack channel](https://dspace-org.slack.com/messages/C9YD42PV3).
