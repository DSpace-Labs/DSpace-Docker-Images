{% include nav.html %}
## Developing Standalone DSpace Angular connected to an External REST service

The DSpace Angular UI has a client (js) and a server component (Node js).  Each component needs to point to the proper REST API.
- js client - this is defined in environment.dev.js
- Node js server - this is defined in the docker-compose.yml file

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)

- Make sure that the environment variable **ANGULAR_SRC** is set to the directory containing your cloned DSpace-angular repo

```
export ANGULAR_SRC=$(pwd)
```
- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.

```
export DPROJ=d7
```

## 2. Using Docker Compose

- cd to the **angular-dev-compose** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 1 container: Node - Angular.

```
$ docker ps -a
CONTAINER ID        IMAGE                        COMMAND                  CREATED             STATUS              PORTS                                            NAMES
a987d9a6fb2a        dspace/dspace-angular-bare   "/bin/sh -c /tmp/sta…"   13 minutes ago      Up 5 minutes        0.0.0.0:3000->3000/tcp, 0.0.0.0:9876->9876/tcp   dspace-angular
```

## 3. Open DSpace in a Browser
- DSpace 7 UI: [http://localhost:3000](http://localhost:3000)

## 4. Stopping DSpace
To stop DSpace, the following command can be run.  The image will be retained in a stopped state.
```
docker-compose -p $DPROJ stop
```

You can destroy the images with the following command.  This command will be necessary to run if you change the compose file that you are using.

```
docker-compose -p $DPROJ down
```


## 6. Restarting DSpace

```
docker-compose -p $DPROJ up -d
```

## 7. Destroying Docker Resources

```
docker-compose -p $DPROJ down
```
