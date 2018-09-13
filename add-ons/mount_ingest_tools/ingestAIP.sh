#!/bin/sh
AIPDIR=${AIPDIR:-/tmp/aip-dir}
cd ${AIPDIR}
for file in COMM* COLL* ITEM*;
do
  /dspace/bin/dspace packager -r -t AIP -e test@test.edu -f -u $file
done
