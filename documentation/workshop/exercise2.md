{% include nav.wkshop.html %}
# Exercise 2:  Docker Images and Containers

### Run Simple Command Line Tasks in Docker

Start a docker container that will print "hello"
```
docker run --rm ubuntu echo hello
```
- The `--rm` option says to delete the container once it is stopped.  

Ask the docker container to describe its operating system
```
docker run --rm ubuntu uname -a
```

Ask the docker container to share it's host name
```
docker run --rm ubuntu hostname
```

Assign a hostname to the container on startup
```
docker run --rm -h my_host ubuntu hostname
```

### Run a Service in Docker

We will run a web server with a sample application used for a library inventory.  We will pull [the application from DockerHub](https://hub.docker.com/r/terrywbrady/alma-inventory-php).

Note: port 80 is the default port for a web server.

#### Run the application on port 80 (web server).

_Note: if your desktop already has an application running on port 80, this step might fail.  If you encounter an error, skip to the next step of the exercise._

```
docker run --rm -p 80:80 --name myapp terrywbrady/alma-inventory-php
```

- The `-p 80:80` option says to map port 80 on your desktop to port 80 in the container.  
- The `--name myapp` option says to give the container the name `myapp`

Open [http://localhost/barcodeReport.html](http://localhost/barcodeReport.html) to view the report.

- Note that we use __localhost__ to indicate that we are accessing a local application.

Hit __Ctrl-C__ to stop the application output.

Run the following to stop the application.

```
docker stop myapp
```

#### Run the application on port 8080.

```
docker run --rm -p 8080:80 terrywbrady/alma-inventory-php
```

- The `-p 8080:80` option says to map port 8080 on your desktop to port 80 in the container.  

Open [http://localhost:8080/barcodeReport.html](http://localhost:8080/barcodeReport.html) to view the report.

- Note that we specify __port 8080__ in the URL.

Hit __Ctrl-C__ to stop the application.

Run the following to stop the application.

```
docker stop myapp
```

#### Run the application in the background.

```
docker run --rm -p 8080:80 -d --name myapp terrywbrady/alma-inventory-php
```

- The `-d` option says to run the application in the background

List the "processes" (containers) running in docker

```
docker ps -a
```

Stop the containers

```
docker stop myapp
```

Verify that the application was stopped.  Note that the container is gone.

```
docker ps -a
```

Remove the `--rm` option and note the difference
```
docker run -p 8080:80 -d --name myapp terrywbrady/alma-inventory-php
```

```
docker ps -a
```

Stop the container

```
docker stop myapp
```

Note that the container still exists

```
docker ps -a
```

Restart the container

```
docker start myapp
```

Note that the container is running again

```
docker ps -a
```

Stop and delete the container

```
docker stop myapp
docker rm myapp
```

Note that the container is gone

```
docker ps -a
```
