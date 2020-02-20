#!/bin/sh

set -ex

cd /host/Terraform/terraform-generator/plans/nae-test

terraform init
terraform plan --out=plan.out
terraform apply plan.out
