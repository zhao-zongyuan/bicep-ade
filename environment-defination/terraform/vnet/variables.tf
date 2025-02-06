variable "name" {
  type        = string
  description = "The name of the resource. If not provided, name will be generated from workload and environment."
  default     = null
}

variable "workload" {
  type        = string
  description = "Abbreviation for the workload (max 6 characters). Required if name is not provided."
  default     = null

  validation {
    condition     = can(regex("^[a-z0-9]{1,6}$", var.workload)) || var.workload == null
    error_message = "Workload must be 1-6 lowercase alphanumeric characters"
  }
}

variable "environment" {
  type        = string
  description = "Environment code. Required if name is not provided."
  default     = null

  validation {
    condition     = var.environment == null ? true : contains(["prod", "preprod", "nonprod", "uat", "syst", "dev", "playpen", "core"], var.environment)
    error_message = "Environment must be one of: prod, preprod, nonprod, uat, syst, dev, playpen, core"
  }
}

variable "stripe" {
  type        = string
  description = "Optional stripe identifier for the workload (e.g. blue, green)"
  default     = null

  validation {
    condition     = var.stripe == null || can(regex("^[a-z0-9]{1,6}$", var.stripe))
    error_message = "Stripe identifier must be 1-6 lowercase alphanumeric characters"
  }
}

variable "purpose" {
  type        = string
  default     = null
  description = "Optional abbreviation for the purpose of this function app in the workload (max 8 characters)"

  validation {
    condition     = var.purpose == null || can(regex("^[a-z0-9]{1,8}$", var.purpose))
    error_message = "Purpose must be 1-8 lowercase alphanumeric characters if specified"
  }
}

variable "instance" {
  type        = string
  default     = null
  description = "Optional 3 digit, zero padded instance identifier (e.g. 001). First digit can indicate deployment zone."

  validation {
    condition     = var.instance == null || can(regex("^[0-9]{3}$", var.instance))
    error_message = "Instance must be exactly 3 digits if specified"
  }
}

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
  description = "Resource group name for the storage account"
  nullable    = false
}

variable "location" {
  type        = string
  description = "Azure region for resource deployment"
  default     = null
}

variable "address_space" {
  description = "(Required) Address space allocated to the Virtual Network."
  type        = list(string)

  validation {
    condition     = length(var.address_space) > 0
    error_message = "address_space must contain at least one address prefix."
  }

  validation {
    condition = alltrue([
      for prefix in var.address_space :
      can(cidrhost(prefix, 1))
    ])
    error_message = "address_space must be a list of valid CIDR blocks."
  }
}

variable "dns_servers" {
  description = "(Optional) List of DNS Servers for the Virtual Network. Defaults to Azure DNS."
  type        = list(string)
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Custom tags to apply to the resource."
}

variable "lock" {
  description = "(Optional) The lock level to apply to the virtual network. The lock will also be applied to all subnets."
  type = object({
    kind = string
    name = string
  })
  default = null

  validation {
    condition     = var.lock == null ? true : contains(["CanNotDelete", "ReadOnly"], var.lock.kind)
    error_message = "Lock kind must be one of: CanNotDelete, ReadOnly"
  }
}
