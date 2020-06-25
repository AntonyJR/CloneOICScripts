#!/bin/bash

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

# Generate STORAGE_REGION
get_storage_region() {
  if [ "$1" != "" ]; then
    STORAGE_REGION="$1"
  fi
  read_if_empty STORAGE_REGION "Storage Region > "
}

# Generate STORAGE_TENANCY
get_storage_tenancy() {
  if [ "$1" != "" ]; then
    STORAGE_TENANCY="$1"
  fi
  read_if_empty STORAGE_TENANCY "Storage Tenancy Name > "
}

# Generate STORAGE_BUCKET
get_storage_bucket() {
  if [ "$1" != "" ]; then
    STORAGE_BUCKET="$1"
  fi
  read_if_empty STORAGE_BUCKET "Storage Bucket > "
}

# Generates STORAGE_URL
get_storage_url() {
  get_storage_region $1
  get_storage_tenancy $2
  get_storage_bucket $3
  STORAGE_URL="https://swiftobjectstorage.${STORAGE_REGION}.oraclecloud.com/v1/${STORAGE_TENANCY}/${STORAGE_BUCKET}"
}

# Generates STORAGE CREDENTIALS
get_storage_credentials() {
  if [ "$1" != "" ]; then
    STORAGE_USER="$1"
  fi
  if [ "$2" != "" ]; then
    STORAGE_PASSWORD="$2"
  fi
  read_if_empty STORAGE_USER "Storage Username (preface with oracleidentitycloudservice/ if using IDCS) > "
  read_if_empty STORAGE_PASSWORD "Storage Password > " -s
  STORAGE_CREDENTIALS="${STORAGE_USER}:${STORAGE_PASSWORD}"
}

# Generate REPLICA_STORAGE_REGION
get_replica_storage_region() {
  if [ "$1" != "" ]; then
    REPLICA_STORAGE_REGION="$1"
  fi
  read_if_empty REPLICA_STORAGE_REGION "Replica Storage Region > "
}

# Generate REPLICA_STORAGE_TENANCY
get_replica_storage_tenancy() {
  if [ "$1" != "" ]; then
    REPLICA_STORAGE_TENANCY="$1"
  fi
  read_if_empty REPLICA_STORAGE_TENANCY "Replica Storage Tenancy Name > "
}

# Generate REPLICA_STORAGE_BUCKET
get_replica_storage_bucket() {
  if [ "$1" != "" ]; then
    REPLICA_STORAGE_BUCKET="$1"
  fi
  read_if_empty REPLICA_STORAGE_BUCKET "Replica Storage Bucket > "
}

# Generates REPLICA_STORAGE_URL
get_replica_storage_url() {
  get_storage_region $1
  get_storage_tenancy $2
  get_storage_bucket $3
  REPLICA_STORAGE_URL="https://swiftobjectstorage.${REPLICA_STORAGE_REGION}.oraclecloud.com/v1/${REPLICA_STORAGE_TENANCY}/${REPLICA_STORAGE_BUCKET}"
}

# Generates STORAGE CREDENTIALS
get_replica_storage_credentials() {
  if [ "$1" != "" ]; then
    REPLICA_STORAGE_USER="$1"
  fi
  if [ "$2" != "" ]; then
    REPLICA_STORAGE_PASSWORD="$2"
  fi
  read_if_empty REPLICA_STORAGE_USER "Replica Storage Username (preface with oracleidentitycloudservice/ if using IDCS) > "
  read_if_empty REPLICA_STORAGE_PASSWORD "Replica Storage Password > " -s
  REPLICA_STORAGE_CREDENTIALS="${REPLICA_STORAGE_USER}:${REPLICA_STORAGE_PASSWORD}"
}

# Generates SRC_OIC_CREDENTIALS
get_src_oic_credentials() {
  if [ "$1" != "" ]; then
    SRC_OIC_USERNAME="$1"
  fi
  if [ "$2" != "" ]; then
    SRC_OIC_PASSWORD="$2"
  fi
  read_if_empty SRC_OIC_USERNAME "Source OIC Username > "
  read_if_empty SRC_OIC_PASSWORD "Source OIC Password > " -s
  SRC_OIC_CREDENTIALS="${SRC_OIC_USERNAME}:${SRC_OIC_PASSWORD}"
}

# Generates TGT_OIC_CREDENTIALS
get_tgt_oic_credentials() {
  if [ "$1" != "" ]; then
    TGT_OIC_USERNAME="$1"
  fi
  if [ "$2" != "" ]; then
    TGT_OIC_PASSWORD="$2"
  fi
  read_if_empty TGT_OIC_USERNAME "Target OIC Username > "
  read_if_empty TGT_OIC_PASSWORD "Target OIC Password > " -s
  TGT_OIC_CREDENTIALS="${TGT_OIC_USERNAME}:${TGT_OIC_PASSWORD}"
}

# Generate SRC_OIC_HOST
get_src_oic_host() {
  if [ "$1" != "" ]; then
    SRC_OIC_HOST="$1"
  fi
  read_if_empty SRC_OIC_HOST "Source OIC base URL (https://host.domain.com) > "
}

# Generate TGT_OIC_HOST
get_tgt_oic_host() {
  if [ "$1" != "" ]; then
    TGT_OIC_HOST="$1"
  fi
  read_if_empty TGT_OIC_HOST "Target OIC base URL (https://host.domain.com) > "
}

