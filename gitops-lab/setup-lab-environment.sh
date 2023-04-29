#!/bin/bash

if [[ -z "$TF_VAR_namespace" ]]; then
    echo "Must provide TF_VAR_namespace in environment" 1>&2
    exit 1
fi

cd ~/terraform-modular-demo-framework

terragrunt run-all apply --terragrunt-modules-that-include ./env-setup.hcl --terragrunt-non-interactive
terragrunt run-all apply --terragrunt-modules-that-include ./gitops-lab.hcl --terragrunt-non-interactive

terragrunt run-all output -json --terragrunt-include-dir aws-appstack-site-1 --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee tf_output_vars.yaml 
terragrunt run-all output -json --terragrunt-include-dir mk8s-cluster-1 --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee -a tf_output_vars.yaml
terragrunt run-all output -json --terragrunt-include-dir gitops-lab --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee -a tf_output_vars.yaml
