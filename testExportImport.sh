#!/bin/bash
echo IMPORT/EXPORT TESTS
echo ===================
echo EXPORT TEST
JOB_ID=`./export.sh | tee | jq ".jobId"`
echo EXPORT STATUS TEST
while [[ `./export_status.sh $JOB_ID | jq ".overallStatus"` != "COMPLETED" ]]; do
  sleep 60
done
EXPORT_FILE=`./export_status.sh $JOB_ID | tee | jq ".archiveName"`
echo LIST BUCKET TEST
./list_bucket.sh
echo COPY EXPORT TEST
./copy_export.sh $EXPORT_FILE
echo IMPORT TEST
JOB_ID=`./import.sh $EXPORT_FILE | jq ".jobId"`
echo IMPORT STATUS TEST
./import_status.sh $JOB_ID
