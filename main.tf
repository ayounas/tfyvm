resource "azurerm_virtual_machine_extension" "res-2" {
  auto_upgrade_minor_version = true
  name                       = "AADSSHLoginForLinux"
  publisher                  = "Microsoft.Azure.ActiveDirectory"
  type                       = "AADSSHLoginForLinux"
  type_handler_version       = "1.0"
  virtual_machine_id         = "/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Compute/virtualMachines/azcloudvm"
  depends_on = [
    azurerm_linux_virtual_machine.res-0,
  ]
}
resource "azurerm_network_interface" "res-3" {
  location            = "uksouth"
  name                = "azcloudvm213_z1"
  resource_group_name = "azcloudvm"
  ip_configuration {
    name                          = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Network/publicIPAddresses/azcloudvm-ip"
    subnet_id                     = "/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Network/virtualNetworks/azcloudvm-vnet/subnets/default"
  }
  depends_on = [
    azurerm_public_ip.res-9,
    azurerm_subnet.res-11,
  ]
}
resource "azurerm_network_security_rule" "res-6" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "80"
  direction                   = "Inbound"
  name                        = "AllowMyIpAddressHTTPInbound"
  network_security_group_name = "azcloudvm-nsg"
  priority                    = 1010
  protocol                    = "Tcp"
  resource_group_name         = "azcloudvm"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_linux_virtual_machine" "res-0" {
  admin_username        = "fatcat"
  location              = "uksouth"
  name                  = "azcloudvm"
  network_interface_ids = ["/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Network/networkInterfaces/azcloudvm213_z1"]
  resource_group_name   = "AZCLOUDVM"
  size                  = "Standard_B2ms"
  zone                  = "1"
  admin_ssh_key {
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDoDdeY6SophozoXBLxRiP36LkRkFUkPjrqPtaeyX2goWzrkbp2IldEiHa86XkS0ljopNM6SQQbqubudgu0G0y2NLm74qFIAxJII/VKbm86gSVTlF2PpI1F+QEakkmE4HCbCKPy6rRZkMAGfH6wnmRwV2E3/WIhfeZA41uwalP7sDk/1t/6qawcW0WzksMmz+Iu9kOmonVcfqZwrEaHMT5Hgcq1n8u5l0vozHo9v5QmocQAkQQANlApx1KbNdSQzoVSgXFHuDkWOMe4/SWGOnlYnuAkZ9zGjHC6aZcPkksfnC0GPeOpBWbodh7ifuM07RGnVHXQ6ZI2d54q2fME69rbi39wa1oztTjKgmrrHejQi+q6SAgUmhjob/tkKxpy3UJ2xrPMNIWb3tIy2MR/D4QY+sKnydxN57v9GGgwsFcs1od87fC7+O/3FaecCJ9oa1m5sg9c0xkUDQinLERLbEDl088Od3rYSC9QYA6KQzHV70L5E4EVlWT61brmyer5WGE= baba@mac"
    username   = "fatcat"
  }
  identity {
    type = "SystemAssigned"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }
  source_image_reference {
    offer     = "0001-com-ubuntu-server-jammy"
    publisher = "canonical"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.res-3,
  ]
}
resource "azurerm_network_interface_security_group_association" "res-4" {
  network_interface_id      = "/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Network/networkInterfaces/azcloudvm213_z1"
  network_security_group_id = "/subscriptions/1da0835b-e77f-431e-a40f-5c626e6d833c/resourceGroups/azcloudvm/providers/Microsoft.Network/networkSecurityGroups/azcloudvm-nsg"
  depends_on = [
    azurerm_network_interface.res-3,
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_network_security_rule" "res-8" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "22"
  direction                   = "Inbound"
  name                        = "default-allow-ssh"
  network_security_group_name = "azcloudvm-nsg"
  priority                    = 1000
  protocol                    = "Tcp"
  resource_group_name         = "azcloudvm"
  source_address_prefix       = "2.222.85.179"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_resource_group" "res-1" {
  location = "uksouth"
  name     = "azcloudvm"
}
resource "azurerm_network_security_rule" "res-7" {
  access                      = "Allow"
  destination_address_prefix  = "*"
  destination_port_range      = "443"
  direction                   = "Inbound"
  name                        = "AllowMyIpAddressHTTPSInbound"
  network_security_group_name = "azcloudvm-nsg"
  priority                    = 1020
  protocol                    = "Tcp"
  resource_group_name         = "azcloudvm"
  source_address_prefix       = "*"
  source_port_range           = "*"
  depends_on = [
    azurerm_network_security_group.res-5,
  ]
}
resource "azurerm_network_security_group" "res-5" {
  location            = "uksouth"
  name                = "azcloudvm-nsg"
  resource_group_name = "azcloudvm"
  depends_on = [
    azurerm_resource_group.res-1,
  ]
}
resource "azurerm_public_ip" "res-9" {
  allocation_method   = "Static"
  location            = "uksouth"
  name                = "azcloudvm-ip"
  resource_group_name = "azcloudvm"
  sku                 = "Standard"
  zones               = ["1"]
  depends_on = [
    azurerm_resource_group.res-1,
  ]
}
resource "azurerm_virtual_network" "res-10" {
  address_space       = ["10.0.0.0/16"]
  location            = "uksouth"
  name                = "azcloudvm-vnet"
  resource_group_name = "azcloudvm"
  depends_on = [
    azurerm_resource_group.res-1,
  ]
}
resource "azurerm_subnet" "res-11" {
  address_prefixes     = ["10.0.0.0/24"]
  name                 = "default"
  resource_group_name  = "azcloudvm"
  virtual_network_name = "azcloudvm-vnet"
  depends_on = [
    azurerm_virtual_network.res-10,
  ]
}
