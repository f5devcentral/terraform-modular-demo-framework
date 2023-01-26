resource "volterra_aws_tgw_site" "aws-region-1" {
  name        = format("%s-tgw-%s", var.projectPrefix, var.instanceSuffix)
  namespace   = "system"
#  description = format("Virtual site for %s-%s", var.projectPrefix, local.buildSuffix)

  vpc_attachments {
    vpc_list {
      vpc_id = var.spokeVpcId
    }
    vpc_list {
      vpc_id = var.spoke2VpcId
    }    
  }

  vn_config {
    global_network_list {
      global_network_connections {
        sli_to_global_dr {
          global_vn {
            name = format("%s-global-network", var.projectPrefix)
          }
        }
      }
    }
    sm_connection_pvt_ip = true
  }

  aws_parameters {
    aws_certified_hw = "aws-byol-multi-nic-voltmesh"
    aws_region       = var.awsRegion
    
    vpc_id = var.vpcId
    ssh_key = var.ssh_public_key
    
    new_tgw {
      system_generated = true
    }


    az_nodes {
      aws_az_name = var.awsAz1
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az1"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az1"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az1"].id            
      }      
    }

    az_nodes {
      aws_az_name = var.awsAz2
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az2"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az2"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az2"].id            
      }      
    }

    az_nodes {
      aws_az_name = var.awsAz3
      inside_subnet {
        existing_subnet_id = var.internalSubnets["az3"].id
      }
      workload_subnet {
        existing_subnet_id = var.workloadSubnets["az3"].id      
      }
      outside_subnet {
        existing_subnet_id = var.externalSubnets["az3"].id            
      }      
    }
    aws_cred {
      name = var.volterraCloudCredAWS
      namespace = "system"      
    }
    assisted = false
    instance_type = "t3.xlarge"
  }
  logs_streaming_disabled = true

  lifecycle {
    ignore_changes = [labels]
  }
}

resource "volterra_cloud_site_labels" "labels" {
  name = volterra_aws_tgw_site.aws-region-1.name
    site_type = "aws_tgw_site"
    labels = {
      site-group = var.projectPrefix
      key1 = "value1"
      key2 = "value2"
    }
  ignore_on_delete = true
}

resource "volterra_tf_params_action" "aws-region-1" {
  site_name        = volterra_aws_tgw_site.aws-region-1.name
  site_kind        = "aws_tgw_site"
  action           = "apply"
  wait_for_action  = true
  ignore_on_update = false

  depends_on = [volterra_aws_tgw_site.aws-region-1]
}

########################### Providers ##########################
provider "aws" {
  region = var.awsRegion
}
# Instance info
data "aws_instances" "xcmesh" {
  instance_state_names = ["running"]
  instance_tags = {
    "ves-io-site-name" = volterra_aws_tgw_site.aws-region-1.name
  }

  depends_on = [volterra_tf_params_action.aws-region-1]
}
