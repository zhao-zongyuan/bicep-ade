# locks.tf
resource "azurerm_management_lock" "vnet" {
  count = var.lock != null ? 1 : 0

  name       = var.lock.name
  scope      = azurerm_virtual_network.this.id
  lock_level = var.lock.kind
  notes      = "Resource lock created via Terraform"
}
