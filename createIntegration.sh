#!/bin/bash
. ~/.bash_profile

. ./env.sh

get_compartment "$1"
get_region "$2"
get_display_name "$3"
get_is_byol "$4"
get_message_packs "$5"
get_type "$6"
get_idcs_at "$7"

oci integration integration-instance create --compartment-id "$COMPARTMENT_ID" --region "$REGION" --display-name "$DISPLAY_NAME" --is-byol "$IS_BYOL" --message-packs "$MESSAGE_PACKS" --type "$TYPE" --idcs-at "$IDCS_AT" --max-wait-seconds 30 --wait-for-state ACCEPTED
