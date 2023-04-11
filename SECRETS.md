This and many other terraform and terragrunt project require bootstrapping and management of sensitive information.

For this project we will use [Mozilla SOPS](https://github.com/mozilla/sops). 

## Install SOPS

- download a release from the [sops GitHub repository](https://github.com/mozilla/sops/releases).
- untar the release
- move the binary to /usr/local/bin/ or somewhere on your path

### use VS Code as editor for sops
If you want to use VS Code as your sops editor for the current session, enter the following prior to the sops command.
```bash
export EDITOR="code --wait"
```
or, if you want VS Code to be the sops editor for all sessions, add the export to your `.bashrc` file

you will still start `sops` at the command line. `sops` will open the document in vs code and wait for you to save and close the document tab.

## update the SOPS creation rules
Before setting the rules that sops uses to create new secrets file, encryption keys are necessary.
### Create a symmetric AWS key
```shell
aws kms create-key --region us-west-2
```
You can change the region as you feel appropriate. And then capture the value at 
```jq
.KeyMetadata.Arn
```
TBD: grant users access to the key  

or

Follow [the instructions](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html) for creating a symmetric kms key and copy the ARN for the key from the AWS console.

### Create GCP KMS key
```bash
gcloud kms keyrings create ef-sops --location global
gcloud kms keys create ef-sops-key --location global --keyring ef-sops --purpose encryption
gcloud kms keys list --location global --keyring ef-sops
```
copy the NAME value of the key you created, which looks like an uri

### Create a PGP key pair 
```shell
gpg --quick-generate-key
```
answer the prompts as appropriate



update `.sops.yaml` with the following
```yaml
creation_rules:
  - path_regex: \.demo\.yaml$
    kms: 'the ARN you copied earlier'
    gcp_kms: 'the uri of the gcp key'
    pgp: 'the fingerprint of your gpg key'
```
replace the `kms` value with the ARN of the AWS KMS key you created earlier
replace the `pgp` value with the fingerprint (spaces removed) of the key pair created with `gpg`

this tells `sops` to encrypt any file named with the .demo.yaml extension with both the AWS key and the PGP key such that either key can be used to decrypt the content. For the `kms` decryption to work the AWS credentials used by Terragrunt/Terraform must have access to the key. For the `pgp` decryption to work, Terragrunt/Terraform must have access to the private key of the pgp key pair.

## update the secret values 
create the secrets file with `sops`
```bash
sops ef.input.demo.yaml
```
Add the following content to the file, making adjustments as appropriate for your configuration.

ef.input.demo.yaml
```yaml
projectPrefix: uniqueprefix
resourceOwner: yourlastname
useremail: your.email@addre.ss
namespace: yourf5distributedcloudnamespace
trusted_ip: 1.1.1.1/32
auto_trust_localip: false
volterraTenant: yourf5distributedcloudtenant
volterraCloudCredAWS: thenameofyourdistributedcloudawscredentials
volterraCloudCredAzure: thenameofyourdistributedcloudazurecredentials
awsRegion: us-east-2
awsRegion2: us-west-2
azureRegion: westus2
azureRegion2: eastus
ssh_key: theawsec2keyname
ssh_public_key: thepublickeycontentsofthekeypairyouwanttouse
xc_api_url: https://yourf5distributedcloudtenant.console.ves.volterra.io/api
xc_tenant: yourf5distributedcloudtenant
project_id: thegooglecomputeplatformprojecttouse
xc_sitetoken: yourvolterraapitoken
clientID_azurespn: theidoftheazureserviceprincipaltouse
clientID_password: thepasswordfortheazureserviceprincipal
```
then create your environment variables file
```bash
sops ef.env.demo.yaml
```
ef.env.demo.yaml
```yaml
VOLT_API_URL: https://yourf5distributedcloudtenant.console.ves.volterra.io/api
VOLT_API_TIMEOUT: 60s
VOLT_API_P12_FILE: /the/absolute/path/to/your/p12file.p12
VES_P12_PASSWORD: thepasswordforyourp12file
VOLTERRA_TOKEN: yourvolterraapitoken
```