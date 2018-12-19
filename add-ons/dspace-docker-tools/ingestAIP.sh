#!/bin/sh
# AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/DogPhotosAIP.zip}
CHECKFILE=/dspace/ingest.flag
if [ ! -f $CHECKFILE ]
then
  /dspace-docker-tools/createAdmin.sh
  AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/dogAndReport.zip}
  ADMIN_EMAIL=${ADMIN_EMAIL:-test@test.edu}
  if [ ! -z $AIPZIP ]
  then
    AIPDIR=/tmp/aip-dir
    rm -rf ${AIPDIR}
    mkdir ${AIPDIR}
    cd ${AIPDIR}
    pwd
    curl ${AIPZIP} -L -s --output aip.zip
    unzip aip.zip
    export JAVA_OPTS="${JAVA_OPTS} -Xmx1500m -Dupload.temp.dir=/tmp"
    cd ${AIPDIR}
    /dspace/bin/dspace packager -r -a -t AIP -e ${ADMIN_EMAIL} -f -u SITE*.zip
    # touch /dspace/solr/search/conf/reindex.flag
    echo "Run \n\tdocker exec -it dspacedb /dspace-docker/tools/updateSequences.sql"
  fi
  touch $CHECKFILE
fi

catalina.sh run
