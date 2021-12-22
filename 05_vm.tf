resource "azurerm_virtual_machine" "backup_vm" {
  name = "backup-vm"
  location = azurerm_resource_group.backup_rg.location
  resource_group_name = azurerm_resource_group.backup_rg.name
  network_interface_ids = [azurerm_network_interface.backup_nif.id]
  vm_size = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "OpenLogic"
    offer = "CentOS"
    sku = "7.5"
    version = "latest"
  }

  storage_os_disk {
    name = "backup_vm_disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name = "azure-vm"
    admin_username = "shyun"
    admin_password = "Bespinbespin1!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_network_interface" "backup_nif" {
  name = "backup_nif"
  location = azurerm_resource_group.backup_rg.location
  resource_group_name = azurerm_resource_group.backup_rg.name

  ip_configuration {
    name = "azure_config"
    subnet_id = azurerm_subnet.backup-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.vm_pubip.id
  }  
}

resource "azurerm_public_ip" "vm_pubip" {
  name = "vm_pub_ip"
  resource_group_name = azurerm_resource_group.backup_rg.name
  location = azurerm_resource_group.backup_rg.location
  allocation_method = "Static"
}