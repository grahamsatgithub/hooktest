#!/bin/bash

echo "This is a test pipeline"

sudo docker run -v $PWD:/host -i --entrypoint=/host/terraform.sh hashicorp/terraform
