NOTE: This code will more to DSpace/DSpace
- https://github.com/DSpace/DSpace/pull/2134 - 6x 
- https://github.com/DSpace/DSpace/pull/2137 - 4x
- https://github.com/DSpace/DSpace/pull/2136 - 5x 
- https://github.com/DSpace/DSpace/pull/2135 - 7x 


## Configure the Build Environment
In order to build this, you must start the database

```
docker network create dspace-build
docker run -it -d --network dspace-build --name dspacedb dspace/dspace-postgres-pgcrypto
```

Build dspace docker (note dspace-6_x will build by default)

```
docker build .  --network dspace-build -t dspace/dspace:dspace-6_x --no-cache
```

### Building a specific release
To build a specific branch or tag, you can pass in the branch/tag name

#### DSpace master
```
docker build .  --build-arg DSPACE_BRANCH=master --network dspace-build -t dspace/dspace:master --no-cache
```

You can verify the version after your build by Running
```
docker run --rm --network dspace-build dspace/dspace:master /dspace/bin/dspace version
```

#### DSpace 6.3
```
docker build .  --build-arg DSPACE_BRANCH=dspace-6.3 --network dspace-build -t dspace/dspace:dspace-6.3 --no-cache
```

You can verify the version after your build by Running

##### Bash
```
docker run --rm --network dspace-build dspace/dspace:dspace-6.3 /dspace/bin/dspace version
```

##### Git-Bash Windows
```
docker run --rm --network dspace-build dspace/dspace:dspace-6.3 //dspace/bin/dspace version
```

#### DSpace 5.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-5.9 --network dspace-build -t dspace/dspace:dspace-5.9 --no-cache
```

You can verify the version after your build by Running

##### Bash
```
docker run --rm --network dspace-build dspace/dspace:dspace-5.9 /dspace/bin/dspace version
```

##### Git-Bash Windows
```
docker run --rm --network dspace-build dspace/dspace:dspace-5.9 //dspace/bin/dspace version
```

#### DSpace 4.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-4.9 --build-arg TARGET_DIR=dspace-build --network dspace-build -t dspace/dspace:dspace-4.9 --no-cache
```

You can verify the version after your build by Running
##### Bash
```
docker run --rm --network dspace-build dspace/dspace:dspace-4.9 /dspace/bin/dspace version
```

##### Git-Bash Windows
```
docker run --rm --network dspace-build dspace/dspace:dspace-4.9 /dspace/bin/dspace version
```

## Destroy the Build Environment
In order to ensure that your next build starts from a clean environment, remove the components that were created.

```
docker network rm dspace-build
docker stop dspacedb
docker rm dspacedb
```

## Full Build Script (for pushing to Dockerhub)
Note: the docker push step in this script requires admin access to the DSpace repository on Dockerhub.

The images generated when building DSpace images can be quite large.  If multiple versions of DSpace are built, it is possible to exceed the storage allocated for Docker.

To prevent running out of space when building, this process removes all orphan images during the build process.
```
export DTAG=master
export DDIR=dspace-installer
# export DDIR=dspace-build

docker network rm dspace-build
docker stop dspacedb
docker rm dspacedb
docker image prune -f

docker network create dspace-build
docker run -it -d --network dspace-build --name dspacedb dspace/dspace-postgres-pgcrypto

docker build .  --build-arg DSPACE_BRANCH=$DTAG --build-arg TARGET_DIR=$DDIR --network dspace-build -t dspace/dspace:$DTAG --no-cache

docker push dspace/dspace:$DTAG
docker run --rm --network dspace-build dspace/dspace:$DTAG //dspace/bin/dspace version

```
