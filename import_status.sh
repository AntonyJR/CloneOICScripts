#!/bin/bash
. ./env.sh

get_job_id "$1"
get_tgt_oic_host "$2"
get_tgt_oic_credentials "$3" "$4"

# GET STATUS
curl ${CURL_FLAGS} -X GET -u "${TGT_OIC_CREDENTIALS}" ${TGT_OIC_HOST}/ic/api/common/v1/importServiceInstanceArchive/"$JOB_ID"
