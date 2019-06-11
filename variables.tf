variable "resource_group_name" {
  type        = string
  description = "The Azure Resource Group where resources will exist."
}

variable "storage_account_name" {
  type        = string
  description = "The name of the Azure Storage Account to use."
}

variable "admin_username" {
  type        = string
  description = "The name of the admin username on each VM."
  default     = "centos"
}

variable "consul_count" {
  type        = number
  description = "The number of Consul VMs to provision."
  default     = 5
}

variable "consul_tag" {
  type        = string
  description = "The tag to associate with Consul VMs."
  default     = "consul"
}
