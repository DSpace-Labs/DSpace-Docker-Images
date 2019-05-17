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
### Run DSpace 6 with a modified (published image)
TODO: create image for 2424 variant

### Pass params via compose
TODO: XMLUI - show/hide items on search screen

### Pass in files via docker-compose
Mirage vs Mirage2

### Volume management
  - empty images
  - change aip images
