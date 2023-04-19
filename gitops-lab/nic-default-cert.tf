# Create a private key in PEM format
resource "tls_private_key" "nic_private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "nic_self_signed_cert" {
  private_key_pem = tls_private_key.nic_private_key.private_key_pem

  validity_period_hours = var.nic_tls_cert_validity_period_hours

  subject {
    # The subject CN field here contains the hostname to secure
    common_name = var.nic_default_cert_cn
  }

  allowed_uses = ["key_encipherment", "digital_signature", "server_auth"]
}
