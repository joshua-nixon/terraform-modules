resource "azurerm_storage_account" "this" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  access_tier                     = "Cold"
  tags                            = module.resource_tags.all_tags
}

module "azure_role_assignment_bundle" {
  source           = "../azure_role_assignment_bundle"
  scope            = azurerm_storage_account.this.id
  role_assignments = var.rbac_role_assignments
}

module "resource_tags" {
  source = "../common_resource_tags"
  update_change_triggers = {
    resource_group_name = var.resource_group_name
  }
}
