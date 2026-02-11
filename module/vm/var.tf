variable environment {
  description = "type envionment name"
  type = string
}
variable rg {
  description = "name of the resource group"
  type = string
}
variable location {
  description = "region where resouce will be deployed"
  type = string
}
variable address_space {
  description = " this is vnet address space"
  type = list(string)
}
variable subnets {
  description = " please enter the subnet name and value"
  type = map(string)
}
variable vm_sizes {
  description = "virtual machine size"
  type = map(string)
}
variable admin_ssh_key {
  }
