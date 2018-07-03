# Setting Up DSpace on Docker

## Install Docker
- [Docker Install](https://docs.docker.com/install/)

## If you are running Docker for Windows
_You must manage your line endings for files that will be deployed to Docker_

TODO: should this config setting be localized to just the DSpace Repo?

    git config --global core.autocrlf false
    git config --global core.eol lf

## Checkout DSpace Using Git
- dspace-6_x
- master

## Create local.cfg for the Docker image in the DSpace root directory
_This file is already in the .gitignore file, it is intended to be localized_

- dspace.dir=/dspace
- db.url = jdbc:postgresql://dspacedb:5432/dspace
- dspace.hostname = dspacetomcat
- dspace.baseUrl = http://dspacetomcat:8080

If you are building DSpace 5, these changes must be made in the build.properties file

### Note on passing working directory to Docker
- Windows 10 Powershell: ${PWD}
- MacOS: "$(pwd)"
