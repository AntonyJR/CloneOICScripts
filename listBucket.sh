#!/bin/bash
. ./env.sh

# CHECK CREDENTIALS PROVIDED
get_storage_url "$1" "$2" "$3"
get_storage_credentials "$4" "$5"

# GET STATUS
curl ${CURL_FLAGS} -X GET -u "${STORAGE_CREDENTIALS}" ${STORAGE_URL}
