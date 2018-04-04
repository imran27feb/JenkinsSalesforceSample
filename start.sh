#!/bin/bash
echo "Deleting existing stack"
aws cloudformation delete-stack --stack-name JenkinsSample

echo "Waiting for the stack to be deleted"
aws cloudformation wait stack-delete-complete --stack-name JenkinsSample

echo "Creating new stack"
aws cloudformation deploy --template-file setupStack.yml --stack-name JenkinsSample

echo "Waiting for the stack creation to be completed"
aws cloudformation wait stack-create-complete --stack-name JenkinsSample

echo "Stack creation results"
aws cloudformation describe-stacks --stack-name JenkinsSample