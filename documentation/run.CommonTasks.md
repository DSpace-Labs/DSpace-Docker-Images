## Tasks for running DSpace instances

### Index Content

MacOS/Linux
```shell
docker exec dspace /dspace/bin/dspace index-discovery
```

Windows
```shell
docker exec dspace //dspace/bin/dspace index-discovery
```

### Create an additional admin user
_Note that a default admin is configured when the DSpace instance started._

MacOS/Linux
```shell
docker exec dspace /dspace/bin/dspace create-administrator
```

Windows
```shell
winpty docker exec dspace //dspace/bin/dspace create-administrator
```

### Filter Media

MacOS/Linux
```shell
docker exec dspace /dspace/bin/dspace filter-media
```

Windows
```shell
docker exec dspace //dspace/bin/dspace filter-media
```

## Other Configuration Tasks

_The following tasks have not yet been documented._

### Create a DSpace instance without AIP Content

### Create a DSpace instance with different AIP content

### Create a DSpace instance with different admin credentials

### Create a DSpace instance from a DSpace pull request
