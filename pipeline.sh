#!/bin/bash

echo "This is a test pipeline"

sudo docker run -v $PWD:/host -ti --entrypoint=/host/terraform.sh hashicorp/terraform
