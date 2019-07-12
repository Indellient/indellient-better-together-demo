////////////////////////////
///// Habitat

variable "hab_service_ring_name" {
  type        = string
  description = "The name of the ring, should correspond to the name used for the ring key"
  default     = "better-together-demo"
}

variable "hab_service_name" {
  type        = string
  description = "The name of the habitat systemd service"
  default     = "hab-sup"
}

variable "habitat_package_nomad_server" {
  type        = string
  description = "The package to load"
  default     = "nomad_server"
}

variable "habitat_package_nomad_client" {
  type        = string
  description = "The package to load"
  default     = "nomad_client"
}

variable "habitat_channel" {
  type        = string
  description = "The channel used when loading the service"
  default     = "stable"
}

variable "habitat_origin" {
  type        = string
  description = "The origin of the package in the Habitat Depot."
  default     = "better-together-demo"
}

variable "habitat_nomad_server_bind_name" {
  type        = string
  description = "The name of the Nomad Server binding, as specified in the habitat package"
  default     = "server"
}

variable "habitat_service_group_nomad_server" {
  type        = string
  description = "The Nomad Server service group to bind to"
  default     = "default"
}

////////////////////////////
///// Azure

variable "resource_group_name" {
  type        = string
  description = "The Azure Resource Group where resources will exist."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the Azure Storage Account to use."
}

////////////////////////////
///// Centos

variable "admin_username" {
  type        = string
  description = "The name of the admin username on each VM."
  default     = "centos"
}

////////////////////////////
///// Nomad

variable "nomad_tag" {
  type        = string
  description = "The tag to associate with Nomad VMs."
  default     = "nomad"
}
