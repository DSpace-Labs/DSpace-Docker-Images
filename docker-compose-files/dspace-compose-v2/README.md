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

Start DSpace
```
docker-compose -p d6job -f docker-compose.yml -f d6.override.yml up -d
```
Verify that all components have started
```
winpty docker-compose -p d6job -f d6.cli.yml -f d6.cli.readiness.yml run --rm dspace-cli
```
Create administrative user
```
winpty docker-compose -p d6job -f d6.cli.yml -f cli.create-admin.yml run --rm dspace-cli
```
Load AIP content
```
winpty docker-compose -p d6job -f d6.cli.yml -f cli.ingest.yml run --rm dspace-cli
```

Alternate approach for invoking dspace CLI commands
```
winpty docker-compose -p d6job -f d6.cli.yml run --rm dspace-cli create-administrator
```

Stop DSpace
```
docker-compose -p d6job -f docker-compose.yml -f d6.override.yml down
```

## Run DSpace 7x
Start DSpace
```
docker-compose -p d7job -f docker-compose.yml -f d7.override.yml up -d
```
Verify that all components have started
```
winpty docker-compose -p d7job -f d7.cli.yml -f d7.cli.readiness.yml run --rm dspace-cli
```
Create administrative user
```
winpty docker-compose -p d7job -f d7.cli.yml -f cli.create-admin.yml run --rm dspace-cli
```
Load AIP content
```
winpty docker-compose -p d7job -f d7.cli.yml -f cli.ingest.yml run --rm dspace-cli
```

Alternate approach for invoking dspace CLI commands
```
winpty docker-compose -p d7job -f d7.cli.yml run --rm dspace-cli create-administrator
```
Stop DSpace
```
docker-compose -p d7job -f docker-compose.yml -f d7.override.yml down
```


## Run DSpace 7x with Entities Dataset

Start database with database dump
```
docker-compose -p d7job -f docker-compose.yml -f d7.override.yml -f d7.db.entities.yml up -d
```
Verify that all components have started
```
winpty docker-compose -p d7job -f d7.cli.yml -f d7.cli.readiness.yml run --rm dspace-cli
```
Load assetstore content
```
winpty docker-compose -p d7job -f d7.cli.yml -f d7.cli.assetstore.yml run --rm dspace-cli
```

Restart DSpace (the entities file is not needed to restart)
```
docker-compose -p d7job -f docker-compose.yml -f d7.override.yml restart
```

Stop DSpace
```
docker-compose -p d7job -f docker-compose.yml -f d7.override.yml down
```
