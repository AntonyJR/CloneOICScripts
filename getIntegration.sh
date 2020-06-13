#!/bin/bash
. ~/.bash_profile

. ./env.sh

get_integration "$1"
get_region "$2"

oci integration integration-instance get --id "$INTEGRATION_ID" --region "$REGION"
