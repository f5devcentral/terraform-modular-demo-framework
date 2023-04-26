include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}

include "gitops-lab" {
  path = find_in_parent_folders("gitops-lab.hcl")
}

terraform {
  source = "github.com/piyerf5/terraform-f5xc-aws-appstack-site.git?ref=v0.1.0"
}

dependencies {
  paths = ["${get_path_to_repo_root()}/aws-base-1","${get_path_to_repo_root()}/mk8s-cluster-1"]
}

dependency "cluster" {
  config_path = "${get_path_to_repo_root()}/mk8s-cluster-1"
}

dependency "infrastructure" {
  config_path = "${get_path_to_repo_root()}/aws-base-1"
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
    instance_suffix        = "1"
    aws_region             = dependency.infrastructure.outputs.aws_region
    aws_az1                = dependency.infrastructure.outputs.aws_az1
    aws_az2                = dependency.infrastructure.outputs.aws_az2
    aws_az3                = dependency.infrastructure.outputs.aws_az3
    external_subnets       = dependency.infrastructure.outputs.external_subnets
    internal_subnets       = dependency.infrastructure.outputs.internal_subnets
    workload_subnets       = dependency.infrastructure.outputs.workload_subnets
    spoke_external_subnets = dependency.infrastructure.outputs.spoke_external_subnets
    spoke_workload_subnets = dependency.infrastructure.outputs.spoke_workload_subnets
    security_group         = dependency.infrastructure.outputs.security_group
    vpc_id                 = dependency.infrastructure.outputs.vpc_id
    spoke_vpc_id           = dependency.infrastructure.outputs.spoke_vpc_id
    spoke2_vpc_id          = dependency.infrastructure.outputs.spoke2_vpc_id
    spoke_security_group   = dependency.infrastructure.outputs.spoke_security_group
    k8s_cluster_name       = dependency.cluster.outputs.k8s_cluster_name
    k8s_cluster_namespace  = dependency.cluster.outputs.k8s_cluster_namespace
}
