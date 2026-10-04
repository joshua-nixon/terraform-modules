locals {
  flat_role_assignments = flatten([
    for role, principals in var.rbac_role_assignments : [
      for principal_id in principals : {
        key          = "${role}_${principal_id}"
        role         = role
        principal_id = principal_id
      }
    ]
  ])
}

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

resource "azurerm_role_assignment" "this" {
  for_each             = { for k, v in local.flat_role_assignments : k => v }
  scope                = azurerm_storage_account.this.id
  role_definition_name = each.value.role
  principal_id         = each.value.principal_id
}

module "resource_tags" {
  source = "../common_resource_tags"
  update_change_triggers = {
    resource_group_name = var.resource_group_name
  }
}
