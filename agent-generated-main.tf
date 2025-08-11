terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 5.0.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "ecommerce_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "ecommerce_vnet" {
  name                = "${var.resource_group_name}-vnet"
  location            = azurerm_resource_group.ecommerce_rg.location
  resource_group_name = azurerm_resource_group.ecommerce_rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "ecommerce_subnet" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.ecommerce_rg.name
  virtual_network_name = azurerm_virtual_network.ecommerce_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.resource_group_name}-vm-nsg"
  location            = azurerm_resource_group.ecommerce_rg.location
  resource_group_name = azurerm_resource_group.ecommerce_rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = azurerm_resource_group.ecommerce_rg.location
  resource_group_name = azurerm_resource_group.ecommerce_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ecommerce_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "vm_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm_nic.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

resource "azurerm_linux_virtual_machine" "ecommerce_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.ecommerce_rg.name
  location            = azurerm_resource_group.ecommerce_rg.location
  size                = var.vm_size

  network_interface_ids = [azurerm_network_interface.vm_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_username                  = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  disable_password_authentication = true

  tags = var.tags
}

resource "azurerm_mssql_server" "ecommerce_sql_server" {
  name                         = "${var.resource_group_name}-sqlserver"
  resource_group_name          = azurerm_resource_group.ecommerce_rg.name
  location                     = azurerm_resource_group.ecommerce_rg.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password

  tags = var.tags
}

resource "azurerm_mssql_database" "ecommerce_db" {
  name                = var.database_name
  server_id           = azurerm_mssql_server.ecommerce_sql_server.id
  sku_name            = "S0"

  tags = var.tags
}
