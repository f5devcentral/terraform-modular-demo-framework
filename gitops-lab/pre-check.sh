#!/bin/bash
#
# Check that the kubernetes API is ready to accept commands before creating workload resources
#
echo "site type: $TF_VAR_site_type"
echo "site name: $TF_VAR_site_name"
echo "kubeconfig file: $TF_VAR_kubeconfig_file"
KUBECONFIG=$TF_VAR_kubeconfig_file

for x in `seq 1 120`; do
   state=$(kubectl auth can-i create namespace --all-namespaces)
if [ "$state" = "yes" ]; then
   echo "ONLINE: $TF_VAR_site_name cluster at $TF_VAR_kubeconfig_file is ready to accept commands.  Safe to proceed. [$x minutes elapsed]"
   exit 0
else
    echo "$state: wait for $TF_VAR_site_name cluster at $TF_VAR_kubeconfig_file to be ready to accept commands before proceeding.  [$x minutes elapsed]"
    #exit 1
fi
sleep 60;
done;
echo "$state: wait for $TF_VAR_site_name cluster at to be ready to accept commands before proceeding; timed out after 120 minutes"
exit 1;
