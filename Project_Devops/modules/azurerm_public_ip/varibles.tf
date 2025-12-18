variable "public_ips" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    allocation_method   = string
    zones               = list(string)   # ✅ declare as list
    domain_name_label   = string         # ✅ declare as string
    sku                 = string         # ✅ declare as string
    ip_version          = string         # ✅ declare as string
    tags                = map(string)
  }))
}