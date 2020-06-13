#!/bin/bash
. ~/.bash_profile

. ./env.sh

get_integration "$1"
get_region "$2"

oci integration integration-instance delete --force --id "$INTEGRATION_ID" --max-wait-seconds 30 --wait-for-state ACCEPTED --region "$REGION"
