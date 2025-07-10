data "azurerm_virtual_network" "datavnet-01" {
    for_each = var.vnet-map
  name                = each.value.name
  resource_group_name = each.value.resource_group
}

