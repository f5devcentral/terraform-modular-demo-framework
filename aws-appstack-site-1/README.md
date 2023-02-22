<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.24 |
| <a name="requirement_volterra"></a> [volterra](#requirement\_volterra) | 0.11.16 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_volterra"></a> [volterra](#provider\_volterra) | 0.11.16 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [volterra_aws_vpc_site.example](https://registry.terraform.io/providers/volterraedge/volterra/0.11.16/docs/resources/aws_vpc_site) | resource |
| [volterra_cloud_site_labels.labels](https://registry.terraform.io/providers/volterraedge/volterra/0.11.16/docs/resources/cloud_site_labels) | resource |
| [volterra_tf_params_action.aws_vpc_action](https://registry.terraform.io/providers/volterraedge/volterra/0.11.16/docs/resources/tf_params_action) | resource |
| [http_http.myip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_trust_localip"></a> [auto\_trust\_localip](#input\_auto\_trust\_localip) | if true, query ifconfig.io for public ip of terraform host. | `bool` | `false` | no |
| <a name="input_awsAz1"></a> [awsAz1](#input\_awsAz1) | Availability zone, will dynamically choose one if left empty | `string` | `null` | no |
| <a name="input_awsAz2"></a> [awsAz2](#input\_awsAz2) | Availability zone, will dynamically choose one if left empty | `string` | `null` | no |
| <a name="input_awsAz3"></a> [awsAz3](#input\_awsAz3) | Availability zone, will dynamically choose one if left empty | `string` | `null` | no |
| <a name="input_awsRegion"></a> [awsRegion](#input\_awsRegion) | aws region | `string` | n/a | yes |
| <a name="input_buildSuffix"></a> [buildSuffix](#input\_buildSuffix) | random build suffix for resources | `string` | `null` | no |
| <a name="input_externalSubnets"></a> [externalSubnets](#input\_externalSubnets) | n/a | `map` | n/a | yes |
| <a name="input_instanceSuffix"></a> [instanceSuffix](#input\_instanceSuffix) | n/a | `string` | n/a | yes |
| <a name="input_internalSubnets"></a> [internalSubnets](#input\_internalSubnets) | n/a | `map` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Volterra application namespace | `string` | n/a | yes |
| <a name="input_projectPrefix"></a> [projectPrefix](#input\_projectPrefix) | projectPrefix name for tagging | `string` | n/a | yes |
| <a name="input_spoke2VpcId"></a> [spoke2VpcId](#input\_spoke2VpcId) | n/a | `any` | n/a | yes |
| <a name="input_spokeVpcId"></a> [spokeVpcId](#input\_spokeVpcId) | n/a | `any` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | n/a | `any` | n/a | yes |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | IP to allow external access | `string` | n/a | yes |
| <a name="input_volterraCloudCredAWS"></a> [volterraCloudCredAWS](#input\_volterraCloudCredAWS) | Name of the volterra aws credentials | `string` | n/a | yes |
| <a name="input_volterraCloudCredAzure"></a> [volterraCloudCredAzure](#input\_volterraCloudCredAzure) | Name of the volterra aws credentials | `string` | n/a | yes |
| <a name="input_volterraP12"></a> [volterraP12](#input\_volterraP12) | Location of volterra p12 file | `string` | `null` | no |
| <a name="input_volterraTenant"></a> [volterraTenant](#input\_volterraTenant) | Tenant of Volterra | `string` | n/a | yes |
| <a name="input_volterraUrl"></a> [volterraUrl](#input\_volterraUrl) | url of volterra api | `string` | `null` | no |
| <a name="input_vpcId"></a> [vpcId](#input\_vpcId) | n/a | `any` | n/a | yes |
| <a name="input_workloadSubnets"></a> [workloadSubnets](#input\_workloadSubnets) | n/a | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_site_name"></a> [site\_name](#output\_site\_name) | n/a |
| <a name="output_site_type"></a> [site\_type](#output\_site\_type) | n/a |
<!-- END_TF_DOCS -->