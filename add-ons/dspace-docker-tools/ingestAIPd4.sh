#!/bin/sh
# Once this file has been saved to a docker volume, the ingest step will not be re-run
CHECKFILE=/dspace/assetstore/ingest.hasrun.flag

export JAVA_OPTS="${JAVA_OPTS} -Xmx2500m -Dupload.temp.dir=/dspace/upload -Djava.io.tmpdir=/tmp"
echo ${LOCALCFG1} >> /dspace/config/local.cfg
echo ${LOCALCFG2} >> /dspace/config/local.cfg
echo ${LOCALCFG3} >> /dspace/config/local.cfg

if [ ! -f $CHECKFILE ]
then
  # On the first startup of a new DSpace instance, this script will run the background
  sleep ${AIPWAIT:-0}
  /dspace-docker-tools/createAdmin.sh
  AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/dogAndReport.zip}
  ADMIN_EMAIL=${ADMIN_EMAIL:-test@test.edu}
  if [ ! -z $AIPZIP -a $SKIPAIP != 'Y' ]
  then
    AIPDIR=/tmp/aip-dir
    rm -rf ${AIPDIR}
    mkdir ${AIPDIR} /dspace/upload
    cd ${AIPDIR}
    pwd
    curl ${AIPZIP} -L -s --output aip.zip
    unzip aip.zip
    cd ${AIPDIR}

    # Needed for dspace 4
    /dspace/bin/dspace registry-loader -dc /dspace/config/registries/dublin-core-types.xml
    /dspace/bin/dspace registry-loader -bitstream /dspace/config/registries/bitstream-formats.xml

    /dspace/bin/dspace packager -r -a -t AIP -e ${ADMIN_EMAIL} -f -u SITE*.zip
    # touch /dspace/solr/search/conf/reindex.flag
    echo "Run \n\tdocker exec -it dspacedb /dspace-docker/tools/updateSequences.sql"
  fi
  touch $CHECKFILE
fi

sleep ${DBWAIT:-0}
catalina.sh run
