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

resource "azurerm_resource_group" "private_network_rg" {
  name     = "private-network-rg"
  location = "India"
}

resource "azurerm_virtual_network" "private_network_vnet" {
  name                = "private-network-vnet"
  resource_group_name = azurerm_resource_group.private_network_rg.name
  location            = azurerm_resource_group.private_network_rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private-subnet"
  resource_group_name  = azurerm_resource_group.private_network_rg.name
  virtual_network_name = azurerm_virtual_network.private_network_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "bastion_public_ip" {
  name                = "bastion-public-ip"
  location            = azurerm_resource_group.private_network_rg.location
  resource_group_name = azurerm_resource_group.private_network_rg.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "bastion_nsg" {
  name                = "bastion-nsg"
  location            = azurerm_resource_group.private_network_rg.location
  resource_group_name = azurerm_resource_group.private_network_rg.name

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
}

resource "azurerm_network_interface" "bastion_nic" {
  name                      = "bastion-nic"
  location                  = azurerm_resource_group.private_network_rg.location
  resource_group_name       = azurerm_resource_group.private_network_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.private_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_public_ip.id
  }
}

resource "azurerm_virtual_machine" "bastion_vm" {
  name                  = "bastion-vm"
  location              = azurerm_resource_group.private_network_rg.location
  resource_group_name   = azurerm_resource_group.private_network_rg.name
  network_interface_ids = [azurerm_network_interface.bastion_nic.id]
  vm_size               = "Standard_B1s"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "bastion-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  os_profile {
    computer_name  = "bastion-vm"
    admin_username = "adminuser"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/adminuser/.ssh/authorized_keys"
      key_data = "${var.admin_ssh_public_key}"
    }
  }
}
