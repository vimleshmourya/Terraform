resource "azurerm_resource_group" "rg" {
    for_each = var.rg-map
    name     = each.key
    location = each.value
}