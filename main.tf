module "rg" {
  source = "./module/rg"
  rg-map = var.rg-map
}
module "vnet" {
  depends_on = [module.rg]
  source     = "./module/vnet"
  vnet-map   = var.vnet-map
}

module "vm" {
  depends_on = [module.vnet]
  source     = "./module/vm"
  vm-map     = var.vm-map
}