#!/bin/bash
echo "Deleting existing stack"
aws cloudformation delete-stack --stack-name JenkinsSample

echo "Waiting for the stack to be deleted"
aws cloudformation wait stack-delete-complete --stack-name JenkinsSample

echo "Creating new stack"
aws cloudformation deploy --template-file setupStack.yml --stack-name JenkinsSample --parameter-overrides KeyName=ec2-test

echo "Waiting for the stack creation to be completed"
aws cloudformation wait stack-create-complete --stack-name JenkinsSample

echo "Waiting for instance to complete running"
aws cloudformation describe-stacks --stack-name JenkinsSample --query 'Stacks[0].Outputs[0].OutputValue' | aws ec2 wait instance-status-ok --instance-ids

export URL="$(aws cloudformation describe-stacks --stack-name JenkinsSample --query 'Stacks[0].Outputs[1].OutputValue' | tr -d '\"')"

echo "URL for Jenkins"
echo "https://${URL}/blue/organizations/jenkins/pipelines"