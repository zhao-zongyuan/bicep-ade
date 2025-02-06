# Diagnostics
variable "operational_workspace" {
  type        = object({ id = string })
  default     = { id = "/subscriptions/<sub_id>/resourceGroups/<rg_name>/providers/Microsoft.OperationalInsights/workspaces/<diagnostics-LAW>" }
  description = "The resource ID of the operational Log Analytics workspace to send logs and metrics to. Set to null to disable operational logging. Defaults to production operational workspace."

  validation {
    condition = var.operational_workspace == null ? true : can(regex(
      "^/subscriptions/[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}/resourceGroups/[^/]+/providers/Microsoft.OperationalInsights/workspaces/[^/]+$",
      var.operational_workspace.id
    ))
    error_message = "The operational_workspace.id must be a valid Azure Log Analytics workspace resource ID in the format '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}'."
  }
  nullable = true
}

variable "sentinel_workspace" {
  type        = object({ id = string })
  default     = { id = "/subscriptions/<subscription_id>/resourceGroups/<rg_name>/providers/Microsoft.OperationalInsights/workspaces/<Sentinel_LAW>" }
  description = "The resource ID of the Sentinel Log Analytics workspace to send logs and metrics to. Defaults to production Sentinel instance."

  validation {
    condition = var.sentinel_workspace == null ? true : can(regex(
      "^/subscriptions/[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}/resourceGroups/[^/]+/providers/Microsoft.OperationalInsights/workspaces/[^/]+$",
      var.sentinel_workspace.id
    ))
    error_message = "The sentinel_workspace.id must be a valid Azure Log Analytics workspace resource ID in the format '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}'."
  }
  nullable = true
}

variable "virtual_network_flow_logs" {
  type = object({
    enabled            = optional(bool, false)
    network_watcher_id = optional(string, null)
    storage_account_id = optional(string, null)
    retention_days     = optional(number, 30)
  })
  default     = null
  description = "Configuration details for the storage account where flow logs will be stored for the virtual network. Set to null to disable flow logs."
}
