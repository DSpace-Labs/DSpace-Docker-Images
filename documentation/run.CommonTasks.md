{% include nav.html %}
## Tasks for running DSpace instances

### Index Content

MacOS/Linux
```shell
docker exec dspace /dspace/bin/dspace index-discovery
```

Windows
```shell
docker exec dspace //dspace/bin/dspace index-discovery
```

### Create an additional admin user
_Note that a default admin is configured when the DSpace instance started._

MacOS/Linux
```shell
docker exec -it dspace /dspace/bin/dspace create-administrator
```

Windows
```shell
winpty docker exec -it dspace //dspace/bin/dspace create-administrator
```

### Filter Media

MacOS/Linux
```shell
docker exec dspace /dspace/bin/dspace filter-media
```

Windows
```shell
docker exec dspace //dspace/bin/dspace filter-media
```

## More Complicated Configuration Tasks

### Start DSpace with a unique set of Docker Volumes

The -p dX parameter is used as a prefix for the volumes that are created.

If you set a value such as -p d6mytest then a unique set of volumes will be created.

It is recommended that you include the DSpace version in your prefix.

### Create a DSpace instance without AIP Content

- export SKIPAIP=Y
- If you plan to re-use existing volumes, delete the existing volumes before starting DSpace
- Start DSpace

### Create a DSpace instance with different AIP content

- Create a zip file containing AIP files.
- export AIPZIP=<url to the zip download>
- If you plan to re-use existing volumes, delete the existing volumes before starting DSpace
- Start DSpace

### Create a DSpace instance with different admin credentials

- Set the following variables as desired
  - export ADMIN_EMAIL=
  - export ADMIN_PASS=
  - export ADMIN_FNAME=
  - export ADMIN_LNAME=
- If you plan to re-use existing volumes, delete the existing volumes before starting DSpace
- Start DSpace

### Run 2 versions of DSpace at the same time

Start DSpace 7 using port 8080

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

Start DSpace 6 using port 8081

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
PORT=8081 docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

## Configuring Memory for DSpace Docker

### Tomcat memory

The JAVA_OPTS variable provided to tomcat is set in the initialization script.  By default, the variable JAVA_MEM is prepended to JAVA_OPTS.

To change the default allocation of `-Xmx2500m`, pass a setting such as `JAVA_MEM=-Xmx4000m` to the dspace container.

### Command line Tasks

The dspace dockerfile is built with a default value `JAVA_OPTS=-Xmx2000m`.  This value will be used when running `docker exec` tasks.

You can override this setting using the following syntax.

`docker exec -it -e JAVA_OPTS=500m dspace /dspace/bin/dspace ...`

## Building DSpace Code

_These instructions are for users who are interested in testing code under active development._

These instructions assume the user will clone the DSpace/DSpace repo for testing purposes.

### Clone DSpace Code

DSpace developers should use their existing DSpace clone (set DSPACE_SRC=<clone dir>) and skip this step.  

```shell
cd
git clone https://github.com/DSpace/DSpace.git
cd DSpace
git fetch --all
git checkout dspace-6_x
export DSPACE_SRC=$(pwd)
```

### Build DSpace Code

Ensure that DSPACE_SRC is set to your local DSpace clone.

Adjust the DSpace version to match the one you want to build.

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml build
```

The build will take several minutes to complete.  Once it has completed, start DSpace.

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml up -d
```

### Build DSpace-angular Code

Ensure that ANGULAR_SRC is set to your local DSpace-angular clone.

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f ang-src.override.yml build
```

The build will take several minutes to complete.  Once it has completed, start DSpace.

```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f ang-src.override.yml up -d
```

### Create a DSpace instance from a DSpace pull request

You need 2 pieces of information
- the BRANCH that this change will be applied to: master, dspace-6_x, dspace-5_x, dspace-4_x
- the PR_NUM

```shell
cd $DSPACE_SRC
git checkout BRANCH --force
curl -o /tmp/pr.patch -L https://github.com/DSpace/DSpace/pull/PR_NUM.diff
git apply /tmp/pr.patch
```

Follow the build instructions above to build the modified code.
