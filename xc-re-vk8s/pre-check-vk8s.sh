#!/bin/bash
#
# Check that vk8s is ready before creating workload resources
#
echo "site type: $TF_VAR_site_type"
echo "site name: $TF_VAR_site_name"
echo "namespace: $TF_VAR_namespace"
echo "vk8sname:"


for x in `seq 1 120`; do
    site_state=$(curl --location --request GET $VOLT_API_URL/config/namespaces/$TF_VAR_namespace/virtual_k8ss/tgmjm2-vk8s?response_format=GET_RSP_FORMAT_DEFAULT  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s  |jq -r '.system_metadata.initializers.pending | length')
if [ "$site_state" = "0" ]; then
   echo "ONLINE: $TF_VAR_site_name is online.  Safe to proceed. waited $x minutes"
   exit 0
else
    echo "$site_state: wait for $TF_VAR_site_name to be ONLINE before proceeding.  Waiting $x minutes"
    #exit 1
fi    
sleep 60;
done;
echo "$site_state: wait for $TF_VAR_site_name to be ONLINE before proceeding; timed out after 120 minutes"
exit 1;