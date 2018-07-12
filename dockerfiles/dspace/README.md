In order to build this, you must start the database

    --network dspacenetwork --name dspacedb dspace/dspace-postgres-pgcrypto

```
docker volume create dspacedbvol
docker network create dspacenetwork

docker run -it -d --network dspacenetwork --name dspacedb -v dspacedbvol:/pgdata -e PGDATA=/pgdata dspace/dspace-postgres-pgcrypto
```

Build the dspace docker

```
docker build .  --network dspacenetwork -t dspace/dspace6:dspace-6_x
```
