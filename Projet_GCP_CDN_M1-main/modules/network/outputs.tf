# modules/network/outputs.tf

output "network_id" {
  description = "ID du réseau VPC"
  value       = google_compute_network.vpc.id
}

output "network_self_link" {
  description = "Self link du réseau VPC"
  value       = google_compute_network.vpc.self_link
}

output "network_name" {
  description = "Nom du réseau VPC"
  value       = google_compute_network.vpc.name
}

output "subnets" {
  description = "Map des sous-réseaux créés"
  value = {
    for k, v in google_compute_subnetwork.subnet : k => {
      id        = v.id
      self_link = v.self_link
      name      = v.name
      cidr      = v.ip_cidr_range
    }
  }
}

output "router_name" {
  description = "Nom du Cloud Router"
  value       = google_compute_router.router.name
}
