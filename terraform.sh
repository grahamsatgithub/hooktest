#!/bin/sh

set -ex

cd nae-test

terraform init
terraform plan --out=plan.out
terraform apply plan.out
