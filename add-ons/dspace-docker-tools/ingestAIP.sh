#!/bin/sh
# Once this file has been saved to a docker volume, the ingest step will not be re-run
CHECKFILE=/dspace/assetstore/ingest.hasrun.flag

# Shell scripts are unable to pass environment variables containing a period.
# By DSPACE convention, a double underbar will be used to set such variables.
#
#   dpsace__path=/dspace --> dspace.path=/dspace
#
# DSpace 7 is able to make this conversion in Apache Commons Config code.
#
# The following script code is designed to provide similar flexibility to earlier
# versions of DSpace running in docker.
if [ "$SCRIPTVER" -ge 6 ]
then
  # Overwrite local.cfg for DSpace 6
  # __D__ -> -
  # __P__ -> .
  env | egrep "__.*=" | egrep -v "=.*__" | sed -e s/__P__/\./g | sed -e s/__D__/-/g > /dspace/config/local.cfg
elif [ "$SCRIPTVER" -lt 6 ]
then
  # Substitute values in dspace.cfg for DSpace 5 and DSpace 4
  VARS=`env | egrep "__.*="|cut -f1 -d=` | sed -e "s/__P__/\./g" | sed -e "s/__D__/-/g"
  for v in $VARS
  do
    grep -v "^${v}=" /dspace/config/dspace.cfg > /dspace/config/dspace.cfg
  done
  env | egrep "__.*=" | egrep -v "=.*__" | sed -e "s/__P__/./g" | sed -e "s/__D__/-/g" >> /dspace/config/dspace.cfg
fi

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

    if [ "$SCRIPTVER" -eq 4 ]
    then
      /dspace/bin/dspace registry-loader -dc /dspace/config/registries/dublin-core-types.xml
      /dspace/bin/dspace registry-loader -bitstream /dspace/config/registries/bitstream-formats.xml
    fi

    /dspace/bin/dspace packager -r -a -t AIP -e ${ADMIN_EMAIL} -f -u SITE*.zip

    if [ "$SCRIPTVER" -ne 4 ]
    then
      /dspace/bin/dspace database update-sequences
      /dspace/bin/dspace index-discovery
    fi
  fi
  touch $CHECKFILE
fi

sleep ${DBWAIT:-0}
catalina.sh run
