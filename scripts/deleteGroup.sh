#!/bin/sh
. ./env.sh

get_idcs_at_cc
get_group_id $1
echo Deleting $GROUP_NAME $GROUP_ID
curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" -X DELETE ${IDCS_URL}/admin/v1/Groups/${GROUP_ID}