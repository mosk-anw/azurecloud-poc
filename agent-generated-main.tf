terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "myweb01" {
  name     = "myweb01"
  location = var.location
}

resource "azurerm_public_ip" "myweb01_pip" {
  name                = "myweb01-pip"
  resource_group_name = azurerm_resource_group.myweb01.name
  location            = azurerm_resource_group.myweb01.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "myweb01_nic" {
  name                = "myweb01-nic"
  location            = azurerm_resource_group.myweb01.location
  resource_group_name = azurerm_resource_group.myweb01.name

  ip_configuration {
    name                          = "myweb01-ipconfig"
    subnet_id                     = azurerm_subnet.myweb01_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myweb01_pip.id
  }
}

resource "azurerm_virtual_network" "myweb01_vnet" {
  name                = "myweb01-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myweb01.location
  resource_group_name = azurerm_resource_group.myweb01.name
}

resource "azurerm_subnet" "myweb01_subnet" {
  name                 = "myweb01-subnet"
  resource_group_name  = azurerm_resource_group.myweb01.name
  virtual_network_name = azurerm_virtual_network.myweb01_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_linux_virtual_machine" "myweb01_vm" {
  name                = "myweb01-vm"
  resource_group_name = azurerm_resource_group.myweb01.name
  location            = azurerm_resource_group.myweb01.location
  size                = "Standard_D2s_v5"
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.myweb01_nic.id]

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

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  tags = var.tags
}
