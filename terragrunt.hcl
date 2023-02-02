terraform {
    extra_arguments "volterra" {
        commands = ["apply","plan","destroy"]
        arguments = []
        env_vars = {
            VOLT_API_URL      = "https://f5-gsa.console.ves.volterra.io/api"
            VOLT_API_TIMEOUT  = "60s"
            VOLT_API_P12_FILE = "/home/piyer/.ssh/f5-gsa-api-creds.p12"
            VES_P12_PASSWORD  = "V0lterra123!@#" 
            VOLTERRA_TOKEN    = "xGL3j8As3OsvtVdj6DsOk9Mxk+0=" 
        }
    }
}

inputs = {
    projectPrefix          = "pki-voltsites"
    namespace              = "p-iyer"
    trusted_ip             = "1.1.1.1/32"
    volterraTenant         = "f5-gsa"
    volterraCloudCredAWS   = "pki-aws"
    volterraCloudCredAzure = "gsa-azure-creds"
    awsRegion              = "us-east-2"
    awsRegion2             = "us-west-2"
    azureRegion            = "westus2"
    azureRegion2           = "eastus"
    ssh_key                = "nameofawsec2keypairtouse"
    ssh_public_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPA/VSWGm77tVohKEfBi/c+itpBLZz/upsoLFlTybfXK/l80kTNP0GxxalJ5swQdKUu9wAFQKR3GjmjE7hyBKHos6tUBtF1knA64Yg+rHZJiFvowMGw9kq0jAdvl4IDCm/tUs3PKCxxNh1I+O6ALJNd65+cABJZ8uhcMR2xA5OcpveCXz7/F5AKsbSUUb6AKVXwQ6HHoEKI7tHfN7dMnYKYOSFhOp/gneKLDVB8+c60getBp4jhVVJx+6rC38bjQSQfWSpv07mdoKeMeOnlJgAjyqIQsSfIZCEcyGCgvo6MxDADu+Ej7x1JS2zEtbfS0CGbzKGZ8KcXoPQ/0wuXv/b piyer@FLD-L-00061464"
    auto_trust_localip     = true
    clientID_azurespn      = "d774f978-038d-4c2e-a891-497ed5fc7893"
    clientID_password      = "zB227-7FXG~dZ.sn~O-A-.rdWJ9rID0uuv"
}