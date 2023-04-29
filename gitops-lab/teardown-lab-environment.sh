#!/bin/bash

if [[ -z "$TF_VAR_namespace" ]]; then
    echo "Must provide TF_VAR_namespace in environment" 1>&2
    exit 1
fi

cd ~/terraform-modular-demo-framework

terragrunt run-all destroy --terragrunt-modules-that-include ./gitops-lab.hcl --terragrunt-non-interactive
terragrunt run-all destroy --terragrunt-modules-that-include ./env-setup.hcl --terragrunt-non-interactive
