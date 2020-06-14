#!/bin/bash

testdir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")

echo IMPORT/EXPORT TESTS
echo ===================

echo EXPORT TEST
./export.sh | tee ${testdir}/exportTest | jq
JOB_ID=`jq -r ".jobId" < ${testdir}/exportTest`
rm ${testdir}/exportTest

echo EXPORT STATUS TEST
while [[ `./exportStatus.sh $JOB_ID  | jq -r ".overallStatus"` != COMPLETED ]]; do
  echo Waiting
  sleep 60
done
./exportStatus.sh $JOB_ID | jq
EXPORT_FILE=`./exportStatus.sh $JOB_ID |  jq -r ".archiveName"`

echo LIST BUCKET TEST
./listBucket.sh | jq

echo COPY EXPORT TEST
./copyExport.sh $EXPORT_FILE | tee ${testdir}/copyTest | jq
JOB_ID=`jq -r ".jobId" < ${testdir}/copyTest`
rm ${testdir}/copyTest

echo COPY EXPORT STATUS TEST
while [[ `./objectStatus.sh $JOB_ID | jq -r ".status"` != COMPLETED ]]; do
  echo Waiting
  sleep 60
done
echo
./objectStatus.sh $JOB_ID

echo IMPORT TEST
./import.sh | tee ${testdir}/importTest | jq
JOB_ID=`jq -r ".jobId" < ${testdir}/importTest`
rm ${testdir}/importTest

echo IMPORT STATUS TEST
while [[ `./importStatus.sh $JOB_ID  | jq -r ".overallStatus"` != "COMPLETED" ]]; do
  echo Waiting
  sleep 60
done
echo
./importStatus.sh $JOB_ID

rm -r ${testdir}