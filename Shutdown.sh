#!/bin/bash
APPNAME="appname"
export AWS_ACCESS_KEY_ID=
export AWS_DEFAULT_REGION=us-east-1
export AWS_SECRET_ACCESS_KEY=

echo "---------------------------------------------------------"
echo "Fetching instance details for ${APPNAME}"
echo "---------------------------------------------------------"
INSTANCE_ID="$(aws ec2 describe-instances --filters 'Name=tag:Name,'Values=${APPNAME}*'' --output text --query 'Reservations[*].Instances[*].InstanceId')"
echo "---------------------------------------------------------"
echo "Instance id for ${APPNAME}: ${INSTANCE_ID}"
echo "---------------------------------------------------------"
sleep .5
INSTANCE_STATUS="$(aws ec2 describe-instance-status --instance-id ${INSTANCE_ID} --output text --query 'InstanceStatuses[*].InstanceState.Name')"
echo "---------------------------------------------------------"
echo "Instance status is ${INSTANCE_STATUS}"
echo "---------------------------------------------------------"
if [[ ${INSTANCE_STATUS} -eq 'running' ]]
then
    echo "---------------------------------------------------------"
    echo "Terminating ${APPNAME} instance"
    echo "---------------------------------------------------------"
    #STATUS="$(aws ec2 terminate-instances --instance-ids ${INSTANCE_ID})"
    echo "Instance ${APPNAME} terminating"
    sleep 1s
    echo "Instance status for ${INSTANCE_ID} : Terminated"
fi
fi
