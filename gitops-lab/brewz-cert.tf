# Create a private key in PEM format
resource "tls_private_key" "brewz_private_key" {
  algorithm = "RSA"
}

# Generates a TLS self-signed certificate using the private key
resource "tls_self_signed_cert" "brewz_self_signed_cert" {
  private_key_pem = tls_private_key.brewz_private_key.private_key_pem

  validity_period_hours = var.brewz_tls_cert_validity_period_hours

  subject {
    # The subject CN field here contains the hostname to secure
    common_name = local.brewz_fqdn
  }

  allowed_uses = ["key_encipherment", "digital_signature", "server_auth"]
}
