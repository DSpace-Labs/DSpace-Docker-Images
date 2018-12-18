# winpty docker run --rm -it --network ${DPROJ}_dspacenet -v ${DPROJ}_assetstore://dspace/assetstore -v ${DPROJ}_solr://dspace/solr -v /${PWD}/../../add-ons/mount_ingest_tools://ingest-tools -e JAVA_OPTS="-Ddspace.hostname=dspace -Ddspace.baseUrl=http://dspace:8080 -Dsolr.server=http://dspace:8080/solr" dspace/dspace:pr2275 //bin/bash

winpty docker run --rm -it --network ${DPROJ}_dspacenet --volumes-from dspace -e JAVA_OPTS="-Ddspace.hostname=dspace -Ddspace.baseUrl=http://dspace:8080 -Dsolr.server=http://dspace:8080/solr" dspace/dspace:${DSPACE_VER} //dspace/bin/dspace index-discovery
