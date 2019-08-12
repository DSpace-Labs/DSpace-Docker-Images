#/bin/sh
rm -rf ${AIPDIR}
mkdir ${AIPDIR} /dspace/upload
cd ${AIPDIR}
pwd
curl ${AIPZIP} -L -s --output aip.zip
unzip aip.zip
cd ${AIPDIR}

/dspace/bin/dspace packager -r -a -t AIP -e ${ADMIN_EMAIL} -f -u SITE*.zip
/dspace/bin/dspace database update-sequences
touch /dspace/solr/search/conf/reindex.flag

/dspace/bin/dspace oai import
/dspace/bin/dspace oai clean-cache
