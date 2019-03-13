#!/bin/sh
# Once this file has been saved to a docker volume, the ingest step will not be re-run
CHECKFILE=/dspace/assetstore/ingest.hasrun.flag

env | egrep "__.*=" | egrep -v "=.*__" | sed -e s/__/./g > /dspace/config/environment.cfg

export JAVA_OPTS="${JAVA_OPTS} -Xmx2500m -Dupload.temp.dir=/dspace/upload -Djava.io.tmpdir=/tmp"

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

    /dspace/bin/dspace packager -r -a -t AIP -e ${ADMIN_EMAIL} -f -u SITE*.zip
    /dspace/bin/dspace database update-sequences
    /dspace/bin/dspace index-discovery
  fi
  touch $CHECKFILE
fi

sleep ${DBWAIT:-0}
catalina.sh run
