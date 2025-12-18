resource "azurerm_public_ip" "pip" {
  for_each = var.public_ips

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  tags                = each.value.tags

  # handle optional values safely
  zones              = try(each.value.zones, null)
  domain_name_label  = try(each.value.domain_name_label, null)
  sku                = try(each.value.sku, null)
  ip_version         = try(each.value.ip_version, null)
}