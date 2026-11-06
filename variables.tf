
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


variable "vnet_name" {
  description = "Name of the Azure Virtual Network"
  type        = string
  default     = "vnet-az104-dev"
}

variable "vnet_address_space" {
  description = "Address space of the Virtual Network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_address_prefix" {
  description = "Address range for the Web subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet_address_prefix" {
  description = "Address range for the App subnet"
  type        = string
  default     = "10.0.2.0/24"
}
