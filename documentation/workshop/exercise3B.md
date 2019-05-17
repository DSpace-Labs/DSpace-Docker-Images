{% include nav.html %}
# Exercise 3B: Running DSpace 6 with Docker-Compose

http://bit.ly/dspace-docker


### Start DSpace 6

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml pull
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

Verify that DSpace is Running
```shell
docker ps
```

It will take 2-5 minutes for the services to start completely.  Once they have started, you can view them on the web.
The first time you start DSpace, it will load some default AIP content.  This process takes an additional 3-5 minutes.
- [http://localhost:8080/xmlui](http://localhost:8080/xmlui)

### Run command line tasks (create admin, create user)

Create a new administrator account.  Make up a fake administrator account.

MacOS/Linux
```shell
docker exec -it dspace /dspace/bin/dspace create-administrator
```

Windows
```shell
winpty docker exec -it dspace //dspace/bin/dspace create-administrator
```

Open [XMLUI](http://localhost:8080/xmlui) and verify that you are able to login with the admin account that you just created.

### Run DSpace 6 with a modified (published image)

Shutdown your running copy of DSpace
```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml down
```

For this test, we are going to use a tagged version of the DSpace image.  
- Open [https://hub.docker.com/r/dspace/dspace/tags](https://hub.docker.com/r/dspace/dspace/tags) to explore the available images
  - Look for __or2019-workshop-6x__
  - [Pull Request Used to Create This Image](https://github.com/DSpace/DSpace/pull/2431/files)

![dockerhub tagged images](../dockerhub.png)

Set the variable DSPACE_VER to select a different image.

```shell
DSPACE_VER=or2019-workshop-6x docker-compose -p d6 -f docker-compose.yml -f d6.override.yml config | grep image:
```

Run the following commands to start DSpace with this image.

```shell
DSPACE_VER=or2019-workshop-6x docker-compose -p d6 -f docker-compose.yml -f d6.override.yml pull
DSPACE_VER=or2019-workshop-6x docker-compose -p d6 -f docker-compose.yml -f d6.override.yml up -d
```

Open [XMLUI](http://localhost:8080/xmlui) and notice the change to the welcome page.

### Pass params via compose
TODO: XMLUI - show/hide items on search screen

Create local.override.yml
```
# suitable for DSpace 6 and 7
version: "3.7"

services:
  dspace:
    environment:
      # __D__ -> -
      # __P__ -> .
      - xmlui__P__theme__P__mirage__P__item__D__list__P__emphasis=file
```

### Pass in files via docker-compose
Mirage vs Mirage2

### Volume management
  - empty images
  - change aip images
