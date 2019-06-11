resource "azurerm_network_interface" "consul_nic" {
  name                = "${var.consul_tag}-nic-${count.index}"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  count = var.consul_count

  ip_configuration {
    name                          = "${var.consul_tag}-configuration-${count.index}"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "consul_vm" {
  name                  = "${var.consul_tag}-vm-${count.index}"
  location              = data.azurerm_resource_group.resource_group.location
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.consul_nic.*[count.index].id]
  vm_size               = "Standard_DS1_v2"
  count = var.consul_count

  storage_image_reference {
    id = data.azurerm_image.image.id
  }
  storage_os_disk {
    name              = "osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.consul_tag}-${count.index}"
    admin_username = var.admin_username
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.ssh_key.public_key_pem
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }
  tags = {
    role = var.consul_tag
  }
}
