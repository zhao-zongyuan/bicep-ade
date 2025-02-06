resource "azurerm_virtual_network" "this" {
  name                = local.virtual_network_name
  location            = coalesce(var.location, var.resource_group.location)
  resource_group_name = var.resource_group.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  tags = var.tags
}

resource "azurerm_role_assignment" "this" {
  for_each = { for ra in var.role_assignments :
    join("|", [ra.principal_id, coalesce(ra.role_definition_name, ra.role_definition_id)]) => ra
  }

  scope                = azurerm_virtual_network.this.id
  principal_id         = each.value.principal_id
  role_definition_id   = each.value.role_definition_id
  role_definition_name = each.value.role_definition_name
}
