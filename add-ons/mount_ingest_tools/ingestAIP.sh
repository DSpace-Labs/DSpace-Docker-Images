#!/bin/sh
AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/DogPhotosAIP.zip}
AIPDIR=/tmp/aip-dir
rm -rf ${AIPDIR}
mkdir ${AIPDIR}
cd ${AIPDIR}
pwd
curl ${AIPZIP} -L -s --output aip.zip
unzip aip.zip
export JAVA_OPTS="${JAVA_OPTS} -Xmx1500m -Dupload.temp.dir=/tmp"
cd ${AIPDIR}
/dspace/bin/dspace packager -r -a -t AIP -e test@test.edu -f -u SITE*.zip
touch /dspace/solr/search/conf/reindex.flag
