include "root" {
  path = find_in_parent_folders()
}

include "aws" {
  path = find_in_parent_folders("aws.hcl")
}
include "appstack" {
  path = find_in_parent_folders("appstack.hcl")
}
include "aws-base" {
  path = find_in_parent_folders("aws-base.hcl")
}

terraform {
  source = "github.com/mjmenger/terraform-f5xc-aws-base.git?ref=v0.1.1"
}

inputs = {
  aws_region = "us-east-2"
  services_vpc_cidr_block = "100.64.0.0/20"
  services_vpc = {
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
  spoke_vpc_cidr_block = "10.0.0.0/20"
  spoke_vpc = {
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
  spoke2_vpc_cidr_block = "10.0.48.0/20"
  spoke2_vpc = {
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
