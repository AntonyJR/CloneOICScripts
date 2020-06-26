#!/bin/bash

echo IDENTITY TESTS
echo ==============

GROUP_NAME=TestScriptGroup
USERNAME_BASE=TestScriptUser
USER_PASSWORD="P@ssw0rd1234"

echo CREATE GROUP TEST
./createGroup.sh $GROUP_NAME | jq -r '["Created Group ", .displayName, " : ", .id]| add'

echo CREATE USERS TEST
./createUsers.sh $USERNAME_BASE "$USER_PASSWORD" | jq -r '["Created User ", .userName, " : ", .id]| add'

echo ADD USERS TO GROUP
./addUsersToGroup.sh ${USERNAME_BASE} ${GROUP_NAME}
./getGroup.sh ${GROUP_NAME} | jq -r '["Group ", .displayName, " : ", .id, " has ", (.members | length | tostring), " members"] | add'

echo REMOVE USERS FROM GROUP
./removeUsersFromGroup.sh ${USERNAME_BASE} ${GROUP_NAME}
./getGroup.sh ${GROUP_NAME} | jq -r '["Group ", .displayName, " : ", .id, " has ", (.members | length | tostring), " members"] | add'

echo DELETE USERS TEST
./deleteUsers.sh ${USERNAME_BASE}

echo DELETE GROUP TEST
./deleteGroup.sh ${GROUP_NAME}
./getGroup.sh ${GROUP_NAME}
