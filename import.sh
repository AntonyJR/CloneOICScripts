#!/bin/bash
. ./env.sh

# EXPORTED FILENAME REQUIRED
if [ "$1" == "" ]; then
  echo Import Filename required
  exit -1
fi

# CHECK IF IMPORT STATE PROVIDED AND VALIDATE
if [ "$2" != "" ]; then
  IMPORT_STATE=$2
fi
if [[ ! "${IMPORT_STATE}" =~ ^("ImportOnly"|"ActivateOnly"|"ImportActivate")$ ]]; then
  echo Import State must be one of ImportOnly, ActivateOnly or ImportActivate
  exit -2
fi

# Generate Endpoints & Credentials
get_storage_url
get_storage_credentials
get_tgt_oic_host
get_tgt_oic_credentials

# IMPORT ARCHIVE
curl ${CURL_FLAGS} -H "Content-Type: application/json" -X POST -d '
{
  "archiveFile": "'"$1"'",
  "importActivateMode": "'"${IMPORT_STATE}"'",
  "storageInfo": {
    "storageUrl": "'"${STORAGE_URL}"'",
    "storageUser": "'"${STORAGE_USER}"'",
    "storagePassword": "'"${STORAGE_PASSWORD}"'"
  }
}' -u "${TGT_OIC_CREDENTIALS}" ${TGT_OIC_HOST}/ic/api/common/v1/importServiceInstanceArchive
