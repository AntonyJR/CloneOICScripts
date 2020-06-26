#!/bin/sh
. ./env.sh

get_username_base $1
get_group_name $2
get_idcs_at_cc

get_group_id

GROUP_COMMA=
ADD_GROUP_REQUEST='
{
  "schemas": [
    "urn:ietf:params:scim:api:messages:2.0:PatchOp"
  ],
  "Operations": [
'

for USER_NUMBER in {00..99}; do
  USERNAME=${USERNAME_BASE}${USER_NUMBER}
  get_user_id ${USERNAME}

  if [ "${USER_ID}" == "null" ]; then
    echo ${USERNAME} not found
  else
#    echo Adding $USERNAME $USER_ID to $GROUP_NAME $GROUP_ID
    ADD_GROUP_REQUEST="${ADD_GROUP_REQUEST}"${GROUP_COMMA}'
    {
      "op": "add",
      "path": "members",
      "value": [
        {
          "value": "'${USER_ID}'",
          "type": "User"
        }
      ]
    }'
  GROUP_COMMA=","
  fi
done
ADD_GROUP_REQUEST="${ADD_GROUP_REQUEST}"'
  ]
}
'
curl ${CURL_FLAGS} -H "Authorization: Bearer ${IDCS_AT_CC}" -H "Content-Type: application/json" -d "${ADD_GROUP_REQUEST}" -X PATCH ${IDCS_URL}/admin/v1/Groups/${GROUP_ID}
