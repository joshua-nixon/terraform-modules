locals {
  labels = merge({
    "server-name" = var.name
  }, var.labels)
}

resource "hcloud_server" "this" {
  name               = var.name
  image              = var.image
  labels             = local.labels
  server_type        = var.server_type
  location           = var.location
  user_data          = var.user_data
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
