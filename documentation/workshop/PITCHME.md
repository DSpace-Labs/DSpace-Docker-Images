#### Docker for DSpace – Lowering the Barrier of Entry for New Contributors
##### OR 2019

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

http://bit.ly/dspace-docker

_Please complete the Pre-work (Docker Install), if you have not already done so._

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

- CEO and founder of The Library Code GmbH
- DSpace Committer
- Member of DSpace's Leadership and Steering Groups
- https://www.the-library-code.de/

![](https://www.the-library-code.de/the-library-code.png)

Note:
Pascal presents

---

### About this workshop

Note:
Terry presents

+++

### Background

- 2018 the DSpace for Docker was created
- Start any version of DSpace from your desktop
  - (Windows 10, MacOS, Linux)
- Helps newcomers to get a test system running quickly
- Helps developers to easily spin up development environments

+++

### Who You Are (we think)

- People who want to ...
  - get a sneak peak on DSpace 7
  - get started with Docker
  - know if Docker can help them with their development environment
  - learn how they can get started with DSpace
  - become more involved in the DSpace project

+++

### Workshop Objectives

- Understand basics of Docker (Images, Containers, Volumes, ...)
- What Docker images have been published for DSpace
- How to install Docker
- How to launch DSpace 6 and DSpace 7 using Docker
- How to participate in DSpace testing using Docker
- Exchanging tips and ideas about DSpace and Docker

---

### Motivation

+++

### Imagine you could...

- ...create a DSpace installation with one single command
- ...install and start a new instance of any version of DSpace in under 3 minutes
- ...wouldn't need to have to think about database versions, operating systems, ordering virtual hosts, and further more.

+++

### Demo: Running DSpace 7

- It takes 2-3 minutes to start up

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml up -d
```

+++?image=documentation/webinar/win.d7.start.gif
+++?image=documentation/webinar/d7.rest.gif
+++?image=documentation/webinar/d7.angular.gif

+++

### What is possible with DSpace and Docker?

- Try out a DSpace feature without impacting your existing instance
- Preview an enhancement or new version
- Give input on the implementation
- Verify a bug fix **before** it is released
- Onboard new developers and repository managers to the project
- and so much more...

+++

### DSpace Docker Images

- DSpace 7x, DSpace 6x, DSpace 5x, DSpace 4x
  - Install content from DSpace AIP files on creation
- DSpace Database
- DSpace Angular UI
- Published to https://hub.docker.com/u/dspace
- See [DSpace Docker Tutorial Overview](https://dspace-labs.github.io/DSpace-Docker-Images/)

+++

### Can I use your images in production?

- Not yet!
- Current images focus on testing and development
- We want to gain more experience on our own
- Do you want to help to create images for production? Contact us on slack!

---

### Install Instructions (Recap)
_Most attendees will have completed this step already_

- Install Docker Desktop
- Install a terminal for running docker (Windows only)
- Download DSpace Docker Compose files

+++

### Installation instructions

- @gitlink[Windows 10 Setup](documentation/setup.Windows10.md)
- @gitlink[MacOS Setup](documentation/setup.MacOS.md)
- @gitlink[Linux Desktop Setup](documentation/setup.LinuxDesktop.md)

---

### Exercise 1: Verify Installation
- [Exercise 1: Verify Installation](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise1.html)

---

### Docker Concepts

- Basic idea of Docker
- Docker Images
- Docker Containers
- Docker vs. virtualization
- Docker Volumes

Note:
Pascal presents

+++

### Why Docker?

_Imagine you could pack an application's complete environment into one package easily._

+++

### Why Docker?

  - One _script_ to start up your service / application
    - All necessary services are started at once (database, web server)
  - Runs identically on __any__ desktop or server that supports Docker
    - Windows, MacOS or Linux!
  - Replicable process
    - Destroy and recreate your service easily

+++

### Docker Images

@quote[ An image is an executable package that includes everything needed to run an application - the code, a runtime, libraries, environment variables, and configuration files.](Docker Documentation, Get started with Docker, Part 1 Orientation)

+++

### Docker Images (continued)

@snap[text-left]
An Image is
@snapend

- A snapshot of an application and its complete environment
- Can be shared and downloaded
- Can be published
  - Online on [docker hub](https://hub.docker.com/)
  - Or in a private repository

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

- Images package a complete environment
- Start a new container from an image is very easy
- A Container is just like a running version of an image
- Delete containers when they stop
- Create a new container everytime a service starts

+++

### Docker Volumes

- If you delete a container when it stops, how do you persist data?
- Volumes can be (re-)used when a container starts
- Volumes outlive the containers that uses them
- Like a really small disk drive or network drive
- Data you wish to save must be stored in a volume

---

### Exercise 2: Docker Images and Containers

- [Exercise 2: Docker Images and Containers](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise2.html)

---

### docker-compose

Note:
Terry presents

+++

### Docker Compose

- An image defines a service and its environment
- Today's applications are composed out of multiple services
- We need information about how to run an application
  - Is it composed out of multiple services?
  - How do they depend on each other?
  - Which ports are used?
  - How to start and stop it all together?

+++

### docker-compose.yaml

- Docker Compose is a command to control environments of multiple containers that work together
- Docker Compose defines information within configuration files about how to run an application
- Docker Compose builds complex docker commands for you to start up multiple services in the right order

+++

### Possibilities of docker-compose

- Docker Compose can describe complex setups
  - Defines which services to run in which order
  - Configures volumes, ports, network structure, limits, environment variables, ...
  - Can apply limits regarding CPU and/or RAM usage
- docker-compose contains shortcuts to interact with the containers it started

+++

### Docker Compose and DSpace

- The DSpace project heavily uses docker compose
- We have several docker-compose files that can be used together
- Some parts of a docker compose file gets overridden by another docker-compose file
- That allows us to easily tweak the instance of DSpace you're running

+++

### Running DSpace 6 with docker-compose

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml down
```

+++?code=docker-compose-files/dspace-compose/docker-compose.yml&lang=yml
Docker Compose File
@[4-8](DSpace Database Image Name)
@[19-21](DSpace Image Definition)
@[28-31](Default Administrator Credentials)
@[32](AIP Files to ingest on initial startup)

+++

### Overriding with docker-compose

@snap[text-left]
command to start DSpace 5:
@snapend

```shell
docker-compose -p d5 -f docker-compose.yml -f d5.override.yml pull
```

@snap[text-left]
DSpace's default image:
@snapend

```yml
dspace:
  image: "${DOCKER_OWNER:-dspace}/dspace:${DSPACE_VER:-dspace-6_x-jdk8-test}"
```

@snap[text-left]
d5.override.yaml:
@snapend

```yml
dspace:
  image: "${DOCKER_OWNER:-dspace}/dspace:${DSPACE_VER:-dspace-5_x-jdk8-test}"
```

---

### Exercise 3A: Understanding Docker Compose

- [Exercise 3A: Understanding Docker Compose](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise3A.html)

+++

### Exercise 3B: Running DSpace 6 with Docker-Compose

- [Exercise 3B: Running DSpace 6 with Docker-Compose](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise3B.html)

---

### Exercise 4: Running DSpace 7 with Docker-Compose

- [Exercise 4: Running DSpace 7 with Docker-Compose](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise4.html)

---
### Advanced Topics

- Our ideas
  - Building code changes with Docker Composse
  - Running DSpace 6 and DSpace 7 on different ports
- Your ideas
  - Anything specific you would like us to cover?

+++

### Exercise 5: Advanced Topics

- [Exercise 5: Advanced Topics](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/workshop/exercise5.html)

---

### We need **your** help

- Try it yourself, give us feedback on the documentation
  - Join the **#dspace-docker** Slack Channel
- Help us assemble assets to distribute in AIP files

+++

### What we need

- Curating and Assembling [AIP Resources](https://github.com/DSpace-Labs/AIP-Files)
  - Public domain / restriction free  
  - Real repository content (but not very large)
    - Small PDFs
    - Small image
  - Realistic metadata

---

### Discussion

- Could you imagine using this capability?
- What would be needed to make this compelling for the repository manager community?

+++

### Feedback/Questions?

- What ideas do you have?
- What questions do you have?

+++

### Reference Links

- [DSpace Docker Tutorial Overview](https://dspace-labs.github.io/DSpace-Docker-Images/)
- [Docker Documentation](https://docs.docker.com/engine/reference/commandline/cli/)
- [Docker Compose Documentation](https://docs.docker.com/compose/reference/overview/)
- Join the [**#dspace-docker**](https://dspace-org.slack.com/messages/C9YD42PV3/) Slack Channel

---

### Thank You

- Terry Brady, Georgetown University Library
- Pascal Becker, The Library Code

http://bit.ly/dspace-docker
