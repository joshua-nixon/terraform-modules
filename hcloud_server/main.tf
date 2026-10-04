resource "hcloud_server" "servers" {
  name               = var.name
  image              = var.image
  labels             = var.labels
  server_type        = var.server_type
  location           = var.location
  ssh_keys           = [var.ssh_key_id]
  keep_disk          = true

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  lifecycle {
    ignore_changes = [ssh_keys, user_data]
  }
}
