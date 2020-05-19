#!/bin/bash
. ./env.sh

# EXPORTED FILENAME REQUIRED
if [ "$1" == "" ]; then
  echo Exported Filename required
  exit -1
fi


# Generate Endpoints & Credentials
get_storage_url
get_storage_credentials
get_replica_storage_url
get_replica_storage_credentials

# RETRIEVE EXPORT ARCHIVE
curl ${CURL_FLAGS} -X GET -u "${STORAGE_CREDENTIALS}" -o $1 ${STORAGE_URL}/$1

# POST ARCHIVE TO BUCKET
curl ${CURL_FLAGS} -X PUT -u "${REPLICA_STORAGE_CREDENTIALS}" -T $1 \
     -H "Content-Type: application/octet-stream" \
     ${REPLICA_STORAGE_URL}/

#REMOVE DOWNLAODED ARCHIVE
rm $1