#!/bin/bash
. ./env.sh

# Generate Endpoints & Credentials
get_storage_url
get_storage_credentials
get_src_oic_host
get_src_oic_credentials

# START EXPORT
curl ${CURL_FLAGS} -H "Content-Type: application/json" -X POST -d '
{
  "storageInfo": {
    "storageUrl": "'"${STORAGE_URL}"'",
    "storageUser": "'"${STORAGE_USER}"'",
    "storagePassword": "'"${STORAGE_PASSWORD}"'"
  }
}' -u "${SRC_OIC_CREDENTIALS}" ${SRC_OIC_HOST}/ic/api/common/v1/exportServiceInstanceArchive