#~/bin/bash

testdir=$(mktemp -d "${TMPDIR:-/tmp/}$(basename $0).XXXXXXXXXXXX")

echo OCI ENVIRONMENT TESTS
echo =====================

echo REGIONS TEST
./listRegions.sh

echo COMPARTMENT TEST
./listCompartments.sh

echo INTEGRATIONS TEST
./listIntegrations.sh

echo CREATE TEST
./createIntegration.sh | tee ${testdir}/createTest
WORK_REQUEST_ID=`jq -r ".data.id" < ${testdir}/createTest`
rm ${testdir}/createTest

echo CREATE STATUS TEST
while [[ `./getWorkRequest.sh $WORK_REQUEST_ID | jq -r ".data.status"` != "SUCCEEDED" ]]; do
  echo Waiting
  sleep 60
done
echo
./getWorkRequest.sh $WORK_REQUEST_ID
INTEGRATION_ID=`./getWorkRequest.sh $WORK_REQUEST_ID | jq -r ".data.resources[0].identifier"`

echo INTEGRATION TEST
./getIntegration.sh

echo DELETE TEST
./deleteIntegration.sh | tee ${testdir}/deleteTest
WORK_REQUEST_ID=`jq -r ".data.id" < ${testdir}/deleteTest`
rm ${testdir}/deleteTest

echo DELETE STATUS TEST
while [[ `./getWorkRequest.sh $WORK_REQUEST_ID | jq -r ".data.status"` != "SUCCEEDED" ]]; do
  echo Waiting
  sleep 60
done
echo
./getWorkRequest.sh $WORK_REQUEST_ID

rm -r ${testdir}