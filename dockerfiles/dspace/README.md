
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
docker exrun --rm --network dspace-build dspace/dspace:master /dspace/bin/dspace version
```

#### DSpace 6.3
```
docker build .  --build-arg DSPACE_BRANCH=dspace-6.3 --network dspace-build -t dspace/dspace:dspace-6.3 --no-cache
```

You can verify the version after your build by Running
```
docker exrun --rm --network dspace-build dspace/dspace:dspace-6.3 /dspace/bin/dspace version
```

#### DSpace 5.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-5.9 --network dspace-build -t dspace/dspace:dspace-5.9 --no-cache
```

You can verify the version after your build by Running
```
docker run --rm --network dspace-build dspace/dspace:dspace-5.9 /dspace/bin/dspace version
```
#### DSpace 4.9
```
docker build .  --build-arg DSPACE_BRANCH=dspace-4.9 --build-arg TARGET_DIR=dspace-build --network dspace-build -t dspace/dspace:dspace-4.9 --no-cache
```

You can verify the version after your build by Running
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
