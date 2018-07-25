
## Configure the Build Environment

Build dspace docker (note dspace-6_x will build by default)

```
docker build . -t dspace/dspace:dspace-6_x --no-cache
```

### Building a specific release
To build a specific branch or tag, you can pass in the branch/tag name

#### DSpace master
```
docker build .  --build-arg DSPACE_BRANCH=master -t dspace/dspace:master --no-cache
```

#### DSpace 6.3
```
docker build .  --build-arg DSPACE_BRANCH=dspace-6.3 -t dspace/dspace:dspace-6.3 --no-cache
```

#### DSpace 5.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-5.9 -t dspace/dspace:dspace-5.9 --no-cache
```

#### DSpace 4.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-4.9 --build-arg TARGET_DIR=dspace-build -t dspace/dspace:dspace-4.9 --no-cache
```

## Full Build Script (for pushing to Dockerhub)
Note: the docker push step in this script requires admin access to the DSpace repository on Dockerhub.

The images generated when building DSpace images can be quite large.  If multiple versions of DSpace are built, it is possible to exceed the storage allocated for Docker.

To prevent running out of space when building, this process removes all orphan images during the build process.
```
export DTAG=master
export DDIR=dspace-installer
# export DDIR=dspace-build

docker image prune -f

docker build .  --build-arg DSPACE_BRANCH=$DTAG --build-arg TARGET_DIR=$DDIR -t dspace/dspace:$DTAG --no-cache

docker push dspace/dspace:$DTAG
```
