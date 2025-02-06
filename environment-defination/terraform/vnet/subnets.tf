resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints

  default_outbound_access_enabled   = each.value.default_outbound_access
  private_endpoint_network_policies = each.value.private_endpoint_network_policies

  dynamic "delegation" {
    for_each = each.value.delegated_service != null ? [each.value.delegated_service] : []

    content {
      name = delegation.value

      service_delegation {
        name    = local.service_delegations[delegation.value].serviceName
        actions = local.service_delegations[delegation.value].actions
      }
    }
  }
}
