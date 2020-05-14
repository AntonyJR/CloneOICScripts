#!/bin/bash
. ./env.sh

# CHECK CREDENTIALS PROVIDED
get_storage_url
get_storage_credentials

# GET STATUS
curl ${CURL_FLAGS} -X GET -u "${STORAGE_CREDENTIALS}" ${STORAGE_URL}