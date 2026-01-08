# VPC1 - 10.0.2.0/24 pour les instances Frontend
module "vpc1_frontend" {
  source = "./modules/vpc"

  vpc_name     = "vpc1-frontend"
  project_id   = var.project_id
  network_name = "vpc1-frontend"
  subnet_name  = "vpc1-subnet-frontend"
  subnet_cidr  = "10.0.2.0/24"
  region       = var.region
}

# VPC2 - 10.0.3.0/24 pour les instances Backend
module "vpc2_backend" {
  source = "./modules/vpc"

  vpc_name     = "vpc2-backend"
  project_id   = var.project_id
  network_name = "vpc2-backend"
  subnet_name  = "vpc2-subnet-backend"
  subnet_cidr  = "10.0.3.0/24"
  region       = var.region
}

# Managed Instance Group pour Frontend dans VPC1
module "frontend_instances" {
  source = "./modules/compute"

  project_id    = var.project_id
  region        = var.region
  instance_name = "frontend-instance"
  machine_type  = var.frontend_machine_type
  source_image  = var.frontend_source_image
  subnet_id     = module.vpc1_frontend.subnet_id

  enable_external_ip = true
  additional_tags    = ["frontend"]

  min_replicas           = var.frontend_min_replicas
  max_replicas           = var.frontend_max_replicas
  cpu_utilization_target = var.frontend_cpu_target

  health_check_port = 80
  named_port_name   = "http"
  named_port        = 80

  startup_script = var.frontend_startup_script

  service_account_email  = var.service_account_email
  service_account_scopes = ["cloud-platform"]
}

# Managed Instance Group pour Backend dans VPC2
module "backend_instances" {
  source = "./modules/compute"

  project_id    = var.project_id
  region        = var.region
  instance_name = "backend-instance"
  machine_type  = var.backend_machine_type
  source_image  = var.backend_source_image
  subnet_id     = module.vpc2_backend.subnet_id

  enable_external_ip = true
  additional_tags    = ["backend"]

  min_replicas           = var.backend_min_replicas
  max_replicas           = var.backend_max_replicas
  cpu_utilization_target = var.backend_cpu_target

  health_check_port = 8080
  named_port_name   = "http"
  named_port        = 8080

  startup_script = var.backend_startup_script

  service_account_email  = var.service_account_email
  service_account_scopes = ["cloud-platform"]
}

module "vpc_bastion" {
  source = "./modules/vpc"

  vpc_name     = "vpc-bastion"
  project_id   = var.project_id
  network_name = "vpc-bastion"
  region       = var.region
  subnet_name  = "subnet-bastion"
  subnet_cidr  = "10.0.1.0/24"

}

module "bastion" {
  source = "./modules/bastion"

  project_id          = var.project_id
  bastion_name        = "bst1"
  region              = var.region
  zone                = var.zone
  network_name        = module.vpc_bastion.network_name
  subnet_self_link    = module.vpc_bastion.subnet_self_link
  bastion_internal_ip = "10.0.1.10"
  machine_type        = var.bastion_machine_type
  enable_external_ip  = false
  environment         = var.environment

  startup_script = file("${path.module}/scripts/bastion-startup.sh")
}

module "load_balancer" {
  source         = "./modules/load_balancer"
  project_id     = var.project_id
  instance_group = module.frontend_instances.mig_instance_group
}

module "cdn" {
  source      = "./modules/cdn"
  project_id  = var.project_id
  name_prefix = "coucou-cdn-65161131616561981516515155555555"
}

module "dns" {
  source           = "./modules/dns"
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
      name    = "cdn"
      type    = "A"
      ttl     = 300
      records = [module.cdn.cdn_external_ip]
    }
  ]
}
