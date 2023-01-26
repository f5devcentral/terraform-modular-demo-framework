#!/bin/bash
#
# Check that site is online before creating workload resources
#
echo "site type: $TF_VAR_site_type"
echo "site name: $TF_VAR_site_name"


for x in `seq 1 120`; do
    site_state=$(curl --location --request GET $VOLT_API_URL/config/namespaces/system/$TF_VAR_site_type/$TF_VAR_site_name  -H "Authorization: APIToken $VOLTERRA_TOKEN" -H "content-type: application/json" -s  |jq -r .spec.site_state)
if [ "$site_state" = "ONLINE" ]; then
   echo "ONLINE: $TF_VAR_site_name is online.  Safe to proceed. [$x minutes elapsed]"
   exit 0
else
    echo "$site_state: wait for $TF_VAR_site_name to be ONLINE before proceeding. [$x minutes elapsed]"
    #exit 1
fi    
sleep 60;
done;
echo "$site_state: wait for $TF_VAR_site_name to be ONLINE before proceeding; timed out after 120 minutes"
exit 1;
