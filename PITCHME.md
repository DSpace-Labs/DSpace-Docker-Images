## Running DSpace with Docker

_These slides will be used for a Repository Manager Introduction to DSpace Docker_

Terry Brady, Georgetown University Library

https://github.com/terrywbrady/info

![](https://www.library.georgetown.edu/sites/default/files/library-logo.png)

---
### Background

- [DSpace Docker Tutorial Overview](https://dspace-labs.github.io/DSpace-Docker-Images/)
- [Docker Installation and Setup](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/tutorialSetup.html)
- _This presentation assumes the following [pull request](https://github.com/DSpace-Labs/DSpace-Docker-Images/pull/68) has been adopted_

---

### Sample Docker Commands

Run an ubuntu Linux and ask what OS it is running

```
winpty docker run --rm ubuntu uname
```
Run an ubuntu Linux and ask for the current time

```
winpty docker run --rm ubuntu date
```

+++

### Run a service

A more compelling example is to run a web server through Docker.

```
docker run -dit --name my-apache-app -p 8080:80 httpd:2.4
```

- http://localhost:8080

+++

### Copy some data to the page

```
echo "<html><h2>Hi DSpace</h2></html>" > index.html
docker cp index.html my-apache-app://usr/local/apache2/htdocs/
```

+++

### Clean Up

```
docker stop my-apache-app
docker rm my-apache-app
```

---

### Docker Volumes

- If data is written to a __docker volume__ that data will be restored when a container is restarted.
- When we run multiple versions of DSpace, we keep the data for each version of DSpace in a separate volume

---

## Running DSpace

+++?code=docker-compose-files/dspace-compose/docker-compose.yml&lang=yml
Docker Compose File
@[4-8](DSpace Database Image Name)
@[19-21](DSpace Image Definition)
@[24-27](Default Administrator Credentials)
@[28](AIP Files to ingest on initial startup)
+++?code=docker-compose-files/dspace-compose/d6.override.yml&lang=yml
DSpace 6 Overrides
@[5](Default DSpace 6 Image)

+++

### Running DSpace 6

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

- [http://localhost:8080/xmlui](http://localhost:8080/xmlui)

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml down
```

+++?code=docker-compose-files/dspace-compose/d7.override.yml&lang=yml
DSpace 7 Overrides
@[5](Default DSpace 7 Image)
@[7-9](DSpace Angular Image)
@[10-12](Ports for Angular)
@[17-20](Location of the DSpace REST API)

+++

### Running DSpace 7

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

- [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)
- [http://localhost:3000](http://localhost:3000)

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml down
```

+++
### Running DSpace 6 with an RDF Triplestore

+++?code=docker-compose-files/dspace-compose/rdf.override.yml&lang=yml
RDF Override File
@[5-15](DSpace Config Overrides for RDF)
@[17-19](RDF Triplestore Image)
@[20-21](Triplestore Ports)
@[22-23](Triplestore Password)
+++

### Running DSpace 6 with RDF

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f rdf.override.yml up -d
```

- [https://dspace-labs.github.io/DSpace-Docker-Images/docker-compose-files/rdf-compose/](RDF instructions)

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f rdf.override.yml down
```

+++

### Future possibilities

- Test fixes for specific bugs
- Test enhancement code _before_ it is part of a release

---

### Help Needed

- Curating and Assembling [AIP Resources](https://github.com/DSpace-Labs/AIP-Files)
  - Small bitstreams with good Metadata
  - License and restriction free for inclusion in many test repositories

+++

### Discussion

- Could you imagine using this capability?
- What would be needed to make this compelling for the repository manager community?

---
### Thank You

---
### TODO's
- Ensure that instructions work on Windows, Mac, Linux
- Ensure that instructions are clear for installation
  - Docker
  - Appropriate shell
