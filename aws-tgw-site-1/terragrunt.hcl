include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/tgw-site"
}

dependencies {
  paths = ["${get_path_to_repo_root()}/aws-base-1"]
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
    instanceSuffix       = "1"
    awsRegion            = dependency.infrastructure.outputs.awsRegion
    awsAz1               = dependency.infrastructure.outputs.awsAz1
    awsAz2               = dependency.infrastructure.outputs.awsAz2
    awsAz3               = dependency.infrastructure.outputs.awsAz3
    externalSubnets      = dependency.infrastructure.outputs.externalSubnets
    internalSubnets      = dependency.infrastructure.outputs.internalSubnets
    workloadSubnets      = dependency.infrastructure.outputs.workloadSubnets
    spokeExternalSubnets = dependency.infrastructure.outputs.spokeExternalSubnets
    spokeWorkloadSubnets = dependency.infrastructure.outputs.spokeWorkloadSubnets
    securityGroup        = dependency.infrastructure.outputs.securityGroup
    vpcId                = dependency.infrastructure.outputs.vpcId
    spokeVpcId           = dependency.infrastructure.outputs.spokeVpcId
    spoke2VpcId          = dependency.infrastructure.outputs.spoke2VpcId
    spokeSecurityGroup   = dependency.infrastructure.outputs.spokeSecurityGroup
}
