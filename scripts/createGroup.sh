#!/bin/sh
. ./env.sh

get_group_name $1
get_idcs_at_cc

CREATE_GROUP_REQUEST='{
  "schemas": [
    "urn:ietf:params:scim:schemas:core:2.0:Group",
    "urn:ietf:params:scim:schemas:oracle:idcs:extension:group:Group"
  ],
  "displayName": "'${GROUP_NAME}'"
}'
curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" -X POST -H "Content-Type: application/json" -d "${CREATE_GROUP_REQUEST}" ${IDCS_URL}/admin/v1/Groups
