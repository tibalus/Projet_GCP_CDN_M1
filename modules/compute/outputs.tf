output "instance_template_id" {
  description = "The ID of the instance template"
  value       = google_compute_instance_template.template.id
}

output "instance_template_self_link" {
  description = "The self link of the instance template"
  value       = google_compute_instance_template.template.self_link
}

output "mig_id" {
  description = "The ID of the managed instance group"
  value       = google_compute_region_instance_group_manager.mig.id
}

output "mig_self_link" {
  description = "The self link of the managed instance group"
  value       = google_compute_region_instance_group_manager.mig.self_link
}

output "instance_group" {
  description = "The instance group URL"
  value       = google_compute_region_instance_group_manager.mig.instance_group
}

output "mig_instance_group" {
  description = "The instance group URL"
  value       = google_compute_region_instance_group_manager.mig.instance_group
}

output "autoscaler_id" {
  description = "The ID of the autoscaler"
  value       = google_compute_region_autoscaler.autoscaler.id
}

output "health_check_id" {
  description = "The ID of the health check"
  value       = google_compute_health_check.autohealing.id
}
