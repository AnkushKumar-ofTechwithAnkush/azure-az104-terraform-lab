
variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "rg-az104-dev"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "Dev"
}

variable "project_name" {
  description = "Project identifier"
  type        = string
  default     = "AZ-104"
}
