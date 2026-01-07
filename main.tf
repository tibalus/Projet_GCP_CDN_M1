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

  # Conversion de la map services en liste d'objets
  dns_records = [
    for name, config in var.services : {
      name    = name
      type    = config.type
      ttl     = config.ttl
      records = config.records
    }
  ]
}