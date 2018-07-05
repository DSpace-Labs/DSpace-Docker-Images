# Running DSpace with Docker compose

## 1. Using Docker Compose

- cd to the **dspace-compose** directory

Run Docker compose
_In the following example, "d6" is being passed as a "compose project name".  This will be used to prefix the name of the network and volumes created by Docker.  This will permit you to maintain multiple variants of a DSpace install (ie DSpace 5 and DSpace 6)._

    docker-compose -p d6 up -d

## 2. Configuring DSpace Admin and Content

#### Use the tomcat bash terminal to configure the DSpace administrator

    docker exec -it --detach-keys "ctrl-p" d6_dspacetomcat_1 /bin/bash

Bash Command
```
/dspace/bin/dspace create-administrator -e test@test.edu -f Admin -l User -p admin -c en
```

### Load AIP Files into DSpace

Identify a set of AIP files to use for testing.

A sample set is located [here](https://github.com/DSpace-Labs/DSpace-codenvy/tree/master/TestData).

#### Copy the AIP files to the Docker Image

In the **dspacetomcat bash terminal**, create an input directory

    mkdir /tmp/testdata

To facilitate the data import, use docker cp.

    docker cp **yourLocalTestDataDir** d6_dspacetomcat_1:/tmp/testdata

#### Load the AIP Files into DSpace

In the bash window created above, run the following command to import data.
```
cd /tmp/testdata
```

```
for file in COMM* COLL* ITEM*;
do
  /dspace/bin/dspace packager -r -t AIP -e test@test.edu -f -u $file
done
```

#### Update the sequences in the DSpace database

It is a long standing issue with AIP import files that necessitates reseting sequences after importing content from AIP Files.

In the **dspacedb psql terminal**, run the following SQL to reset the database sequences.

    docker exec -it --detach-keys "ctrl-p" d6_dspacedb_1 psql -U dspace

SQL
```
SELECT
  setval(
    'handle_seq',
    CAST (
      max(
      to_number(
          regexp_replace(handle, '.*/', ''),
          '999999999999'
        )
      )
      AS BIGINT
    )
  )
FROM handle
WHERE handle SIMILAR TO '%/[0123456789]*';
```

## 3. Open DSpace in a Browser
- DSpace 5 or 6: http://localhost:8080/xmlui
- DSpace 7: http://localhost:8080/spring-rest

## 4. Stopping DSpace

    docker-compose -p d6 stop

After stopping your instances, note that the volumes have persisted.

    docker volume ls

Sample Output
```
DRIVER              VOLUME NAME
local               269bb301cec95f0bcb1c6f0b5e0947c33308d59628185856eb727a08f654980e
local               d6_dspace
local               d6_pgdata
```

## 5. Restarting DSpace
_When DSpace is restarted, the contents of your volumes will be restored_

    docker-compose -p d6 start
