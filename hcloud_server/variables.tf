variable "name"  {
    type = string
}

variable "location" {
  type = string
}

variable "server_type" {
  type = string
}

variable "image" {
  type = string
}

variable "ssh_key_id" {
  type    = string
}

variable "firewall_id" {
  type    = string
  default = null
}

variable "user_data" {
  type      = string
  default   = null
  sensitive = true
}

variable "labels" {
  type    = map(string)
  default = null
}