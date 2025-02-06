variable "resource_group_name" {
  description = "Resource group name for the storage account"
  type        = string  
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
  default = "vnet-ade"
  
}

variable "location" {
  type        = string
  description = "Azure region for resource deployment"
  default     = "Australia East"
  
}