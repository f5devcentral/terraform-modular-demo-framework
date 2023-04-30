include "root" {
  path = find_in_parent_folders()
}
include "aws" {
  path = find_in_parent_folders("aws.hcl")
}

include "aws-base" {
  path = find_in_parent_folders("aws-base.hcl")
}

terraform {
  source = "github.com/piyerf5/terraform-f5xc-aws-base.git?ref=v0.1.1//"
}

inputs = {
  aws_region = "us-west-2"
  services_vpc_cidr_block = "100.64.32.0/20"
  services_vpc = {
    "azs" = {
      "az1" = { az = "us-west-2a" },
      "az2" = { az = "us-west-2b" },
      "az3" = { az = "us-west-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "100.64.32.0/24"
      },
      "az2" = {
        cidr = "100.64.35.0/24"
      },
      "az3" = {
        cidr = "100.64.36.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "100.64.33.0/24"
      },
      "az2" = {
        cidr = "100.64.37.0/24"
      },
      "az3" = {
        cidr = "100.64.39.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "100.64.34.0/24"
      },
      "az2" = {
        cidr = "100.64.38.0/24"
      },
      "az3" = {
        cidr = "100.64.40.0/24"
      }
    }

  }
  spoke_vpc_cidr_block = "10.0.32.0/20"
  spoke_vpc = {
    "azs" = {
      "az1" = { az = "us-west-2a" },
      "az2" = { az = "us-west-2b" },
      "az3" = { az = "us-west-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.32.0/24"
      },
      "az2" = {
        cidr = "10.0.35.0/24"
      },
      "az3" = {
        cidr = "10.0.38.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.33.0/24"
      },
      "az2" = {
        cidr = "10.0.36.0/24"
      },
      "az3" = {
        cidr = "10.0.39.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.34.0/24"
      },
      "az2" = {
        cidr = "10.0.37.0/24"
      },
      "az3" = {
        cidr = "10.0.40.0/24"
      }
    }

  }
  spoke2_vpc_cidr_block = "10.0.64.0/20"
  spoke2_vpc = {
    "azs" = {
      "az1" = { az = "us-west-2a" },
      "az2" = { az = "us-west-2b" },
      "az3" = { az = "us-west-2c" },
    },
    "external" = {
      "az1" = {
        cidr = "10.0.64.0/24"
      },
      "az2" = {
        cidr = "10.0.67.0/24"
      },
      "az3" = {
        cidr = "10.0.70.0/24"
      }
    },
    "internal" = {
      "az1" = {
        cidr = "10.0.65.0/24"
      },
      "az2" = {
        cidr = "10.0.68.0/24"
      },
      "az3" = {
        cidr = "10.0.71.0/24"
      }
    },
    "workload" = {
      "az1" = {
        cidr = "10.0.66.0/24"
      },
      "az2" = {
        cidr = "10.0.69.0/24"
      },
      "az3" = {
        cidr = "10.0.72.0/24"
      }
    }

  }
}
