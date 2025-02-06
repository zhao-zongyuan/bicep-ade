locals {
  virtual_network_name = coalesce(
    var.name,
    substr(join("-", compact([
      var.workload,
      var.environment,
      var.purpose,
      var.stripe,
      var.instance
    ])), 0, 80)
  )

  parsed_network_watcher = var.virtual_network_flow_logs != null ? provider::azurerm::parse_resource_id(var.virtual_network_flow_logs.network_watcher_id) : null
}
