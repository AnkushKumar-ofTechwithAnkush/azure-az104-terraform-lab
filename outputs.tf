
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
