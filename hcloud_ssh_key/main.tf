resource "tls_private_key" "this" {
  algorithm = "ED25519"
}

resource "local_file" "ssh_private_key" {
  count           = var.private_key_path == null ? 0 : 1
  content         = tls_private_key.this.private_key_pem
  filename        = var.private_key_path
  file_permission = "0600"
}

resource "hcloud_ssh_key" "this" {
  name       = var.name
  public_key = tls_private_key.this.public_key_openssh
}