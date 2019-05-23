{% include nav.wkshop.html %}
# Exercise 3A: Understanding Docker Compose 

## Understanding the DSpace 6 Configuration
```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml config
```

View the containers that will be created

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml config | grep container_name
```

Output:

```
    container_name: dspace
    container_name: dspacedb
```

View the images that will be used

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml config | grep image:
```

Output:

```
    image: dspace/dspace:dspace-6_x-jdk8-test
    image: dspace/dspace-postgres-pgcrypto
```

## Understanding the DSpace 7 Configuration

View the containers that will be created

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml config | grep container_name
```

Output:

```
    container_name: dspace
    container_name: dspace-angular
    container_name: dspacedb
    container_name: dspacesolr
```

View the images that will be used

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml config | grep image:
```

Output:

```
    image: dspace/dspace:dspace-7_x-jdk8-test
    image: dspace/dspace-angular:latest
    image: dspace/dspace-postgres-pgcrypto
    image: dspace/dspace-solr
```

## Understanding the DSpace 7 Preview Release Configuration

View the images that will be used

```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f d7.preview.yml config | grep image:
```

Output: 

```
    image: dspace/dspace:dspace-7.0-preview-1
    image: dspace/dspace-angular:dspace-7.0-preview-1
    image: dspace/dspace-postgres-pgcrypto
    image: dspace/dspace-solr
```
