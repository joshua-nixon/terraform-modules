variable "name" {
    type = string
}

variable "rules" {
    type = list(object({
      description = string
      protocol    = string
      port        = string
      source_ips  = optional(list(string))
    }))
    default = []
}

variable "attachment_selectors" {
    type = list(string)
    default = []
}