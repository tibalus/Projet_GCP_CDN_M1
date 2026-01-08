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
