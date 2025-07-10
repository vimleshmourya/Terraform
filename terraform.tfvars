rg-map = {
  "rg1" = "eastus"
}

vnet-map = {
  vnet1 = {
    name           = "vnet1"
    location       = "eastus"
    resource_group = "rg1"
    address_space  = ["10.0.0.0/16"]
    subnet-map = {
      subnet1 = {
        subnet_name      = "frontend-subnet-01"
        address_prefixes = ["10.0.1.0/24"]
      }
      subnet2 = {
        subnet_name      = "backend-subnet-01"
        address_prefixes = ["10.0.2.0/24"]
      }
    }
  }
}

vm-map = {
  vm1 = {
    vm_name         = "frontend-vm-01"
    subnet_name     = "frontend-subnet-01"
    vnet_name       = "vnet1"
    location        = "eastus"
    resource_group  = "rg1"
    virtual_network = "vnet1"
    subnet          = "frontend-subnet-01"
    size            = "Standard_DS1_v2"
    admin_username  = "azureuser"
    admin_password  = "P@ssw0rd1234!"
    os_disk_size_gb = 30
    image-map = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
  }

  vm2 = {
    vm_name         = "backend-vm-01"
    subnet_name     = "frontend-subnet-01"
    vnet_name       = "vnet1"
    location        = "eastus"
    resource_group  = "rg1"
    subnet          = "backend-subnet-01"
    size            = "Standard_DS1_v2"
    admin_username  = "azureuser"
    admin_password  = "P@ssw0rd1234!"
    os_disk_size_gb = 30
    image-map = {
      image1 = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
      }
    }
}
}