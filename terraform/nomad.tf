////////////////////////////
///// Habitat

data "template_file" "habitat_service_nomad_server" {
  template = file("templates/hab-sup.service.tpl")

  vars = {
    peers           = ""
    ring_name       = var.hab_service_ring_name
  }
}

data "template_file" "habitat_service_nomad_client" {
  template = file("templates/hab-sup.service.tpl")

  vars = {
    peers           = "--peer ${azurerm_public_ip.nomad_client_public_ip.ip_address}"
    ring_name       = var.hab_service_ring_name
  }
}

////////////////////////////
///// Nomad Server

resource "azurerm_public_ip" "nomad_server_public_ip" {
  name                = "${var.nomad_tag}-server-public-ip"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nomad_server_nic" {
  name                = "${var.nomad_tag}-server-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.nomad_tag}-server-configuration"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nomad_server_public_ip.id
  }
}

resource "azurerm_virtual_machine" "nomad_server_vm" {
  connection {
    host        = azurerm_public_ip.nomad_server_public_ip.ip_address
    type        = "ssh"
    user        = var.admin_username
    private_key = tls_private_key.ssh_key.public_key_openssh
  }

  name                  = "${var.nomad_tag}-server-vm"
  location              = data.azurerm_resource_group.resource_group.location
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.nomad_server_nic.id]
  vm_size               = "Standard_DS1_v2"

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
    computer_name  = "${var.nomad_tag}-server"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.ssh_key.public_key_openssh
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }

  provisioner "file" {
    destination = "/tmp/${var.hab_service_name}.service"
    content     = data.template_file.habitat_service_nomad_server.rendered
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/${var.hab_service_name}.service /etc/systemd/system/${var.hab_service_name}.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start ${var.hab_service_name}",
      "sudo systemctl enable ${var.hab_service_name}",
      "until sudo hab svc status > /dev/null 2>&1; do sleep 1; done",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hab svc load ${var.habitat_origin}/${var.habitat_package_nomad_server} --channel ${var.habitat_channel}",
    ]
  }

  tags = {
    role = "${var.nomad_tag}-server"
  }
}

////////////////////////////
///// Nomad Client

resource "azurerm_public_ip" "nomad_client_public_ip" {
  name                = "${var.nomad_tag}-client-public-ip"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nomad_client_nic" {
  name                = "${var.nomad_tag}-client-nic"
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "${var.nomad_tag}-client-configuration"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.nomad_client_public_ip.id
  }
}

resource "azurerm_virtual_machine" "nomad_client_vm" {
  connection {
    host        = azurerm_public_ip.nomad_client_public_ip.ip_address
    type        = "ssh"
    user        = var.admin_username
    private_key = tls_private_key.ssh_key.public_key_openssh
  }

  name                  = "${var.nomad_tag}-client-vm"
  location              = data.azurerm_resource_group.resource_group.location
  resource_group_name   = data.azurerm_resource_group.resource_group.name
  network_interface_ids = [azurerm_network_interface.nomad_client_nic.id]
  vm_size               = "Standard_DS1_v2"

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
    computer_name  = "${var.nomad_tag}-client"
    admin_username = var.admin_username
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = tls_private_key.ssh_key.public_key_openssh
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/${var.hab_service_name}.service /etc/systemd/system/${var.hab_service_name}.service",
      "sudo systemctl daemon-reload",
      "sudo systemctl start ${var.hab_service_name}",
      "sudo systemctl enable ${var.hab_service_name}",
      "until sudo hab svc status > /dev/null 2>&1; do sleep 1; done",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hab svc load ${var.habitat_origin}/${var.habitat_package_nomad_server} --channel ${var.habitat_channel} --bind ${var.habitat_nomad_server_bind_name}:${var.habitat_package_nomad_server}.${var.habitat_service_group_nomad_server}",
    ]
  }

  tags = {
    role = "${var.nomad_tag}-client"
  }
}
