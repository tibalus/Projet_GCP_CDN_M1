module "network" {
  source       = "./modules/network"
  region       = var.region
  network_name = "network-test"
  subnet_name  = "subnet-test"
  subnet_range = "10.0.0.0/24"
}

module "compute" {
  source        = "./modules/compute"
  instance_name = "instance-test"
  zone          = var.zone
  subnet_id     = module.network.subnet_id
  internal_ip   = "10.0.0.4"
  ssh_keys      = var.ssh_keys
}
