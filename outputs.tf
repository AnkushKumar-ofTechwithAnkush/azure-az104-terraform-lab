
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


# Spoke VNet Outputs

output "spoke_vnet_id" {
  description = "ID of the Spoke Virtual Network"
  value       = azurerm_virtual_network.spoke_vnet.id
}

output "spoke_subnet_id" {
  description = "ID of the Spoke Subnet"
  value       = azurerm_subnet.spoke_subnet.id
}

# VNet Peering Outputs

output "main_to_spoke_peering_id" {
  description = "Main to Spoke VNet peering ID"
  value       = azurerm_virtual_network_peering.main_to_spoke.id
}

output "spoke_to_main_peering_id" {
  description = "Spoke to Main VNet peering ID"
  value       = azurerm_virtual_network_peering.spoke_to_main.id
}

# Private Endpoint Output

output "storage_private_endpoint_ip" {
  description = "Private IP of the Storage Blob endpoint"
  value       = azurerm_private_endpoint.storage_blob_pe.private_service_connection[0].private_ip_address
}

# Private DNS Output

output "blob_private_dns_zone_id" {
  description = "Private DNS Zone ID"
  value       = azurerm_private_dns_zone.blob_private_dns.id
}

# Route Table Output

output "spoke_route_table_id" {
  description = "Spoke Route Table ID"
  value       = azurerm_route_table.spoke_route_table.id
}

# Load Balancer Outputs

output "load_balancer_public_ip" {
  description = "Public IP of Azure Load Balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "load_balancer_id" {
  description = "Azure Load Balancer Resource ID"
  value       = azurerm_lb.az104_lb.id
}

# Application Gateway Outputs

output "application_gateway_public_ip" {
  description = "Public IP of Application Gateway"
  value       = azurerm_public_ip.appgw_public_ip.ip_address
}

output "application_gateway_id" {
  description = "Application Gateway Resource ID"
  value       = azurerm_application_gateway.az104_appgw.id
}

# Application Gateway Subnet Output

output "application_gateway_subnet_id" {
  description = "Dedicated Application Gateway Subnet ID"
  value       = azurerm_subnet.appgw_subnet.id
}

# Cost Management Budget Output

output "azure_monthly_budget_id" {
  description = "Azure Resource Group Budget ID"
  value       = azurerm_consumption_budget_resource_group.az104_budget.id
}

output "azure_monthly_budget_amount" {
  description = "Configured monthly Azure budget"
  value       = azurerm_consumption_budget_resource_group.az104_budget.amount
}
