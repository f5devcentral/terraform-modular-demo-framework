## Errors
## Azure legal terms error
In case of the following Azure error
```text
Error: compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="ResourcePurchaseValidationFailed" Message="User failed validation to purchase resources. Error message: 'You have not accepted the legal terms on this subscription: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' for this plan. Before the subscription can be used, you need to accept the legal terms of the image. To read and accept legal terms, use the Azure CLI commands described at https://go.microsoft.com/fwlink/?linkid=2110637 or the PowerShell commands available at https://go.microsoft.com/fwlink/?linkid=862451. Alternatively, deploying via the Azure portal provides a UI experience for reading and accepting the legal terms. Offer details: publisher='volterraedgeservices' offer = 'entcloud_voltmesh_voltstack_node', sku = 'freeplan_entcloud_voltmesh_voltstack_node_multinic', Correlation Id: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'.'"
```
use this command with the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
```shell
az vm image accept-terms --offer entcloud_voltmesh_voltstack_node --publisher volterraedgeservices --plan freeplan_entcloud_voltmesh_voltstack_node_multinic
```
## tf_params_action "unable to find ... " error
In the case of an error during the tf_params_action, the credentials used by Terraform on the workstation are likely for a different account/subscription than the F5 Distributed Cloud Cloud Credentials used. Verify which accounts/subscriptions the credentials are for, and adjust the credentials accordingly.


## changed password
if `az login` is used to provide authentication for the Terraform Azurerm provider, if the password for the Azure account is changed, any previous authentication token is invalid and `az login` must be used again to avoid authentication errors when the Azurerm provider tries to authenticate.

## Invalid Credentials Azure
 Error: Unable to list provider registration status, it is possible that this is due to invalid credentials or the service principal does not have permission 
to use the Resource Manager API, Azure error: resources.ProvidersClient#List: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: 
Service returned an error. Status=400 Code="InvalidSubscriptionId" Message="The provided subscription identifier 'providers' is malformed or invalid."

## Unable to list provider registration status 

