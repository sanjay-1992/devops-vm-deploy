environment = "dev"
location = "east us"
rg = "my-terraform-rg1"
address_space = ["10.250.0.0/16"]
subnets = {
  app = "10.250.0.0/24"
  db =  "10.250.1.0/24"
  web = "10.250.2.0/24"
}
vm_sizes = { 
   qa = "Standard_D2s_v3"
   dev = "Standard_DC1ds_v3"
}
