#!/bin/bash
. ./env.sh

# Generate Endpoints & Credentials
get_exported_filename "$1"
get_import_state "$2"
get_storage_url "$3" "$4" "$5"
get_storage_credentials "$6" "$7"
get_tgt_oic_host "$8"
get_tgt_oic_credentials "$9" "${10}"

# IMPORT ARCHIVE
curl ${CURL_FLAGS} -H "Content-Type: application/json" -X POST -d '
{
  "archiveFile": "'"$EXPORTED_FILENAME"'",
  "importActivateMode": "'"${IMPORT_STATE}"'",
  "storageInfo": {
    "storageUrl": "'"${STORAGE_URL}"'",
    "storageUser": "'"${STORAGE_USER}"'",
    "storagePassword": "'"${STORAGE_PASSWORD}"'"
  }
}' -u "${TGT_OIC_CREDENTIALS}" ${TGT_OIC_HOST}/ic/api/common/v1/importServiceInstanceArchive
