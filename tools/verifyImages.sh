#!/bin/sh
# CD to docker-compose dir
export DOCKER_OWNER=${DOCKER_OWNER:-dspace}
export DPROJ=test-image

function checkOutput {
  egrep $1 /tmp/out.txt > /dev/null
  if [ $? -ne 0 ]
  then
    (>&2 echo " *** ERROR $2")
    cat /tmp/out.txt
  fi
}


function checkImage {

  removeVols > /dev/null 2> /dev/null
  export DSPACE_VER=$1
  export DSPACE_REGEX=$2
  export JRE_REGEX=$3
  export STAT_XMLUI=$4
  export STAT_OAI=$5
  export STAT_SOLR=$6
  export STAT_REST=$7
  docker-compose -p $DPROJ -f docker-compose.yml -f verify.yml up -d > /dev/null 2> /dev/null
  echo " ===== ${DOCKER_OWNER}/dspace:${DSPACE_VER} ===== "
  docker exec dspace //dspace/bin/dspace version | egrep "DSpace version:|JRE:" > /tmp/out.txt
  cat /tmp/out.txt
  checkOutput ${DSPACE_REGEX} "Unexpected DSpace Version - Expected ${DSPACE_REGEX}"
  checkOutput ${JRE_REGEX} "Unexpected JRE Version - Expected ${JRE_REGEX}"

  checkUrl xmlui
  checkOutput ${STAT_XMLUI} "Unexpected XMLUI Stat - Expected ${STAT_XMLUI}"

  checkUrl oai/request
  checkOutput ${STAT_OAI} "Unexpected OAI Stat - Expected ${STAT_OAI}"

  checkUrl solr
  checkOutput ${STAT_SOLR} "Unexpected SOLR Stat - Expected ${STAT_SOLR}"

  checkUrl rest
  checkOutput ${STAT_REST} "Unexpected REST Stat - Expected ${STAT_REST}"

  docker-compose -p $DPROJ down > /dev/null 2> /dev/null
}

function checkUrl {
  URL="http://localhost:8080/$1"
  echo "  ---> ${URL} "
  curl -s -I -L $URL | grep "^HTTP" > /tmp/out.txt
}

function removeVols {
  vols=`docker volume ls --format "{{.Labels}};{{.Name}}"|grep "com.docker.compose.project=${DPROJ}"|cut -d';' -f2`
  for vol in $vols
  do
    docker volume rm $vol
  done
}

#
# Default Images - SOLR and REST* are inaccessible
# ------------------------------------------------
# checkImg imageName            DSpaceVersion JRE-Version   XML OAI SLR RST
# -------- ---------------      ------------- ------------- --- --- --- ---
checkImage dspace-7_x-jdk8      7.0-SNAPSHOT  "version 1.8" 404 200 403 302
checkImage dspace-6_x-jdk8      6.4-SNAPSHOT  "version 1.8" 200 200 403 302
checkImage dspace-5_x-jdk8      5.11-SNAPSHOT "version 1.8" 200 200 403 302
checkImage dspace-5_x-jdk7      5.11-SNAPSHOT "version 1.7" 200 200 403 302
# *REST restriction not in place in 4x; No schema for XMLUI
checkImage dspace-4_x-jdk7      4.10-SNAPSHOT "version 1.7" 500 200 403 200

# Test Images - SOLR and REST are accessible
# ------------------------------------------------
# checkImg imageName            DSpaceVersion JRE-Version   XML OAI SLR RST
# -------- ---------------      ------------- ------------- --- --- --- ---
checkImage dspace-7_x-jdk8-test 7.0-SNAPSHOT  "version 1.8" 404 200 200 200
checkImage dspace-6_x-jdk8-test 6.4-SNAPSHOT  "version 1.8" 200 200 200 200
checkImage dspace-5_x-jdk8-test 5.11-SNAPSHOT "version 1.8" 200 200 200 200
checkImage dspace-5_x-jdk7-test 5.11-SNAPSHOT "version 1.7" 200 200 200 200
checkImage dspace-4_x-jdk7-test 4.10-SNAPSHOT "version 1.7" 500 200 200 200
