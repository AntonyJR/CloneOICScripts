#!/bin/bash

# STORAGE
# OIC Docs https://docs.oracle.com/en/cloud/paas/integration-cloud/integration-cloud-auton/export-integration-and-process-design-time-metadata-instances.html
# OIC Docs https://docs.oracle.com/en/cloud/paas/integration-cloud/ics-pcs-migration-to-oci-b/step-3-create-object-storage-bucket-and-construct-storage-url.html
# STORAGE_REGION is OCI region us-region-1, eu-frankfurt-1 etc.
# STORAGE_TENANCY is tenancy name used when logging in
# STORAGE_BUCKET is bucket used to store exported archive
# STORAGE_USER should be prefaced by "oracleidentitycloudservice/" if using IDCS federated user
# STORAGE PASSWORD is OCI Auth Token
STORAGE_REGION=
STORAGE_TENANCY=
STORAGE_BUCKET=
STORAGE_USER=
STORAGE_PASSWORD=

# Replica is only used by the copy_export.sh script to copy the export from one bucket to another.
# Using Object Storage replication does not help here as replica storage buckets are read only and the
# import operation requires a writeable bucket for unzipping archives and writing log files.
# REPLICA_STORAGE_REGION is OCI region us-region-1, eu-frankfurt-1 etc.
# REPLICA_STORAGE_TENANCY is tenancy name used when logging in
# REPLICA_STORAGE_BUCKET is bucket used to store exported archive
# REPLICA_STORAGE_USER should be prefaced by "oracleidentitycloudservice/" if using IDCS federated user
# REPLICA_STORAGE PASSWORD is OCI Auth Token
REPLICA_STORAGE_REGION=
REPLICA_STORAGE_TENANCY=
REPLICA_STORAGE_BUCKET=
REPLICA_STORAGE_USER=
REPLICA_STORAGE_PASSWORD=

# SOURCE OIC
# User needs Admin Role
# Host format https://hostname
SRC_OIC_HOST=
SRC_OIC_USERNAME=
SRC_OIC_PASSWORD=

# TARGET OIC
# User needs Admin Role
# Host format https://hostname
TGT_OIC_HOST=
TGT_OIC_USERNAME=
TGT_OIC_PASSWORD=

# Possible Values: ImportOnly ActivateOnly ImportActivate
IMPORT_STATE=

# Flags used in request
# -k
#   Insecure, ignore bad certificates
# -v
#   Verbose
# -w \nHTTP_STATUS=%{http_code}\n
#   Show HTTP status code
CURL_FLAGS=""

#
# Helper Functions used to Validate Variables have Values
#

# READ FUNCTION
# $1 is Variable to Set if empty
# $2 is Prompt
# $3 is optional flag to read - usually used for -s to suppress password
read_if_empty() {
  while [ "${!1}" == "" ]; do
    read -p "$2" $3 $1
    if [ "$3" == "-s" ]; then
      echo
    fi
  done
}

# Generates STORAGE_URL
get_storage_url() {
  read_if_empty STORAGE_REGION "Storage Region > "
  read_if_empty STORAGE_TENANCY "Storage Tenancy Name > "
  read_if_empty STORAGE_BUCKET "Storage Bucket > "
  STORAGE_URL=https://swiftobjectstorage.${STORAGE_REGION}.oraclecloud.com/v1/${STORAGE_TENANCY}/${STORAGE_BUCKET}
}

# Generates STORAGE CREDENTIALS
get_storage_credentials() {
  read_if_empty STORAGE_USER "Storage Username (preface with oracleidentitycloudservice/ if using IDCS) > "
  read_if_empty STORAGE_PASSWORD "Storage Password > " -s
  STORAGE_CREDENTIALS="${STORAGE_USER}:${STORAGE_PASSWORD}"
}

# Generates REPLICA_STORAGE_URL
get_replica_storage_url() {
  read_if_empty REPLICA_STORAGE_REGION "Replica Storage Region > "
  read_if_empty REPLICA_STORAGE_TENANCY "Replica Storage Tenancy Name > "
  read_if_empty REPLICA_STORAGE_BUCKET "Replica Storage Bucket > "
  REPLICA_STORAGE_URL=https://swiftobjectstorage.${REPLICA_STORAGE_REGION}.oraclecloud.com/v1/${REPLICA_STORAGE_TENANCY}/${REPLICA_STORAGE_BUCKET}
}

# Generates STORAGE CREDENTIALS
get_replica_storage_credentials() {
  read_if_empty REPLICA_STORAGE_USER "Replica Storage Username (preface with oracleidentitycloudservice/ if using IDCS) > "
  read_if_empty REPLICA_STORAGE_PASSWORD "Replica Storage Password > " -s
  REPLICA_STORAGE_CREDENTIALS="${REPLICA_STORAGE_USER}:${REPLICA_STORAGE_PASSWORD}"
}

# Generates SRC_OIC_CREDENTIALS
get_src_oic_credentials() {
  read_if_empty SRC_OIC_USERNAME "Source OIC Username > "
  read_if_empty SRC_OIC_PASSWORD "Source OIC Password > " -s
  SRC_OIC_CREDENTIALS="${SRC_OIC_USERNAME}:${SRC_OIC_PASSWORD}"
}

# Generates TGT_OIC_CREDENTIALS
get_tgt_oic_credentials() {
  read_if_empty TGT_OIC_USERNAME "Target OIC Username > "
  read_if_empty TGT_OIC_PASSWORD "Target OIC Password > " -s
  TGT_OIC_CREDENTIALS="${TGT_OIC_USERNAME}:${TGT_OIC_PASSWORD}"
}

# Generate SRC_OIC_HOST
get_src_oic_host () {
  read_if_empty SRC_OIC_HOST "Source OIC base URL (https://host.domain.com) > "
}

# Generate TGT_OIC_HOST
get_tgt_oic_host () {
  read_if_empty TGT_OIC_HOST "Target OIC base URL (https://host.domain.com) > "
}
