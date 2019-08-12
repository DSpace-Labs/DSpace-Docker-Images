## Purpose

This is an alternative version of the DSpace Docker Compose files.  

The purpose of this alternate approach is to create more portable Docker orchestration solutions (docker-compose or kubernetes).

These changes depend on the following PR's.  
- https://github.com/DSpace/DSpace/pull/2476
- https://github.com/DSpace/DSpace/pull/2480

The necessary Docker images associated with these PR's have been published as
- dspace/dspace-cli

The following PR for kubernetes may also be instructive.
- https://github.com/DSpace-Labs/DSpace-Docker-Images/pull/140

NOTE: only DSpace 6 and DSpace 7 will be supported by this approach.

## Run DSpace 6x

```
winpty docker-compose -p d6job -f docker-compose.yml -f d6.override.yml up -d
winpty docker-compose -p d6job -f d6.cli.yml -f cli.create-admin.yml run --rm dspace-cli
winpty docker-compose -p d6job -f d6.cli.yml -f cli.ingest.yml run --rm dspace-cli
```

## Run DSpace 7x

```
winpty docker-compose -p d7job -f docker-compose.yml -f d7.override.yml up -d
winpty docker-compose -p d7job -f d7.cli.yml -f cli.create-admin.yml run --rm dspace-cli
winpty docker-compose -p d7job -f d7.cli.yml -f cli.ingest.yml run --rm dspace-cli
```
