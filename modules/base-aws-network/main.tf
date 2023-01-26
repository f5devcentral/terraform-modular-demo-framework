########################### Providers ##########################
provider "aws" {
  region = var.awsRegion
}


########################### Locals ##########################
resource "random_id" "buildSuffix" {
  byte_length = 2
}

locals {
  # Allow user to specify a build suffix, but fallback to random as needed.
  buildSuffix = coalesce(var.buildSuffix, random_id.buildSuffix.hex)
}

########################### AWS Availibility Zones ##########################

# Retrieve AZ values
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  awsAz1 = var.awsAz1 != null ? var.awsAz1 : data.aws_availability_zones.available.names[0]
  awsAz2 = var.awsAz2 != null ? var.awsAz1 : data.aws_availability_zones.available.names[1]
  awsAz3 = var.awsAz3 != null ? var.awsAz1 : data.aws_availability_zones.available.names[2]
}

##################################################################### VPC's #############################################################
#transit VPC's


# module "vpcService1" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 2.0"

#   name = "${var.projectPrefix}-vpcService1-${random_id.buildSuffix.hex}"

#   cidr = "100.64.0.0/16"

#   azs             = [local.awsAz1, local.awsAz2, local.awsAz3]
#   public_subnets  = ["100.64.0.0/24","100.64.3.0/24","100.64.6.0/24"]
#   private_subnets = ["100.64.1.0/24","100.64.4.0/24","100.64.7.0/24"]
#   enable_dns_hostnames = true
#   enable_nat_gateway = false
#   tags = {
#     Name          = "${var.projectPrefix}-vpcService1-${random_id.buildSuffix.hex}"
#   }

# }

# resource "aws_subnet" "Service1VoltSliAz1" {
#   vpc_id            = module.vpcService1.vpc_id
#   availability_zone = local.awsAz1
#   cidr_block        = "100.64.2.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Service1VoltSliAz1-${random_id.buildSuffix.hex}"
#   }
# }

# resource "aws_subnet" "Service1VoltSliAz2" {
#   vpc_id            = module.vpcService1.vpc_id
#   availability_zone = local.awsAz2
#   cidr_block        = "100.64.5.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Service1VoltSliAz2-${random_id.buildSuffix.hex}"
#   }
# }

# resource "aws_subnet" "Service1VoltSliAz3" {
#   vpc_id            = module.vpcService1.vpc_id
#   availability_zone = local.awsAz3
#   cidr_block        = "100.64.8.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Service1VoltSliAz3-${random_id.buildSuffix.hex}"
#   }
# }

# # spoke VPC

# module "vpcSpoke1" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 2.0"

#   name = "${var.projectPrefix}-vpcSpoke1-${random_id.buildSuffix.hex}"

#   cidr = "10.0.0.0/16"

#   azs             = [local.awsAz1, local.awsAz2, local.awsAz3]
#   public_subnets  = ["10.0.0.0/24","10.0.3.0/24","10.0.6.0/24"]
#   private_subnets = ["10.0.1.0/24","10.0.4.0/24","10.0.7.0/24"]
#   enable_dns_hostnames = true
#   enable_nat_gateway = false
#   tags = {
#     Name          = "${var.projectPrefix}-vpcSpoke1-${random_id.buildSuffix.hex}"
#   }

# }

# resource "aws_subnet" "Spoke1WorkloadAz1" {
#   vpc_id            = module.vpcSpoke1.vpc_id
#   availability_zone = local.awsAz1
#   cidr_block        = "10.0.2.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Spoke1WorkloadAz1-${random_id.buildSuffix.hex}"
#   }
# }

# resource "aws_subnet" "Spoke1WorkloadAz2" {
#   vpc_id            = module.vpcSpoke1.vpc_id
#   availability_zone = local.awsAz2
#   cidr_block        = "10.0.5.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Spoke1WorkloadAz2-${random_id.buildSuffix.hex}"
#   }
# }

# resource "aws_subnet" "Spoke1WorkloadAz3" {
#   vpc_id            = module.vpcSpoke1.vpc_id
#   availability_zone = local.awsAz3
#   cidr_block        = "10.0.8.0/24"

#   tags = {
#     Name          = "${var.projectPrefix}-Spoke1WorkloadAz3-${random_id.buildSuffix.hex}"
#   }
# }

