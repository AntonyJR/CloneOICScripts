#!/bin/bash
. ./env.sh

# Generate Endpoints & Credentials
# shellcheck disable=SC2086
get_storage_url $1 $2 $3
get_storage_credentials "$4" "$5"
get_src_oic_host $6
get_src_oic_credentials "$7" "$8"

# START EXPORT
curl ${CURL_FLAGS} -H "Content-Type: application/json" -X POST -d '
{
  "storageInfo": {
    "storageUrl": "'"${STORAGE_URL}"'",
    "storageUser": "'"${STORAGE_USER}"'",
    "storagePassword": "'"${STORAGE_PASSWORD}"'"
  }
}' -u "${SRC_OIC_CREDENTIALS}" ${SRC_OIC_HOST}/ic/api/common/v1/exportServiceInstanceArchive
