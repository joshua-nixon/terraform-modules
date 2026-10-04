

locals {
  cloudflare_ips = concat(
    compact(split("\n", data.http.cloudflare_ipv4.response_body)),
    compact(split("\n", data.http.cloudflare_ipv6.response_body))
  )

  firewall_rules = flatten([
    for rule in var.rules : {
        description = rule.description
        protocol    = rule.protocol
        port        = rule.port
        source_ips  = local.cloudflare_ips
    }
  ])
}

data "http" "cloudflare_ipv4" {
  url = "https://www.cloudflare.com/ips-v4"
}

data "http" "cloudflare_ipv6" {
  url = "https://www.cloudflare.com/ips-v6"
}

resource "hcloud_firewall" "this" {
  name = var.name

  dynamic "rule" {
    for_each = local.firewall_rules
    content {
      description = rule.value.description
      direction   = "in"
      protocol    = rule.value.protocol
      port        = rule.value.port
      source_ips  = rule.value.source_ips
    }
  }
}

resource "hcloud_firewall_attachment" "this" {
  firewall_id     = hcloud_firewall.this.id
  label_selectors = var.attachment_selectors
}