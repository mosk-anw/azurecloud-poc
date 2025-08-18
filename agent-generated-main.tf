terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.71.0, < 5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mywebrg" {
  name     = "mywebrg"
  location = "South India"
}

resource "azurerm_virtual_network" "myweb_vnet" {
  name                = "myweb-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mywebrg.location
  resource_group_name = azurerm_resource_group.mywebrg.name
}

resource "azurerm_subnet" "myweb_subnet" {
  name                 = "myweb-subnet"
  resource_group_name  = azurerm_resource_group.mywebrg.name
  virtual_network_name = azurerm_virtual_network.myweb_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.mywebrg.name
  virtual_network_name = azurerm_virtual_network.myweb_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_security_group" "myweb_nsg" {
  name                = "myweb-nsg"
  location            = azurerm_resource_group.mywebrg.location
  resource_group_name = azurerm_resource_group.mywebrg.name

  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "myweb_nic" {
  name                = "myweb-nic"
  location            = azurerm_resource_group.mywebrg.location
  resource_group_name = azurerm_resource_group.mywebrg.name

  ip_configuration {
    name                          = "myweb-ipconfig"
    subnet_id                     = azurerm_subnet.myweb_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "myweb_vm" {
  name                = "myweb-vm"
  location            = azurerm_resource_group.mywebrg.location
  resource_group_name = azurerm_resource_group.mywebrg.name
  network_interface_ids = [azurerm_network_interface.myweb_nic.id]
  size                = "Standard_B1s"

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

  admin_username = "azureuser"
  admin_ssh_key {
    username   = "azureuser"
    public_key = var.ssh_public_key
  }

  disable_password_authentication = true
}

resource "azurerm_public_ip" "bastion_pip" {
  name                = "bastion-pip"
  resource_group_name = azurerm_resource_group.mywebrg.name
  location            = azurerm_resource_group.mywebrg.location
  allocation_method   = "Static"
}

resource "azurerm_bastion_host" "myweb_bastion" {
  name                = "myweb-bastion"
  location            = azurerm_resource_group.mywebrg.location
  resource_group_name = azurerm_resource_group.mywebrg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "myweb_nic_nsg" {
  network_interface_id      = azurerm_network_interface.myweb_nic.id
  network_security_group_id = azurerm_network_security_group.myweb_nsg.id
}