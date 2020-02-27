#!/bin/sh

set -ex

cd /host/nae-test

cp -va /share/hooktest.tfstate terraform.tfstate || true

terraform init
terraform plan --out=plan.out
terraform apply plan.out

cp terraform.tfstate /share/hooktest.tfstate
