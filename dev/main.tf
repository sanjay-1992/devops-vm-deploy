module "vm-t" {
  source =  "../module/vm"
  environment   = var.environment
  rg            = var.rg
  location      = var.location
  address_space = var.address_space
  subnets       = var.subnets
  vm_sizes      = var.vm_sizes
}
