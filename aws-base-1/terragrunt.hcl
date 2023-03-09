include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

terraform {
  source = "github.com/mjmenger/terraform-f5xc-aws-base.git?ref=v0.0.3rc"
}

inputs = {
  awsRegion = "us-east-2"
  servicesVpcCidrBlock = "100.64.0.0/20"
  servicesVpc = {
    "azs" = {
      "az1" = { az = "us-east-2a" },
      "az2" = { az = "us-east-2b" },
      "az3" = { az = "us-east-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "100.64.0.0/24"
      },
      "az2" = {
        cidr = "100.64.3.0/24"
      },
      "az3" = {
        cidr = "100.64.6.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "100.64.1.0/24"
      },
      "az2" = {
        cidr = "100.64.4.0/24"
      },
      "az3" = {
        cidr = "100.64.7.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "100.64.2.0/24"
      },
      "az2" = {
        cidr = "100.64.5.0/24"
      },
      "az3" = {
        cidr = "100.64.8.0/24"
      }
    }

  }
  spokeVpcCidrBlock = "10.0.0.0/20"
  spokeVpc = {
    "azs" = {
      "az1" = { az = "us-east-2a" },
      "az2" = { az = "us-east-2b" },
      "az3" = { az = "us-east-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.0.0/24"
      },
      "az2" = {
        cidr = "10.0.3.0/24"
      },
      "az3" = {
        cidr = "10.0.6.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.1.0/24"
      },
      "az2" = {
        cidr = "10.0.4.0/24"
      },
      "az3" = {
        cidr = "10.0.7.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.2.0/24"
      },
      "az2" = {
        cidr = "10.0.5.0/24"
      },
      "az3" = {
        cidr = "10.0.8.0/24"
      }
    }

  }
  spoke2VpcCidrBlock = "10.0.48.0/20"
  spoke2Vpc = {
    "azs" = {
      "az1" = { az = "us-east-2a" },
      "az2" = { az = "us-east-2b" },
      "az3" = { az = "us-east-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.48.0/24"
      },
      "az2" = {
        cidr = "10.0.51.0/24"
      },
      "az3" = {
        cidr = "10.0.54.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.49.0/24"
      },
      "az2" = {
        cidr = "10.0.52.0/24"
      },
      "az3" = {
        cidr = "10.0.55.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.50.0/24"
      },
      "az2" = {
        cidr = "10.0.53.0/24"
      },
      "az3" = {
        cidr = "10.0.56.0/24"
      }
    }

  }
}
