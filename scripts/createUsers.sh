#!/bin/sh
. ./env.sh

get_username_base $1
get_user_password "$2"
get_idcs_at_cc

for USER_NUMBER in {00..99}
do
  USERNAME=${USERNAME_BASE}${USER_NUMBER}
  CREATE_USER_REQUEST='{
    "schemas": [
      "urn:ietf:params:scim:schemas:core:2.0:User"
    ],
    "userName": "'${USERNAME}'",
    "name": {
      "familyName": "'${USERNAME_BASE}'",
      "givenName": "'${USER_NUMBER}'"
    },
    "password": "'${USER_PASSWORD}'",
    "emails": [
      {
        "value": "'${USERNAME}'@nowhere.com",
        "type": "Work",
        "primary": true
      }
    ]
  }'
  curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" -X POST -H "Content-Type: application/json" -d "${CREATE_USER_REQUEST}" ${IDCS_URL}/admin/v1/Users
done