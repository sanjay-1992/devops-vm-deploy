variable "prefix" {
  default = "terraform"
}

resource azurerm_resource_group "terraform-rg" {
  name = var.rg
  location = "${var.location}"
  tags = {
    env = "dev"
    app = "terraform"
  }
}

resource azurerm_virtual_network "my-vnet" {
  name = "${var.environment}-vnet"
  location = azurerm_resource_group.terraform-rg.location
  address_space = var.address_space
  resource_group_name = azurerm_resource_group.terraform-rg.name
}
resource azurerm_subnet "vm-subnet" {
  for_each = var.subnets
  name = each.key
  address_prefixes = [each.value]
  virtual_network_name = azurerm_virtual_network.my-vnet.name
  resource_group_name = azurerm_resource_group.terraform-rg.name
}
resource azurerm_network_interface "net-inter" {
  name = "${var.environment}-${var.prefix}-vm-nic"
  location = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name

  ip_configuration {
    name = "nic1"
    subnet_id = azurerm_subnet.vm-subnet["app"].id
    private_ip_address_allocation = "Dynamic"
  }
}
resource azurerm_linux_virtual_machine "test" {
  name = "${var.prefix}-vm"
  location =  azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name
  #size =  "Standard_D2ls_V5"
  size = var.vm_sizes[var.environment]
  network_interface_ids = [azurerm_network_interface.net-inter.id]
  admin_username = "cloudadmin"
  admin_password = "et5e@wtteasgagas"
  admin_ssh_key {
    username = "cloudadmin"
    public_key = file("~/.ssh/id_rsa.pub")
    }
  source_image_reference {
    publisher = "canonical"
    sku = "22_04-lts-gen2"
    version = "latest"
    offer     = "0001-com-ubuntu-server-jammy"
    }
  os_disk {
    name = "os-disk"
    disk_size_gb = 32
    storage_account_type = "Standard_LRS"
    caching =  "ReadWrite"
}
}
