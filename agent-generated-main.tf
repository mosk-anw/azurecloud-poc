terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.46"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "testvm_rg" {
  name     = "testvm"
  location = "uksouth"
}

resource "azurerm_linux_virtual_machine" "ubuntu_vm" {
  name                = "ubuntu-vm"
  resource_group_name = azurerm_resource_group.testvm_rg.name
  location            = azurerm_resource_group.testvm_rg.location
  size                = "Standard_DS1_v2"

  admin_username = "adminuser"
  admin_password = "Password1234!"

  network_interface_ids = [azurerm_network_interface.ubuntu_nic.id]

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
}

resource "azurerm_public_ip" "ubuntu_public_ip" {
  name                = "ubuntu-public-ip"
  location            = azurerm_resource_group.testvm_rg.location
  resource_group_name = azurerm_resource_group.testvm_rg.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "ubuntu_nic" {
  name                = "ubuntu-nic"
  location            = azurerm_resource_group.testvm_rg.location
  resource_group_name = azurerm_resource_group.testvm_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.testvm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ubuntu_public_ip.id
  }
}

resource "azurerm_subnet" "testvm_subnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.testvm_rg.name
  virtual_network_name = azurerm_virtual_network.testvm_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_virtual_network" "testvm_vnet" {
  name                = "testvm-vnet"
  resource_group_name = azurerm_resource_group.testvm_rg.name
  location            = azurerm_resource_group.testvm_rg.location
  address_space       = ["10.0.0.0/16"]
}
