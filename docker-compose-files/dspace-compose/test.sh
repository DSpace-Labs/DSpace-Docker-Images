# winpty docker run --rm -it --network ${DPROJ}_dspacenet -v ${DPROJ}_assetstore://dspace/assetstore -v ${DPROJ}_solr://dspace/solr -v /${PWD}/../../add-ons/mount_ingest_tools://ingest-tools -e JAVA_OPTS="-Ddspace.hostname=dspace -Ddspace.baseUrl=http://dspace:8080 -Dsolr.server=http://dspace:8080/solr" dspace/dspace:pr2275 //bin/bash

winpty docker exec -it dspace //ingest-tools/createAdmin.sh

winpty docker exec -it dspace //ingest-tools/ingestAIP.sh
# winpty docker run --rm -it --network ${DPROJ}_dspacenet --volumes-from dspace -e JAVA_OPTS="-Ddspace.hostname=dspace -Ddspace.baseUrl=http://dspace:8080 -Dsolr.server=http://dspace:8080/solr" dspace/dspace:${DSPACE_VER} //ingest-tools/ingestAIP.sh

sleep 5

winpty docker exec -it dspacedb psql -U dspace -f //ingest-tools/updateSequences.sql
