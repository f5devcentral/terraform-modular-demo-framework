variable "volt_ic_namespace" {
  type        = string
  description = "Namespace where the XC ingress controller objects will be created."
}

variable "volt_ic_secret_name" {
  type        = string
  description = "Name of the secret that XC ingress controller will use when calling the XC APIs."
}

variable "nginx_jwt" {
  type        = string
  description = "The file path to the NGINX JWT file"
}

variable "k8s_cluster_name" {
  type        = string
  description = "The name of the Managed K8s cluster"
}

variable "site_name" {
  type        = string
  description = "Your F5 XC AppStack site name"
}

variable "xc_sitetoken" {
  type        = string
  description = "Your F5 XC API token"
}

variable "api_p12_file" {
  type        = string
  description = "The path to your F5 XC API certificate and key file in p12 format"
}

variable "api_p12_passphrase" {
  type        = string
  description = "The passphrase for the p12 certificate and key"
}

variable "argo_host_prefix" {
  type        = string
  description = "The prefix to be used for the argocd site"
  default     = "argocd"
}

variable "grafana_host_prefix" {
  type        = string
  description = "The prefix to be used for the grafana site"
  default     = "grafana"
}

variable "brewz_host_prefix" {
  type        = string
  description = "The prefix to be used for the brewz site"
  default     = "brewz"
}

variable "nic_default_cert_secret_name" {
  type        = string
  description = "The secret name to be used for the default certificate to be used for NIC"
  default     = "default-server-secret"
}

variable "nic_default_cert_cn" {
  type        = string
  description = "The subject name to be used for the default certificate to be used for NIC"
  default     = "NGINXIngressController"
}

variable "brewz_cert_secret_name" {
  type        = string
  description = "The secret name to be used for the default certificate to be used for Brewz"
  default     = "brewz-tls"
}

variable "brewz_tls_cert_validity_period_hours" {
  type        = number
  description = "The validity period of the certificate generated for the Brewz app on the NIC proxy"
  default     = 720 # 30 days
}

variable "nic_tls_cert_validity_period_hours" {
  type        = number
  description = "The validity period of the certificate generated for the NIC default server certificate"
  default     = 720 # 30 days
}

variable "nginx_pull_secret_name" {
  type        = string
  description = "The secret name to be used for the NGINX container pull secret"
  default     = "regcred"
}

variable "nginx_pull_secret_server" {
  type        = string
  description = "The container registry server for the NGINX containers"
  default     = "private-registry.nginx.com"
}

variable "lab_domain" {
  type        = string
  description = "The domain name for the lab"
}

variable "namespace" {
  type        = string
  description = "Volterra app namespace where the objects will be created. This cannot be system or shared ns."
}

variable "xc_tenant" {
  type        = string
  description = "Volterra tenant name where the objects will be created."
}

variable "xc_tenant_suffix" {
  type        = string
  description = "Volterra tenant suffix where the objects will be created."
}

variable "project_prefix" {
  type        = string
  description = "This value is inserted at the beginning of each XC object (alpha-numeric, no special character)"
}

variable "xc_service_cred_cert" {
  type        = string
  description = "The certificate to use for the xc ingress controller api calls"
}

variable "xc_service_cred_key" {
  type        = string
  description = "The key to use for the xc ingress controller api calls"
}

variable "xc_lb_lab_tls_cert" {
  type        = string
  description = "The certificate to use for the lab load balancers"
}

variable "xc_lb_lab_tls_key" {
  type        = string
  description = "The key to use for the lab load balancers"
}

variable "xc_lb_lab_tls_secret_name" {
  type        = string
  description = "The name of the secret to create to use for the lab load balancers"
  default     = "xc-lb-lab-tls-secret"
}
