output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "network_name" {
  description = "The name of the network"
  value       = google_compute_network.vpc.name
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_self_link" {
  description = "The self link of the subnet"
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_cidr" {
  description = "The CIDR range of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "router_name" {
  description = "Nom du Cloud Router"
  value       = google_compute_router.router.name
}

# output "network_self_link" {
#   description = "Self link du réseau VPC"
#   value       = google_compute_network.vpc.self_link
# }

# output "subnets" {
#   description = "Map des sous-réseaux créés"
#   value = {
#     for k, v in google_compute_subnetwork.subnet : k => {
#       id        = v.id
#       self_link = v.self_link
#       name      = v.name
#       cidr      = v.ip_cidr_range
#     }
#   }
# }