terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_image" "image" {
  name                = "centos-habitat"
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

resource "tls_private_key" "ssh_key" {
  algorithm   = "ECDSA"
}
