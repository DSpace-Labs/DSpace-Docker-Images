#### DSpace Docker for Repository Managers
##### Running Any Version of DSpace from your Desktop

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

```
https://github.com/DSpace-Labs/DSpace-Docker-Images
```

Note:
- March 5th, 8am pt, 11am ET, 5pm CET
- https://duraspace.org/webinar-registration-open-dspace-docker-for-repository-managers-running-any-version-of-dspace-from-your-desktop/
---

### Who We Are

+++

### Terry Brady

- Software Developer, Georgetown University Library
- DSpace Committer
- https://github.com/terrywbrady/info

![](https://www.library.georgetown.edu/sites/default/files/library-logo.png)

+++

### Pascal Becker

- CEO and founder of The Library Code
- Senior Software Developer at Technische Universität Berlin
- DSpace Committer
- https://www.the-library-code.de/

---

### Background

- 2018 the DSpace for Docker was created
- Possible to start any version of DSpace from your desktop
  - (Windows 10, MacOS, Linux)
- Great potential for repository managers

+++

### Who You Are (we think)

- Repository Managers who want to preview new DSpace functionality
- Repository Managers who want to become more involved in DSpace development
- Potential DSpace contributors who want to learn how they can get started with the project

+++

### Webinar Objectives

- What is a *Docker image* and what images have been published for DSpace
- How to install Docker
- How to launch DSpace 6 and DSpace 7 using Docker
- How to participate in DSpace testing using Docker

---

### Set Up

For the first demo, we have already
- Installed Docker
- Installed a command line tool
- Downloaded some code to help us start DSpace

Note:

```
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

+++

### Launch DSpace 7

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

- http://localhost:3000
- http://localhost:8080/spring-rest

---

### 5 Quick Docker Concepts

- Docker Images
- DSpace Docker Images
- Docker Containers
- Docker Volumes
- Docker compose

+++

### Docker Images

- A snapshot of an application
- Published Online
  - On [docker hub](https://hub.docker.com/)
  - Or in a private repository
- Can be shared and downloaded

+++

### DSpace Docker Images

- DSpace 7x, DSpace 6x, DSpace 5x, DSpace 4x
  - Install content from DSpace AIP files on creation
- DSpace Database
- DSpace Angular UI
- Published to https://cloud.docker.com/u/dspace/repository/list

+++

### Docker Containers

- A running version of a docker image
- Like a small server running within your desktop
- Started and stopped by Docker
- Runs independently of other applications

+++

### Docker Volumes

- Data saved by a Docker container
- Can be re-used when a container is restarted
- Like a really small disk drive or network drive

+++

### docker-compose

- Docker compose is a command that can start one or more containers that work together
  - DSpace Database
  - DSpace Web Server
  - Angular UI (for DSpace 7)

---

### What is possible with DSpace and Docker?

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

### Install Instructions

+++

### Install Docker
- [Docker Installation and Setup](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/tutorialSetup.html)

+++

### MacOS

- Install docker (above)
- Open terminal (in Applications/Utilities)
```
git version
```
- You will be prompted to install developer tools

+++

### Windows: Install Git-Bash

- Install docker (above)
- https://git-scm.com/downloads
```
git version
```

+++

### Linux Desktop: Install Git, Docker, Docker Compose

```
sudo yum install git
```
```
sudo yum install docker
```
- [Install Docker compose](https://docs.docker.com/compose/install/#install-compose)

Note:
- apt-get equivalents?

---

### Step by Step Instructions

+++

### Download DSpace Docker Compose Files

```
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

+++

### Running Docker Command

```
docker version
```
```
docker-compose version
```
```
docker run --rm ubuntu date
```

Note:
Time permitting, we will do this on MacOS and on Windows 10

+++

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
@[13-15](DSpace Angular Image)
@[16-18](Ports for Angular)
@[23-26](Location of the DSpace REST API)

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

---

### Help needed

- Try it yourself, give us feedback on the documentation
  - Join the **#dspace-docker** Slack Channel
- Help us assemble assets to distribute in AIP files

+++

- Curating and Assembling [AIP Resources](https://github.com/DSpace-Labs/AIP-Files)
  - Public domain / restriction free  
  - Real repository content (but not very large)
    - Small PDFs
    - Small image
  - Realistic metadata

+++

### What ideas do you have?

---

### Reference Links

- [DSpace Docker Tutorial Overview](https://dspace-labs.github.io/DSpace-Docker-Images/)
- Docker tutorial
- Docker compose tutorial
- Join the **#dspace-docker** Slack Channel

---

### Questions?

---

### Discussion

- Could you imagine using this capability?
- What would be needed to make this compelling for the repository manager community?

---
### Thank You

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

```
https://github.com/DSpace-Labs/DSpace-Docker-Images
```
