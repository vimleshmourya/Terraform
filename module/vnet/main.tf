resource "azurerm_virtual_network" "vnet" {
  for_each            = var.vnet-map
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "subnet" {
  depends_on = [ azurerm_virtual_network.vnet ]
  for_each             = var.subnet-map
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

}

resource "azurerm_network_security_group" "nsgblck" {
  for_each = var.subnet-map
  name                = "${each.value.subnet_name}-nsg"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.security_rules_map
      content {
        name                       = security_rule.value.name
        priority                   = security_rule.value.priority
        direction                  = security_rule.value.direction
        access                     = security_rule.value.access
        protocol                   = security_rule.value.protocol
        source_port_range          = security_rule.value.source_port_range
        destination_port_range     = security_rule.value.destination_port_range
        source_address_prefix      = security_rule.value.source_address_prefix
        destination_address_prefix = security_rule.value.destination_address_prefix
      }
}
}

resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = var.subnet-map
  depends_on = [ azurerm_network_security_group.nsgblck ]
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsgblck[each.key].id
}