│ Error: Unable to list provider registration status, it is possible that this is due to invalid credentials or the service principal does not have permission 
to use the Resource Manager API, Azure error: resources.ProvidersClient#List: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: 
Service returned an error. Status=400 Code="InvalidSubscriptionId" Message="The provided subscription identifier 'providers' is malformed or invalid."
│
│   with provider["registry.terraform.io/hashicorp/azurerm"],
│   on main.tf line 2, in provider "azurerm":
│    2: provider "azurerm" {
│
╵ --> For this error, delete terragrunt cache directory and terragrunt lock file from the directory/module causing the error, and re-attempt. To review environment parameters, use following method to investigate:
In terragrunt.hcl file (of the module causing the error)
 terraform {
  source = "github.com/mjmenger/terraform-f5xc-azure-base.git?ref=v0.0.1"
   before_hook "pre-check" {   // Add a custom before-hook to execute test.sh script
      commands = ["apply","plan"]
      execute  = ["./test.sh"]
    }
}

test.sh script file (in the same directory as the module causing the error)
#!/bin/bash
printenv | sort


## status code 409 Another site with that name already exists
```shell
│ Error: error creating AwsVpcSite: Creating object: Unsuccessful POST at URL https://f5-sa.console.ves.volterra.io/api/public/namespaces/system/aws_vpc_sites, status code 409, body {"code":6,"details":[{"type_url":"type.googleapis.com/ves.io.stdlib.server.error.Error","value":"�CreateResource: Failed transaction handling aws_vpc_site: STM Error, PreDBUndo Error: %!s(\u003cnil\u003e): Applying transaction function: Another site with that name already exists;2023-02-17 19:29:03.174821013 +0000 UTC m=+118054.380740479"}],"message":"Another site with that name already exists"}, err %!s(<nil>)
│ 
│   with volterra_aws_vpc_site.example,
│   on vpc-site.tf line 1, in resource "volterra_aws_vpc_site" "example":
│    1: resource "volterra_aws_vpc_site" "example" {
│ 
╵
ERRO[0018] Terraform invocation failed in /home/mjmenger/expensive.food/aws-vpc-site-1/.terragrunt-cache/2ATXA7pHfCmxvR7opOIAFtJ9jT8/YFl5GlvBUt5PatEAnxvY7abuGtI  prefix=[/home/mjmenger/expensive.food/aws-vpc-site-1] 
ERRO[0018] 1 error occurred:
        * exit status 1
```
This may occur after Terraform/Terragrunt reports a successful destroy. You may have to manually delete the site using the XC console. The root cause of this behavior is unknown.


## destroying something you never built
```shell
Error: Error Running terraform parameter action struct: Invoking CustomAPI RPC: Doing custom RPC using Rest: Unsuccessful custom API POST on /public/namespaces/system/terraform/aws_vpc_site/tgmjm2-appstackvpc-1/run, status code 404, body {"code":5,"details":[],"message":"no view ves.io.schema.views.aws_vpc_site.Object entry system/tgmjm2-appstackvpc-1"}, err %!s(<nil>)
│ 
│ 
╵
ERRO[0083] Terraform invocation failed in /home/mjmenger/expensive.food/aws-appstack-site-1/.terragrunt-cache/KJ-QPegccrkHV_ZrHx3a_NJzo-Y/nCwQR148dRCCsZS3mkCeqEracNM  prefix=[/home/mjmenger/expensive.food/aws-appstack-site-1] 
ERRO[0083] Module /home/mjmenger/expensive.food/aws-appstack-site-1 has finished with an error: 1 error occurred:
        * exit status 1
  prefix=[/home/mjmenger/expensive.food/aws-appstack-site-1] 
ERRO[0083] Dependency /home/mjmenger/expensive.food/aws-appstack-site-1 of module /home/mjmenger/expensive.food/aws-base-1 just finished with an error. Module /home/mjmenger/expensive.food/aws-base-1 will have to return an error too.  prefix=[/home/mjmenger/expensive.food/aws-base-1] 
ERRO[0083] Module /home/mjmenger/expensive.food/aws-base-1 has finished with an error: Cannot process module Module /home/mjmenger/expensive.food/aws-base-1 (excluded: false, assume applied: false, dependencies: []) because one of its dependencies, Module /home/mjmenger/expensive.food/aws-appstack-site-1 (excluded: false, assume applied: false, dependencies: [/home/mjmenger/expensive.food/aws-base-1]), finished with an error: 1 error occurred:
        * exit status 1
  prefix=[/home/mjmenger/expensive.food/aws-base-1] 
  ```

  ## cloud credentials expire
  ```shell
  │ Error: building account: getting authenticated object ID: listing Service Principals: ServicePrincipalsClient.BaseClient.Get(): clientCredentialsToken: received HTTP status 401 with response: {"error":"invalid_client","error_description":"AADSTS7000222: The provided client secret keys for app 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' are expired. Visit the Azure portal to create new keys for your app: https://aka.ms/NewClientSecret, or consider using certificate credentials for added security: https://aka.ms/certCreds.\r\nTrace ID: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx\r\nCorrelation ID: 511a874b-32b3-4e46-898e-b81af195fe57\r\nTimestamp: 2023-03-02 21:18:01Z","error_codes":[7000222],"timestamp":"2023-03-02 21:18:01Z","trace_id":"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx","correlation_id":"xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx","error_uri":"https://login.microsoftonline.com/error?code=7000222"}
  ```
  the cloud credentials you've been using for months to build and destory sites are no longer valid. Creating new credentials, updating the reference in the input variables and running another `apply` doesn't work. You have to `destroy` the site reference completely and `apply` anew from scratch. Otherwise, you'll get an uninformative error like this
  ```shell
  ERRO[0026] Terraform invocation failed in /home/mjmenger/expensive.food/azure-site-2/.terragrunt-cache/F2W9uf6RUtUg4NCR3uXqWcDyrJo/uJllHPvKY1AgIzARtE2WRHjjX3o  prefix=[/home/mjmenger/expensive.food/azure-site-2] 
ERRO[0026] 1 error occurred:
        * exit status 1
```