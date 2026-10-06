locals {
  flat_role_assignments = flatten([
    for role, principals in var.role_assignments : [
      for principal_id in principals : {
        key          = "${role}-${principal_id}"
        role         = role
        principal_id = principal_id
      }
    ]
  ])
}

resource "azurerm_role_assignment" "this" {
  for_each             = { for v in local.flat_role_assignments : v.key => v }
  scope                = var.scope
  role_definition_name = each.value.role
  principal_id         = each.value.principal_id
}
