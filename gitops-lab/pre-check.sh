#!/bin/bash
#
# Check that the kubernetes API is ready to accept commands before creating workload resources
#
echo "site name: $TF_VAR_site_name"
KUBECONFIG=$1
echo "kubeconfig file: $KUBECONFIG"

for x in `seq 1 120`; do
   state=$(kubectl auth can-i create namespace --all-namespaces)
if [ "$state" = "yes" ]; then
   echo "ONLINE: $TF_VAR_site_name cluster at $KUBECONFIG is ready to accept commands.  Safe to proceed. [$x minutes elapsed]"
   exit 0
else
    echo "$state: wait for $TF_VAR_site_name cluster at $KUBECONFIG to be ready to accept commands before proceeding.  [$x minutes elapsed]"
    #exit 1
fi
sleep 60;
done;
echo "$state: wait for $KUBECONFIG cluster at to be ready to accept commands before proceeding; timed out after 120 minutes"
exit 1;
