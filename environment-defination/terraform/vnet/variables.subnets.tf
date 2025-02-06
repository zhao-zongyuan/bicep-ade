variable "subnets" {
  description = "(Optional) Map of additional subnets to create."
  type = map(object({
    address_prefixes                  = list(string)
    service_endpoints                 = optional(list(string), [])
    default_outbound_access           = optional(bool, false)
    private_endpoint_network_policies = optional(string, null)
    delegated_service                 = optional(string, null)
    network_security_group = optional(object({
      id = string
    }), null)
  }))
  default = {}

  validation {
    condition = alltrue([
      for k, v in var.subnets :
      try(
        v.private_endpoint_network_policies == null ? true : contains(
          ["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"],
          v.private_endpoint_network_policies
        ),
        true
      )
    ])
    error_message = "private_endpoint_network_policies must be one of 'Disabled', 'Enabled', 'NetworkSecurityGroupEnabled', or 'RouteTableEnabled'."
  }

  validation {
    condition = alltrue([
      for k, v in var.subnets :
      try(
        v.delegated_service == null ? true : contains(keys(local.service_delegations), v.delegated_service),
        true
      )
    ])
    error_message = "delegated_service is not a valid service identifier."
  }
}
