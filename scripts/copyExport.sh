#!/bin/bash
. ./env.sh

# Generate Endpoints & Credentials
get_exported_filename "$1"
get_storage_url "$2" "$3" "$4"
get_replica_storage_url "$7" "$8" "$9"

#
NAMESPACE=`oci os ns get | jq -r ".data"`
oci os object copy --namespace-name ${NAMESPACE} --region ${STORAGE_REGION} --bucket-name ${STORAGE_BUCKET} --source-object-name ${EXPORTED_FILENAME} --destination-namespace ${NAMESPACE} --destination-region ${REPLICA_STORAGE_REGION} --destination-bucket ${REPLICA_STORAGE_BUCKET} --destination-object-name ${EXPORTED_FILENAME}
