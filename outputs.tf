
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

# Storage Account Outputs

output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = azurerm_storage_account.az104_storage.name
}

output "storage_account_id" {
  description = "Resource ID of the Storage Account"
  value       = azurerm_storage_account.az104_storage.id
}

output "storage_primary_location" {
  description = "Primary location of the Storage Account"
  value       = azurerm_storage_account.az104_storage.primary_location
}

# Blob Container Output

output "storage_container_name" {
  description = "Name of the Blob Container"
  value       = azurerm_storage_container.documents.name
}

# Storage Replication Output

output "storage_replication_type" {
  description = "Storage redundancy configuration"
  value       = azurerm_storage_account.az104_storage.account_replication_type
}


# Managed Identity Output

output "vm_managed_identity_principal_id" {
  description = "VM Managed Identity Principal ID"
  value       = azurerm_linux_virtual_machine.web_vm.identity[0].principal_id
}

# RBAC Output

output "vm_storage_role_assignment_id" {
  description = "Storage RBAC assignment ID"
  value       = azurerm_role_assignment.vm_storage_reader.id
}

# Azure Policy Output

output "allowed_locations_policy_id" {
  description = "Allowed locations policy assignment ID"
  value       = azurerm_resource_group_policy_assignment.allowed_locations.id
}

# Resource Lock Output

output "storage_resource_lock_id" {
  description = "Storage Account resource lock ID"
  value       = azurerm_management_lock.storage_lock.id
}

# Log Analytics Workspace Outputs

output "log_analytics_workspace_name" {
  description = "Name of Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.az104_law.name
}

output "log_analytics_workspace_id" {
  description = "Resource ID of Log Analytics Workspace"
  value       = azurerm_log_analytics_workspace.az104_law.id
}

# Monitoring Outputs

output "data_collection_rule_id" {
  description = "Linux VM Data Collection Rule ID"
  value       = azurerm_monitor_data_collection_rule.linux_dcr.id
}

output "vm_cpu_alert_id" {
  description = "VM CPU Metric Alert ID"
  value       = azurerm_monitor_metric_alert.vm_cpu_alert.id
}

# Backup Outputs

output "recovery_services_vault_name" {
  description = "Recovery Services Vault name"
  value       = azurerm_recovery_services_vault.az104_vault.name
}

output "vm_backup_policy_id" {
  description = "VM Backup Policy ID"
  value       = azurerm_backup_policy_vm.linux_backup_policy.id
}
