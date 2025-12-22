variable "rgs" {
  type = map(object({
    name       = string
    location   = string
    managed_by = string
    tags       = map(string)
  }))
}

variable "networks" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    address_space       = list(string)
    tags                = map(string)
    subnets             = list(object({
      name             = string
      address_prefixes = list(string)
    }))
  }))
}

variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    zones               = list(string)
    domain_name_label   = string
    sku                 = string
    ip_version          = string
    tags                = map(string)
  }))
}

variable "key_vaults" {
  type = map(object({
    kv_name  = string
    location = string
    rg_name  = string
  }))
}

variable "vm_name"        { type = string }
variable "vm_size"        { type = string }
variable "admin_username" { type = string }
variable "admin_password" { type = string }
variable "sql_server_name" { type = string }