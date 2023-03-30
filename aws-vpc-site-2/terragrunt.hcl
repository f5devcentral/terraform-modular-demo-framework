include "root" {
  path = find_in_parent_folders()
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
terraform {
  source = "github.com/mjmenger/terraform-f5xc-aws-vpc-site.git?ref=v0.0.3"
}

dependencies {
  paths = ["${get_path_to_repo_root()}/aws-base-2"]
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}/aws-base-2"
  mock_outputs = {
    awsAz1 = ""
    awsAz2 = ""
    awsAz3 = ""
    externalSubnets = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      },
      "az3" = {
        "id" = "3"
      }
    }
    internalSubnets = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      },
      "az3" = {
        "id" = "3"
      }
    }
    workloadSubnets = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      },
      "az3" = {
        "id" = "3"
      }
    }
    spokeExternalSubnets = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      },
      "az3" = {
        "id" = "3"
      }
    }
    spokeWorkloadSubnets = {
      "az1" = {
        "id" = "1"
      },
      "az2" = {
        "id" = "2"
      },
      "az3" = {
        "id" = "3"
      }
    }
    securityGroup = ""
    vpcId = ""
    spokeVpcId = ""
    spoke2VpcId = ""
    spokeSecurityGroup = ""
  }
}

inputs = {
    instanceSuffix       = "2"
    awsRegion            = dependency.infrastructure.outputs.aws_region
    awsAz1               = dependency.infrastructure.outputs.aws_az1
    awsAz2               = dependency.infrastructure.outputs.aws_az2
    awsAz3               = dependency.infrastructure.outputs.aws_az3
    externalSubnets      = dependency.infrastructure.outputs.external_subnets
    internalSubnets      = dependency.infrastructure.outputs.internal_subnets
    workloadSubnets      = dependency.infrastructure.outputs.workload_subnets
    spokeExternalSubnets = dependency.infrastructure.outputs.spoke_external_subnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spoke_workload_subnets
    securityGroup        = dependency.infrastructure.outputs.security_group
    vpcId                = dependency.infrastructure.outputs.vpc_id
    spokeVpcId           = dependency.infrastructure.outputs.spoke_vpc_id
    spoke2VpcId          = dependency.infrastructure.outputs.spoke2_vpc_id
    spokeSecurityGroup   = dependency.infrastructure.outputs.spoke_security_group
}
