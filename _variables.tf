variable "registry_name" {
  description = "The name of this Container Registry."
  type        = string
  default     = "registryname"
}

variable "location" {
  description = "The supported Azure location where the resources exist."
  type        = string
  default     = "northeurope"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "rgname"
}

variable "sku" {
  description = "The SKU tier for the Container Registry."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Is admin enabled for this Container Registry?"
  type        = bool
  default     = false
}

variable "georeplications" {
  description = "A list of properties of the geo-replication blocks for this Container Registry. Only availiable for Premium SKU."

  type = list(object({
    location                = string                # The location where this Container Registry should be geo-replicated.
    zone_redundancy_enabled = optional(bool, false) # Is zone redundancy enabled for this replication location?
  }))

  default = []
}

variable "images_retention_enabled" {
  description = "Specifies whether images retention is enabled (Premium only)."
  type        = bool
  default     = false
}

variable "images_retention_days" {
  description = "Specifies the number of images retention days."
  type        = number
  default     = 90
}

variable "azure_services_bypass_allowed" {
  description = "Whether to allow trusted Azure services to access a network restricted Container Registry."
  type        = bool
  default     = false
}

variable "trust_policy_enabled" {
  description = "Specifies whether the trust policy is enabled (Premium only)."
  type        = bool
  default     = false 
}

variable "public_network_access_enabled" {
  description = "Whether the Container Registry is accessible publicly."
  type        = bool
  default     = true
}

variable "data_endpoint_enabled" {
  description = "Whether to enable dedicated data endpoints for this Container Registry? (Only supported on resources with the Premium SKU)."
  default     = false
  type        = bool
}
variable "webhooks" {
  description = "A map of webhooks to create for this Container Registry."

  type = map(object({
    name        = string
    service_uri = string
    actions     = optional(list(string), ["push"])
    status      = optional(string, "enabled")
    scope       = optional(string, "")
  }))

  default = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "log_analytics_destination_type" {
  description = "The type of log analytics destination to use for this Log Analytics Workspace."
  type        = string
  default     = null
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)

  default = [
    "ContainerRegistryLoginEvents",
    "ContainerRegistryRepositoryEvents"
  ]
}

variable "diagnostic_setting_name" {
  description = "The name of this Diagnostic Setting."
  type        = string
  default     = "audit-logs"
}

variable "name" {
  type        = string
  description = "A string value to describe prefix of all the resources"
  default     = "Dev-SpecialChem"
}

variable "default_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default = {
    "Scope" : "ACR"
    "CreatedBy" : "TTN"
  }
}

variable "common_tags" {
  type        = map(string)
  description = "A map to add common tags to all the resources"
  default     = {}
}

variable "subnet_id" {
  type = string
}