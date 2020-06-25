#!/bin/sh
. ./env.sh

get_integration "$1"
get_region "$2"
get_idcs_at_cc

IDCS_APPLICATION_NAME=`./getIntegration.sh "$1" "$2" | jq -r '.data."instance-url"|split(".")[0][8:]'`
curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" ${IDCS_URL}/admin/v1/Apps?filter=displayName+eq+%22${IDCS_APPLICATION_NAME}%22