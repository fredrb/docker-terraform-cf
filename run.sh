#!/bin/sh
terraform init

if [ -z "$VAR_FILE" ]; then
    terraform apply -auto-approve -input=false
else
    terraform apply -auto-approve -input=false -var-file=$VAR_FILE
fi