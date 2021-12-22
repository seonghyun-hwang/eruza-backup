resource "azurerm_virtual_network" "backup_vn" {
  name = "backup_vn"
  location = azurerm_resource_group.backup_rg.location
  resource_group_name = azurerm_resource_group.backup_rg.name
  address_space = ["10.0.0.0/16"]
}