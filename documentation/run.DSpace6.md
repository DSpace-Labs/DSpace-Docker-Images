{% include nav.html %}
## Running DSpace 6

### Go to the Docker Compose Directory
```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

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

### Next steps

See [Common Tasks](run.CommonTasks.md) for additional actions you can take with your DSpace instance.

### Stop DSpace 6
_This option will pause your container and free up any ports in use.  The container can be restarted._

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml stop
```

Verify that DSpace has stopped
```shell
docker ps
```

### Restart DSpace 6

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml start
```

Verify that DSpace has restarted
```shell
docker ps
```

### Terminate DSpace 6
_This option will delete your docker container. When you bring up a new container, it will look for an updated image._
_Your database and assetstore will be preserved._

```shell
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml down
```

Verify that DSpace has stopped
```shell
docker ps
```

### Delete docker Volumes
_This will allow you to build a fresh installation with new data._

```shell
docker volume rm d6_assetstore d6_pgdata d6_solr_authority d6_solr_oai d6_solr_search d6_solr_statistics
```
