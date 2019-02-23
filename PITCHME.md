#### DSpace Docker for Repository Managers
##### Running Any Version of DSpace from your Desktop

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

@size[18px](https://github.com/DSpace-Labs/DSpace-Docker-Images)

Note:
- Kristi presents
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

Note:
Terry presents

+++

### Pascal Becker

- CEO and founder of The Library Code
- Senior Software Developer at Technische Universität Berlin
- DSpace Committer
- https://www.the-library-code.de/

Note:
Pascal presents

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
- Repository Managers who want to test certain functionality of DSpace
- Potential DSpace contributors who want to learn how they can get started with the project
- Developers who wants to use DSpace within Docker as part of their development environment

+++

### Webinar Objectives

- What is a *Docker image* and what are *Containers*
- What Docker images have been published for DSpace
- How to install Docker
- How to launch DSpace 6 and DSpace 7 using Docker
- How to participate in DSpace testing using Docker

---

### Motivation

In our first demo, we want to show you how easy it is to get DSpace 7 runing. For this demo, we have already
- Installed Docker
- Installed a command line tool
- Downloaded some code to help us start DSpace

Note:
Terry presents

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

+++

### Launch DSpace 7

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

- http://localhost:8080/spring-rest
- http://localhost:3000

---

### 5 Quick Docker Concepts

- Docker Images
- DSpace Docker Images
- Docker Containers
- Docker Volumes
- Docker compose

Note:
Pascal presents

+++

### Docker Images

- Imagine you could install a complex application with its complete environment with one command
- Imagine you'd have a possibility to pack a whole environment into one package

Docker Images makes that possible.

+++

### Docker Images (continued)

An Image is

- A snapshot of an application and its complete environment
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
- Containing a complete environment
- Containing an application or service
- Started and stopped by Docker
- Runs independently of other applications

+++

### A container's lifetime

- Images package a complete environment needed to run an application
- Containers can be deleted when they are stopped
- A container can be thrown away and recreated easily as the image defines it well

+++

### Docker Volumes

- Can be (re-)used when a container starts
- Volumes outlive the containers that uses them
- Like a really small disk drive or network drive
- All data a container wants to saved must be stored in a volume

+++

### docker-compose

- Docker compose is a command to control environments of multiple containers that work together
  - DSpace Database
  - DSpace Web Server
  - Angular UI (for DSpace 7)
- Build, start, stop, ... all necessary containers for a service or application

---

### What is possible with DSpace and Docker?

- Try out a DSpace feature without impacting your existing instance
- Preview an enhancement or new version
- Give input on the implementation
- Verify a bug fix **before** it is released
- Onboard new developers and repository managers to the project

---

### Install Instructions

- Install Docker Desktop
- Install a terminal for running docker
- Download DSpace Docker Compose files

Note:
Terry presents

+++

### Installation instructions

- @gitlink[Windows 10 Setup](documentation/setup.Windows10.md)
- @gitlink[MacOS Setup](documentation/setup.MacOS.md)
- @gitlink[Linux Desktop Setup](documentation/setup.LinuxDesktop.md)

---

### Step by Step Demonstration

+++

### Verify Installs

```shell
git version
```
```shell
docker version
```
```shell
docker-compose version
```

+++?image=documentation/webinar/win.versions.gif

+++

### Download DSpace Docker Compose Files

```shell
cd
git clone https://github.com/DSpace-Labs/DSpace-Docker-Images.git
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

+++?image=documentation/webinar/win.clone.gif

+++

## Running DSpace

+++

### A quick peek at the DSpace 6 compose files

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

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

+++?image=documentation/webinar/win.d6.start.gif

+++

### Running a DSpace command line task
- dspace version
- dspace index-discovery
- dspace filter-media
- dspace oai import

+++?image=documentation/webinar/win.d6version.gif

+++

### Test DSpace 6

- [http://localhost:8080/xmlui](http://localhost:8080/xmlui)

+++?image=documentation/webinar/d6.web.gif

+++

### Stop DSpace 6

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml down
```

+++?image=documentation/webinar/win.d6.down.gif

+++

### A quick peek at the DSpace 7 compose files

+++?code=docker-compose-files/dspace-compose/d7.override.yml&lang=yml
DSpace 7 Overrides
@[5](Default DSpace 7 Image)
@[13-15](DSpace Angular Image)
@[16-18](Ports for Angular)
@[23-26](Location of the DSpace REST API)

+++

### Running DSpace 7

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

+++?image=documentation/webinar/win.d7.start.gif

+++

### DSpace 7 REST API Back End

-  [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)

+++?image=documentation/webinar/d7.rest.gif

+++

### Manually Index DSpace 7 content

```shell
docker exec dspace //dspace/bin/dspace index-discovery
```

+++
### DSpace 7 Angular Front End

  - [http://localhost:3000](http://localhost:3000)

+++?image=documentation/webinar/d7.angular.gif

+++

### Stopping DSpace 7

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml down
```

+++?image=documentation/webinar/win.d7.down.gif

---

### We need **your** help

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
- [Docker Documentation](https://docs.docker.com/engine/reference/commandline/cli/)
- [Docker Compose Documentation](https://docs.docker.com/compose/reference/overview/)
- Join the [**#dspace-docker**](https://dspace-org.slack.com/messages/C9YD42PV3/) Slack Channel


---

### Discussion

- Could you imagine using this capability?
- What would be needed to make this compelling for the repository manager community?

---

### Questions?

---
### Thank You

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

@size[18px](https://github.com/DSpace-Labs/DSpace-Docker-Images)
