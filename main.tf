
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
