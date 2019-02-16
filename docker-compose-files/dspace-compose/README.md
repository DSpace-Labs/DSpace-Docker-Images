{% include nav.html %}
# Running DSpace with Docker compose

[![Demonstration Video](https://i.ytimg.com/vi/ovJ8sJk1Apg/hqdefault.jpg)](https://www.youtube.com/watch?v=ovJ8sJk1Apg)

## Pre-requisites

See [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md).

## Running DSpace

- [Run DSpace 6](run.DSpace6.md)
- [Run DSpace 7](run.DSpace7.md)

## Docker Compose File Overview

[Compose File Options](ComposeFiles.md)

---

## Miscellaneous Notes

### Passing Variables and Properties to DSpace

DSpace uses Apache Commons Config to access runtime properties.  Values can be passed to Apache commons through the dspace.cfg file, the local.cfg file, as system properties (-Ddspace.name=Foo), and as environment variables.

Note that enviroment variables containing dots in their names are not supported by some Linux shells.  While it is possible to pass an ENV variable (`-e dspace.name=Foo`) through docker run or Docker Compose, that value will not propagate to the DSpace runtime becuase the underlying shell will reject the variable name.

If you need to set a property name that contains a period, the recommended approach is to pass the override as a system property set in JAVA_OPTS.  `-e JAVA_OPTS=-Ddspace.name=Foo`.

### Verify DSpace Version

#### Bash
```
docker exec -it dspace /dspace/bin/dspace version
```

#### Git-Bash Windows
```
winpty docker exec -it dspace //dspace/bin/dspace version
```

### Verify Database Schema

#### Bash
```
docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

#### Git-Bash Windows
```
winpty docker exec -it dspacedb psql -U dspace -c "select * from schema_version order by installed_rank desc limit 1"
```

## Accessing the Command Line

### Tomcat

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspace /bin/bash
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspace //bin/bash
```

### Database

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspacedb psql -U dspace
```

## Destroying Docker Resources
If you no longer need to retain your Docker volumes, run the following command.  Alter the volume prefix to match your version of DSpace

```
docker volume rm d6_assetstore d6_pgdata d6_solr_authority d6_solr_oai d6_solr_search d6_solr_statistics
```
A helper script exists in this repository to remove volumes.

[removeVols script](../../removeVols.md) 
