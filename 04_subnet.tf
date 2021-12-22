resource "azurerm_subnet" "backup-subnet" {
  name = "backup-subnet"
  resource_group_name = azurerm_resource_group.backup_rg.name
  virtual_network_name = azurerm_virtual_network.backup_vn.name
  address_prefixes = ["10.0.1.0/24"]
}