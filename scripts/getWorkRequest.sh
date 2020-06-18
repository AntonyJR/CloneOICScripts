#!/bin/bash
. ./env.sh

get_work_request "$1"
get_region "$2"

oci integration work-request get --work-request-id "$WORK_REQUEST_ID" --region "$REGION"
