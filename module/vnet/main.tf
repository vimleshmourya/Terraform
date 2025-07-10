resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet-map
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group
  address_space       = each.value.address_space

  dynamic "subnet" {
    for_each = each.value.subnet-map
    content {
      name             = subnet.value.subnet_name
      address_prefixes = subnet.value.address_prefixes
    }

  }
}
