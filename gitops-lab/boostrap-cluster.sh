#!/bin/bash

# terraform init
# terraform apply --auto-approve

# terraform output -json | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P

terragrunt run-all apply

terragrunt output-all -json --terragrunt-include-dir aws-appstack-site-1 --terragrunt-strict-include | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P > tf_output_vars.yaml 

terragrunt output-all -json --terragrunt-include-dir mk8s-cluster-1 --terragrunt-strict-include | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P >> tf_output_vars.yaml

terragrunt output-all -json --terragrunt-include-dir gitops-lab --terragrunt-strict-include | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P >> tf_output_vars.yaml
