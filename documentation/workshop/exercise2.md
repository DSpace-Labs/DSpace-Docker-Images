{% include nav.html %}
# Exercise 2:  Docker Images and Containers

[http://bit.ly/dspace-docker](http://bit.ly/dspace-docker)

### Run Simple Command Line Tasks in Docker

Print "hello"
```
docker run ubuntu echo hello
```

Ask the docker container to describe its operating system
```
docker run ubuntu uname -a
```

Ask the docker container to share it's host name
```
docker run ubuntu hostname
```

Assign a hostname to the container on startup
```
docker run -h my_host ubuntu hostname
```

### Run a Service in Docker

We will run a web server with a sample application used for a library inventory.  We will pull [the application from DockerHub](https://hub.docker.com/r/terrywbrady/alma-inventory-php).


Run the application on port 80 (web server).
``
docker run --rm -p 80:80 terrywbrady/alma-inventory-php
```

- The `--rm` option says to delete the container once it is stopped.  
- The `-p 80:80` option says to map port 80 on your desktop to port 80 in the container.  


Open [http://localhost/barcodeReport.html](http://localhost/barcodeReport.html) to view the report.

Hit __Ctrl-C__ to stop the application.

Run the application on port 8080.
``
docker run --rm -p 8080:80 terrywbrady/alma-inventory-php
```
- The `-p 8080:80` option says to map port 8080 on your desktop to port 80 in the container.  

Open [http://localhost:8080/barcodeReport.html](http://localhost:8080/barcodeReport.html) to view the report.

Hit __Ctrl-C__ to stop the application.

Run the application in the background.
```
docker run --rm -p 80:80 -d --name myapp terrywbrady/alma-inventory-php
```
- The `-d` option says to run the application in the background
- The `--name myapp` option says to give the container the name `myapp`

List the "processes" (containers) running in docker

```
docker ps
```

Stop the containers

```
docker stop myapp
```

Verify that the application was stopped.  Note that the container is gone.

```
docker ps
```

Remove the `--rm` option and note the difference
```
docker run -p 80:80 -d --name myapp terrywbrady/alma-inventory-php
```

```
docker ps
```

Stop the container

```
docker stop myapp
```

Note that the container still exists

```
docker ps
```

Restart the container

```
docker start myapp
```

Note that the container is running again

```
docker ps
```

Stop and delete the container

```
docker stop myapp
docker rm myapp
```

Note that the container is gone

```
docker ps
```
