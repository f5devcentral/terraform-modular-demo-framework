resource "kubernetes_namespace" "volt_ic_namespace" {
  metadata {
    name = var.volt_ic_namespace
  }
  depends_on = [local_file.kubeconfig]
}

resource "kubernetes_namespace" "student_namespace" {
  metadata {
    name = var.namespace
  }
  depends_on = [local_file.kubeconfig]
}

resource "kubernetes_secret" "volt_ic_secret" {
  metadata {
    name      = var.volt_ic_secret_name
    namespace = var.volt_ic_namespace
  }

  binary_data = {
    ApiCert = var.xc_service_cred_cert
    ApiKey  = var.xc_service_cred_key
  }
  type       = "Opaque"
  depends_on = [kubernetes_namespace.volt_ic_namespace, local_file.kubeconfig]
}


resource "kubernetes_secret" "nic_default_tls_secret" {
  metadata {
    name      = var.nic_default_cert_secret_name
    namespace = var.namespace
  }
  data = {
    "tls.crt" = tls_self_signed_cert.nic_self_signed_cert.cert_pem
    "tls.key" = tls_private_key.nic_private_key.private_key_pem
  }
  type = "kubernetes.io/tls"
  depends_on = [kubernetes_namespace.student_namespace]
}

resource "kubernetes_secret" "brewz_tls_secret" {
  metadata {
    name      = var.brewz_cert_secret_name
    namespace = var.namespace
  }
  data = {
    "tls.crt" = tls_self_signed_cert.brewz_self_signed_cert.cert_pem
    "tls.key" = tls_private_key.brewz_private_key.private_key_pem
  }
  type = "kubernetes.io/tls"
  depends_on = [kubernetes_namespace.student_namespace]
}

resource "kubernetes_secret" "xc_lb_lab_tls_secret" {
  metadata {
    name      = var.xc_lb_lab_tls_secret_name
    namespace = var.namespace
  }
  data = {
    "tls.crt" = var.xc_lb_lab_tls_cert
    "tls.key" = var.xc_lb_lab_tls_key
  }
  type = "kubernetes.io/tls"
  depends_on = [kubernetes_namespace.student_namespace]
}

resource "kubernetes_secret" "nginx_pull_secret" {
  metadata {
    name      = var.nginx_pull_secret_name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        "${local.nginx_pull_secret_server}" = {
          "username" = local.nginx_pull_secret_username
          "password" = local.nginx_pull_secret_password
          "auth"     = base64encode("${local.nginx_pull_secret_username}:${local.nginx_pull_secret_password}")
        }
      }
    })
  }
  depends_on = [kubernetes_namespace.student_namespace]
}
