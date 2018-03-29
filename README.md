# DSpace-Docker-Images
Repository for developing and managing published Docker images (https://hub.docker.com/u/dspace/) for DSpace development

__This project is under development__

## Planned Images

- dspace-postgres-pgcrypto
  - built from the postgres image.  
  - Data is persisted by setting env PGDATA.
  - Includes pgcrypto (for DSpace 6 or later)
- dspace-oracle
- dspace-tomcat
  - built on image with java, maven, tomcat
  - ant is added
  - has assumptions based on env DSPACE_INSTALL
- dspace-dev
  - Optimized for rapid build/test

### Service Specific Images
- dspace-codenvy-tomcat
- dspace-janitor

## Planned Docker Compose Configurations

- Could we build an image with dspace-install already populated and ready to go?

## Other Ideas

## More information
For more information, join our [#dspace-docker Slack channel](https://dspace-org.slack.com/messages/C9YD42PV3).
