data "azurerm_subnet" "subnet-data" {
    for_each = var.vm-map
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group
}


resource "azurerm_network_interface" "nic" {
  for_each            = var.vm-map
  name                = "${each.value.vm_name}-nic"
  location            = each.value.location
  resource_group_name = each.value.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet-data[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = var.vm-map
  name                = each.value.vm_name
  resource_group_name = each.value.resource_group
  location            = each.value.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "Aszxjun@2025"
  network_interface_ids = [azurerm_network_interface.nic[each.key].id,]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  dynamic "source_image_reference" {
    for_each = each.value.image-map
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
}
