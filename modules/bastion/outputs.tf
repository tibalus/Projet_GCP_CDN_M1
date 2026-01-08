# modules/bastion/outputs.tf

output "bastion_instance_id" {
  description = "ID de l'instance bastion"
  value       = google_compute_instance.bastion.instance_id
}

output "bastion_instance_name" {
  description = "Nom de l'instance bastion"
  value       = google_compute_instance.bastion.name
}

output "bastion_internal_ip" {
  description = "Adresse IP interne du bastion"
  value       = google_compute_instance.bastion.network_interface[0].network_ip
}

output "bastion_external_ip" {
  description = "Adresse IP externe du bastion (si activée)"
  value       = length(google_compute_instance.bastion.network_interface[0].access_config) > 0 ? google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip : null
}

output "bastion_service_account_email" {
  description = "Email du service account du bastion"
  value       = google_service_account.bastion.email
}

output "bastion_zone" {
  description = "Zone de l'instance bastion"
  value       = google_compute_instance.bastion.zone
}

output "iap_ssh_command" {
  description = "Commande pour se connecter au bastion via IAP"
  value       = "gcloud compute ssh ${google_compute_instance.bastion.name} --zone=${google_compute_instance.bastion.zone} --tunnel-through-iap --project=${var.project_id}"
}