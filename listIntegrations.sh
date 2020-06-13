#!/bin/bash
. ~/.bash_profile

. ./env.sh

get_compartment "$1"
get_region "$2"

oci integration integration-instance list --output table --query "data [*].{Name:\"display-name\", URL:\"instance-url\", OCID:id}" --compartment-id "$COMPARTMENT_ID" --region "$REGION"
