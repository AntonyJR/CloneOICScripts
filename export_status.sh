#!/bin/bash
. ./env.sh

get_job_id "$1"
get_src_oic_host "$2"
get_src_oic_credentials "$3" $4

# GET STATUS
curl ${CURL_FLAGS} -X GET -u "${SRC_OIC_CREDENTIALS}" ${SRC_OIC_HOST}/ic/api/common/v1/exportServiceInstanceArchive/"${JOB_ID}"
