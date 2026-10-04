resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
}

resource "local_file" "ssh_private_key" {
  count           = var.private_key_path == null ? 0 : 1
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = var.private_key_path
  file_permission = "0600"
}

resource "hcloud_ssh_key" "default" {
  name       = var.name
  public_key = tls_private_key.ssh_key.public_key_openssh
}