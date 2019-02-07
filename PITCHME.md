### DSpace Docker for Repository Managers - Running Any Version of DSpace from your Desktop

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code
---

### Webinar Marketing Details
_The information on the following 3 slides will be shared with Kristi for marketing.  It will not be part of the presentation._

- Background
- Webinar Objectives
- Target Audience

+++

### Background

<div style="font-size:18px; text-align: left">
In 2018, the DSpace development team packaged DSpace to be run with Docker.  
This made it possible to start any version of DSpace from your desktop with a simple command line call.
<br/><br/>
The use of Docker has created a more flexible development environment for DSpace contributors.
<br/><br/>
Docker also offers great potential for repository managers. That is the focus of this webinar.
</div>

Note: 
In 2018, the DSpace development team packaged DSpace to be run with Docker.  
This made it possible to start any version of DSpace from your desktop with a simple command line call.

The use of Docker has created a more flexible development environment for DSpace contributors.

Docker also offers great potential for repository managers. That is the focus of this webinar.

+++

### Webinar Objectives

Webinar attendees will learn
- What is a *Docker image* and what images have been published for DSpace
- How to install Docker
- How to launch DSpace 6 and DSpace 7 using Docker
- How to participate in DSpace testing using Docker

+++

### Target Audience

- Repository Managers who want to preview new DSpace functionality
- Repository Managers who want to become more involved in DSpace development
- Potential DSpace contributors who want to learn how they can get started with the project

+++

### Logistics

- 1 hour
- 10 min will be saved for Questions
- Terry and Pascal will want to screen share
- March 5th, 8am pt, 11am ET, 5pm CET

---

### About the presenters

+++

### Terry Brady

- Software Developer, Georgetown University Library
- DSpace Committer
- https://github.com/terrywbrady/info

![](https://www.library.georgetown.edu/sites/default/files/library-logo.png)

+++

### Pascal Becker

- DSpace Committer
- https://www.the-library-code.de/

---

### What is Possible?

Note:

Assumption: since we recommend bash or git-bash, we will assume the repo has been cloned to ~/DSpace-Docker-Images.

```
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

Question: would it be helpful to show these files before invoking the up command?

+++

### Launch DSpace 7

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

- http://localhost:3000
- http://localhost:8080/spring-rest

---

### What is Docker?

- Explain Docker images
- Explain DSpace Docker images
- Maybe explain docker volumes

---

### What is possible with Docker?

- Try out a DSpace feature without impacting your existing instance
- Preview an enhancement **before** it is released
  - Give input on the implementation
- Verify a bug fix **before** it is released
- Onboard new developers and repository managers to the project

---

### Launch DSpace 6

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

- http://localhost:8080/xmlui
- http://localhost:8080/rest/static/reports/query.html

---

### Step by step instructions

+++

### Install Docker
- [Docker Installation and Setup](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/tutorialSetup.html)

+++

### Other recommended installs

- On windows, bash is Needed

+++

### Install DSpace project

```
docker run --rm  -v $(pwd)://git alpine/git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
```

---

### Running Docker Command
_Time permitting, we will do this on MacOS and on Windows 10_

- docker version
- docker run --rm ubuntu date
- start dspace 6
  - stop dspace 6
- start dspace 7
  - stop dspace 7

---

### Help needed

- Try it yourself, give us feedback on the documentation
- Help us assemble public domain assets to distribute in AIP files
  - with great Metadata

+++

### What ideas do you have?

---

### Reference Links

- compile useful resources here
- [DSpace Docker Tutorial Overview](https://dspace-labs.github.io/DSpace-Docker-Images/)

---

### Questions?


---

## Prior Slides -- If useful to include

+++

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
