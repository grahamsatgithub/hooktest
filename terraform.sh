#!/bin/sh

set -ex

cd /host/nae-test

terraform init
terraform plan --out=plan.out
terraform apply plan.out
