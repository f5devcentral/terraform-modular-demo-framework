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
In the case of an error during the tf_params_action, the credentials used by Terraform on the workstation are likely for a different account/subscription than the F5 Distributed Cloud Cloud Credentials used.