# Get EXPORTED_FILENAME
get_exported_filename() {
  if [ "$1" != "" ]; then
    EXPORTED_FILENAME="$1"
  fi
  read_if_empty EXPORTED_FILENAME "Exported Filename > "
}

# GET IMPORT_STATE
get_import_state() {
  if [ "$1" != "" ]; then
    IMPORT_STATE="$1"
  fi
  read_if_empty IMPORT_STATE "Import State ( ImportOnly / ActivateOnly / ImportActivate ) > "
  if [[ ! "${IMPORT_STATE}" =~ ^("ImportOnly"|"ActivateOnly"|"ImportActivate")$ ]]; then
    echo Import State must be one of ImportOnly, ActivateOnly or ImportActivate
    exit 2
  fi
}

# Get JOB_ID
get_job_id() {
  if [ "$1" != "" ]; then
    JOB_ID="$1"
  fi
  read_if_empty JOB_ID "Job ID > "
}

# Get INTEGRATION_ID
get_integration() {
  if [ "$1" != "" ]; then
    INTEGRATION_ID="$1"
  fi
  read_if_empty INTEGRATION_ID "Integration ID > "
}

# Get COMPARTMENT_ID
get_compartment() {
  if [ "$1" != "" ]; then
    COMPARTMENT_ID="$1"
  fi
  read_if_empty COMPARTMENT_ID "Compartment ID > "
}

# Get REGION
get_region() {
  if [ "$1" != "" ]; then
    REGION="$1"
  fi
  read_if_empty REGION "Region > "
}

# GET DISPLAY_NAME
get_display_name() {
  if [ "$1" != "" ]; then
    DISPLAY_NAME="$1"
  fi
  read_if_empty DISPLAY_NAME "Display Name > "
}

# GET IS_BYOL
get_is_byol() {
  if [ "$1" != "" ]; then
    IS_BYOL="$1"
  fi
  read_if_empty IS_BYOL "Is BYOL ( true / false ) > "
  if [[ ! "${IS_BYOL}" =~ ^("true"|"false")$ ]]; then
    echo Is BYOL must be one of true or false
    exit 2
  fi
}

# GET MESSAGE_PACKS
get_message_packs() {
  if [ "$1" != "" ]; then
    MESSAGE_PACKS="$1"
  fi
  read_if_empty MESSAGE_PACKS "Message Packs > "
}

# GET TYPE
get_type() {
  if [ "$1" != "" ]; then
    TYPE="$1"
  fi
  read_if_empty TYPE "Type ( ENTERPRISE / STANDARD ) > "
  if [[ ! "${TYPE}" =~ ^("ENTERPRISE"|"STANDARD")$ ]]; then
    echo Type must be one of ENTERPRISE or STANDARD
    exit 2
  fi
}

# GET IDCS_AT_PWD
# OAuth Password Grant Type (don't ask....)
get_idcs_at_pwd() {
  if [ "$1" != "" ]; then
    IDCS_URL="$1"
  fi
  if [ "$2" != "" ]; then
    IDCS_CLIENT_ID="$2"
  fi
  if [ "$3" != "" ]; then
    IDCS_CLIENT_SECRET="$3"
  fi
  if [ "$4" != "" ]; then
    IDCS_USERNAME="$4"
  fi
  if [ "$5" != "" ]; then
    IDCS_PASSWORD="$5"
  fi
  read_if_empty IDCS_URL "IDCS_URL ( https://some.url ) > "
  read_if_empty IDCS_CLIENT_ID "IDCS Client ID > "
  read_if_empty IDCS_CLIENT_SECRET "IDCS Client Secret > " -s
  read_if_empty IDCS_USERNAME "IDCS Username > "
  read_if_empty IDCS_PASSWORD "IDCS Password > " -s

  IDCS_AT_PWD=$(curl "${CURL_FLAGS}" -u "$IDCS_CLIENT_ID:$IDCS_CLIENT_SECRET" $IDCS_URL/oauth2/v1/token -d "grant_type=password&scope=urn:opc:idm:__myscopes__&username=${IDCS_USERNAME}&password=${IDCS_PASSWORD}" | jq -r ".access_token")
}

# GET IDCS_AT_CC
# OAuth Client Credentials Grant Type
get_idcs_at_cc() {
  if [ "$1" != "" ]; then
    IDCS_URL="$1"
  fi
  if [ "$2" != "" ]; then
    IDCS_CLIENT_ID="$2"
  fi
  if [ "$3" != "" ]; then
    IDCS_CLIENT_SECRET="$3"
  fi
  read_if_empty IDCS_URL "IDCS_URL ( https://some.url ) > "
  read_if_empty IDCS_CLIENT_ID "IDCS Client ID > "
  read_if_empty IDCS_CLIENT_SECRET "IDCS Client Secret > " -s

  IDCS_AT_CC=$(curl "${CURL_FLAGS}" -u "$IDCS_CLIENT_ID:$IDCS_CLIENT_SECRET" $IDCS_URL/oauth2/v1/token -d "grant_type=client_credentials&scope=urn:opc:idm:__myscopes__" | jq -r ".access_token")
}

# GET WORK_REQUEST_ID
get_work_request() {
  if [ "$1" != "" ]; then
    WORK_REQUEST_ID="$1"
  fi
  read_if_empty WORK_REQUEST_ID "Work Request ID > "
}
