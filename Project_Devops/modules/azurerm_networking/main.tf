# Create Virtual Network(s)
resource "azurerm_virtual_network" "vnet" {
  for_each            = var.networks
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
  tags                = each.value.tags
}

# Flatten subnets into a single map keyed by vnet + subnet name
locals {
  subnet_map = {
    for subnet in flatten([
      for vnet_key, vnet in var.networks : [
        for s in vnet.subnets : {
          key                 = "${vnet_key}-${s.name}"
          vnet_name           = vnet.name
          resource_group_name = vnet.resource_group_name
          address_prefixes    = s.address_prefixes
          name                = s.name
        }
      ]
    ]) : subnet.key => subnet
  }
}

# Create Subnets
resource "azurerm_subnet" "subnets" {
  for_each = local.subnet_map

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = each.value.address_prefixes

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}