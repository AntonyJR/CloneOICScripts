#!/bin/sh
. ./env.sh

get_group_name $1
get_idcs_at_cc

get_group_id

curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" ${IDCS_URL}/admin/v1/Groups/${GROUP_ID}?attributeSets=all
