{% include nav.html %}
## Running DSpace 7 With Entities

Our recommended Docker installation instructions are [here](https://dspace-labs.github.io/DSpace-Docker-Images/documentation/tutorialSetup.html).  Be sure to configure Docker with at least 6G of RAM when running this test.

A test dataset exists to illustrate the functionality of **DSpace Configurable Entities** .

An optional docker compose file exists to trigger the population of new DSpace containers with this content.

### Go to the Docker Compose Directory
```shell
cd
cd DSpace-Docker-Images/docker-compose-files/dspace-compose
```

### Ingest the Entities Test Dataset and Start DSpace 7

To run the __DSpace 7 Preview Release__ images.
```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f d7.preview.yml -f load.entities.yml pull
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f d7.preview.yml -f load.entities.yml up -d
```

To run the __latest DSpace 7__ images.
```shell
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f load.entities.yml pull
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f load.entities.yml up -d
```

Verify that DSpace is Running
```shell
docker ps
```
It will take approximately 5 minutes for the services to start completely.  Once they have started, you can view them on the web.

- [http://localhost:8080/spring-rest](http://localhost:8080/spring-rest)
- [http://localhost:3000](http://localhost:3000)

#### To stop the services

```
docker-compose -p d7ent -f docker-compose.yml -f d7.override.yml -f d7.preview.yml -f load.entities.yml down
```

Verify that DSpace has stopped
```shell
docker ps
```

#### On subsequent restart, you do not need the load.entities.yml file

To run the __DSpace 7 Preview Release__ images.
```
docker-compose -p d7ent -f docker-compose.yml -f d7.override.yml -f d7.preview.yml up -d
```

To run the __latest DSpace 7__ images.
```
docker-compose -p d7ent -f docker-compose.yml -f d7.override.yml up -d
```

### Testing the entities functionality

#### Test User credentials

| e-mail | password |
| ------ | -------- |
| dspacedemo+submit@gmail.com | dspace |
| dspacedemo+admin@gmail.com | dspace |
| dspacedemo+acceptreject@gmail.com | dspace |
| dspacedemo+acceptrejectedit@gmail.com | dspace |
| dspacedemo+edit@gmail.com | dspace |

#### Collections of interest

The following URL's will illustrate key Configurable Entities features.

- [View Journal Volume](http://localhost:3000/items/f9b89a11-b44e-4a64-a3b4-ab24a33553c7)
- Additional recommendations needed

### Next steps

See [Common Tasks](run.CommonTasks.md) for additional actions you can take with your DSpace instance.

Note: In DSpace 7, content does not yet automatically index on startup.  See the link above to index the content.

### Delete docker Volumes
_This will allow you to build a fresh installation with new data._

```shell
docker volume rm d7_assetstore d7_pgdata d7_solr_authority d7_solr_oai d7_solr_search d7_solr_statistics
```
