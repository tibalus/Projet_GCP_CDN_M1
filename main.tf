

# VPC1 - 10.0.2.0/16 pour les instances Frontend
module "vpc1_frontend" {
  source = "./modules/vpc"

  project_id  = var.project_id
  vpc_name    = "vpc1-frontend"
  subnet_name = "vpc1-subnet-frontend"
  subnet_cidr = "10.0.2.0/24"
  region      = var.region
}

# VPC2 - 10.0.3.0/16 pour les instances Backend
module "vpc2_backend" {
  source = "./modules/vpc"

  project_id  = var.project_id
  vpc_name    = "vpc2-backend"
  subnet_name = "vpc2-subnet-backend"
  subnet_cidr = "10.0.3.0/24"
  region      = var.region
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
