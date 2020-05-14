#!/bin/bash
. ./env.sh

# JOB ID REQUIRED
if [ "$1" == "" ]; then
    echo Job ID required
    exit -1
fi

get_tgt_oic_host
get_tgt_oic_credentials

# GET STATUS
# echo curl ${CURL_FLAGS} -X GET -u ${SRC_OIC_CREDENTIALS} ${SRC_OIC_HOST}/icsapis/v2/clonepod/exportStatus
curl ${CURL_FLAGS} -X GET -u ${TGT_OIC_CREDENTIALS} ${TGT_OIC_HOST}/ic/api/common/v1/importServiceInstanceArchive/$1