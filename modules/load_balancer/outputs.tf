output "lb_ip_address" {
  description = "The external IP address of the load balancer"
  value       = google_compute_global_address.default.address
}
