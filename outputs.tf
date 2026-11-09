
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

# Virtual Machine Outputs

output "vm_name" {
  description = "Name of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.web_vm.name
}

output "vm_size" {
  description = "Size of the Linux Virtual Machine"
  value       = azurerm_linux_virtual_machine.web_vm.size
}

output "vm_public_ip" {
  description = "Public IP address of the Linux VM"
  value       = azurerm_public_ip.vm_public_ip.ip_address
}

output "vm_private_ip" {
  description = "Private IP address of the Linux VM"
  value       = azurerm_network_interface.vm_nic.private_ip_address
}

output "vm_admin_username" {
  description = "Linux administrator username"
  value       = var.admin_username
}
