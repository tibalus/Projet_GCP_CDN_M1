output "instance_external_ip" {
  description = "The external IP of the instance"
  value       = google_compute_instance.vm_instance.network_interface.0.access_config.0.nat_ip
}

output "instance_internal_ip" {
  description = "The internal IP of the instance"
  value       = google_compute_instance.vm_instance.network_interface.0.network_ip
}
