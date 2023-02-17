## Errors
### Azure legal terms error
In case of the following Azure error
```text
Error: compute.VirtualMachinesClient#CreateOrUpdate: Failure sending request: StatusCode=400 -- Original Error: Code="ResourcePurchaseValidationFailed" Message="User failed validation to purchase resources. Error message: 'You have not accepted the legal terms on this subscription: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' for this plan. Before the subscription can be used, you need to accept the legal terms of the image. To read and accept legal terms, use the Azure CLI commands described at https://go.microsoft.com/fwlink/?linkid=2110637 or the PowerShell commands available at https://go.microsoft.com/fwlink/?linkid=862451. Alternatively, deploying via the Azure portal provides a UI experience for reading and accepting the legal terms. Offer details: publisher='volterraedgeservices' offer = 'entcloud_voltmesh_voltstack_node', sku = 'freeplan_entcloud_voltmesh_voltstack_node_multinic', Correlation Id: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'.'"
```
use this command with the [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
```shell
az vm image accept-terms --offer entcloud_voltmesh_voltstack_node --publisher volterraedgeservices --plan freeplan_entcloud_voltmesh_voltstack_node_multinic
```
### tf_params_action "unable to find ... " error
In the case of an error during the tf_params_action, the credentials used by Terraform on the workstation are likely for a different account/subscription than the F5 Distributed Cloud Cloud Credentials used. Verify which accounts/subscriptions the credentials are for, and adjust the credentials accordingly.


### changed password
if `az login` is used to provide authentication for the Terraform Azurerm provider, if the password for the Azure account is changed, any previous authentication token is invalid and `az login` must be used again to avoid authentication errors when the Azurerm provider tries to authenticate.

### Invalid Credentials Azure
 Error: Unable to list provider registration status, it is possible that this is due to invalid credentials or the service principal does not have permission 
to use the Resource Manager API, Azure error: resources.ProvidersClient#List: Failure responding to request: StatusCode=400 -- Original Error: autorest/azure: 
Service returned an error. Status=400 Code="InvalidSubscriptionId" Message="The provided subscription identifier 'providers' is malformed or invalid."

### Unable to list provider registration status 

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