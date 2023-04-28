#!/bin/bash
cd ~/terraform-modular-demo-framework

terragrunt run-all destroy --terragrunt-modules-that-include ./gitops-lab.hcl
terragrunt run-all destroy --terragrunt-modules-that-include ./env-setup.hcl
