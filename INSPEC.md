
## Install Inspec
Follow [the directions](https://docs.chef.io/inspec/install/)
note: all of the tests below were performed with Inspec 5.21.29

## Set the input parameters
create a file named `params.yaml` with the following content, adjusted as appropriate for your environment
```yaml
xc_tenant: tenant
xc_token: Akjhasdklfhaskdfh=
xc_service_discovery: discoveryname
xc_aws_site_name: sitename
xc_azure_site_name: sitename
```


## Are they there and working?
the following command will test if the resources are deployed
```bash
inspec exec test/xc-ready --input-file=params.yaml --tags=up
```
a successful result will look like
```bash
Profile: InSpec Profile (xc-ready)
Version: 0.1.0
Target:  local://

  ✔  aws-site-online: XC Site is ONLINE
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/aws_vpc_sites/aws-1 status is expected to cmp == 200
     ✔  JSON content ["spec", "site_state"] is expected to cmp == "ONLINE"
  ✔  azure-site-online: Azure XC Site is ONLINE
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/azure_vnet_sites/azure-1 status is expected to cmp == 200
     ✔  JSON content ["spec", "site_state"] is expected to cmp == "ONLINE"
  ✔  discovery-publishing: XC Service Discovery is publishing
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/discoverys/discovery-1 status is expected to cmp == 200
     ✔  JSON content ["status", 0, "metadata", "publish"] is expected to cmp == "STATUS_PUBLISH"


Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 6 successful, 0 failures, 0 skipped
```
and unsuccessful result will look like
```bash
Profile: InSpec Profile (xc-ready)
Version: 0.1.0
Target:  local://

  ×  aws-site-online: XC Site is ONLINE (2 failed)
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/aws_vpc_sites/aws-1 status is expected to cmp == 200
     
     expected: 200
          got: 404
     
     (compared using `cmp` matcher)

     ×  JSON content ["spec", "site_state"] is expected to cmp == "ONLINE"
     
     expected: ONLINE
          got: 
     
     (compared using `cmp` matcher)

  ×  azure-site-online: Azure XC Site is ONLINE (2 failed)
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/azure_vnet_sites/azure-1 status is expected to cmp == 200
     
     expected: 200
          got: 404
     
     (compared using `cmp` matcher)

     ×  JSON content ["spec", "site_state"] is expected to cmp == "ONLINE"
     
     expected: ONLINE
          got: 
     
     (compared using `cmp` matcher)

  ×  discovery-publishing: XC Service Discovery is publishing (2 failed)
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/discoverys/discovery-1 status is expected to cmp == 200
     
     expected: 200
          got: 404
     
     (compared using `cmp` matcher)

     ×  JSON content ["status", 0, "metadata", "publish"] is expected to cmp == "STATUS_PUBLISH"
     
     expected: STATUS_PUBLISH
          got: 
     
     (compared using `cmp` matcher)



Profile Summary: 0 successful controls, 3 control failures, 0 controls skipped
Test Summary: 0 successful, 6 failures, 0 skipped
```

## Are they disposed of as expected?
the following command will test that the resources appear to be removed from the XC console
```bash
inspec exec test/xc-ready --input-file=params.yaml --tags=down
```

a successful result will look like
```bash
Profile: InSpec Profile (xc-ready)
Version: 0.1.0
Target:  local://

  ✔  aws-site-does-not-exist: XC Site does not exist
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/aws_vpc_sites/aws-1 status is expected to cmp == 404
  ✔  azure-site-does-not-exist: Azure XC Site does not exist
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/azure_vnet_sites/azure-1 status is expected to cmp == 404
  ✔  discovery-does-not-exists: XC Service Discovery does not exist
     ✔  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/discoverys/discovery-1 status is expected to cmp == 404


Profile Summary: 3 successful controls, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped
```

an unsuccessful result will look like
```bash
Profile: InSpec Profile (xc-ready)
Version: 0.1.0
Target:  local://

  ×  aws-site-does-not-exist: XC Site does not exist
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/aws_vpc_sites/aws-1 status is expected to cmp == 404
     
     expected: 404
          got: 200
     
     (compared using `cmp` matcher)

  ×  azure-site-does-not-exist: Azure XC Site does not exist
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/azure_vnet_sites/azure-1 status is expected to cmp == 404
     
     expected: 404
          got: 200
     
     (compared using `cmp` matcher)

  ×  discovery-does-not-exists: XC Service Discovery does not exist
     ×  HTTP GET on https://tenant.console.ves.volterra.io/api/config/namespaces/system/discoverys/discovery-1 status is expected to cmp == 404
     
     expected: 404
          got: 200
     
     (compared using `cmp` matcher)



Profile Summary: 0 successful controls, 3 control failures, 0 controls skipped
Test Summary: 0 successful, 3 failures, 0 skipped
```