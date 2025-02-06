# Virtual Network outputs:

output "id" {
  description = "ID of the Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.this.name
}

output "location" {
  description = "Location of the Virtual Network"
  value       = azurerm_virtual_network.this.location
}

output "resource_group_name" {
  description = "Resource Group containing the Virtual Network"
  value       = azurerm_virtual_network.this.resource_group_name
}

output "subnets" {
  description = "Map of subnet objects created within the virtual network"
  value       = azurerm_subnet.this
}

output "subnet_nsg_associations" {
  description = "Map of subnet NSG associations"
  value = {
    for k, v in azurerm_subnet_network_security_group_association.this : k => v.id
  }
}
