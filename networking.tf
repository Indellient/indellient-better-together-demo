resource "azurerm_virtual_network" "main" {
  name                = "${data.azurerm_resource_group.resource_group.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}
