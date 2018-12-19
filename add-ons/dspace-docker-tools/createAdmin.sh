#!/bin/sh
ADMIN_EMAIL=${ADMIN_EMAIL:-test@test.edu}
ADMIN_PASS=${ADMIN_PASS:-admin}
ADMIN_FNAME=${ADMIN_FNAME:-Admin}
ADMIN_LNAME=${ADMIN_LNAME:-User}
/dspace/bin/dspace create-administrator -e ${ADMIN_EMAIL} -f ${ADMIN_FNAME} -l ${ADMIN_LNAME} -p ${ADMIN_PASS} -c en
