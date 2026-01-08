# VPC1 Frontend Outputs
output "vpc1_frontend_id" {
  description = "VPC1 Frontend network ID"
  value       = module.vpc1_frontend.vpc_id
}

output "vpc1_frontend_subnet_id" {
  description = "VPC1 Frontend subnet ID"
  value       = module.vpc1_frontend.subnet_id
}

output "vpc1_frontend_subnet_cidr" {
  description = "VPC1 Frontend subnet CIDR"
  value       = module.vpc1_frontend.subnet_cidr
}

# VPC2 Backend Outputs
output "vpc2_backend_id" {
  description = "VPC2 Backend network ID"
  value       = module.vpc2_backend.vpc_id
}

output "vpc2_backend_subnet_id" {
  description = "VPC2 Backend subnet ID"
  value       = module.vpc2_backend.subnet_id
}

output "vpc2_backend_subnet_cidr" {
  description = "VPC2 Backend subnet CIDR"
  value       = module.vpc2_backend.subnet_cidr
}

# Frontend MIG Outputs
output "frontend_mig_id" {
  description = "Frontend Managed Instance Group ID"
  value       = module.frontend_instances.mig_id
}

output "frontend_mig_instance_group" {
  description = "Frontend instance group URL"
  value       = module.frontend_instances.mig_instance_group
}

output "frontend_autoscaler_id" {
  description = "Frontend autoscaler ID"
  value       = module.frontend_instances.autoscaler_id
}

# Backend MIG Outputs
output "backend_mig_id" {
  description = "Backend Managed Instance Group ID"
  value       = module.backend_instances.mig_id
}

output "backend_mig_instance_group" {
  description = "Backend instance group URL"
  value       = module.backend_instances.mig_instance_group
}

output "backend_autoscaler_id" {
  description = "Backend autoscaler ID"
  value       = module.backend_instances.autoscaler_id
}
output "instance_external_ip" {
  description = "The external IP of the instance"
  value       = module.compute.instance_external_ip
}

output "instance_internal_ip" {
  description = "The internal IP of the instance"
  value       = module.compute.instance_internal_ip
}

output "load_balancer_ip" {
  description = "The external IP of the load balancer"
  value       = module.load_balancer.lb_ip_address
}
