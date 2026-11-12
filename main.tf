
resource "azurerm_resource_group" "az104" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}


# Azure Virtual Network

resource "azurerm_virtual_network" "az104_vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.vnet_address_space

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Web Subnet

resource "azurerm_subnet" "web_subnet" {
  name                 = "snet-web"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.az104_vnet.name
  address_prefixes     = [var.web_subnet_address_prefix]
}


# Application Subnet

resource "azurerm_subnet" "app_subnet" {
  name                 = "snet-app"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.az104_vnet.name
  address_prefixes     = [var.app_subnet_address_prefix]
}


# Network Security Group for Web Subnet

resource "azurerm_network_security_group" "web_nsg" {
  name                = "nsg-web-az104"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}


# Network Security Group for App Subnet

resource "azurerm_network_security_group" "app_nsg" {
  name                = "nsg-app-az104"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}


# Associate Web NSG with Web Subnet

resource "azurerm_subnet_network_security_group_association" "web_nsg_association" {
  subnet_id                 = azurerm_subnet.web_subnet.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

# Associate App NSG with App Subnet

resource "azurerm_subnet_network_security_group_association" "app_nsg_association" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_nsg.id
}

# Allow SSH access to Web Subnet from trusted IP

resource "azurerm_network_security_rule" "allow_ssh" {
  name                       = "Allow-SSH-From-Admin"
  priority                   = 100
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = var.admin_source_ip
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

# Public IP for Linux Virtual Machine

resource "azurerm_public_ip" "vm_public_ip" {
  name                = "pip-az104-web"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Network Interface Card

resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-az104-web"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_public_ip.id
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Linux Virtual Machine

resource "azurerm_linux_virtual_machine" "web_vm" {
  name                = var.vm_name
  computer_name       = "vm-az104-web"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size

  admin_username = var.admin_username

  identity {
    type = "SystemAssigned"
  }

  network_interface_ids = [
    azurerm_network_interface.vm_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  disable_password_authentication = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
# Azure Storage Account

resource "azurerm_storage_account" "az104_storage" {
  name                = var.storage_account_name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  access_tier = "Hot"

  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Azure Blob Storage Container

resource "azurerm_storage_container" "documents" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.az104_storage.id
  container_access_type = "private"
}


# Blob Lifecycle Management Policy

resource "azurerm_storage_management_policy" "az104_lifecycle" {
  storage_account_id = azurerm_storage_account.az104_storage.id

  rule {
    name    = "documents-lifecycle"
    enabled = true

    filters {
      prefix_match = ["documents/"]
      blob_types   = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = 30
        delete_after_days_since_modification_greater_than       = 365
      }
    }
  }
}

#Assign Storage Blob Data Reader to Linux VM Managed Identity

resource "azurerm_role_assignment" "vm_storage_reader" {
  scope                = azurerm_storage_account.az104_storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_virtual_machine.web_vm.identity[0].principal_id
  principal_type       = "ServicePrincipal"
}

# Azure Policy: Restrict allowed Azure locations

resource "azurerm_resource_group_policy_assignment" "allowed_locations" {
  name                 = "policy-allowed-locations"
  resource_group_id    = azurerm_resource_group.az104.id
  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"

  display_name = "Restrict resources to approved Azure locations"

  description = "Only allow resources in the configured Azure region."

  parameters = jsonencode({
    listOfAllowedLocations = {
      value = [var.location]
    }
  })
}

# Protect Storage Account from accidental deletion

resource "azurerm_management_lock" "storage_lock" {
  name       = "lock-storage-no-delete"
  scope      = azurerm_storage_account.az104_storage.id
  lock_level = "CanNotDelete"

  notes = "Protect AZ-104 lab Storage Account from accidental deletion."
}


# Log Analytics Workspace

resource "azurerm_log_analytics_workspace" "az104_law" {
  name                = "law-az104-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "PerGB2018"
  retention_in_days = 30

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Azure Monitor Agent for Linux VM

resource "azurerm_virtual_machine_extension" "azure_monitor_agent" {
  name               = "AzureMonitorLinuxAgent"
  virtual_machine_id = azurerm_linux_virtual_machine.web_vm.id

  publisher            = "Microsoft.Azure.Monitor"
  type                 = "AzureMonitorLinuxAgent"
  type_handler_version = "1.0"

  auto_upgrade_minor_version = true
}

# Data Collection Rule for Linux VM

resource "azurerm_monitor_data_collection_rule" "linux_dcr" {
  name                = "dcr-az104-linux"
  resource_group_name = var.resource_group_name
  location            = var.location

  destinations {
    log_analytics {
      name                  = "destination-law"
      workspace_resource_id = azurerm_log_analytics_workspace.az104_law.id
    }
  }

  data_sources {
    syslog {
      name    = "linux-syslog"
      streams = ["Microsoft-Syslog"]
      facility_names = [
        "auth",
        "authpriv",
        "cron",
        "daemon",
        "kern",
        "syslog",
        "user"
      ]

      log_levels = [
        "Info",
        "Notice",
        "Warning",
        "Error",
        "Critical",
        "Alert",
        "Emergency"
      ]
    }
  }

  data_flow {
    streams      = ["Microsoft-Syslog"]
    destinations = ["destination-law"]
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Associate Data Collection Rule with Linux VM

resource "azurerm_monitor_data_collection_rule_association" "linux_dcr_association" {
  name                    = "dcr-association-az104"
  target_resource_id      = azurerm_linux_virtual_machine.web_vm.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.linux_dcr.id
  depends_on = [
    azurerm_virtual_machine_extension.azure_monitor_agent
  ]

}

# Diagnostic Settings for Linux VM

resource "azurerm_monitor_diagnostic_setting" "vm_diagnostics" {
  name                       = "diag-az104-vm"
  target_resource_id         = azurerm_linux_virtual_machine.web_vm.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.az104_law.id

  enabled_metric {
    category = "AllMetrics"
  }
}

# Azure Monitor Metric Alert for VM CPU

resource "azurerm_monitor_metric_alert" "vm_cpu_alert" {
  name                = "alert-az104-vm-high-cpu"
  resource_group_name = var.resource_group_name

  scopes = [
    azurerm_linux_virtual_machine.web_vm.id
  ]

  description = "Alert when VM average CPU utilization exceeds 80 percent."

  severity    = 2
  enabled     = true
  frequency   = "PT1M"
  window_size = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

# Azure Recovery Services Vault

resource "azurerm_recovery_services_vault" "az104_vault" {
  name                = "rsv-az104-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  sku               = "Standard"
  storage_mode_type = "LocallyRedundant"

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

# Daily Azure VM Backup Policy

resource "azurerm_backup_policy_vm" "linux_backup_policy" {
  name                = "policy-az104-linux-daily"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.az104_vault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 7
  }
}

# Protect Linux VM using Azure Backup

resource "azurerm_backup_protected_vm" "web_vm_backup" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.az104_vault.name

  source_vm_id     = azurerm_linux_virtual_machine.web_vm.id
  backup_policy_id = azurerm_backup_policy_vm.linux_backup_policy.id
}
