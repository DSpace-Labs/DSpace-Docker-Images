#!/bin/sh
ADMIN_EMAIL=${ADMIN_EMAIL:-test@test.edu}
AIPOUT=/tmp/aipout
rm -rf ${AIPOUT}
mkdir ${AIPOUT} /dspace/upload
cd ${AIPOUT}
export JAVA_OPTS="-Xmx1500m -Dupload.temp.dir=/dspace/upload -Djava.io.tmpdir=/tmp"
/dspace/bin/dspace packager -d -a -t AIP -i 123456789/0 -e ${ADMIN_EMAIL} -u SITE.zip
