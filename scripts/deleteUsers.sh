#!/bin/sh
. ./env.sh

get_username_base $1
get_idcs_at_cc

for USER_NUMBER in {00..99}
do
  USERNAME=${USERNAME_BASE}${USER_NUMBER}
  get_user_id ${USERNAME}
  if [ "${USER_ID}" == "null" ]
  then
    echo ${USERNAME} not found
  else
    echo Deleting $USERNAME $USER_ID
    curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" -X DELETE ${IDCS_URL}/admin/v1/Users/${USER_ID}
  fi
done