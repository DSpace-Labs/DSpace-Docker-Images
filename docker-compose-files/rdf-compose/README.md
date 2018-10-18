{% include nav.html %}
# Running DSpace RDF with Docker compose

[![Demonstration Video](https://i.ytimg.com/vi/ovJ8sJk1Apg/hqdefault.jpg)](https://www.youtube.com/watch?v=ovJ8sJk1Apg)

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)
- Set the environment variable DSPACE_VER to the [DSpace image version](https://hub.docker.com/r/dspace/dspace/tags/) you would like to use.

```
export DSPACE_VER=dspace-6_x-jdk8-test
```

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.
  - d7, d6, d5, d4[*](../../documentation/tutorial4x)

```
export DPROJ=d6
```

- The one of the following lines within the docker-compose.yml file can be uncommented to enable the RDF within the site.

```
# DSpace 6+: Uncomment the following to connect to fuseki
- "./local.cfg:/dspace/config/local.cfg"
# DSpace 5: Uncomment the following to connect to fuseki
# - "./rdf.cfg_5x:/dspace/config/modules/rdf.cfg"
```

## 2. Using Docker Compose

- cd to the **[rdf-compose](https://github.com/DSpace-Labs/DSpace-Docker-Images/tree/master/docker-compose-files/rdf-compose)** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 3 containers: (1) database (2) tomcat (3) fuseki (RDF triplestore).

```
$ docker ps -a
CONTAINER ID        IMAGE                             COMMAND                  CREATED             STATUS              PORTS                              NAMES
8679e4106da8        dspace/dspace:dspace-6_x          "catalina.sh run"        15 minutes ago      Up 15 minutes       8009/tcp, 0.0.0.0:8080->8080/tcp   d6_dspace_1
5572b047dbe3        dspace/dspace-postgres-pgcrypto   "docker-entrypoint.s…"   15 minutes ago      Up 15 minutes       5432/tcp                           d6_dspacedb_1
cace7b646cc8        stain/jena-fuseki                 "/docker-entrypoint.…"   15 minutes ago      Up 15 minutes       0.0.0.0:3030->3030/tcp             d6_fuseki_1
```

## 4. Create Dataset in d6_fuseki

- http://localhost:3030
- user: admin
- password: dspace

Create a dataset named **dspace**

## 5. Build the RDF dataset from the DSpace repository

#### Bash
```
docker exec -it ${DPROJ}_dspace_1 /dspace/bin/dspace rdfizer -c -v
```

#### Git-Bash Windows
```
winpty docker exec -it ${DPROJ}_dspace_1 //dspace/bin/dspace rdfizer -c -v
```

## 6. View Metadata via the RDF service

- http://localhost:8080/rdf/handle/123456789/1/rdf?text=true
