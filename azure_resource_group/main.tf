resource "azurerm_resource_group" "this" {
  name      = var.name
  location  = "uksouth"
  tags      = module.common_resource_tags.all_tags
}

module "common_resource_tags" {
  source = "../common_resource_tags"
  update_change_triggers = {
    resource_group_name = var.name
  }
}