In order to build this, you must start the database

```
docker volume create dspacedbvol
docker network create dspacenetwork

docker run -it -d --network dspacenetwork --name dspacedb -v dspacedbvol:/pgdata -e PGDATA=/pgdata dspace/dspace-postgres-pgcrypto
```

Build dspace docker (note dspace-6_x will build by default)

```
docker build .  --network dspacenetwork -t dspace/dspace:dspace-6_x
```

To build a specific branch or tag, you can pass in the branch/tag name

```
docker build .  --build-arg DSPACE_BRANCH=dspace-6.3 --network dspacenetwork -t dspace/dspace:dspace-6.3
```
