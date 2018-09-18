{% include nav.html %}
# Building DSpace for Docker

If you simply want to run an image of DSpace in Docker, a build is not necessary.  See [Running DSpace with Docker Compose](../docker-compose-files/dspace-compose).

If you want to build a specific branch of DSpace code, you will need to clone the DSpace code base using Git.

## DSpace Development With Git
See [DSpace Development with Git](https://wiki.duraspace.org/display/DSPACE/Development+with+Git) for instructions on using Git with the DSpace code base.

## If you are running Docker for Windows
If you plan to deploy code from Windows into a Docker container, the files that you deploy must have linux-style line endings.

The following settings will force all of your git interactions to use linux-style line endings.

```
git config --global core.autocrlf false
git config --global core.eol lf
```

Warning: these settings may introduce issues when committing resources with Git especially to non-DSpace repositories.  

TODO: Revise this guidance to localize the settings for the DSpace repo.

## Building DSpace with Maven

Before building DSpace, you must configure the local installation properties.  Because we will be deploying DSpace into a known Docker image, you can use a standard local configuration file.

### Configure the __dspace-install__ directory for your Container
When building DSpace, you need to specify the install location and the hostname of the database.

Create [local.cfg](https://github.com/DSpace/DSpace/blob/master/dspace/src/main/docker/local.cfg) for the Docker image in the DSpace root directory.  Because this file is already in the  DSpace .gitignore file, it will not appear as a change in your GitHub repository.

```
dspace.dir=/dspace
db.url = jdbc:postgresql://dspacedb:5432/dspace
dspace.hostname = dspacetomcat
dspace.baseUrl = http://dspacetomcat:8080
```

If you are building DSpace 4 or 5, these changes must be made in the [build.properties](https://github.com/DSpace/DSpace/blob/dspace-5_x/dspace/src/main/docker/build.properties) file

### Building DSpace Using Docker
_It is not necessary to run this step using Docker. The following instructions illustrate how Docker can be used to run Docker._

_If you have maven installed locally, it is probably preferable to run the maven build using your local maven installation._

Set the environment variable **DSPACE_SRC** to the root directory of your cloned DSpace repository.

#### Bash

```
export DSPACE_SRC=$(pwd)
docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v ${DSPACE_SRC}:/opt/maven -w /opt/maven maven mvn clean install
```

#### Git-Bash Windows

```
export DSPACE_SRC=$(pwd)
winpty docker run -it --rm -v ${HOME}/.m2:/root/.m2 -v /${DSPACE_SRC}:/opt/maven -w //opt/maven maven mvn clean install
```

### Building DSpace from Your Desktop

Run the following command from your DSPACE_SRC directory.

```
mvn clean install
```

## Building a Tagged DSpace Image
_This assumes that the PR's associated with [Jira DS-3967](https://jira.duraspace.org/browse/DS-3967) have been merged._

### Branch Build

```
cd $DSPACE_SRC
git checkout myBranch
```

To build the image

```
docker build -t dspace/dspace:myBranch .
```

To push the image to DockerHub (if you have permission)
```
docker push dspace/dspace:myBranch
```

### PR Build

Configure your repo to recognize DSpace pull requests
```
git config --add remote.DSpace.fetch "+refs/pull/*/head:refs/remotes/origin/pr/*"
```

Merge a pull request into a branch of your local repo
```
cd $DSPACE_SRC
git fetch --all

#delete any local changes
git checkout -- .

#pull PR updates
git fetch DSpace

#Get branch to which the PR will be merged
git checkout dspace-6_x
git pull DSpace dspace-6_x
git clean -df

#delete testing branch
git branch -D test-prs

#recreate testing branch
git checkout -b test-prs

git merge origin/pr/XXXX

git build -t dspace/dspace:prXXXX .
```
