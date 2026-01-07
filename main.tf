module "vpc_bastion" {
  source = "./modules/network"

  project_id   = var.project_id
  network_name = "vpc1"
  region       = var.region

  subnets = {
    bastion = {
      name = "subnet-bastion"
      cidr = "10.0.1.0/24"
    }
  }
}

module "bastion" {
  source = "./modules/bastion"

  project_id          = var.project_id
  bastion_name        = "bst1"
  region              = var.region
  zone                = var.zone
  network_name        = module.vpc_bastion.network_name
  subnet_self_link    = module.vpc_bastion.subnets["bastion"].self_link
  bastion_internal_ip = "10.0.1.10"
  machine_type        = var.bastion_machine_type
  enable_external_ip  = false
  environment         = var.environment

  startup_script = file("${path.module}/scripts/bastion-startup.sh")
}

