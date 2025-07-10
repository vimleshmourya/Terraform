rg-map = {
  rg1 = {
    name     = "rg1"
    location = "eastus"
  }
}

vnet-map = {
  vnet1 = {
    name                = "vnet1"
    nsg_name            = "nsg1"
    location            = "eastus"
    resource_group_name = "rg1"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet-map = {
  subnet1 = {
    subnet_name          = "frontend-subnet-01"
    address_prefixes     = ["10.0.1.0/24"]
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    location             = "eastus"
    security_rules_map = {
      rule1 = {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      rule2 = {
        name                       = "Allow-SSH"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
  subnet2 = {
    subnet_name          = "backend-subnet-01"
    address_prefixes     = ["10.0.2.0/24"]
    resource_group_name  = "rg1"
    virtual_network_name = "vnet1"
    location             = "eastus"
    security_rules_map = {
      rule1 = {
        name                       = "Allow-HTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
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
    size            = "Standard_B1s"
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
    subnet_name     = "backend-subnet-01"
    vnet_name       = "vnet1"
    location        = "eastus"
    resource_group  = "rg1"
    subnet          = "backend-subnet-01"
    size            = "Standard_B1s"
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
