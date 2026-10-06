variable "scope" {
  type = string
}

variable "role_assignments" {
  type    = map(list(string))
  default = {}
}
