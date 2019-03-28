#!/bin/sh

function checkOutput {
  egrep $1 /tmp/out.txt > /dev/null
  if [ $? -ne 0 ]
  then
    (>&2 echo " *** ERROR $2")
    cat /tmp/out.txt
  fi
}

function checkUrl {
  NAME=$1
  URL=$2
  EXPECTED=$3
  echo "  ---> ${NAME} ${URL} "
  curl -s -I -L $URL | grep "^HTTP" > /tmp/out.txt
  checkOutput $EXPECTED $NAME
}

BR=${BASEROOT:-http://localhost:8080}
BASE=http://localhost
TOM=${BASE}:8080
SOLR=${BASE}:8983/solr
checkUrl "Tomcat" $TOM 200
checkUrl "Spring-Rest" ${BR} 200
checkUrl "Angular" ${BASE}:3000 200
checkUrl "Legacy-Rest" ${TOM}/rest 200
checkUrl "OAI" ${BR}/oai/request?verb=Identify 200
checkUrl "RDF" ${BR}/rdf/handle/123456789/1/rdf?text=true 200
checkUrl "Triplestore" ${BASE}:3030 200
# checkUrl "SOLR-Embedded" ${TOM}/solr 200
checkUrl "SOLR-External" ${SOLR} 200
# checkUrl "SOLR-Authority" ${SOLR}/authority/select?q=*%3A* 200
# checkUrl "SOLR-OAI" ${SOLR}/authority/select?q=*%3A* 200
# checkUrl "SOLR-Search" ${SOLR}/authority/select?q=*%3A* 200
# checkUrl "SOLR-Statistics" ${SOLR}/authority/select?q=*%3A* 200

echo "  ---> Sword v1 ${BR}/sword/deposit/123456789/4"
curl -i --data-binary "@sword/example.zip" -H "Content-Disposition:filename=sword/example.zip" -H "Content-Type:application/zip" -H "X-Packaging:http://purl.org/net/sword-types/METSDSpaceSIP" -u test@test.edu:admin -X POST ${BR}/sword/deposit/123456789/4 2>&1 | grep "^HTTP" > /tmp/out.txt
checkOutput 201 "Sword v1"

echo "  ---> Sword v2 ${BR}/swordv2/collection/123456789/3"
curl -i --data-binary "@sword/example.zip" -H "Content-Disposition:attachment; filename=sword/example.zip" -H "Content-Type:application/zip" -H "Packaging:http://purl.org/net/sword/package/METSDSpaceSIP" -u test@test.edu:admin -X POST ${BR}/swordv2/collection/123456789/3 2>&1 | grep "^HTTP" > /tmp/out.txt
checkOutput 201 "Sword v2"
