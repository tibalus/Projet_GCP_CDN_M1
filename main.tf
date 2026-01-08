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

module "load_balancer" {
  source         = "./modules/load_balancer"
  project_id     = var.project_id
  instance_group = module.compute.instance_group
}

module "cdn" {
  source = "./modules/cdn"
  project_id = var.project_id
  name_prefix = "bcfgcnfg"
}
module "dns" {
  source = "./modules/dns"
  project_id       = var.project_id
  zone_name        = "groupe1-${var.environment}"
  domain           = var.domain
  zone_description = "Zone DNS pour TP1 - ${var.environment}"
  zone_type        = "public"
  enable_dnssec    = true

  labels = {
    environment = var.environment
    managed_by  = "terraform"
    project     = "tp1"
  }

  dns_records = [
    {
      name    = "app"
      type    = "A"
      ttl     = 300
      records = [module.load_balancer.lb_ip_address]
    },
    {
      name = "cdn"
      type = "A"
      ttl = 300
      records = [module.cdn.cdn_external_ip]
    }
  ]
}
