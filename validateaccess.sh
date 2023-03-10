#!/bin/bash
# CHECK FOR THE PLATFORM CLIs
az_installed=1
aws_installed=1
gcloud_installed=1
command -v az &> /dev/null ||  { 
        echo 'az CLI is missing. Instructions are at https://learn.microsoft.com/en-us/cli/azure/install-azure-cli'; 
        az_installed=0 
    }
command -v aws &> /dev/null ||  {
        echo 'aws CLI is missing. Instructions are at https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html'
        aws_installed=0
    }
command -v gcloud &> /dev/null ||  {
        echo 'gcloud CLI is missing. Instructions are at https://cloud.google.com/sdk/docs/install.'
        gcloud_installed=0
    }
if [ $az_installed -eq 1 ] 
then
    # CHECK FOR AZURE ACCESS
    echo Checking for Azure account access
    az account show | jq .name
    echo TBD validate that the account is the expected one
    ## validate the the account name is appropriate
fi
# CHECK FOR AWS ACCESS
if [ $aws_installed -eq 1 ] 
then
    # CHECK FOR AWS ACCESS
    echo Checking for AWS account access
    aws sts get-caller-identity | jq .Account
    echo TBD validate that the account is the expected one
    ## validate the the account name is appropriate
fi
# CHECK FOR GOOGLE ACCESS
if [ $gcloud_installed -eq 1 ] 
then
    # CHECK FOR GOOGLE ACCESS
    echo Checking for Google account access
    gcloud config list --format 'value(core.project)'
    ## validate the the account name is appropriate
fi