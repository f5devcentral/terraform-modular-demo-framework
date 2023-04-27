#!/bin/bash

terragrunt run-all apply --terragrunt-modules-that-include ./env-setup.hcl

terragrunt run-all apply --terragrunt-modules-that-include ./appstack.hcl

terragrunt output-all -json --terragrunt-include-dir aws-appstack-site-1 --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee tf_output_vars.yaml 

terragrunt output-all -json --terragrunt-include-dir mk8s-cluster-1 --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee -a tf_output_vars.yaml

terragrunt output-all -json --terragrunt-include-dir gitops-lab --terragrunt-strict-include | awk '!/\[\w+\]/' | jq 'with_entries(.value = .value.value | select(.value != null))' | yq e -P | tee -a tf_output_vars.yaml
