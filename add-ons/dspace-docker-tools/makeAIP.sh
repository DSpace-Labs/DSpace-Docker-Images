#!/bin/sh
AIPOUT=/tmp/aipout
rm -rf ${AIPOUT}
mkdir ${AIPOUT}
cd ${AIPOUT}
export JAVA_OPTS="-Xmx1500m -Dupload.temp.dir=/tmp -Djava.io.tmpdir=/tmp"
/dspace/bin/dspace packager -d -a -t AIP -i 123456789/0 -e test@test.edu -u SITE.zip
