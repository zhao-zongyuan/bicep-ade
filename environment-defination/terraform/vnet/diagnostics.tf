# Enable Diagnostic Settings for Storage account
resource "azurerm_monitor_diagnostic_setting" "operational_storage" {
  count = var.operational_workspace != null ? 1 : 0

  name                       = "operational-logging"
  target_resource_id         = azurerm_virtual_network.this.id
  log_analytics_workspace_id = var.operational_workspace.id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "allMetrics"
    enabled  = true
  }
}

resource "azurerm_monitor_diagnostic_setting" "sentinel" {
  count = var.sentinel_workspace != null ? 1 : 0

  name                       = "sentinel-logging"
  target_resource_id         = azurerm_virtual_network.this.id
  log_analytics_workspace_id = var.sentinel_workspace.id

  enabled_log {
    category = "VMProtectionAlerts"
  }

  metric {
    category = "AllMetrics"
    enabled  = false
  }
}

# Enable Diagnostic Settings for Flow Logs. If var.virtual_network_flow_logs is null, flow logs will be disabled.
resource "azurerm_network_watcher_flow_log" "this" {
  count = var.virtual_network_flow_logs != null ? 1 : 0

  network_watcher_name = local.parsed_network_watcher.resource_name
  resource_group_name  = local.parsed_network_watcher.resource_group_name
  name                 = "flow-logs"

  target_resource_id = azurerm_virtual_network.this.id
  storage_account_id = var.virtual_network_flow_logs.storage_account_id
  enabled            = var.virtual_network_flow_logs.enabled

  retention_policy {
    enabled = var.virtual_network_flow_logs.retention_days > 0 ? true : false
    days    = var.virtual_network_flow_logs.retention_days
  }
}
