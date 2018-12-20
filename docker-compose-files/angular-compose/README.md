{% include nav.html %}
## Running Standalone DSpace Angular connected to an External REST service

The DSpace Angular UI has a client (js) and a server component (Node js).  Each component needs to point to the proper REST API.
- js client - this is defined in environment.dev.js
- Node js server - this is defined in the docker-compose.yml file

## 1. Pre-requisites
- [Setting Up Docker for DSpace](../../documentation/tutorialSetup.md)

- Set the environment variable DPROJ to a shorthand version of the version of DSpace you are running (this needs to be distinct for each database schema version). Docker will name the network, images, and persistent volumes with this value.  This will allow you to host multiple DSpace configurations through Docker.

```
export DPROJ=d7
```

- Modify the Docker Compose file to point to the external REST API that you would like to use.  The development instance at 4Science is configured by default.

```
      - DSPACE_REST_HOST=dspace7.4science.it
      - DSPACE_REST_SSL=true
        # DSPACE_REST_NAMESPACE=/spring-rest/api
      - DSPACE_REST_NAMESPACE=/dspace-spring-rest/api
      - DSPACE_REST_PORT=443
```
- Modify the environment.js file to point to the external REST API that you would like to use. The development instance at 4Science is configured by default.

```
module.exports = {
  rest: {
    ssl: true,
    host: 'dspace7.4science.it',
    port: 443,
    // NOTE: Space is capitalized because 'namespace' is a reserved string in TypeScript
    //nameSpace: '/spring-rest/api'
    nameSpace: '/dspace-spring-rest/api'
  }
};
```

## 2. Using Docker Compose

- cd to the **angular-compose** directory

Run Docker compose

```
docker-compose -p $DPROJ up -d
```

This will start 1 container: Node - Angular.

```
$ docker ps -a
CONTAINER ID        IMAGE                             COMMAND                  CREATED             STATUS              PORTS                                            NAMES
7d6532ef898f        dspace/dspace-angular             "/bin/sh -c 'yarn ru…"   25 seconds ago      Up 24 seconds       0.0.0.0:3000->3000/tcp, 0.0.0.0:9876->9876/tcp   dspace-angular
```

## 3. Accessing the Command Line

#### Bash
```
docker exec -it --detach-keys "ctrl-p" dspace-angular /bin/sh
```

#### Git-Bash Windows
```
winpty docker exec -it --detach-keys "ctrl-p" dspace-angular //bin/sh
```

## 4. Open DSpace in a Browser
- DSpace 7 UI: [http://localhost:3000](http://localhost:3000)

## 5. Stopping DSpace
To stop DSpace, the following command can be run.  The image will be retained in a stopped state.
```
docker-compose -p $DPROJ stop
```

## 6. Restarting DSpace

```
docker-compose -p $DPROJ up -d
```

## 7. Destroying Docker Resources

```
docker-compose -p $DPROJ down
```

## 8. Updating Code within an Angular Image

To deploy new code within your image, see [angular-dev-compose](../angular-dev-compose).
