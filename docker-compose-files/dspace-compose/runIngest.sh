#!/bin/sh
source ./myenv.sh

winpty docker exec -it dspace //dspace-docker-tools/createAdmin.sh

winpty docker exec -it dspace //dspace-docker-tools/ingestAIP.sh

# It is possible to run this task in a separate container, but it is a bit complex.
# winpty docker run --rm -it --network ${DPROJ}_dspacenet --volumes-from dspace -e JAVA_OPTS="-Ddspace.hostname=dspace -Ddspace.baseUrl=http://dspace:8080 -Dsolr.server=http://dspace:8080/solr" dspace/dspace:${DSPACE_VER} //ingest-tools/ingestAIP.sh

sleep 5

winpty docker exec -it dspacedb //dspace-docker-tools/updateSequences.sh
