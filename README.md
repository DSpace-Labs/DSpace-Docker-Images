# DSpace-Docker-Images
Repository for developing and managing published Docker images [https://hub.docker.com/u/dspace/](https://hub.docker.com/u/dspace/) for DSpace development

__Note: These images are intended for DSpace development purposes and are not appropriate for production use.__

## DSpace Docker Overview
![DSpace Docker Overview Diagram](documentation/DSpaceDockerFlow.png)

## Tutorials

- [Running DSpace with Docker Compose](docker-compose-files/dspace-compose/README.md)
- [Building and Running DSpace with Docker Compose](docker-compose-files/dspace-dev-compose/README.md)
- [Ingesting Content into a Docker Container](docker-compose-files/dspace-ingest-compose/README.md)
- [Manually deploying DSpace with Docker](documentation/tutorial.md)

## Published Images

| Image Name | Status | DockerHub | Labels | Compose Files | Comments |
| ---------- | ------ | --------- | ------ | ------------- | -------- |
| [dspace-postgres-pgcrypto](dockerfiles/dspace-postgres-pgcrypto) | Published |  [dspace/dspace-postgres-pgcrypto](https://hub.docker.com/r/dspace/dspace-postgres-pgcrypto/) | latest | dspace-compose <br/><br/>dspace-dev-compose<br/><br/>dspace-ingest-compose | Postgres image for DSpace 6+.  Also suitable for DSpace 5.|
| [dspace-tomcat](dockerfiles/dspace-tomcat) | Published | [dspace/dspace-tomcat](https://hub.docker.com/r/dspace/dspace-tomcat/) | latest |  | Base image for dspace/dspace. <br/>Tomcat + Ant image configured for DSpace. <br/>Requires an ant deploy to become usable (otherwise tomcat will start with no DSpace webapps). <br/> User must mount DSPACE_SRC in order to deploy. |
| [dspace](dockerfiles/dspace) | Not yet published || master<br/><br/>dspace-6_x<br/><br/>dspace-6.3 |dspace-compose <br/><br/>dspace-ingest-compose | Tomcat + Ant with populated dspace-install directory. <br/>DSpace code will be cloned and built during image build. <br/>Image contains local.cfg and build.properties file suitable for the container. |
| [dspace-angular-dev](dockerfiles/dspace-angular-dev) | In progress ||| in project dir | Designed for Angular development, relies on an external REST API |
| dspace-angular | Not yet developed || | dspace7-compose | Containerized Angular UI |
| dspace-oracle | Not yet developed ||| dspace-oracle-compose | For DSpace / Oracle testing |

## Published Images For Cloud Environments
These images have been designed to run in specific cloud environments.

| Image Name | Status | DockerHub | Labels | Compose Files | Comments |
| ---------- | ------ | --------- | ------ | ------------- | -------- |
| [dspace-codenvy-tomcat](dockerfiles/dspace-codenvy-tomcat) |Published|[dspace-codenvy-tomcat](https://hub.docker.com/r/dspace/dspace-codenvy-tomcat/) |latest||Referenced by the [Codenvy service](https://codenvy.io)|
| [dspace-janitor-angular](dockerfiles/dspace-janitor-angular)|Developed||||Referenced by the [Janitor](https://janitor.technology) service]|

## Development Images (Source Code Only)
Developers interested in these images should build them locally.

| Image Name | Status | Compose Files | Comments |
| ---------- | ------ | ------------- | -------- |
| [dspace-angular-dev](dockerfiles/dspace-angular-dev) | In progress | in project dir | Designed for Angular development, relies on an external REST API |


## Compose files

| Compose File | Status | Purpose |
| ------------ | ------ | ------- |
| [dspace-dev-compose](docker-compose-files/dspace-dev-compose) | Developed | Runtime DSpace container.  User will manually deploy code into the container. |
| [dspace-compose](docker-compose-files/dspace-compose) | Developed | Running a pre-built DSpace Image for testing purposes |
| [dspace-ingest-compose](docker-compose-files/dspace-ingest-compose) | Developed |Compose file designed to assist a user with repository configuration and data ingest. |
| dspace7-compose | To be created | Compose file to run the DSpace 7 REST API and Angular UI |
| dspace-oracle-compose | To be created| Compose file for testing DSpace code with Oracle |

## More information
For more information, join our [#dspace-docker Slack channel](https://dspace-org.slack.com/messages/C9YD42PV3).

[DSpace Docker Wiki Page](https://wiki.duraspace.org/display/DSPACE/DSpace+and+Docker)
