#!/bin/sh
AIPZIP=${AIPZIP:-https://github.com/DSpace-Labs/AIP-Files/raw/master/DogPhotosAIP.zip}

AIPDIR=/tmp/aip-dir
rm -rf ${AIPDIR}
mkdir ${AIPDIR}

cd ${AIPDIR}
pwd
curl ${AIPZIP} -L -s --output aip.zip
unzip aip.zip
