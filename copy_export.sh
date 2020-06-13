#!/bin/bash
. ./env.sh

# Generate Endpoints & Credentials
get_exported_filename "$1"
get_storage_url "$2" "$3" "$4"
get_storage_credentials "$5" "$6"
get_replica_storage_url "$7" "$8" "$9"
get_replica_storage_credentials "${10}" "${11}"

# RETRIEVE EXPORT ARCHIVE
curl ${CURL_FLAGS} -X GET -u ${STORAGE_CREDENTIALS} -o ${EXPORTED_FILENAME} ${STORAGE_URL}/${EXPORTED_FILENAME}

# POST ARCHIVE TO BUCKET
curl ${CURL_FLAGS} -X PUT -u ${REPLICA_STORAGE_CREDENTIALS} -T ${EXPORTED_FILENAME} -H "Content-Type: application/octet-stream" ${REPLICA_STORAGE_URL}

#REMOVE DOWNLOADED ARCHIVE
rm ${EXPORTED_FILENAME}
