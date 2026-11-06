
output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.az104.name
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.az104.location
}

output "resource_group_id" {
  description = "Azure resource group ID"
  value       = azurerm_resource_group.az104.id
}

# Virtual Network Output

output "vnet_name" {
  description = "Name of the Virtual Network"
  value       = azurerm_virtual_network.az104_vnet.name
}

output "vnet_address_space" {
  description = "Address space of the Virtual Network"
  value       = azurerm_virtual_network.az104_vnet.address_space
}

# Subnet Outputs

output "web_subnet_id" {
  description = "ID of the Web subnet"
  value       = azurerm_subnet.web_subnet.id
}

output "app_subnet_id" {
  description = "ID of the Application subnet"
  value       = azurerm_subnet.app_subnet.id
}

# NSG Outputs

output "web_nsg_id" {
  description = "ID of the Web Network Security Group"
  value       = azurerm_network_security_group.web_nsg.id
}

output "app_nsg_id" {
  description = "ID of the Application Network Security Group"
  value       = azurerm_network_security_group.app_nsg.id
}
