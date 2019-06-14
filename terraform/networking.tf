////////////////////////////
///// Networking

resource "azurerm_virtual_network" "main" {
  name                = "${data.azurerm_resource_group.resource_group.name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

// This public subnet is where resources will be deployed. In a hardened environment,
// consider using a private subnet and NAT-ing external requests from VMs inside the private subnet.
resource "azurerm_subnet" "public" {
  name                 = "public"
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = "10.0.2.0/24"
}
