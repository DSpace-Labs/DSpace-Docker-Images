#!/bin/sh
ADMIN_EMAIL=${ADMIN_EMAIL:-test@test.edu}
ADMIN_PASS=${ADMIN_PASS:-admin}
ADMIN_FNAME=${ADMIN_FNAME:-Admin}
ADMIN_LNAME=${ADMIN_LNAME:-User}
#AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/DogPhotosAIP.zip}
AIPZIP=${AIPZIP:-}

/dspace/bin/dspace create-administrator -e ${ADMIN_EMAIL} -f ${ADMIN_FNAME} -l ${ADMIN_LNAME} -p ${ADMIN_PASS} -c en

if [ "$AIPZIP" != "" ]
then
  AIPDIR=/tmp/aip-dir
  rm -rf ${AIPDIR}
  mkdir ${AIPDIR}

  cd ${AIPDIR}
  pwd
  curl ${AIPZIP} -L -s --output aip.zip
  unzip aip.zip

  export JAVA_OPTS="-Xmx1500m -Dupload.temp.dir=/tmp"
  cd ${AIPDIR}
  /dspace/bin/dspace packager -r -a -t AIP -e test@test.edu -f -u SITE*.zip
  touch /dspace/solr/search/conf/reindex.flag
fi

export JAVA_OPTS="-Xmx1500m"
catalina.sh run
