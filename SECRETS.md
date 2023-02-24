This and many other terraform and terragrunt project require bootstrapping and management of sensitive information.

For this project we will use [Mozilla SOPS](https://github.com/mozilla/sops). 

## Install SOPS

- download a release from the [sops GitHub repository](https://github.com/mozilla/sops/releases).
- untar the release
- move the binary to /usr/local/bin/ or somewhere on your path

## update the SOPS creation rules

TBD: how to create a key with AWS KMS

TBD: how to create a key pair with gpg

update `.sops.yaml` with the following
```yaml
creation_rules:
  - path_regex: \.demo\.yaml$
    kms: 'arn:aws:kms:us-west-2:317124676658:key/06e6489e-496c-4838-99c0-e6236a035160'
    pgp: '629D84554D89CF03C8A79432C01BFF1963A98831'
```
the `kms` value is the ARN of the AWS KMS key you created
the `pgp` value is the fingerprint (spaces removed) of the key pair created with `gpg`

this tells `sops` to encrypt any file named with the .demo.yaml extension with both the AWS key and the PGP key such that either key can be used to decrypt the content. For the `kms` decryption to work the AWS credentials used by Terragrunt/Terraform must have access to the key. For the `pgp` decryption to work, Terragrunt/Terraform must have access to the private key of the pgp key pair.

## update the secret values 
create the secrets file with `sops`
```bash
sops ef.demo.yaml
```
Add the following content to the file, making adjustments as appropriate for your configuration.

```yaml
volt_api_url: https://tenant.console.ves.volterra.io/api
volt_tenant: tenant
volt_api_p12_file: /complete/path/to/your/p12.file
volt_p12_password: passwordforyourp12file
volt_api_token: yourvolterraapitoken
volt_cloud_credentials_aws: thenameofyourdistributedcloudawscredentials
volt_cloud_credentials_azure: thenameofyourdistributedcloudazurecredentials
ssh_public_key: thepublickeycontentsofthekeypairyouwanttouse
aws_ec2_key_name: theawsec2keyname
azure_clientid_spn: theidoftheazureserviceprincipaltouse
azure_clientid_password: thepasswordfortheazureserviceprincipal
gcp_project_id: thegooglecomputeplatformprojecttouse
```