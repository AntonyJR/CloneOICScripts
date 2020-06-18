#!/bin/bash

#############################
# IMPORT / EXPORT VARIABELS #
#############################

# STORAGE
# OIC Docs https://docs.oracle.com/en/cloud/paas/integration-cloud/integration-cloud-auton/export-integration-and-process-design-time-metadata-instances.html
# OIC Docs https://docs.oracle.com/en/cloud/paas/integration-cloud/ics-pcs-migration-to-oci-b/step-3-create-object-storage-bucket-and-construct-storage-url.html
# STORAGE_REGION is OCI region us-region-1, eu-frankfurt-1 etc.
# STORAGE_TENANCY is tenancy name used when logging in
# STORAGE_BUCKET is bucket used to store exported archive
# STORAGE_USER should be prefaced by "oracleidentitycloudservice/" if using IDCS federated user
# STORAGE PASSWORD is OCI Auth Token
export STORAGE_REGION=
export STORAGE_TENANCY=
export STORAGE_BUCKET=
export STORAGE_USER=
export STORAGE_PASSWORD=

# Replica is only used by the copyExport.sh script to copy the export from one bucket to another.
# Using Object Storage replication does not help here as replica storage buckets are read only and the
# import operation requires a writeable bucket for unzipping archives and writing log files.
# REPLICA_STORAGE_REGION is OCI region us-region-1, eu-frankfurt-1 etc.
# REPLICA_STORAGE_TENANCY is tenancy name used when logging in
# REPLICA_STORAGE_BUCKET is bucket used to store exported archive
# REPLICA_STORAGE_USER should be prefaced by "oracleidentitycloudservice/" if using IDCS federated user
# REPLICA_STORAGE PASSWORD is OCI Auth Token
export REPLICA_STORAGE_REGION=
export REPLICA_STORAGE_TENANCY=
export REPLICA_STORAGE_BUCKET=
export REPLICA_STORAGE_USER=
export REPLICA_STORAGE_PASSWORD=

# SOURCE OIC
# User needs Admin Role
# Host format https://hostname
export SRC_OIC_HOST=
export SRC_OIC_USERNAME=
export SRC_OIC_PASSWORD=

# TARGET OIC
# User needs Admin Role
# Host format https://hostname
export TGT_OIC_HOST=
export TGT_OIC_USERNAME=
export TGT_OIC_PASSWORD=

# EXPORTED FILENAME
export EXPORTED_FILENAME=

# IMPORT STATE
# Possible Values: ImportOnly ActivateOnly ImportActivate
export IMPORT_STATE=

# JOB ID
export JOB_ID=

############################
# OIC OPERATIONS VARIABLES #
############################

# INTEGRATION INSTANCE
# List of integration instances can be obtained using listIntegrations.sh
export INTEGRATION_ID=

# COMPARTMENT
# List of compartments can be obtained using listCompartments.sh
export COMPARTMENT_ID=

# REGION
# List of regions can be obtained using listRegions.sh
export REGION=

# DISPLAY NAME
# User visible name of OIC instance
export DISPLAY_NAME=

# BYOL
# Is instance using BYOL values are true or false
export IS_BYOL=

# MESSAGE PACKS
# Number of message packs to provision
export MESSAGE_PACKS=

# TYPE
# Valid types are ENTERPRISE or STANDARD
export TYPE=

# IDCS AUTHENTICATION TOKEN
# IDCS token generated from confidential app in IDCS
export IDCS_URL=
export IDCS_CLIENT_ID=
export IDCS_CLIENT_SECRET=
export IDCS_USERNAME=
export IDCS_PASSWORD=

# WORK REQUEST ID
# Obtained from createIntegration.sh or deleteIntegration.sh
export WORK_REQUEST_ID=

# Flags used in request for import/export & storage management
# -s
#   Silent mode
# -k
#   Insecure, ignore bad certificates
# -v
#   Verbose
# -w \nHTTP_STATUS=%{http_code}\n
#   Show HTTP status code
export CURL_FLAGS="-s"
